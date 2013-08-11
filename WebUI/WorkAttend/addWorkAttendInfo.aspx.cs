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

using Business;
using Entity;

public partial class addWorkAttendInfo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!new UserPopedeom().GetPopedom("addWorkAttendInfo", Session["userCd"].ToString()))
        {
            Response.Write("<script language = 'javascript'>alert('抱歉！您没有访问该页的权限！');history.go(-1);</script>");
            Response.End();
        }
        else
        {
            if (!IsPostBack)
            {
                string month = DateTime.Now.Month.ToString(), day = DateTime.Now.Day.ToString();
                if (DateTime.Now.Month < 10)
                    month = "0" + month;
                if (DateTime.Now.Day < 10)
                    day = "0" + day;
                txtAttendanceDate.Text = DateTime.Now.Year.ToString() + "/" + month + "/" + day; //ToString("yyyy/MM/dd");

                txtEmpName.Attributes.Add("readonly", "readonly");
                txtAttendanceDate.Attributes.Add("readonly", "readonly");
            }
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        int chkFlg = 0;
        new Attendances().TheDayInsertedCheck(txtEmpCd.Text, DateTime.Parse(txtAttendanceDate.Text), out chkFlg);
        if (chkFlg == 0)
        {
            int checkFlag = 1;  //标志插入操作是否成功的变量

            try
            {

                //--------------------------if 开始时间 > 上班时间  迟到; else 没迟到;

                string lateTime = "0";
                if (chkLateTime.Checked)
                    lateTime = "1";

                Attendances attendances = new Attendances();
                attendances.AttendanceInsert(txtEmpCd.Text, txtAttendanceDate.Text, DateTime.Parse(txtAttendanceDate.Text + " " + txtCardTimeStart.Text), DateTime.Parse(txtAttendanceDate.Text + " " + txtCardTimeEnd.Text), txtOvertime.Text, lateTime, selVacClass.SelectedValue/*休假区分*/, txtVacTime.Text/*休假时数*/, out checkFlag);
            }
            catch { }

            //如果插入成功，即attendances.AttendanceInsert(...)执行成功，则checkFlag会被赋值为0
            if (checkFlag == 0)
                ClientScript.RegisterStartupScript(GetType(), "success", "<Script language='JavaScript'>alert('补录成功!');</Script>");
            else
                ClientScript.RegisterStartupScript(GetType(), "fail", "<Script language='JavaScript'>alert('补录失败!');</Script>");
                         }
        else
            ClientScript.RegisterStartupScript(GetType(), "exist", "<Script language='JavaScript'>alert('此员工所指定的日期已插入记录，每一天不能重复插入!');</Script>");
    }
    protected void txtEmpCd_TextChanged(object sender, EventArgs e)
    {
        if (txtEmpCd.Text != "")
        {
            //根据编号获取员工姓名
            if (new Emps().GetEmpNameByEmpId(txtEmpCd.Text).Tables["EmpName"].Rows.Count != 0) //有数据返回即存在此员工编号
                txtEmpName.Text = new Emps().GetEmpNameByEmpId(txtEmpCd.Text).Tables["EmpName"].Rows[0]["emp_name"].ToString(); //给显示员工姓名的文本框赋值
            else
            {
                txtEmpName.Text = "";
            }
        }
        else
        {
            txtEmpName.Text = "";
        }
    }
    protected void selVacClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (selVacClass.SelectedIndex != 0)
            rfvVacTime.Enabled = true;
        else
            rfvVacTime.Enabled = false;
    }
}
