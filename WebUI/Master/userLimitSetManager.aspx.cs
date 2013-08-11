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

public partial class userLimitSetManager : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            this.GvUserManagerBindData();

            Response.Cache.SetCacheability(HttpCacheability.NoCache);
        }
    }

    private void GvUserManagerBindData()
    {
        string user_cd = Request.QueryString["ucd"].ToString();
        lblUserCd.Text = user_cd;
        DataSet ds = new Users().GetUser(user_cd);
        lblUserName.Text = ds.Tables[0].Rows[0]["user_name"].ToString();
        gvUserManager.DataSource = ds;
        gvUserManager.DataBind();
        

        int rows = gvUserManager.Rows.Count;
        for (int i = 0; i < rows; i++)
        {
            if (ds.Tables[0].Rows[i]["popedom_class"].ToString() == "0")
                ((CheckBox)gvUserManager.Rows[i].FindControl("chkPopedomClass")).Checked = false;
            else
                ((CheckBox)gvUserManager.Rows[i].FindControl("chkPopedomClass")).Checked = true;
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        int rows = gvUserManager.Rows.Count;
        string result="";
        for (int i = 0; i < rows; i++)
        {
            if (((CheckBox)gvUserManager.Rows[i].FindControl("chkPopedomClass")).Checked)
                result = result + gvUserManager.Rows[i].Cells[0].Text + ",";

        }
        if (new Popedoms().PopedomUpdate(Request.QueryString["ucd"].ToString(), result) == 0)
        {
            this.GvUserManagerBindData();
            Response.Write("<script>alert('操作成功！');</script>");
        }
        else
            Response.Write("<script>alert('操作失败！');</script>");

       
    }
}
