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

public partial class WorkAttend_reportWorkAttendInfo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!new UserPopedeom().GetPopedom("reportWorkAttendInfo", Session["userCd"].ToString()))
        {
            Response.Write("<script language = 'javascript'>alert('抱歉！您没有访问该页的权限！');history.go(-1);</script>");
            Response.End();
        }
        else
        {
            ucPager.Grd = gv;
        }
    }
    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Pager)
            e.Row.Visible = false;

        if (e.Row.Cells.Count > 2)
            if (e.Row.Cells[2].Text == "失败")
            {
                e.Row.Cells[2].ForeColor = System.Drawing.Color.Red;
                if (e.Row.FindControl("lnkOperation") != null)
                    ((LinkButton)e.Row.FindControl("lnkOperation")).Visible = true;
            }
    }
    protected void gv_DataBound(object sender, EventArgs e)
    {
        ucPager.TotalRecords = new Attendances().CheckRecordsSelect().Tables[0].Rows.Count;
        ucPager.UCdatabound();
    }
    protected void lnkImport_Click(object sender, EventArgs e)
    {
        gv.DataBind();
    }
}