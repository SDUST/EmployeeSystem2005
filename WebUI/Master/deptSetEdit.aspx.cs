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

public partial class DepartmentDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

            Depts depts = new Depts();
            DataSet ds = depts.GetdeptByDeptcd(Request.QueryString["deptcd"]);

            if (!IsPostBack)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    txtDeptCd.Text = ds.Tables["Depts"].Rows[0]["dept_cd"].ToString();
                    txtDeptName.Text = ds.Tables["Depts"].Rows[0]["dept_name"].ToString();
                    txtManager.Text = ds.Tables["Depts"].Rows[0]["manager"].ToString();
                    if (ds.Tables["Depts"].Rows[0]["dept_class"].ToString() == "0")
                        selDeptClass.SelectedIndex = 0;
                    if (ds.Tables["Depts"].Rows[0]["dept_class"].ToString() == "1")
                        selDeptClass.SelectedIndex = 1;
                    if (ds.Tables["Depts"].Rows[0]["dept_class"].ToString() == "2")
                        selDeptClass.SelectedIndex = 2;
                    if (ds.Tables["Depts"].Rows[0]["dept_class"].ToString() == "3")
                        selDeptClass.SelectedIndex = 3;

                    if (ds.Tables["Depts"].Rows[0]["dept_cd2"].ToString() == "")

                        selParentDeptCd.SelectedIndex = -1;
                    else
                    {
                        selParentDeptCd.SelectedValue = ds.Tables["Depts"].Rows[0]["dept_cd2"].ToString();

                    }
                }
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
            }

    }
    protected void selDeptClass_DataBound(object sender, EventArgs e)
    {
        selDeptClass.Items.Insert(0, "");
       
    }
    protected void selParentDeptCd_DataBound(object sender, EventArgs e)
    {
        selParentDeptCd.Items.Insert(0, "");
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        Depts depts = new Depts();
        Dept newdept = new Dept();
        newdept.OldDeptCd = Request.QueryString["deptcd"].ToString();
        newdept.DeptCd = txtDeptCd.Text;
        newdept.DeptName = txtDeptName.Text;
        newdept.DeptClass = selDeptClass.SelectedValue;
        newdept.ParentDeptCd = selParentDeptCd.SelectedValue;
        newdept.Manager = txtManager.Text;
        int p=depts.DeptUpdate(newdept);
        if (p == 2)
        {
            //数据重复
            ClientScript.RegisterStartupScript(this.GetType(), "clientScript", "<script>alert(getMsg(13,0));</script>");
        }
        if (p == 1)
        {
            //错误
            ClientScript.RegisterStartupScript(this.GetType(), "clientScript", "<script>alert(getMsg(0,1));</script>");
        }
        if (p == 0)
        {
            //添加成功! 
            ClientScript.RegisterStartupScript(this.GetType(), "clientScript", "<script>alert(getMsg(0,0));window.close();</script>");
            
        }
       
        //关闭弹出页面
        //Response.Write("<script Language = 'JavaScript'>window.close();</script>");
    }
}
