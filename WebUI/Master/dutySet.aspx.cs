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
using Entity;
using Business;


public partial class Master_dutySet : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!new UserPopedeom().GetPopedom("dutySet", Session["userCd"].ToString()))
        {
            Response.Write("<script language = 'javascript'>alert('抱歉！您没有访问该页的权限！');history.go(-1);</script>");
            Response.End();
        }
        else
        {
            UCPager1.Grd = GridView1;
            //if (IsPostBack)
            //{
            //    GridView1.DataBind();
            //    UCPager1.UCGridView_PageIndexChanged();
            //}
            //GridView1.DataBind();
        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType != DataControlRowType.DataRow)
        {
            return;
        }
        LinkButton lnkModi = (LinkButton)e.Row.FindControl("lnkModi");
        LinkButton lnkDel = (LinkButton)e.Row.FindControl("lnkDel");
        string duty_cd = e.Row.Cells[0].Text;
        string duty_name=e.Row.Cells[1].Text;
        lnkDel.OnClientClick = "return confirm('确定要删除[ " + duty_cd +"--"+ duty_name + " ]这个职务吗？')";
        //Session["duty_cd"] = GridView1.DataKeys[e.Row.RowIndex].ToString();

        string script = "fPopUpPage1('dutySetModify.aspx?dutycd=" + duty_cd + "','480','170')";
        ////////////////
        //Session["duty_cd"] = e.Row.Cells[0].Text;
        //Session["duty_name"] = e.Row.Cells[1].Text;
        ///////////////
        lnkModi.Attributes.Add("onclick", script);
        
    }
   
    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        Duty newDuty = new Duty();
        newDuty.Duty_cd = Convert.ToString(GridView1.DataKeys[e.RowIndex].Value);
        new Dutys().DutyDelete(newDuty);
        GridView1.DataBind();
    }
    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        UCPager1.UCdatabound();
        ////GridView1
        //int i = 0;
        //for (int j; j < GridView1.PageCount; j++)
        //{
        //    if (j == 1)
        //    {
        //        i = GridView1.Rows.Count;
        //    }
        //    else
        //    { 
        //         i=i+GridView1.PageIndex[i-1]
        //    }
        //}
        Dutys dutys=new Dutys();
        DataSet ds=dutys.GetDuty();
        int i = ds.Tables["dutys"].Rows.Count;
        UCPager1.TotalRecords = i;
    }
    protected void GridView1_PageIndexChanged(object sender, EventArgs e)
    {
        UCPager1.UCGridView_PageIndexChanged();
    }
    protected void lnkModi_Click(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }
    protected void lnkAdd_Click(object sender, EventArgs e)
    {

    }
}
