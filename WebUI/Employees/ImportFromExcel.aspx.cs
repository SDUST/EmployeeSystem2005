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
using DataAccess;

public partial class ImportFromExcel : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnImportData_Click(object sender, EventArgs e)
    {

        if (fuImportData.FileName.Substring(fuImportData.FileName.LastIndexOf(".") + 1) == "xls")
        {
            DataSet ds = FileImportExport.ImportDataFromExcel(fuImportData.PostedFile.FileName);

            foreach (DataRow drr in ds.Tables[0].Rows)
            {
                drr.SetAdded();
            }

            string[] paras = new string[] { "@rect_Name", "@rect_date", "@sex", "@birthday", "@id_Card", "@diploma", "@account_address" };
            if (DataBaseAccess.InsertDataToDB(ds, "p_RectInsert", CommandType.StoredProcedure, paras))
                Response.Write("<script>alert('操作成功！');window.close();</script>");
            else
                Response.Write("<script>alert(' 操作失败！')</script>");
        }
        else if (fuImportData.FileName.Substring(fuImportData.FileName.LastIndexOf(".") + 1) == "xml" || fuImportData.FileName.Substring(fuImportData.FileName.LastIndexOf(".") + 1) == "XML")
        {
            DataSet ds = new DataSet();
            if (!FileImportExport.ImportDataFromXML(fuImportData.PostedFile.FileName, ref ds))
                Response.Write("<script>alert(' 操作失败！')</script>");
            else
            {
                string[] paras = new string[] { "@rect_Name", "@rect_date", "@sex", "@birthday", "@id_Card", "@diploma", "@account_address" };
                if (DataBaseAccess.InsertDataToDB(ds, "p_RectInsert", CommandType.StoredProcedure, paras))
                    Response.Write("<script>alert('操作成功！');window.close();</script>");
                else
                    Response.Write("<script>alert(' 操作失败！')</script>");
            }
        }
        else
            Response.Write("<script>alert('请选择正确文件格式！');</script>");
    }

}
