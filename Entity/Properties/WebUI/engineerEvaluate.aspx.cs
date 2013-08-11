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
using Bussiness;
using Entity;

public partial class engineerEvaluate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void selDeptCd_DataBound(object sender, EventArgs e)
    {
        //为下拉框添加第一个没有任何数据的项。
        selDeptCd.Items.Insert(0, "");
        selDeptCd.SelectedIndex = 0;
    }
    protected void selPjCd_DataBound(object sender, EventArgs e)
    {
        //为下拉框添加第一个没有任何数据的项。
        selPjCd.Items.Insert(0, "");
        selPjCd.SelectedIndex = 0;
    }
    protected void selContract_DataBound(object sender, EventArgs e)
    {
        //为下拉框添加第一个没有任何数据的项。
        selContract.Items.Insert(0, "");
        selContract.SelectedIndex = 0;
    }
    protected void selTime_DataBound(object sender, EventArgs e)
    {
        //为下拉框添加第一个没有任何数据的项。
        selTime.Items.Insert(0, "");
        selTime.SelectedIndex = 0;
    }
    protected void btnQuery_Click(object sender, EventArgs e)
    {
        Pjevaluation pj_evalu = new Pjevaluation();
        Emp emp = new Emp();
        emp.Emp_cd = txtEmpCd.Text;
        emp.Emp_name = txtEmpName.Text;
        emp.Dept_cd = selDeptCd.SelectedValue;
        emp.Pj_cd = selPjCd.SelectedValue;
        pj_evalu.Evaluation_class = selContract.SelectedValue;
        pj_evalu.Evaluation_date = selTime.SelectedValue;
        //添加两个Session对象并且在页索引改变后事件里重新绑定。
        Session["engineer_pj_evalu"] = pj_evalu;
        Session["engineer_pj_emp"] = emp;
        GVEmps.DataSource = new Pjevaluations().p_GetEvaluation(pj_evalu, emp);
        GVEmps.DataBind();
    }
    protected void GVEmps_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType != DataControlRowType.DataRow)
            return;
        LinkButton lnkAddNew = (LinkButton)e.Row.FindControl("lnkAddNew");
        lnkAddNew.Attributes.Add("onclick", "fPopUpPj_E('" + e.Row.Cells[0].Text + "')");

        if (e.Row.Cells[5].Text != null)
            e.Row.Cells[5].Text = Convert.ToDateTime(e.Row.Cells[5].Text).ToShortDateString();
        //在fPopUpPj_E方法前不加return默认为可发回服务器。
    }
    protected void GVEmps_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GVEmps.PageIndex = e.NewPageIndex;
    }
    protected void GVEmps_PageIndexChanged(object sender, EventArgs e)
    {
        Pjevaluation pj_evalu = (Pjevaluation)Session["engineer_pj_evalu"];
        Emp emp = (Emp)Session["engineer_pj_emp"];
        GVEmps.DataSource = new Pjevaluations().p_GetEvaluation(pj_evalu, emp);
        GVEmps.DataBind();
        //this.btnQuery_Click(null, null);等同于以上代码。
    }
    protected void lnkAddNew_Click(object sender, EventArgs e)
    {
        //相当于按照原先查询条件，重新绑定。
        //最后执行按钮单击事件，当调用的函数可发回服务器时，执行此事件。
        this.btnQuery_Click(null, null);
    }

}
