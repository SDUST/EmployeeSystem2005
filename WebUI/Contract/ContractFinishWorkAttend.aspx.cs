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
using Common;

public partial class ContractMessage_ContractFinishWorkAttend : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userCd"] == null)
            Response.Redirect("~/Login.aspx");

        if (!new UserPopedeom().GetPopedom("contractFinishWorkAttend", Session["userCd"].ToString()))
        {
            Response.Write("<script language = 'javascript'>alert('抱歉！您没有访问该页的权限！');history.go(-1);</script>");
            Response.End();
        }
        else
        {
            if (!IsPostBack)
            {
                DateTime myDateTime = DateTime.UtcNow;
                string date = myDateTime.ToString("yyyy-MM");
                selContract.Text = date.Replace("-", "/");
            }
        }
    }
    protected void btnQuery_Click(object sender, EventArgs e)
    {
        ContractMessage con = new ContractMessage();
        string eid;
        eid = txtEmpCd.Text;
        DataSet ds = con.GetSearchEmpInfoSql(eid);
        if (ds.Tables["empInfo"].Rows.Count == 0)
        {
            txtEmpName.Text = "";
            selDept.Items.Clear();
            selPj.Items.Clear();
            GridView1.Visible = false;
            GridView5.Visible = false;
            GridView3.Visible = false;
            GridView2.Visible = false;
            GridView4.Visible = false;
            ClientScript.RegisterStartupScript(GetType(), null, "<script language=javascript>alert('无此员工');</script>");
        }
        else
        {
            txtEmpName.Text = ds.Tables["empInfo"].Rows[0]["emp_Name"].ToString();
            selDept.Items.Add(ds.Tables["empInfo"].Rows[0]["dept_name"].ToString());
            selPj.Items.Add(ds.Tables["empInfo"].Rows[0]["pj_name"].ToString());
            Panel1.Visible = true;
            Panel2.Visible = true;
            GridView1.Visible = true;
            GridView5.Visible = true;
            GridView3.Visible = true;
            GridView2.Visible = true;
            GridView4.Visible = true;
        }

        lbContract.Text = selContract.Text + "出勤表";
        lbContractTime.Text = "加班日报表" + selContract.Text;
        lb.Visible = true;
    }
    protected void btn_Click(object sender, EventArgs e)
    {
        
    }
}
