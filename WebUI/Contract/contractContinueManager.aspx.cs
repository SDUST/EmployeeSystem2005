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

public partial class Contract_contractContinueManager : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!new UserPopedeom().GetPopedom("contractContinueManager", Session["userCd"].ToString()))
        {
            Response.Write("<script language = 'javascript'>alert('抱歉！您没有访问该页的权限！');history.go(-1);</script>");
            Response.End();
        }
        else
        {
            GridView1.PagerSettings.Visible = false;
            UCPager1.Grd = GridView1;

            if (!IsPostBack)
            {
                DateTime myDateTime = DateTime.UtcNow;
                string date = myDateTime.ToString("yyyy-MM-dd");
                txtBecomeDueFrom.Text = date.Replace("-", "/");

                txtBecomeDueto.Text = (myDateTime.AddMonths(3).ToString("yyyy-MM-dd")).Replace("-", "/");

            }
            txtBecomeDueFrom.Attributes.Add("readonly", "readonly");
            txtBecomeDueto.Attributes.Add("readonly", "readonly");

            GridView1.PagerSettings.Visible = false;
            UCPager1.Grd = GridView1;
        }
    }
    protected void selDept_DataBound(object sender, EventArgs e)
    {
        selDept.Items.Insert(0, "");
        selDept.SelectedIndex = 0;
    }
    protected void selPj_DataBound(object sender, EventArgs e)
    {
        selPj.Items.Insert(0, "");
        selPj.SelectedIndex = 0;
    }
    protected void btnQuery_Click(object sender, EventArgs e)
    {
        ContractMessage con = new ContractMessage();
        DataSet ds = con.GetEmpInfoByContractDate(txtEmpCd.Text, txtEmpName.Text, selDept.SelectedItem.Text, selPj.SelectedItem.Text, txtBecomeDueFrom.Text, txtBecomeDueto.Text);
        int i = ds.Tables["emp"].Rows.Count;
        UCPager1.TotalRecords = i;

        GridView1.Visible = true;
        GridView1.DataBind();
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType != DataControlRowType.DataRow)
            return;
        LinkButton lk = (LinkButton)e.Row.FindControl("lnkDetail");
        string emp_cd = e.Row.Cells[1].Text;
        string scrip = "fPopPage_Con( '../Contract/ContractLog.aspx?eid=" + emp_cd + "')";
        lk.Attributes.Add("onclick", scrip);

        LinkButton lb = (LinkButton)e.Row.FindControl("lnkOption");
        string scrip1 = "fPopPage_ConCon( '../Contract/contractContinue.aspx?eid=" + emp_cd + "')";
        lb.Attributes.Add("onclick", scrip1);

    }
    protected void btnCon_Click(object sender, EventArgs e)
    {
        int rows = GridView1.Rows.Count;
        string eid = "";
        for (int i = 0; i < rows; i++)
        {
            CheckBox c = new CheckBox();
            c = (CheckBox)GridView1.Rows[i].FindControl("chk");
            if (c.Checked)
                eid = eid + ((GridView1.Rows[i].Cells[1].Text) + ",");
        }
        ContractMessage con = new ContractMessage();
        int result = con.ContractRecordInsert(eid, "", 2, 1, "");
        GridView1.DataBind();
    }

    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        UCPager1.UCdatabound();
    }
    protected void GridView1_PageIndexChanged(object sender, EventArgs e)
    {
        UCPager1.UCGridView_PageIndexChanged();
    }
    protected void lnkOption_Click(object sender, EventArgs e)
    {
        btnQuery_Click(null, null);
    }
}