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

public partial class Master_deptAddNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!new UserPopedeom().GetPopedom("deptAddNew", Session["userCd"].ToString()))
        //{
        //    Response.Write("<script language = 'javascript'>alert('抱歉！您没有访问该页的权限！');history.go(-1);</script>");
        //    Response.End();  
        //}
        
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        Depts depts = new Depts();
        Dept newdept = new Dept();
        newdept.DeptCd = txtDeptCd.Text;
        newdept.DeptName = txtDeptName.Text;
        newdept.DeptClass = selDeptClass.SelectedValue;
        newdept.ParentDeptCd = selParentDeptCd.SelectedValue;
        newdept.Manager = txtManager.Text;
        int p = depts.DeptInsert(newdept);
        if (p == 2)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "clientScript", "<script>alert(getMsg(13,0));</script>");
        }
        if (p == 1)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "clientScript", "<script>alert(getMsg(0,1));</script>");
        }
        if (p == 0)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "clientScript", "<script>alert(getMsg(0,2));window.close();</script>");
        }
    }
    protected void selParentDeptCd_DataBound(object sender, EventArgs e)
    {
        selParentDeptCd.Items.Insert(0, "");
        selParentDeptCd.SelectedIndex = 0;
    }
}