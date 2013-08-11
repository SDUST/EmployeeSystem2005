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

public partial class Contract_contractContinue : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        txtStartDate.Attributes.Add("readonly", "readonly");
        txtEndDate.Attributes.Add("readonly", "readonly");
        if (!IsPostBack)
        {
            Emp newEmp = new Emp();
            Emps emps = new Emps();
            string cd = Request.QueryString["eid"];
            DataSet dsName = emps.GetEmpNameByEmpId(cd);
            empName.Text = dsName.Tables["empName"].Rows[0]["emp_Name"].ToString();


            //'合同期变更后，根据合同开始时间推算出合同到期时间 脚本实现
            txtContractDate.Attributes.Add("onblur", "javascript:setContractEndDate();");
            //开始日期变更后，根据合同期推算出合同到期时间 脚本实现
            txtStartDate.Attributes.Add("onchange", "javascript:setContractEndDate();");
            ContractMessage contract = new ContractMessage();
            DataSet ds = contract.GetContractEndDate(Request.QueryString["eid"]);
            txtStartDate.Text = ds.Tables["end_date"].Rows[0][0].ToString();

        }
        this.Response.Cache.SetCacheability(HttpCacheability.NoCache);
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        ContractMessage contract = new ContractMessage();
        string empcd = Request.QueryString["eid"];
        DateTime start = Convert.ToDateTime(txtStartDate.Text);
        DateTime end = Convert.ToDateTime(txtEndDate.Text);
        string year = txtContractDate.Text;
        string memo = txtmemo.Text;
        contract.OneContractContinue(empcd, start, end, year, memo);
        //Response.Write("<script Language = 'JavaScript'>window.alert('签订成功!');window.close();</script>");
        ClientScript.RegisterStartupScript(this.GetType(), null, "<script>alert('签订成功！');window.close();</script>");
    }
}
