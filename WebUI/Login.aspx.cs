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

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblPwd.Visible = false;
            lblUserCd.Visible = false;
            lblLogin.Visible = false;

            txtUser.Focus();
        }
    }
    protected void txtUser_TextChanged(object sender, EventArgs e)
    {
        if (new Users().LoginCheck(txtUser.Text) == 0)
        {
            lblUser.Visible = true;
            ScriptManager1.SetFocus(txtUser);
        }
        else
        {
            lblUser.Visible = false;
            ScriptManager1.SetFocus(txtPwd);
        }
    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        if (txtUser.Text == "")
            lblUserCd.Visible = true;

        if (txtPwd.Text == "")
            lblPwd.Visible = true;

        if (txtUser.Text != "" && txtPwd.Text != "")
        {

            if (new Users().Login(txtUser.Text) != txtPwd.Text)
                lblLogin.Visible = true;
            else
            {
                Session["userCd"] = txtUser.Text;
                Response.Redirect("~/Portal.aspx");
            }
        }
    }
}
