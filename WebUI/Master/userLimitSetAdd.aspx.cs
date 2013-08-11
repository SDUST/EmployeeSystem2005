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

public partial class userLimitSetModify : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Expires = -1;
        if (!IsPostBack)
        {
            if (Request.QueryString["mode"].ToString() == "addnew")
            {
                lblTitle.Text = "新增用户";
                //txtUserName.BackColor = Color.Empty;（using System.Drawing;）
                ClientScript.RegisterStartupScript(this.GetType(), "clientScript", "<script>oldPassHide()</script>");
                //Response.Write("<script>var mode='addnew';</script>");在ScriptManager之前执行，不受其控制
                //txtUserCd.AutoPostBack = true;

                Title = "用户权限设置新增";
            }
            else
            {
                lblTitle.Text = "修正用户";
                DataSet ds = new Users().GetUser(Request.QueryString["ucd"].ToString());
                txtUserCd.Text = ds.Tables[0].Rows[0]["user_cd"].ToString();
                txtUserName.Text = ds.Tables[0].Rows[0]["user_name"].ToString();
                txtPassOld.Text = ds.Tables[0].Rows[0]["password"].ToString();
                ClientScript.RegisterStartupScript(this.GetType(), "clientScript", "<script>idReadOnly()</script>");

                Title = "用户权限设置修正";
            }
        }
        btnSave.Attributes.Add("onclick", "javascript:if(fsBtnSave()==false) return false;if(passCheck()==false) return false;");
        //btnSave.Attributes.Add("onclick", "return fsBtnSave();");
        //if(passCheck()==false) return false;OnClientClick="return fsBtnSave();"
    }
    private void ShowMessage(string i, string j)
    {
        ClientScript.RegisterStartupScript(this.GetType(), "clientScript", "<script>alert(getMsg('" + i + "','" + j + "'))</script>");
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Request.QueryString["mode"].ToString() == "addnew")
        {
            //ClientScript.RegisterStartupScript(this.GetType(), "clientScript", "<script>oldPassHide()</script>");

            if (new Users().CheckUser(txtUserCd.Text) == 1)
                ClientScript.RegisterStartupScript(this.GetType(), "clientScript0", "<script>oldPassHide();alert('请确保登录ID不重复！');</script>");
            else
            {
                if (new Users().UserInsert(txtUserCd.Text, txtUserName.Text, txtPassword.Text) != 0)
                    ClientScript.RegisterStartupScript(this.GetType(), "clientScript0", "<script>oldPassHide();alert('新增成功！');window.close();</script>");
                else
                    ClientScript.RegisterStartupScript(this.GetType(), "clientScript", "<script>oldPassHide();alert('新增失败！');</script>");
            }
        }
        else
        {
            if (new Users().UserUpdate(txtUserCd.Text, txtUserName.Text, txtPassword.Text) != 0)
            {
                this.ShowMessage("0", "0");
                ClientScript.RegisterStartupScript(this.GetType(), "closeClientScript", "<script>window.close();</script>");
            }
            else
                this.ShowMessage("0", "1");
        }
    }
}
