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
using Business;

public partial class Master_workCalendarSet : System.Web.UI.Page
{
    //定义日历的颜色标识
    readonly System.Drawing.Color FADING_F = System.Drawing.Color.Red;//法定节假日字体颜色
    readonly System.Drawing.Color FADING_B = System.Drawing.Color.Red;
    readonly System.Drawing.Color GONGXIU_B = System.Drawing.Color.Yellow;//公休日背景颜色
    readonly System.Drawing.Color BEIZHU_F = System.Drawing.Color.Gray;//带有备注信息的字体色
    readonly System.Drawing.Color FADING_WEEKEND_F = System.Drawing.Color.Purple;//法定假日且是周末的字体颜色
    readonly System.Drawing.Color TODAY_B = System.Drawing.Color.FromArgb(153, 204, 204);//颜色#99CCCC

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!new UserPopedeom().GetPopedom("workCalendarSet", Session["userCd"].ToString()))
        {
            Response.Write("<script language = 'javascript'>alert('抱歉！您没有访问该页的权限！');history.go(-1);</script>");
            Response.End();
        }
        else
        {
            this.Title = "设置工作日历";

            if (!IsPostBack)
            {
                this.SetYears(2005, 2025);

                DateTime day = DateTime.Today;
                if (Request.QueryString["handleDate"] != null)
                {
                    day = Convert.ToDateTime(Request.QueryString["handleDate"]);
                }

                selYear.SelectedValue = day.Year.ToString();
                selMonth.SelectedValue = day.Month.ToString();
                Calendar1.VisibleDate = day;
                Business.WorkCalendar calen = new Business.WorkCalendar();
                ViewState["currentDays"] = calen.GetCalendar(day.Year, day.Month);
            }
        }
    }

    private void SetYears(int start, int end)
    {
        selYear.Items.Clear();
        for (int i = start; i <= end; i++)
        {
            selYear.Items.Add(new ListItem(i.ToString(), i.ToString()));
        }
    }

    private DataSet GetCurrentDays()
    {
        Business.WorkCalendar calen = new Business.WorkCalendar();
        DataSet dsWorkCalendar = calen.GetCalendar(Calendar1.VisibleDate.Year, Calendar1.VisibleDate.Month);
        return dsWorkCalendar;
    }

    //查询按钮
    protected void btnQuery_Click(object sender, EventArgs e)
    {
        DateTime selDate = new DateTime(Convert.ToInt32(selYear.SelectedValue), Convert.ToInt32(selMonth.SelectedValue), 1);
        Calendar1.VisibleDate = selDate;
        ViewState["currentDays"] = this.GetCurrentDays();
    }

    //在日历控件中呈现每一天时发生的事件
    protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
    {
        if (ViewState["currentDays"] == null)
            return;

        CalendarDay day = e.Day;
        TableCell tc = e.Cell;
        tc.Style["font-size"] = "Large";
        tc.Style["font-weigth"] = "bold";
        //tc.Attributes["onClick"]="
        DataSet dsWordCalendar = (DataSet)ViewState["currentDays"];

        //如果要显示的日期是其他月份的，则清空文本
        if (day.IsOtherMonth)
        {
            tc.Text = string.Empty;
            if (day.IsWeekend)
            {
                tc.BackColor = GONGXIU_B;
            }
            return;
        }

        DataRow[] drs = dsWordCalendar.Tables[0].Select("[day]=" + e.Day.Date.Day.ToString());
        if (drs.Length == 0)
            return;

        //设置周末（公休日）单元格的背景色和字体颜色
        if ((day.IsWeekend && drs[0]["flag"].ToString() != "平日") || (drs[0]["flag"].ToString() == "公休日"))
        {
            tc.BackColor = GONGXIU_B;
            tc.ForeColor = FADING_F;
        }

        //如果是法定节假日，设置单元格的背景色和字体颜色
        if (drs[0]["flag"].ToString() == "法定节假日")
        {
            tc.BackColor = FADING_B;
            //tc.ForeColor = FADING_F;
        }

        if (day.Date == DateTime.Today && drs[0]["flag"].ToString() == "平日")
        {
            tc.BackColor = TODAY_B;
        }

        //设置有备注内容的单元格的字体色
        if (!(drs[0].IsNull("memo") || drs[0]["memo"].ToString() == ""))
        {
            tc.ForeColor = BEIZHU_F;
            string memo = drs[0]["memo"].ToString();
            tc.ToolTip = memo.Length > 10 ? (memo.Substring(0, 10) + "...") : memo;
        }
    }

    protected void Calendar1_SelectionChanged(object sender, EventArgs e)
    {
        string strUrl = "workDayRemark.aspx?selDay=" + Calendar1.SelectedDate.ToShortDateString();
        this.ClientScript.RegisterStartupScript(this.GetType(), "key", "<script>window.showModalDialog('" + strUrl + "','','dialogWidth:280px;dialogHeight:280px;top=250;left=300;status: No;help: No;resizable=no;toolbar=no;directories=no;menubar=no;scrollbars=yes');window.location='workcalendarset.aspx?handleDate=" + Calendar1.SelectedDate.ToShortDateString() + "';</script>");
        Calendar1.VisibleDate = Calendar1.SelectedDate;
        ViewState["currentDays"] = this.GetCurrentDays();
    }
}