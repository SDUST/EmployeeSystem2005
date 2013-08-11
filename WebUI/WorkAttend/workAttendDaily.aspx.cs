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

public partial class workAttendDaily : System.Web.UI.Page
{
    static DataSet ds;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userCd"] == null)
            Response.Redirect("~/Login.aspx");

        if (!new UserPopedeom().GetPopedom("workAttendDaily", Session["userCd"].ToString()))
        {
            Response.Write("<script language = 'javascript'>alert('抱歉！您没有访问该页的权限！');history.go(-1);</script>");
            Response.End();
        }
        else
        {
            if (!IsPostBack)
            {
                string month = DateTime.Now.Month.ToString(), day = DateTime.Now.Day.ToString();
                if (DateTime.Now.Month < 10)
                    month = "0" + month;
                if (DateTime.Now.Day < 10)
                    day = "0" + day;
                txtCardTime1.Text = DateTime.Now.Year.ToString() + "/" + month + "/" + day; //ToString("yyyy/MM/dd");
                txtCardTime2.Text = DateTime.Now.Year.ToString() + "/" + month + "/" + day; //ToString("yyyy/MM/dd");

                txtCardTime1.Attributes.Add("readonly", "readonly");
                txtCardTime2.Attributes.Add("readonly", "readonly");
            }

            ucPager.Grd = gv;
        }
    }
 
    protected void gv_DataBound(object sender, EventArgs e)
    {
        ucPager.UCdatabound();
    }
    protected void btnQuery_Click(object sender, EventArgs e)
    {
        ods.SelectParameters["attendanceDateBegin"].DefaultValue = txtCardTime1.Text;
        ods.SelectParameters["attendanceDateEnd"].DefaultValue = txtCardTime2.Text;

        gv.DataSourceID = "ods";

        DateTime cardTime1, cardTime2;

        cardTime1 = DateTime.Parse(txtCardTime1.Text);

        cardTime2 = DateTime.Parse(txtCardTime2.Text);

        ds = new Attendances().AttendancesSelect(cardTime1, cardTime2);

        Session["workAttendDaily"] = ds;

        ucPager.TotalRecords = ds.Tables["Attendances"].Rows.Count;
    }
    protected void gv_PageIndexChanged(object sender, EventArgs e)
    {
        ucPager.UCGridView_PageIndexChanged();
    }

    protected void lnkPrint_Click(object sender, EventArgs e)
    {
        if (gv.Rows.Count > 0)
        {
            Response.Redirect("~/ExportToExcel.aspx?ds=workAttendDaily&template=workAttendDaily");
        }
    }
}
