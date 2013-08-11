using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using Entity;
using Business;
using Common;

public partial class WorkAttend_reportWorkAttendOpenFile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!new UserPopedeom().GetPopedom("reportWorkAttendOpenFile", Session["userCd"].ToString()))
        {
            Response.Write("<script language = 'javascript'>alert('抱歉！您没有访问该页的权限！');history.go(-1);</script>");
            Response.End();
        }
        //else
        //{
        //    //Title = "导入考勤表";
        //    //if (!IsPostBack)
        //    //{
        //    //    Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //    //}
        //}
    }
    protected void btnImportData_Click(object sender, EventArgs e)
    {
        //Title = "导入考勤表";

        if (!fuImportData.HasFile)
            ClientScript.RegisterStartupScript(GetType(), null, "<script language=javascript>alert('请选择文件');</script>");
        else
        {
            int chkflgSum = 0, recordCount = 0;
            string failureCd = "";

            Attendances attendances = new Attendances();
            Attendance attendance;
            VacationRecord vacationRecord;
            YearHoliday yearHoliday;

            try
            {
                DataSet ds = FileImportExport.ImportDataFromExcel(fuImportData.PostedFile.FileName);
                recordCount = ds.Tables[0].Rows.Count - 1;

                DataSet dsVacClasses = new Vacations().GetVacClasses();

                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    if (!dr["工号"].ToString().Contains("汇总"))
                    {
                        DateTime date = Convert.ToDateTime(dr["打卡日期"]);
                        decimal vacTime = 0;
                        string kuanggongVacClass = null, nianjiaVacClass = null;

                        //// t_chk_attendance_temp 考勤临时表
                        attendance = new Attendance();

                        attendance.EmpCd = dr["工号"].ToString();

                        attendance.AttendanceDate = date;

                        if (dr["上班1"].ToString() != "")
                        {
                            DateTime cardTimeStart = Convert.ToDateTime(dr["上班1"]);
                            attendance.CardTimeStart = new DateTime(date.Year, date.Month, date.Day, cardTimeStart.Hour, cardTimeStart.Minute, cardTimeStart.Second);
                        }
                        else
                            attendance.CardTimeStart = DateTime.MinValue;

                        if (dr["下班2"].ToString() != "")
                        {
                            DateTime cardTimeEnd = Convert.ToDateTime(dr["下班2"]);
                            attendance.CardTimeEnd = new DateTime(date.Year, date.Month, date.Day, cardTimeEnd.Hour, cardTimeEnd.Minute, cardTimeEnd.Second);
                        }
                        else
                            attendance.CardTimeEnd = DateTime.MinValue;

                        attendance.OverTime = Convert.ToDecimal(dr[16]) + Convert.ToDecimal(dr[17]) + Convert.ToDecimal(dr[18]);//加班时数

                        if (int.Parse(dr["迟到分"].ToString()) == 0)
                            attendance.LateTime = "0";
                        else
                            attendance.LateTime = "1";

                        //// t_vac_record_list 休假登记明细表
                        vacationRecord = new VacationRecord();

                        string vac = dr["记 事"].ToString().Trim();//Trim()一下以防止空格产生异常
                        if (vac != "" && vac != "-")
                        {
                            int vacTimeBit, numberStartIndex = 0, numberEndIndex = 0;
                            decimal dotBit = 10;
                            bool numberIsStarted = false, isAfterDot = false;
                            for (int i = 0; i < vac.Length; i++)// foreach(char c in vac)
                            {
                                if (int.TryParse(vac.Substring(i, 1), out vacTimeBit) || (vac.Substring(i, 1) == "." && numberIsStarted))
                                {
                                    if (!numberIsStarted)
                                    {
                                        numberIsStarted = true;
                                        numberStartIndex = i;
                                    }

                                    if (vac.Substring(i, 1) != "." && !isAfterDot)
                                    {
                                        vacTime = vacTime * 10 + vacTimeBit;
                                    }
                                    else
                                    {
                                        isAfterDot = true;
                                        dotBit *= 0.1m;
                                        vacTime = vacTime + vacTimeBit * dotBit;
                                    }
                                }
                                else
                                {
                                    if (numberIsStarted && numberEndIndex == 0)
                                    {
                                        //numberIsEnded = true;
                                        numberEndIndex = i - 1;
                                    }
                                }
                            }

                            vacationRecord.EmpCd = dr["工号"].ToString();

                            foreach (DataRow drVacClass in dsVacClasses.Tables[0].Rows)
                            {
                                if (drVacClass["fun_name"].ToString() == "旷工")
                                    kuanggongVacClass = drVacClass["combine_cd"].ToString();

                                if (vac.Substring(0, numberStartIndex) == "有薪假")
                                {
                                    if (drVacClass["fun_name"].ToString() == "年假")
                                    {
                                        nianjiaVacClass = drVacClass["combine_cd"].ToString();
                                        vacationRecord.VacClass = nianjiaVacClass;
                                    }
                                }
                                else if (vac.Substring(0, numberStartIndex) == drVacClass["fun_name"].ToString())
                                {
                                    vacationRecord.VacClass = drVacClass["combine_cd"].ToString();
                                }
                            }
                            if (vacationRecord.VacClass == null)
                                vacationRecord.VacClass = kuanggongVacClass;

                            //vacationRecord.VacDate = date;

                            switch (vac.Substring(numberEndIndex + 1))
                            {
                                case "天":
                                    vacationRecord.VacTime = vacTime * 24;
                                    break;
                                case "小时":
                                    vacationRecord.VacTime = vacTime;
                                    break;
                                case "分钟":
                                    vacationRecord.VacTime = vacTime / 60;
                                    break;
                            }
                        }

                        //// tb_year_hols 年假mst
                        yearHoliday = new YearHoliday();

                        if (vacationRecord.VacClass != null && vacationRecord.VacClass == nianjiaVacClass)
                        {
                            yearHoliday.EmpCd = dr["工号"].ToString();

                            //yearHoliday.Year = date.Year.ToString();

                            yearHoliday.UsedDay = vacationRecord.VacTime / 24;
                        }

                        //插入数据库
                        int chkflg = 0;
                        attendances.ImportWorkAttendInfo(attendance, vacationRecord, yearHoliday, out chkflg);
                        if (chkflg != 0)
                        {
                            chkflgSum += chkflg;
                            failureCd += attendance.EmpCd + ", ";
                        }
                    }
                }

                if (failureCd.Length > 2)
                    failureCd = failureCd.Substring(0, failureCd.Length - 2);

                if (chkflgSum == 0)
                {
                    ClientScript.RegisterStartupScript(GetType(), null, "<script language=javascript>alert('导入成功');</script>");
                    attendances.AddCheckRecord(DateTime.Now, recordCount.ToString(), "成功");
                }
                else
                {
                    ClientScript.RegisterStartupScript(GetType(), null, "<script language=javascript>alert('工号为 " + failureCd + " 的考勤信息导入失败，工号可能不存在');</script>");
                    attendances.AddCheckRecord(DateTime.Now, recordCount.ToString(), "失败");
                }

                //switch (Request.QueryString["Mode"])
                //{
                //    case "New": { }
                //        break;
                //    case "Edit": { }
                //        break;
                //}
            }
            catch (Exception exp)
            {
                if (exp.Message.Contains("插入重复键"))
                {
                    ClientScript.RegisterStartupScript(GetType(), null, "<script language=javascript>alert('未能导入，打卡日期可能与数据库中的值重复或重复导入了同一个文件');</script>");
                    attendances.AddCheckRecord(DateTime.Now, recordCount.ToString(), "失败");
                }
                else
                {
                    ClientScript.RegisterStartupScript(GetType(), null, "<script language=javascript>alert('导入时出现未知的异常');</script>");
                    attendances.AddCheckRecord(DateTime.Now, recordCount.ToString(), "失败");
                }
            }
            //finally { }
        }
    }

}
