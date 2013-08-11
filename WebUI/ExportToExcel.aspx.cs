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
using Common;

public partial class ExportToExcel : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userCd"] == null)
            Response.Redirect("~/Login.aspx");

        string dsName = Request.QueryString["ds"];
        string template = Request.QueryString["template"];

        if (template != null && template != "")
            template = Server.MapPath("~/ReportsModel/") + template + ".xls";

        if(dsName==null || Session[dsName]==null)
            Response.Write("<script>alert('未查询出报表，请重新查询！');history.back();</script>");
        else
        {
            DataSet ds = (DataSet)Session[dsName];
            string tempFile = "temp"; //Common.CommonOperation.GenerateFileName();
            tempFile = Server.MapPath("~/temp/" + tempFile + ".xls");

            FileImportExport.ExportDataToExcel(ds, tempFile, template, 4, 1);
            //FileImportExport.ExportDataToXML(ds, serverFile);

            FileImportExport.FileDownLoad(this, tempFile, "download.xls", FileType.Excel);

            Common.CommonOperation.DeleteFile(tempFile);
            this.ClientScript.RegisterStartupScript(this.GetType(), "download", "<script>history.back();</script>");
        }
    }
    protected void btnImportData_Click(object sender, EventArgs e)
    {

    }
}
