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

public partial class Master_dutySetAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!new UserPopedeom().GetPopedom("dutySetAdd", Session["userCd"].ToString()))
        //{
        //    Response.Write("<script language = 'javascript'>alert('抱歉！您没有访问该页的权限！');history.go(-1);</script>");
        //    Response.End();
        //}
        //else
        //{
        //    btnSave.Attributes.Add("onclick", "javascript:if(fsBtnSave()==false) return false;");
        //}
    }

    protected void btnSave_Click1(object sender, EventArgs e)
    {
        Duty newDuty = new Duty();
        Dutys dutys = new Dutys();

        newDuty.Duty_cd = txtDutyCd.Text;
        newDuty.Duty_name = txtDutyName.Text;

        int p = dutys.DutyIinsert(newDuty);
        if (p == 2)
        {
            //ClientScript.RegisterClientScriptBlock(this.GetType(), "Popup", "<script>alert('数据重复!')</script>");
            ClientScript.RegisterStartupScript(this.GetType(), "clientScript", "<script>alert(getMsg(13,0));</script>");
        }
        if (p == 1)
        {
            //ClientScript.RegisterClientScriptBlock(this.GetType(), "Popup", "<script>alert('错误')</script>");
            ClientScript.RegisterStartupScript(this.GetType(), "clientScript", "<script>alert(getMsg(0,1));</script>");
        }
        if (p == 0)
        {
            //ClientScript.RegisterClientScriptBlock(this.GetType(), "Popup", "<script>alert('添加成功!')</script>"); 
            ClientScript.RegisterStartupScript(this.GetType(), "clientScript", "<script>alert(getMsg(0,2));window.close();</script>");
        }

    }
}
