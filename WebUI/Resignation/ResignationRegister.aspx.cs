﻿using System;
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
using Entity;
using System.Drawing;


public partial class Resignation_ResignationRegister : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!new UserPopedeom().GetPopedom("resignationRegister", Session["userCd"].ToString()))
        {
            Response.Write("<script language = 'javascript'>alert('抱歉！您没有访问该页的权限！');history.go(-1);</script>");
            Response.End();
        }
        else
        {
        GridView1.PagerSettings.Visible = false;
        UCPager1.Grd = GridView1;
        }
    }
    protected void btnDetail_Click(object sender, EventArgs e)
    {
        GridView1.Visible = true;
        GridView1.DataBind();

        Dimissions dims = new Dimissions();
        DataSet ds = dims.GetEmpByCondition(txtEmpCd.Text, txtEmpName.Text, selDept.Text, selPj.Text);
        int i = ds.Tables["emp"].Rows.Count;
        UCPager1.TotalRecords = i;
    }
    protected void selDept_DataBound(object sender, EventArgs e)
    {
        selDept.Items.Insert(0, "");
        selDept.SelectedIndex = 0;        
    }
    protected void selPj_DataBound(object sender, EventArgs e)
    {
        selPj.Items.Insert(0, "");
        selPj.SelectedIndex = 0;
    }
    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        UCPager1.UCdatabound();
        if (GridView1.Rows.Count == 0)
            GridView1.Visible = false;

    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType != DataControlRowType.DataRow)
            return;
        LinkButton lk = (LinkButton)e.Row.FindControl("btnDetail");
        string emp_cd=e.Row.Cells[0].Text;
        string scrip = "fPopPage_Con( '/webui/Contract/ContractLog.aspx?eid=" + emp_cd + "')";        
        lk.Attributes.Add("onclick",scrip);
       
        LinkButton lk1 = (LinkButton)e.Row.FindControl("btnRegistered");
        string scrip1 = "fPopPage_Det( '/webui/Resignation/ResignationRegisterAdd.aspx?eid=" + emp_cd + "')";
        lk1.Attributes.Add("onclick", scrip1);


        if (e.Row.Cells[5].Text == "试用期")
        {
            e.Row.Cells[5].ForeColor = Color.Red;
        }
        
    }
    protected void LinkButton4_Click(object sender, EventArgs e)
    {
        GridView1.PageIndex = 0;
        GridView1_PageIndexChanged(sender, e);
    }
    protected void LinkButton7_Click(object sender, EventArgs e)
    {
        int lastpage = (Convert.ToInt32(GridView1.PageCount.ToString()) - 1);
        GridView1.PageIndex = lastpage;
        GridView1_PageIndexChanged(sender, e);
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }
    protected void LinkButton5_Click(object sender, EventArgs e)
    {
        GridView1.PageIndex = GridView1.PageIndex - 1;
        GridView1_PageIndexChanged(sender, e);
    }
    protected void LinkButton6_Click(object sender, EventArgs e)
    {
        GridView1.PageIndex = GridView1.PageIndex + 1;
        GridView1_PageIndexChanged(sender, e);
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void GridView1_PageIndexChanged(object sender, EventArgs e)
    {
        UCPager1.UCGridView_PageIndexChanged();
       
    }
 
    protected void btnRegistered_Click1(object sender, EventArgs e)
    {
        btnDetail_Click(null, null);
    }
}






