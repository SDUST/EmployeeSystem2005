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


public partial class ContractMessage_ContractLog : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
            Emp newEmp = new Emp();
            Emps emps = new Emps();
            string cd = Request.QueryString["eid"];
            DataSet ds = emps.GetEmpNameByEmpId(cd);
            empName.Text = ds.Tables["empName"].Rows[0]["emp_Name"].ToString();

            this.Response.Cache.SetCacheability(HttpCacheability.NoCache);
    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
       
    }
}
