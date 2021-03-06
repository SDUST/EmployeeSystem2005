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
using System.Windows.Forms;

public partial class engineerEvaluateAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Title = "工程评价画面";
        //向编号和姓名里添加数据。
        Emps emps = new Emps();
        DataSet ds = emps.GetEmpByEmpcd(Request.QueryString["emp_cd"]);
        Label1.Text = Request.QueryString["emp_cd"];
        Label2.Text = Convert.ToString(ds.Tables["Emp1"].Rows[0]["emp_name"]);
        txtDate.Attributes.Add("Readonly", "Readonly");
        this.Response.Cache.SetCacheability(HttpCacheability.NoCache);
    }
    protected void selClass_DataBound(object sender, EventArgs e)
    {
        //为下拉框添加第一个没有任何数据的项。
        if (!IsPostBack)
        {
            selClass.Items.Insert(0, "");
            selClass.SelectedIndex = 0;
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (txtDate.Text == "" && selClass.SelectedValue == "")
        {
            ClientScript.RegisterStartupScript(GetType(), null, "<script language=\"javascript\">alert(getMsg(18,0));</script>");
        }
        else if (txtDate.Text == "" && selClass.SelectedValue != "")
        {
            ClientScript.RegisterStartupScript(GetType(), null, "<script language=\"javascript\">alert(getMsg(18,1));</script>");
        }
        else if (txtDate.Text != "" && selClass.SelectedValue == "")
        {
            ClientScript.RegisterStartupScript(GetType(), null, "<script language=\"javascript\">alert(getMsg(18,2));</script>");
        }
        else if (txtDate.Text != "" && selClass.SelectedValue != "")
        {
            Pjevaluations pj_evalus = new Pjevaluations();
            Pjevaluation pj_evalu = new Pjevaluation();
            pj_evalu.Emp_cd = Label1.Text;
            pj_evalu.Evaluation_class = selClass.SelectedValue;
            pj_evalu.Evaluation_date = txtDate.Text;
            pj_evalu.Evaluation_emp_name = txtEmpName.Text;
            pj_evalu.Evaluation_memo = txtMemo.Text;
            pj_evalu.Flag = 1;
            bool check = pj_evalus.CheckPjDate(Label1.Text, Convert.ToDateTime(txtDate.Text));
            if (check == true)
            {
                pj_evalus.PjEvaluationInsert(pj_evalu);
                GVevaluation.DataBind();
                ClientScript.RegisterStartupScript(GetType(), null, "<script language=\"javascript\">alert('插入成功！');</script>");
            }
            else
                ClientScript.RegisterStartupScript(GetType(), null, "<script language=\"javascript\">alert(getMsg(18,3));</script>");
        }
    }
    protected void GVevaluation_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType != DataControlRowType.DataRow)
            return;
        else
            if (e.Row.Cells[0].Text != null)
                e.Row.Cells[0].Text = Convert.ToDateTime(e.Row.Cells[0].Text).ToShortDateString();
    }
}