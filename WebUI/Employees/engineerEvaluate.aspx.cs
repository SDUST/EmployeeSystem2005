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
using Entity;

public partial class engineerEvaluate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!new UserPopedeom().GetPopedom("engineerEvaluate", Session["userCd"].ToString()))
        {
            Response.Write("<script language = 'javascript'>alert('抱歉！您没有访问该页的权限！');history.go(-1);</script>");
            Response.End();
        }
        else
        {

            this.Title = "工程评价管理";
            UCPagerV2_1.Grd = GVEmps;
            UCPagerV2_1.DataSetName = "engineerEvaluate";
        }
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
        DataSet ds = new Pjevaluations().GetEvaluation(pj_evalu, emp);
        GVEmps.DataSource = ds;
        UCPagerV2_1.TotalRecords = ds.Tables[0].Rows.Count;
        Session["engineerEvaluate"] = ds;
        GVEmps.DataBind();
        UCPagerV2_1.UCdatabound();

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
        //Pjevaluation pj_evalu = new Pjevaluation();
        //Emp emp = new Emp();
        //emp.Emp_cd = txtEmpCd.Text;
        //emp.Emp_name = txtEmpName.Text;
        //emp.Dept_cd = selDeptCd.SelectedValue;
        //emp.Pj_cd = selPjCd.SelectedValue;
        //pj_evalu.Evaluation_class = selContract.SelectedValue;
        //pj_evalu.Evaluation_date = selTime.SelectedValue;
        //Pjevaluations newpjevaluation = new Pjevaluations();
        //DataSet ds = newpjevaluation.GetEvaluation(pj_evalu, emp);

        //UCPager1_1.TotalRecords = ds.Tables[0].Rows.Count;

        //Session["aa"] = ds;




    }
    protected void GVEmps_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GVEmps.PageIndex = e.NewPageIndex;
    }
    protected void GVEmps_PageIndexChanged(object sender, EventArgs e)
    {
        Pjevaluation pj_evalu = (Pjevaluation)Session["engineer_pj_evalu"];
        Emp emp = (Emp)Session["engineer_pj_emp"];
        GVEmps.DataSource = new Pjevaluations().GetEvaluation(pj_evalu, emp);
        GVEmps.DataBind();
        //UCPager1_1.UCGridView_PageIndexChanged();
        //this.btnQuery_Click(null, null);等同于以上代码。
    }
    protected void lnkAddNew_Click(object sender, EventArgs e)
    {
        //相当于按照原先查询条件，重新绑定。
        //最后执行按钮单击事件，当调用的函数可发回服务器时，执行此事件。
        this.btnQuery_Click(null, null);
    }

    protected void lnkPrint_Click(object sender, EventArgs e)
    {
        if (GVEmps.Rows.Count > 0)
        {
            Response.Redirect("~/ExportToExcel.aspx?ds=engineerEvaluate&template=" + "engineerEvaluate");
            Response.Redirect("~/ExportToExcel.aspx?ds=companyevaluate&template=" + "companyEvaluate");


        }
    }

    protected void GVEmps_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void selContract_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void selPjCd_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void selContract_DataBound1(object sender, EventArgs e)
    {

        //为下拉框添加第一个没有任何数据的项。

        selContract.Items.Insert(0, "");
        selContract.SelectedIndex = 0;
    }
    protected void selTime_DataBound1(object sender, EventArgs e)
    {

        //为下拉框添加第一个没有任何数据的项。

        selTime.Items.Insert(0, "");
        selTime.SelectedIndex = 0;
    }
}
