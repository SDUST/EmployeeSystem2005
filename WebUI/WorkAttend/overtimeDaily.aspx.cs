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

public partial class WorkAttend_overtimeDaily : System.Web.UI.Page
{
    static DataSet ds;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!new UserPopedeom().GetPopedom("overtimeDaily", Session["userCd"].ToString()))
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
    //当点击查询按钮后，显示数据
    protected void btnQuery_Click(object sender, EventArgs e)
    {
        //为数据源控件的选择方法的参数们赋值
        ods.SelectParameters["empCd"].DefaultValue = txtEmpCd.Text;
        ods.SelectParameters["empName"].DefaultValue = txtEmpName.Text;
        ods.SelectParameters["deptCd"].DefaultValue = selDept.SelectedValue;
        ods.SelectParameters["pjCd"].DefaultValue = selPj.SelectedValue;
        if (txtAttendanceDate.Text != "")
            ods.SelectParameters["attendanceDate"].DefaultValue = txtAttendanceDate.Text.Split(new char[] { '/', '-' })[0] + "-" + txtAttendanceDate.Text.Split(new char[] { '/', '-' })[1] + "-01";
        else
            ods.SelectParameters["attendanceDate"].DefaultValue = null;

        //为GridView们选择数据源
        gv.DataSourceID = "ods";
        gvDays.DataSourceID = "ods";
        gvTotal.DataSourceID = "ods";
        gvDaysTotal.DataSourceID = "ods";

        DateTime attendanceDate;
        if (txtAttendanceDate.Text != "")
            attendanceDate = DateTime.Parse(ods.SelectParameters["attendanceDate"].DefaultValue);
        else
            attendanceDate = DateTime.MinValue;

        ds = new Attendances().GetOvertimesDaily(txtEmpCd.Text, txtEmpName.Text, selDept.SelectedValue, selPj.SelectedValue, attendanceDate);

        Session["overtimeDaily"] = ds;

    }
    //protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    //if (e.Row.RowType == DataControlRowType.Pager)
    //    //    e.Row.Visible = false;
    //}
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

        //去掉合计的那一行，合计那一行在最后一页的最后一行
        if (gv.PageIndex == gv.PageCount - 1)
            gv.Rows[gv.Rows.Count - 1].Visible = false;

        //gv.BottomPagerRow.Visible = false;

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
        if (ds.Tables["OvertimesDaily"].Rows.Count == 0)
            lblRecordCount.Text = "0";
        else
            lblRecordCount.Text = (ds.Tables["OvertimesDaily"].Rows.Count - 1).ToString();

        selPage.Items.Clear();
        for (int i = 0; i < gv.PageCount; i++)
            selPage.Items.Add(new ListItem((i + 1).ToString()));

        if (selPage.Items.Count != 0)
            selPage.SelectedIndex = gv.PageIndex;

        //if (gv.PageCount < 2) //页数不到两页，即为0或1页，则使翻页的相关按钮不可用
        //{
        //    lnkFirstPage.Enabled = false;
        //    lnkPriviousPage.Enabled = false;
        //    lnkNextPage.Enabled = false;
        //    lnkLastPage.Enabled = false;
        //}
        //else
        //{
        //    lnkFirstPage.Enabled = true;
        //    lnkPriviousPage.Enabled = true;
        //    lnkNextPage.Enabled = true;
        //    lnkLastPage.Enabled = true;
        //}
        //if (gv.PageIndex == 0)
        //{
        //    lnkFirstPage.Enabled = false;
        //    lnkPriviousPage.Enabled = false;
        //}
        //else if (gv.PageIndex == gv.PageCount - 1)
        //{
        //    lnkNextPage.Enabled = false;
        //    lnkLastPage.Enabled = false;
        //}
        //else
        //{
        //    lnkFirstPage.Enabled = true;
        //    lnkPriviousPage.Enabled = true;
        //    lnkNextPage.Enabled = true;
        //    lnkLastPage.Enabled = true;
        //}
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
        if (gv.PageIndex == gv.PageCount - 1 /*gv.PageCount==1*/|| gv.PageCount == 0)
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
    protected void gvTotal_DataBound(object sender, EventArgs e)
    {
        for (int i = 0; i < gvTotal.Rows.Count - 1; i++)
            gvTotal.Rows[i].Visible = false;
    }
    protected void gvDays_DataBound(object sender, EventArgs e)
    {
        if (gvDays.PageIndex == gvDays.PageCount - 1)
            gvDays.Rows[gvDays.Rows.Count - 1].Visible = false;
    }
    protected void gvDaysTotal_DataBound(object sender, EventArgs e)
    {
        for (int i = 0; i < gvDaysTotal.Rows.Count - 1; i++)
            gvDaysTotal.Rows[i].Visible = false;
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
    //        int i;
    //        for (i = 0; i < gv.Columns.Count; i++)
    //            ds.Tables["OvertimesDaily"].Columns[i].ColumnName = gv.Columns[i].HeaderText;
    //        for (i = 0; i < gvDays.Columns.Count; i++)
    //            ds.Tables["OvertimesDaily"].Columns[i + gv.Columns.Count].ColumnName = gvDays.Columns[i].HeaderText;

    //        string serverFile = MapPath("~/reports/overtimeDaily.xls");

    //        FileImportExport.ExportDataToExcel(ds, serverFile, null, 1, 1);

    //        FileImportExport.FileDownLoad(this, serverFile, "testtt.xls", FileType.Excel);
    //    }
    //}

    protected void lnkPrint_Click(object sender, EventArgs e)
    {
        //if (Session["overtimeDaily"] != null && ((DataSet)Session["overtimeDaily"]).Tables[0].Rows.Count != 0)
        //{
        if (gv.Rows.Count > 0)
        {
            Response.Redirect("~/ExportToExcel.aspx?ds=overtimeDaily&template=overtimeDaily");
        }
        //}
        //else
        //    ClientScript.RegisterStartupScript(GetType(), null, "<Script language='JavaScript'>alert('请先查询');</Script>");
    }

}
