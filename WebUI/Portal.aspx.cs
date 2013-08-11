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

using DataAccess;
using Common;
using Business;

public partial class Portal : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userCd"] == null)
            Response.Redirect("~/Login.aspx");

        this.Page.Title = "初始页面";
        MainPageGet ma = new MainPageGet();
        DataSet dsNotEmp = ma.NotEmp();
        DataSet dsNotContract = ma.NotContract();
        DataSet dsRecordTime = ma.RecordTime();

        lblNotEmp.Text = dsNotEmp.Tables["NotEmp"].Rows[0]["con1"].ToString();
        lblNotContract.Text = dsNotContract.Tables["NotContract"].Rows[0]["con2"].ToString();
        lblRecordTime.Text = dsRecordTime.Tables["RecordTime"].Rows[0]["date"].ToString();
    }
}
