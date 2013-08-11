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
using System.Drawing;

using Business;

public partial class Resignation_resignWorkAttendQuery : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!new UserPopedeom().GetPopedom("resignWorkAttendQuery", Session["userCd"].ToString()))
        {
            Response.Write("<script language = 'javascript'>alert('抱歉！您没有访问该页的权限！');history.go(-1);</script>");
            Response.End();
        }
        else
        {
            if (!IsPostBack)
            {
                DateTime myDateTime = DateTime.UtcNow;
                string date = myDateTime.ToString("yyyy-MM");
                txtMonth.Text = date.Replace("-", "/");
            }
        }
    }
    protected void btnQuery_Click(object sender, EventArgs e)
    {
        GridView1.Visible = true;
        GridView2.Visible = true;
    }
    protected void selPj_DataBound(object sender, EventArgs e)
    {
        selPj.Items.Insert(0, "");
        selPj.SelectedIndex = 0;
    }
    protected void selDept_DataBound(object sender, EventArgs e)
    {
        selDept.Items.Insert(0, "");
        selDept.SelectedIndex = 0;
    }
    protected void lnkReport_Click(object sender, EventArgs e)
    {
        DataSet ds = new DataSet();
        DataTable dt = new DataTable();

        ds.Tables.Add(dt);

        int column = GridView1.Columns.Count + GridView2.Columns.Count;
        for (int i = 0; i < column; i++)
        {
            dt.Columns.Add(i.ToString());
        }
        int n = 0;
        int m = 0;
        int rows = GridView1.Rows.Count;
        for (int j = 0; j < rows; j++)
        {
            dt.Rows.Add(dt.NewRow());
            for (n = 0; n < GridView1.Columns.Count; n++)
            {
                if (GridView1.Rows[j].Cells[n].Text == null || GridView1.Rows[j].Cells[n].Text == "&nbsp;")
                {
                    dt.Rows[j][n] = null;
                }
                else
                {
                    dt.Rows[j][n] = GridView1.Rows[j].Cells[n].Text;
                }
            }
            for (m = 0; m < GridView2.Columns.Count; m++)
            {
                dt.Rows[j][n + m] = GridView2.Rows[j].Cells[m].Text;
            }
        }

        Session["ds"] = ds;

        if (GridView1.Visible == false || GridView1.Rows.Count == 0)
        {
            ClientScript.RegisterStartupScript(GetType(), null, "<script>alert('无查询数据！！');</script>");
        }
        else
        {
            if (GridView1.Rows.Count > 0 && GridView2.Rows.Count > 0)
            {
                Response.Redirect("~/ExportToExcel.aspx?ds=ds&template=resignWorkAttendQuery");
            }
        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.Cells[3].Text == "试用期")
        {
            e.Row.Cells[3].ForeColor = Color.Red;
        }
    }
}
