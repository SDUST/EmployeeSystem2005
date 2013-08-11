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
using Common;

public partial class WorkAttend_workAttendMonthly : System.Web.UI.Page
{
    static DataSet ds;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!new UserPopedeom().GetPopedom("workAttendMonthly", Session["userCd"].ToString()))
        {
            Response.Write("<script language = 'javascript'>alert('抱歉！您没有访问该页的权限！');history.go(-1);</script>");
            Response.End();
        }
        else
        {
            if (!IsPostBack)
            {
                //刚运行此页时，先将翻页的相关按钮设置为不可用
                lnkFirstPage.Enabled = false;
                lnkPriviousPage.Enabled = false;
                lnkNextPage.Enabled = false;
                lnkLastPage.Enabled = false;

                string month = DateTime.Now.Month.ToString();
                if (DateTime.Now.Month < 10)
                    month = "0" + month;
                txtAttendanceDate.Text = DateTime.Now.Year.ToString() + "/" + month; //ToString("yyyy/MM");
            }
        }
    }
    protected void btnQuery_Click(object sender, EventArgs e)
    {
        //btnQuery.Enabled = false;

        //为数据源控件的选择方法的参数们赋值
        ods.SelectParameters["empCd"].DefaultValue = txtEmpCd.Text;
        ods.SelectParameters["empName"].DefaultValue = txtEmpName.Text;
        ods.SelectParameters["deptCd"].DefaultValue = selDept.SelectedValue;
        ods.SelectParameters["pjCd"].DefaultValue = selPj.SelectedValue;
        ods.SelectParameters["attendanceDate"].DefaultValue = txtAttendanceDate.Text.Split(new char[] { '/', '-' })[0] + "-" + txtAttendanceDate.Text.Split(new char[] { '/', '-' })[1] + "-01";

        lblYear.Text = DateTime.Parse(ods.SelectParameters["attendanceDate"].DefaultValue).Year.ToString();
        lblMonth.Text = DateTime.Parse(ods.SelectParameters["attendanceDate"].DefaultValue).Month.ToString();

        //为GridView们选择数据源
        gv.DataSourceID = "ods";
        gvDays.DataSourceID = "ods";

        ds = new Attendances().AttendancesSelectMonthly(txtEmpCd.Text, txtEmpName.Text, selDept.SelectedValue, selPj.SelectedValue, DateTime.Parse(txtAttendanceDate.Text.Split(new char[] { '/', '-' })[0] + "-" + txtAttendanceDate.Text.Split(new char[] { '/', '-' })[1] + "-01"));

        //btnQuery.Enabled = true;

        Session["workAttendMonthly"] = ds;

    }
    //翻页按钮事件：首页
    protected void lnkFirstPage_Click(object sender, EventArgs e)
    {
        gv.PageIndex = 0;
        gvDays.PageIndex = 0;
    }
    //翻页按钮事件：上一页
    protected void lnkPriviousPage_Click(object sender, EventArgs e)
    {
        gv.PageIndex--;
        gvDays.PageIndex--;
    }
    //翻页按钮事件：下一页
    protected void lnkNextPage_Click(object sender, EventArgs e)
    {
        gv.PageIndex++;
        gvDays.PageIndex++;
    }
    //翻页按钮事件：尾页
    protected void lnkLastPage_Click(object sender, EventArgs e)
    {
        gv.PageIndex = gv.PageCount - 1;
        gvDays.PageIndex = gvDays.PageCount - 1;
    }
    //翻页下拉框事件
    protected void selPage_SelectedIndexChanged(object sender, EventArgs e)
    {
        gv.PageIndex = selPage.SelectedIndex;
        //gv.DataBind();
        gvDays.PageIndex = selPage.SelectedIndex;
        //gvDays.DataBind();
    }
    protected void gv_DataBound(object sender, EventArgs e)
    {
        //如果没有数据返回，则不显示面板，即不显示那个水平滚动条
        if (gv.Rows.Count != 0)
            p.Visible = true;
        else
            p.Visible = false;

        if (gv.PageCount != 0)
        {
            lblCurrentPage.Text = (gv.PageIndex + 1).ToString();
            lblTotolPageCount.Text = gv.PageCount.ToString();
        }
        else
        {
            lblCurrentPage.Text = " ";
            lblTotolPageCount.Text = " ";
        }

        //获取记录条数，lblRecordCount是显示记录条数的标签
        //DateTime attendanceDate;
        //if (!DateTime.TryParse(txtAttendanceDate.Text, out attendanceDate))
        //    attendanceDate = DateTime.MinValue;
        lblRecordCount.Text = ds.Tables["AttendancesMonthly"].Rows.Count.ToString();

        selPage.Items.Clear();
        for (int i = 0; i < gv.PageCount; i++)
            selPage.Items.Add(new ListItem((i + 1).ToString()));

        if (selPage.Items.Count != 0)
            selPage.SelectedIndex = gv.PageIndex;

        if (gv.PageIndex == 0)
        {
            lnkFirstPage.Enabled = false;
            lnkPriviousPage.Enabled = false;
        }
        else
        {
            lnkFirstPage.Enabled = true;
            lnkPriviousPage.Enabled = true;
        }
        if (gv.PageIndex == gv.PageCount - 1 || gv.PageCount == 0)
        {
            lnkNextPage.Enabled = false;
            lnkLastPage.Enabled = false;
        }
        else
        {
            lnkNextPage.Enabled = true;
            lnkLastPage.Enabled = true;
        }
    }
    protected void selDept_DataBound(object sender, EventArgs e)
    {
        selDept.Items.Insert(0, new ListItem());
    }
    protected void selPj_DataBound(object sender, EventArgs e)
    {
        selPj.Items.Insert(0, new ListItem());
    }
    //protected void lnkPrint_Click(object sender, EventArgs e)
    //{
    //    if (ds != null && ds.Tables.Count != 0)
    //    {
    //        //System.IO.StreamWriter sw = new System.IO.StreamWriter(System.IO.File.Create(@"d:\log.log"));
    //        //sw.WriteLine(gv.Columns.Count);
    //        //sw.WriteLine(gvDays.Columns.Count);
    //        //sw.WriteLine(ds.Tables["AttendancesMonthly"].Columns.Count);
    //        //sw.Close();

    //        int i;
    //        for (i = 0; i < gv.Columns.Count; i++)
    //            ds.Tables["AttendancesMonthly"].Columns[i].ColumnName = gv.Columns[i].HeaderText;
    //        for (i = 0; i < gvDays.Columns.Count; i++)
    //            ds.Tables["AttendancesMonthly"].Columns[i + gv.Columns.Count].ColumnName = gvDays.Columns[i].HeaderText;

    //        string serverFile = MapPath("~/reports/workAttendMonthly.xls");
    //        //string serverFile = MapPath("~/reports/workAttendMonthly.xml");

    //        FileImportExport.ExportDataToExcel(ds, serverFile, null, 1, 1);
    //        //FileImportExport.ExportDataToXML(ds, serverFile);

    //        //Response.Redirect("~/reports/workAttendMonthly.xls");
    //        FileImportExport.FileDownLoad(this, serverFile, "workAttendMonthly.xls", FileType.Excel);//出勤月报表
    //        //FileImportExport.FileDownLoad(this, serverFile, "donw.xml", FileType.XML);
    //    }
    //}

    protected void lnkPrint_Click(object sender, EventArgs e)
    {
        if (gv.Rows.Count > 0)
        {
            Response.Redirect("~/ExportToExcel.aspx?ds=workAttendMonthly&template=workAttendMonthly");
        }
    }
}
