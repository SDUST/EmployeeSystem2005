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

public partial class Master_workDayRemark : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!new UserPopedeom().GetPopedom("workDayRemark", Session["userCd"].ToString()))
        //{
        //    Response.Write("<script language = 'javascript'>alert('抱歉！您没有访问该页的权限！');history.go(-1);</script>");
        //    Response.End();
        //}
        //else
        //{
            if (!IsPostBack)
            {
                string selDay = Request.QueryString["selDay"];
                if (selDay != null && !selDay.Equals(string.Empty))
                {
                    DateTime selDate;
                    try
                    {
                        selDate = DateTime.Parse(selDay);
                    }
                    catch
                    {
                        this.ClientScript.RegisterStartupScript(this.GetType(), "selectDate", "<script>alert('请选择一个合法的日期');window.close();</script>");
                        return;
                    }
                    WorkCalendar calen = new WorkCalendar();
                    object[] values = calen.GetDayInfo(selDate.Year, selDate.Month, selDate.Day);
                    lblTitle.Text = values[0].ToString() + " " + selDate.ToLongDateString();
                    selFlag.SelectedValue = values[0].ToString();
                    txtDayMemo.Text = values[1].ToString();

                }
                else
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "selectDate", "<script>alert('请选择一个日期');window.close();</script>");
                }
            }
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //}
    }
    protected void btnSave_ServerClick(object sender, EventArgs e)
    {
        string selDay = Request.QueryString["selDay"];
        DateTime selDate=Convert.ToDateTime(selDay);

        WorkCalendar calen = new WorkCalendar();
        bool isOK=calen.UpdateCalendar(selDate.Year, selDate.Month, selDate.Day, selFlag.SelectedValue, txtDayMemo.Text);

        this.ClientScript.RegisterStartupScript(this.GetType(), "updatecalendar", "<script>alert('更新成功');window.close();</script>");
    }
}
