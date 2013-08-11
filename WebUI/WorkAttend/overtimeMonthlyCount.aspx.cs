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

public partial class WorkAttend_overtimeMonthlyCount : System.Web.UI.Page
{
    static DataSet ds, dsTotal;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userCd"] == null)
            Response.Redirect("~/Login.aspx");

        if (!new UserPopedeom().GetPopedom("overtimeMonthlyCount", Session["userCd"].ToString()))
        {
            Response.Write("<script language = 'javascript'>alert('抱歉！您没有访问该页的权限！');history.go(-1);</script>");
            Response.End();
        }
        else
        {
            if (!IsPostBack)
            {
                lnkFirstPage.Enabled = false;
                lnkPriviousPage.Enabled = false;
                lnkNextPage.Enabled = false;
                lnkLastPage.Enabled = false;

                string month = DateTime.Now.Month.ToString();
                if (DateTime.Now.Month < 10)
                    month = "0" + month;
                txtMonthQuer.Text = DateTime.Now.Year.ToString() + "/" + month; //ToString("yyyy/MM");
            }
        }
    }
    protected void btnQuery_Click(object sender, EventArgs e)
    {
        //ods.SelectParameters["empCd"].DefaultValue = txtEmpCd.Text;
        //ods.SelectParameters["empName"].DefaultValue = txtEmpName.Text;
        //ods.SelectParameters["deptCd"].DefaultValue = selDept.SelectedValue;
        //ods.SelectParameters["pjCd"].DefaultValue = selPj.SelectedValue;
        //ods.SelectParameters["attendanceDate"].DefaultValue = txtMonthQuer.Text;
        //ods.SelectParameters["empClass"].DefaultValue = selEmpClass.SelectedValue;

        //ods.SelectParameters["empCd"].DefaultValue = txtEmpCd.Text;
        //ods.SelectParameters["empName"].DefaultValue = txtEmpName.Text;
        //ods.SelectParameters["deptCd"].DefaultValue = selDept.SelectedValue;
        //ods.SelectParameters["pjCd"].DefaultValue = selPj.SelectedValue;
        //ods.SelectParameters["attendanceDate"].DefaultValue = txtMonthQuer.Text;
        //ods.SelectParameters["empClass"].DefaultValue = selEmpClass.SelectedValue;

        //gv.DataSourceID = "ods";
        //gvTotal.DataSourceID = "odsTotal";

        //////////////////////////////////////////////////////////////////////////////

        DateTime attendanceDate;
        if (txtMonthQuer.Text != "")
            attendanceDate = DateTime.Parse(txtMonthQuer.Text.Split(new char[] { '/', '-' })[0] + "-" + txtMonthQuer.Text.Split(new char[] { '/', '-' })[1] + "-01");
        else
            attendanceDate = DateTime.MinValue;

        ds = new Attendances().GetOvertimesMonthly(txtEmpCd.Text, txtEmpName.Text, selDept.SelectedValue, selPj.SelectedValue, attendanceDate, selEmpClass.SelectedValue);

        gv.DataSource = ds;
        gv.DataBind();

        if (gv.PageCount != 0)
            lblTotolPageCount.Text = gv.PageCount.ToString();
        else
            lblTotolPageCount.Text = " ";
        lblRecordCount.Text = ds.Tables["OvertimesMonthly"].Rows.Count.ToString();

        dsTotal = new Attendances().GetOvertimesMonthlyTotal(txtEmpCd.Text, txtEmpName.Text, selDept.SelectedValue, selPj.SelectedValue, attendanceDate, selEmpClass.SelectedValue);

        DataSet dsTemp = ds.Copy();
        DataRow dr = dsTemp.Tables["OvertimesMonthly"].NewRow();
        int count = dsTotal.Tables["OvertimesMonthlyTotal"].Columns.Count;
        for (int i = 0; i < count; i++)
        {
            dr[i] = dsTotal.Tables["OvertimesMonthlyTotal"].Rows[0][i];
        }
        dsTemp.Tables["OvertimesMonthly"].Rows.Add(dr);

        Session["overtimeMonthlyCount"] = dsTemp;

        gvTotal.DataSource = dsTotal;
        gvTotal.DataBind();

        selPage.Items.Clear();
        for (int i = 0; i < gv.PageCount; i++)
            selPage.Items.Add(new ListItem((i + 1).ToString()));
    }
    protected void lnkFirstPage_Click(object sender, EventArgs e)
    {
        gv.PageIndex = 0;
        gv.DataSource = ds;
        gv.DataBind(); //gv_DataBound(null, null);
    }
    protected void lnkPriviousPage_Click(object sender, EventArgs e)
    {
        gv.PageIndex--;
        gv.DataSource = ds;
        gv.DataBind();
    }
    protected void lnkNextPage_Click(object sender, EventArgs e)
    {
        gv.PageIndex++;
        gv.DataSource = ds;
        gv.DataBind();
    }
    protected void lnkLastPage_Click(object sender, EventArgs e)
    {
        gv.PageIndex = gv.PageCount - 1;
        gv.DataSource = ds;
        gv.DataBind();
    }
    protected void selPage_SelectedIndexChanged(object sender, EventArgs e)
    {
        gv.PageIndex = selPage.SelectedIndex;
        gv.DataSource = ds;
        gv.DataBind();
    }
    protected void gv_DataBound(object sender, EventArgs e)
    {
        if (gv.PageCount != 0)
        {
            lblCurrentPage.Text = (gv.PageIndex + 1).ToString();
            //lblTotolPageCount.Text = gv.PageCount.ToString();
        }
        else
        {
            lblCurrentPage.Text = " ";
            //lblTotolPageCount.Text = " ";
        }

        //DateTime attendanceDate;
        //if (!DateTime.TryParse(txtMonthQuer.Text, out attendanceDate))
        //    attendanceDate = DateTime.MinValue;
        //lblRecordCount.Text = new Attendances().GetOvertimesMonthly(txtEmpCd.Text, txtEmpName.Text, selDept.SelectedValue, selPj.SelectedValue, attendanceDate, selEmpClass.SelectedValue).Tables["OvertimesMonthly"].Rows.Count.ToString();

        //selPage.Items.Clear();
        //for (int i = 0; i < gv.PageCount; i++)
        //    selPage.Items.Add(new ListItem((i + 1).ToString()));

        if (selPage.Items.Count != 0)
            selPage.SelectedIndex = gv.PageIndex;

        if (gv.PageCount < 2)
        {
            lnkFirstPage.Enabled = false;
            lnkPriviousPage.Enabled = false;
            lnkNextPage.Enabled = false;
            lnkLastPage.Enabled = false;
        }
        else
        {
            lnkFirstPage.Enabled = true;
            lnkPriviousPage.Enabled = true;
            lnkNextPage.Enabled = true;
            lnkLastPage.Enabled = true;
        }
        if (gv.PageIndex == 0)
        {
            lnkFirstPage.Enabled = false;
            lnkPriviousPage.Enabled = false;
        }
        else if (gv.PageIndex == gv.PageCount - 1)
        {
            lnkNextPage.Enabled = false;
            lnkLastPage.Enabled = false;
        }
        else
        {
            lnkFirstPage.Enabled = true;
            lnkPriviousPage.Enabled = true;
            lnkNextPage.Enabled = true;
            lnkLastPage.Enabled = true;
        }
    }
    protected void selDept_DataBound(object sender, EventArgs e)
    {
        selDept.Items.Insert(0, new ListItem());
    }
    protected void selPj_DataBound(object sender, EventArgs e)
    {
        selPj.Items.Insert(0, new ListItem());
    }
    protected void selEmpClass_DataBound(object sender, EventArgs e)
    {
        selEmpClass.Items.Insert(0, new ListItem());
    }
    protected void lnkReport_Click(object sender, EventArgs e)
    {
        if (gv.Rows.Count > 0)
        {
            Response.Redirect("~/ExportToExcel.aspx?ds=overtimeMonthlyCount&template=overtimeMonthlyCount");
        }
    }

}
