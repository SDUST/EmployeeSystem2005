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
using System.Drawing;
using Business;


public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userCd"] == null)
            Response.Redirect("~/Login.aspx");

        if (!new UserPopedeom().GetPopedom("deptSet", Session["userCd"].ToString()))
        {
            Response.Write("<script language = 'javascript'>alert('抱歉！您没有访问该页的权限！');history.go(-1);</script>");
            Response.End();
        }
        else
        {
            UCPager1.Grd = grd;

            //if(!IsPostBack)
            //    selParent.DataBind();
            //selParent.DataBind();
        }
        //Response.Cache.SetCacheability(HttpCacheability.NoCache);
    }
    protected void btnQuery_Click(object sender, EventArgs e)
    {

        grd.DataBind();
    }
    protected void selParent_DataBound(object sender, EventArgs e)
    {
        selParent.Items.Insert(0, "");
        selParent.SelectedIndex = 0;
    }
    protected void grd_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //if (!IsPostBack)
        //{
            if (e.Row.RowType != DataControlRowType.DataRow)
            {
                return;
            }

            LinkButton lnkSet = (LinkButton)e.Row.FindControl("lnkSet");
            LinkButton lnkEdit = (LinkButton)e.Row.FindControl("lnkEdit");

            if (e.Row.Cells[2].Text == "工程")
                lnkSet.Visible = true;
            else
                lnkSet.Visible = false;

            string deptcd = e.Row.Cells[0].Text;

            string script = "fPopUpPage1('proficiencySet.aspx?deptcd=" + deptcd + "',720,230)";
            string script2 = "fPopUpPage1('deptSetEdit.aspx?deptcd=" + deptcd + "',460,220)";

            lnkSet.Attributes.Add("onclick", script);
            lnkEdit.Attributes.Add("onclick", script2);
        //}
    }
    protected void grd_DataBound(object sender, EventArgs e)
    {
        grd.Visible = true;
        string Dept_cd = txtDeptCd.Text;

        string Dept_name = txtDeptName.Text;
        string Dept_class = selDeptClass.SelectedValue;
        string pj_cd = selParent.SelectedValue;
        Depts newDept = new Depts();

        DataSet ds = newDept.GetDepts(Dept_cd, Dept_name, Dept_class, pj_cd);
        int i = ds.Tables["Depts"].Rows.Count;
        UCPager1.TotalRecords = i;
        UCPager1.UCdatabound();

    }
    protected void grd_PageIndexChanged(object sender, EventArgs e)
    {
        UCPager1.UCGridView_PageIndexChanged();
    }
    protected void lnkAdd_Click(object sender, EventArgs e)
    {
        //grd.DataBind();
        //if(get)
    }
    protected void lnkEdit_Click(object sender, EventArgs e)
    {
        grd.DataBind();
    }
    protected void lnkSet_Click(object sender, EventArgs e)
    {

    }
}