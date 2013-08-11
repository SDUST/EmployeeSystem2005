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

public partial class proficiencySet : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
            if (!IsPostBack)
            {

                Proficiencys proficiencys = new Proficiencys();
                DataSet ds = proficiencys.GetProcficiency(Request.QueryString["deptcd"]);
                Depts Depts = new Depts();
                DataSet dept = Depts.GetDeptPjBydeptcd(Request.QueryString["deptcd"]);
                txtPjName.Text = "工程：" + dept.Tables["Depts"].Rows[0]["dept_name2"].ToString();
                if (ds.Tables["procficiency"].Rows.Count == 0)
                    return;
                else
                {

                    txtFiveYear.Text = ds.Tables["procficiency"].Rows[0]["five_year"].ToString();
                    txtFourYear.Text = ds.Tables["procficiency"].Rows[0]["four_year"].ToString();
                    txtThreeYear.Text = ds.Tables["procficiency"].Rows[0]["three_year"].ToString();
                    txtTwoYear.Text = ds.Tables["procficiency"].Rows[0]["two_year"].ToString();
                    txtOneYear.Text = ds.Tables["procficiency"].Rows[0]["one_year"].ToString();
                    txtSixMonth.Text = ds.Tables["procficiency"].Rows[0]["six_month"].ToString();
                    txtThreeMonth.Text = ds.Tables["procficiency"].Rows[0]["three_month"].ToString();
                    txtTwoMonth.Text = ds.Tables["procficiency"].Rows[0]["two_month"].ToString();
                    txtOneMonth.Text = ds.Tables["procficiency"].Rows[0]["one_month"].ToString();
                    txtZeroMonth.Text = ds.Tables["procficiency"].Rows[0]["zero_month"].ToString();
                    txtPLead.Text = ds.Tables["procficiency"].Rows[0]["p_lead"].ToString();
                    txtSLead.Text = ds.Tables["procficiency"].Rows[0]["s_lead"].ToString();
                    txtOther.Text = ds.Tables["procficiency"].Rows[0]["other"].ToString();
                }

                Response.Cache.SetCacheability(HttpCacheability.NoCache);
            }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        
        Proficiencys proficiencys = new Proficiencys();
        Proficiency newProficiency = new Proficiency();
        newProficiency.Pj_cd = Request.QueryString["deptcd"].ToString();
        newProficiency.Five_year = txtFiveYear.Text;
        newProficiency.Four_year = txtFourYear.Text;
        newProficiency.Three_year = txtThreeYear.Text;
        newProficiency.Two_year = txtTwoYear.Text;
        newProficiency.One_year = txtOther.Text;
        newProficiency.Six_month = txtSixMonth.Text;
        newProficiency.Three_month = txtThreeMonth.Text;
        newProficiency.Two_month = txtTwoMonth.Text;
        newProficiency.One_month = txtOneMonth.Text;
        newProficiency.Zero_month = txtZeroMonth.Text;
        newProficiency.P_lead = txtPLead.Text;
        newProficiency.S_lead = txtSLead.Text;
        newProficiency.Other = txtOther.Text;
        int p = proficiencys.proficiencyUpdate(newProficiency);
        if (p == 0)
            ClientScript.RegisterStartupScript(this.GetType(), "clientScript", "<script>alert(getMsg(0,0));window.close();</script>");
        
    }
}
