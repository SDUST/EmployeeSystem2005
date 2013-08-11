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

public partial class userLimitSet : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!new UserPopedeom().GetPopedom("userLimitSet", Session["userCd"].ToString()))
        {
            Response.Write("<script language = 'javascript'>alert('抱歉！您没有访问该页的权限！');history.go(-1);</script>");
            Response.End();
        }
        else
        {
            this.Title = "用户权限设置";
            UCPager1.Grd = gvUsers;
            UCPager1.DataSetName = "Users";
        }
    }

    private void GvUsersBindData()
    {
        gvUsers.Visible = true;
        DataSet ds = new Users().GetUsers(txtUserCd.Text, txtUserName.Text);
        gvUsers.DataSource = ds;
        UCPager1.TotalRecords = ds.Tables[0].Rows.Count;

        Session["Users"] = ds;
        gvUsers.DataBind();
        UCPager1.UCdatabound();
    }
    protected void gvUsers_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvUsers.PageIndex = e.NewPageIndex;
        this.GvUsersBindData();
    }
    protected void btnQuery_Click(object sender, EventArgs e)
    {
        this.GvUsersBindData();
    }
    protected void gvUsers_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType != DataControlRowType.DataRow)
            return;

        string user_cd = e.Row.Cells[0].Text;
        string user_name=e.Row.Cells[1].Text;
        string scrip="";
        LinkButton lbtnManager = (LinkButton)e.Row.FindControl("lnkLimitManager");
        scrip = "fPopUpPage('userLimitSetManager.aspx?ucd=" + user_cd + "&uname="+user_name+"',550,540)";
        lbtnManager.Attributes.Add("onclick", scrip);

        LinkButton lbtnModify = (LinkButton)e.Row.FindControl("lnkLimitModify");
        scrip = "fPopUpPage('userLimitSetAdd.aspx?mode=modify&ucd=" + user_cd + "',355,261)";
        lbtnModify.Attributes.Add("onclick", scrip);
    }
    protected void gvUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string user_cd = Convert.ToString(gvUsers.DataKeys[e.RowIndex].Value);
        new Users().UserDelete(user_cd);
        this.GvUsersBindData();

    }
    protected void lnkLimitModify_Click(object sender, EventArgs e)
    {
        this.GvUsersBindData();
    }
    protected void lnkLimitAdd_Click1(object sender, EventArgs e)
    {
        this.GvUsersBindData();
    }
    protected void gvUsers_PageIndexChanged(object sender, EventArgs e)
    {
        UCPager1.UCGridView_PageIndexChanged();
    }
    protected void lnkLimitManager_Click(object sender, EventArgs e)
    {
        this.GvUsersBindData();
    }
}

