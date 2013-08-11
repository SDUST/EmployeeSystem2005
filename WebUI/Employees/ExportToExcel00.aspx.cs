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
        if (Session["rectEmps"] == null)
            Response.Write("<script>alert('未查询出报表，请重新查询！');history.back();</script>");
        else
        {
            DataSet ds = (DataSet)Session["rectEmps"];
            string tempFile = "temp"; 
            tempFile = Server.MapPath("~/temp/" + tempFile + ".xls");
            FileImportExport.ExportDataToExcel(ds, tempFile, Server.MapPath("~/temp/recruitManager.xls"), 4, 1);

            FileImportExport.FileDownLoad(this, tempFile, "download.xls", FileType.Excel);
            Common.CommonOperation.DeleteFile(tempFile);
            this.ClientScript.RegisterStartupScript(this.GetType(), "download", "<script>history.back();</script>");
        }
    }
}
