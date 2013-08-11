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
using DataAccess;
using Business;

public partial class Master_workTimeSet : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!new UserPopedeom().GetPopedom("workTimeSet", Session["userCd"].ToString()))
        {
            Response.Write("<script language = 'javascript'>alert('抱歉！您没有访问该页的权限！');history.go(-1);</script>");
            Response.End();
        }
        else
        {
            this.Page.Title = "工作时间设置";
            //加载工作时间，将时间显示给用户
            if (!IsPostBack)
            {
                WorkTimeSet newSystemManage = new WorkTimeSet();
                txtOnDuty.Text = Convert.ToString((newSystemManage.GetWorktime()).Tables[0].Rows[0].ItemArray.GetValue(0));
                txtOffDuty.Text = Convert.ToString((newSystemManage.GetWorktime()).Tables[0].Rows[0].ItemArray.GetValue(1));
            }
        }
    }
    protected void lnkSave_Click(object sender, EventArgs e)
    {
        //调用方法实现存储工作时间
        WorkTimeSet newSystemManage = new WorkTimeSet();
        string onDuty = txtOnDuty.Text;
        string offDuty = txtOffDuty.Text;
        newSystemManage.WorktimeUpdate(onDuty, offDuty);
    }
}