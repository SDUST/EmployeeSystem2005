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
using DataAccess;
using Entity;

public partial class Resignation_ResignationEmpDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {


        if (!IsPostBack)
        {
            Dimissions dim = new Dimissions();
            DataSet ds = dim.GetResignationEmpInfobyId(Request.QueryString["eid"].ToString());
            txtEmpCd.Text = ds.Tables["empInfo"].Rows[0]["emp_cd"].ToString();
            txtEmpName.Text = ds.Tables["empInfo"].Rows[0]["emp_name"].ToString();
            txtDept.Text = ds.Tables["empInfo"].Rows[0]["dept_name"].ToString();
            txtPj.Text = ds.Tables["empInfo"].Rows[0]["pj_name"].ToString();
            txtJoinDate.Text = ds.Tables["empInfo"].Rows[0]["join_date"].ToString();
            txtContractBeginDate.Text = ds.Tables["empInfo"].Rows[0]["start_date"].ToString();
            txtContractEndDate.Text = ds.Tables["empInfo"].Rows[0]["end_date"].ToString();
            txtDimissionDate.Text = ds.Tables["empInfo"].Rows[0]["Dimission_Date"].ToString();
            txtContractMemo.Text = ds.Tables["empInfo"].Rows[0]["Dimission_memo"].ToString();
            if (ds.Tables["empInfo"].Rows[0]["emp_card"].ToString() == "1")
                chkEmpCard.Checked = true;
            else
                chkEmpCard.Checked = false;
            if (ds.Tables["empInfo"].Rows[0]["timecard"].ToString() == "1")
                chkTimeCard.Checked = true;
            else
                chkTimeCard.Checked = false;
            if (ds.Tables["empInfo"].Rows[0]["wage_card"].ToString() == "1")
                chkWageCard.Checked = true;
            else
                chkWageCard.Checked = false;
            if (ds.Tables["empInfo"].Rows[0]["tools"].ToString() == "1")
                chkTools.Checked = true;
            else
                chkTools.Checked = false;
            if (ds.Tables["empInfo"].Rows[0]["ark_key"].ToString() == "1")
                chkArkKey.Checked = true;
            else
                chkArkKey.Checked = false;
            if (ds.Tables["empInfo"].Rows[0]["dorm_key"].ToString() == "1")
                chkDormKey.Checked = true;
            else
                chkDormKey.Checked = false;
        }

    }

}
