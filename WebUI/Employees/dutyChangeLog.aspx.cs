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
using System.Windows.Forms;

public partial class dutyChangeLog : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
           empName.Text = Request.QueryString["emp_cd_duty"];
        recordDate.Attributes.Add("readonly", "readonly");
        this.Response.Cache.SetCacheability(HttpCacheability.NoCache);
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        if (recordDate.Text == "" && dutyName.SelectedValue == "")
        { 
            ClientScript.RegisterStartupScript(GetType(), null, "<script language=\"javascript\">alert('职务不为空！时间不为空！');</script>");
        }
        else if (recordDate.Text != "" && dutyName.SelectedValue == "")
        {           
            ClientScript.RegisterStartupScript(GetType(), null, "<script language=\"javascript\">alert('职务不为空！');</script>");
        }
        else if (recordDate.Text == "" && dutyName.SelectedValue != "")
        {
            ClientScript.RegisterStartupScript(GetType(), null, "<script language=\"javascript\">alert('时间不为空！');</script>");
        }
        else
        {
            DutyRecord record = new DutyRecord();
            Dutys duties = new Dutys();
            record.Emp_cd = Request.QueryString["emp_cd_duty"];
            record.Duty_name = dutyName.SelectedValue;
            record.Record_date = Convert.ToDateTime(recordDate.Text);
            record.Record_memo = recordMemo.Text;
            duties.InsertDutyChange(record);
            GVDuty.DataBind();
            ClientScript.RegisterStartupScript(GetType(), null, "<script language=\"javascript\">alert('变更成功！');window.returnValue=document.all.dutyName.value;</script>");
        }

    }
    protected void btnClose_Click(object sender, EventArgs e)
    {

    }
    protected void dutyName_DataBound(object sender, EventArgs e)
    {
        dutyName.Items.Insert(0,"");
        dutyName.SelectedIndex = 0;
    }
    protected void btnClose_Click1(object sender, EventArgs e)
    {
        Session["dutyname"] = dutyName.SelectedValue;
    }
    protected void GVDuty_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType != DataControlRowType.DataRow)
            return;
        else 
        if (e.Row.Cells[1].Text != null)
            e.Row.Cells[1].Text = Convert.ToDateTime(e.Row.Cells[1].Text).ToShortDateString();

    }
}
