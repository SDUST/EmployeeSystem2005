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
using System.Drawing;

using Entity;
using Bussiness;

public partial class companyEvaluate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //使gridview控件和翻页控件联系。
        UCPager1.Grd = GVEmps;
    }
    protected void btnQuery_Click(object sender, EventArgs e)
    {
        //功能：获取总共查询记录。
        //注意：分页功能不许用GVEmps.DataSource = ds;GVEmps.DataBind();所以在控件上配置了数据源，对每个参数进行控件绑定。
        string emp_cd = txtEmpCd.Text;
        string emp_name = txtEmpName.Text;
        string dept_cd = selDeptCd.SelectedValue;
        string pj_cd = selPjCd.SelectedValue;
        string evaluation_class = selContract.SelectedValue;
        string dateBegin = txtBegin.Text;
        string dateEnd = txtTermination.Text;
        Comyevaluations comy_evalus = new Comyevaluations();
        DataSet ds = comy_evalus.GetCompanyEvaluation(emp_cd, emp_name, dept_cd, pj_cd, evaluation_class, dateBegin, dateEnd);
        int count = ds.Tables["comy"].Rows.Count;
        UCPager1.TotalRecords = count;
        GVEmps.Visible = true;
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

    //呈现 GridView 控件之前，该控件中的每一行必须绑定到数据源中的一条记录。将某个数据行（用 GridViewRow 对象表示）绑定到 GridView 控件中的数据以后，将引发 RowDataBound 事件。
    //这使您可以提供一个这样的事件处理方法，即每次发生此事件时都执行一个自定义例程（如修改绑定到该行的数据的值）。
    //GridViewRowEventArgs 对象将被传给事件处理方法，以便您可以访问正在绑定的行的属性。
    //若要访问行中的特定单元格，请使用 GridViewRowEventArgs 对象的 Cells 属性。使用 RowType 属性可确定正在绑定的是哪一种行类型（标题行、数据行等等）。
    protected void GVEmps_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType != DataControlRowType.DataRow)
            return;
        //点击'评价'时，为此按钮添加点击属性转到评价页面。
        LinkButton lnk = (LinkButton)e.Row.FindControl("lnkAddNew");
        lnk.Attributes.Add("onclick", "fPopUpCE('" + e.Row.Cells[0].Text + "','" + e.Row.Cells[1].Text + "')");
        //修改绑定到该行的数据的值.
        if (e.Row.Cells[5].Text == "处罚")
        {
            e.Row.Cells[5].ForeColor = Color.Red;
        }
    }
    protected void GVEmps_DataBound(object sender, EventArgs e)
    {
        //翻页控件
        UCPager1.UCdatabound();
    }
    protected void GVEmps_PageIndexChanged(object sender, EventArgs e)
    {
        //翻页控件
        UCPager1.UCGridView_PageIndexChanged();
    }
    protected void lnkAddNew_Click(object sender, EventArgs e)
    {
        //添加评价后，重新绑定。
        this.btnQuery_Click(null, null);
        GVEmps.DataBind();
    }
}
