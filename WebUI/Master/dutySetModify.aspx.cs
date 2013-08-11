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

public partial class Master_dutySetModify : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        

            if (!IsPostBack)
            {
                Dutys dutys = new Dutys();
                DataSet ds = dutys.GetDutyBydutycd(Request.QueryString["dutycd"]);
                txtDutyCd.Text = ds.Tables["duty"].Rows[0]["duty_cd"].ToString();
                txtDutyName.Text = ds.Tables["duty"].Rows[0]["duty_name"].ToString();

                Response.Cache.SetCacheability(HttpCacheability.NoCache);
            }

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        Duty newDuty = new Duty();
        Dutys dutys = new Dutys();
        newDuty.Old_duty_cd = Request.QueryString["dutycd"].ToString();
        newDuty.Duty_cd = txtDutyCd.Text;
        newDuty.Duty_name = txtDutyName.Text;
        dutys.DutyUpdate(newDuty);

        //this.ClientScript.RegisterStartupScript(this.GetType(), "update", "<script>alert('更新成功！');window.close();</script>");
        ClientScript.RegisterStartupScript(this.GetType(), "clientScript", "<script>alert(getMsg(0,0));window.close();</script>");
    }
}
