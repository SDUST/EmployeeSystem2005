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

public partial class MainMasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userCd"] == null)
            Response.Redirect("~/Login.aspx");

        lblUser.Text = new Users().GetUserName(Session["userCd"].ToString()).Tables[0].Rows[0]["user_name"].ToString();

        doing.Style["WIDTH"] = "100%";
        doing.Style["HEIGHT"] = "100%";
    }
}
