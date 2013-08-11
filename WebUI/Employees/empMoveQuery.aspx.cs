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
public partial class empMoveQuery : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnQuery_Click(object sender, EventArgs e)
    {
        //根据查询条件，显示查询结果。
        GVMoveQuery.Visible = true;
        DataSet ds = new Emps().GetEmpMoveQuery(txtYear1.Text != "" ? txtYear1.Text : null, txtYear2.Text != "" ? txtYear2.Text : null);
        GVMoveQuery.DataSource = ds;
        Session["EmpMoveQuery"] = ds;
        GVMoveQuery.DataBind();
    }
    protected void GVMoveQuery_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //当翻页前，把将要翻到的页索引赋给此GridView控件的页索引。
        GVMoveQuery.PageIndex = e.NewPageIndex;
    }
    protected void GVMoveQuery_PageIndexChanged(object sender, EventArgs e)
    {
        //执行翻页功能时后，按照原来查询条件重新执行一遍。--相当重新绑定。
        this.btnQuery_Click(null, null);
    }
    protected void lnkPrint_Click(object sender, EventArgs e)
    {
        if (GVMoveQuery.Rows.Count > 0)
        {
            Response.Redirect("~/ExportToExcel.aspx?ds=EmpMoveQuery&template=" + "empMoveQuery");

        }
    }
    protected void GVMoveQuery_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
