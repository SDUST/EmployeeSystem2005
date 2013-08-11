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

public partial class Resignation_ResignationRegisterAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Emps emps = new Emps();
            DataSet ds = null;
            ds = emps.GetEmpInfoByEmpID(Request.QueryString["eid"].ToString());
            txtEmpCd.Text = ds.Tables["emp"].Rows[0]["emp_cd"].ToString();
            txtEmpName.Text = ds.Tables["emp"].Rows[0]["emp_name"].ToString();
            txtDept.Text = ds.Tables["emp"].Rows[0]["dept_name"].ToString();
            txtPj.Text = ds.Tables["emp"].Rows[0]["pj_name"].ToString();
            txtJoinDate.Text = ds.Tables["emp"].Rows[0]["join_date"].ToString();
            txtContractBeginDate.Text = ds.Tables["emp"].Rows[0]["start_date"].ToString();
            txtContractEndDate.Text = ds.Tables["emp"].Rows[0]["end_date"].ToString();

            txtDimissionDate.Attributes.Add("readonly", "readonly");
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        Dimission dim = new Dimission();
        Dimissions dims = new Dimissions();
        dim.Emp_cd = txtEmpCd.Text;
        dim.Dimission_date = txtDimissionDate.Text;
        dim.Dimission_memo = txtContractMemo.Text;
        if (chkEmpCard.Checked)
            dim.Emp_card = "1";
        else
            dim.Emp_card = "0";

        if (chkTimeCard.Checked)
            dim.Timecard = "1";
        else
            dim.Timecard = "0";

        if (chkWageCard.Checked)
            dim.Wage_card = "1";
        else
            dim.Wage_card = "0";

        if (chkTools.Checked)
            dim.Tools = "1";
        else
            dim.Tools = "0";

        if (chkArkKey.Checked)
            dim.Ark_key = "1";
        else
            dim.Ark_key = "0";

        if (chkDormKey.Checked)
            dim.Drom_key = "1";
        else
            dim.Drom_key = "0";
        if (txtDimissionDate.Text == "")
            ClientScript.RegisterStartupScript(GetType(), null, "<script language=\"javascript\">alert('离职日期不能为空！')</script>");
        else
        {
            dims.PEmpInsert(dim);
            Response.Write("<script Language = 'JavaScript'>alert('更新成功');window.close();</script>");
        }

        //Response.Write("<script Language = 'JavaScript'>window.close();</script>");

    }
    protected void btnClose_Click(object sender, EventArgs e)
    {

    }

}