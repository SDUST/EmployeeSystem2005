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
using System.Drawing;

public partial class companyEvaluateAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //为编号和姓名赋值。
        Emps emps = new Emps();
        DataSet ds = emps.GetEmpByEmpcd(Request.QueryString["emp_cd"]);
        lblemp_name.Text = Convert.ToString(ds.Tables["Emp1"].Rows[0]["emp_name"]);
        lblemp_cd.Text = Request.QueryString["emp_cd"];
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (txtEvaluationDate.Text == "" && selEvaluationClass.SelectedValue == "")
        {
            ClientScript.RegisterStartupScript(GetType(), null, "<script language=\"javascript\">alert('评价日期不为空！评价区分不为空！');</script>");
        }
        if (txtEvaluationDate.Text == "" && selEvaluationClass.SelectedValue != "")
        {
            ClientScript.RegisterStartupScript(GetType(), null, "<script language=\"javascript\">alert('评价日期不为空！');</script>");
        }
        if (txtEvaluationDate.Text != "" && selEvaluationClass.SelectedValue == "")
        {
            ClientScript.RegisterStartupScript(GetType(), null, "<script language=\"javascript\">alert('评价区分不为空！');</script>");
        }
        if (txtEvaluationDate.Text != "" && selEvaluationClass.SelectedValue != "")
        {
            Comyevaluation comy_evalu = new Comyevaluation();
            Comyevaluations comy_evalus = new Comyevaluations();
            string emp_cd = Request.QueryString["emp_cd"];
            comy_evalu.Emp_cd = emp_cd;
            comy_evalu.Evaluation_date = txtEvaluationDate.Text;
            comy_evalu.Evaluation_class = selEvaluationClass.SelectedValue;
            comy_evalu.Evaluation_emp_name = txtEvaluationEmpName.Text;
            comy_evalu.Evaluation_memo = txtEvaluationMemo.Text;
            comy_evalu.Flag = 1;
            //判断评价日期是否已存在。
            bool check = comy_evalus.CheckComyDate(emp_cd, Convert.ToDateTime(txtEvaluationDate.Text));
            if (check == true)
            {
                comy_evalus.ComyEvaluationInsert(comy_evalu);
                GVComy_Evalu.DataBind();
            }
            else
                ClientScript.RegisterStartupScript(GetType(), null, "<script language=\"javascript\">window.alert('该日已评价！');</script>");
        }
    }
    protected void selEvaluationClass_DataBound(object sender, EventArgs e)
    {
        //为下拉框的第一个数据设为无数据的项。
        selEvaluationClass.Items.Insert(0, "");
        selEvaluationClass.SelectedIndex = 0;
    }

    protected void GVComy_Evalu_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //修改时间。
        if (e.Row.RowType != DataControlRowType.DataRow)
            return;
        else
            if (e.Row.Cells[0].Text != null)
                e.Row.Cells[0].Text = Convert.ToDateTime(e.Row.Cells[0].Text).ToShortDateString();
        //修改单元格里的值。
        if (e.Row.Cells[1].Text == "10-02")
        {
            e.Row.Cells[1].Text = "处罚";
            e.Row.Cells[1].ForeColor = Color.Red;
        }
        if (e.Row.Cells[1].Text == "10-01")
        {
            e.Row.Cells[1].Text = "奖励";

        }
    }

}
