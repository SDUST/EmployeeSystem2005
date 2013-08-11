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
using Entity;
using Bussiness;

public partial class empBaseInfo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //应用对象--数据源--翻页控件。
        UCPager1_1.Grd = GVEmps;
        UCPager1_1.DataSetName = "GetEmps";               
    }
    protected void btnQuery_Click(object sender, EventArgs e)
    {
        //根据查询条件查询员工信息。
        Emp emp = new Emp();
        emp.Emp_cd = txtEmpCd.Text;
        emp.Emp_name = txtEmpName.Text;
        emp.Dept_cd = selDept.SelectedItem.Value;
        emp.Pj_cd = selPj.SelectedValue;
        emp.Marry = selMarry.SelectedValue;
        emp.Contract_class = selContract.SelectedValue;
        //为gridview控件重新绑定时用到Session对象。
        Session["Query"] = emp;
        GVEmps.Visible = true;
        DataSet ds = new Emps().GetEmps(emp);
        
        GVEmps.DataSource = ds;
        UCPager1_1.TotalRecords= ds.Tables[0].Rows.Count;
        Session["GetEmps"] = ds;
        GVEmps.DataKeyNames = new string[] { "emp_cd" };
        GVEmps.DataBind();
        UCPager1_1.UCdatabound();
    }
    protected void selDept_DataBound(object sender, EventArgs e)
    {
        //为下拉框添加第一个没有任何数据的项。
        selDept.Items.Insert(0, "");
        selDept.SelectedIndex = 0;
    }
    protected void selPj_DataBound(object sender, EventArgs e)
    {
        //为下拉框添加第一个没有任何数据的项。
        selPj.Items.Insert(0, "");
        selPj.SelectedIndex = 0;
    }
    protected void selContract_DataBound(object sender, EventArgs e)
    {
        //为下拉框添加第一个没有任何数据的项。
        selContract.Items.Insert(0, "");
        selContract.SelectedIndex = 0;
    }
   
    protected void GVEmps_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType != DataControlRowType.DataRow)
            return;
        //为删除按钮添加单击属性。
        LinkButton lnk = (LinkButton)e.Row.FindControl("lnkDelete");
        lnk.Attributes.Add("onclick", "return confirm('确实要删除 " + e.Row.Cells[0].Text + ":" + e.Row.Cells[1].Text + " 吗？');");
        //为详细按钮添加单击属性。
        LinkButton lnkDetail = (LinkButton)e.Row.FindControl("lnkDetail");
        lnkDetail.Attributes.Add("onclick", "fPopUpEmpDetail('" + e.Row.Cells[0].Text + "','edit')");
    }
    protected void GVEmps_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //gridview控件的页索引=点击的索引值。
        GVEmps.PageIndex = e.NewPageIndex;
    }
    protected void GVEmps_PageIndexChanged(object sender, EventArgs e)
    {
        //重新绑定。
        Emp emp = new Emp();
        emp = (Emp)Session["Query"];
        GVEmps.Visible = true;
        GVEmps.DataSource = new Emps().GetEmps(emp);
        GVEmps.DataBind();
        UCPager1_1.UCGridView_PageIndexChanged();
    }
    protected void lnkDetail_Click(object sender, EventArgs e)
    {
        this.btnQuery_Click(null, null);
    }

    protected void GVEmps_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        //执行删除操作。
        string emp_cd = Convert.ToString(GVEmps.DataKeys[e.RowIndex].Value);
        Emps emps = new Emps();
        emps.EmpDelete(emp_cd);
        //把此控件重新绑定。
        Emp emp = new Emp();
        emp = (Emp)Session["Query"];
        GVEmps.Visible = true;
        GVEmps.DataSource = new Emps().GetEmps(emp);
        GVEmps.DataBind();
        //弹出消息框。
        ClientScript.RegisterStartupScript(GetType(), null, "<script language=\"javascript\">alert('删除成功！');window.close();</script>");
    }
}
