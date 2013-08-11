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
using Common;
using System.Drawing;

public partial class recruitManager : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!new UserPopedeom().GetPopedom("recruitManager", Session["userCd"].ToString()))
        {
            Response.Write("<script language = 'javascript'>alert('抱歉！您没有访问该页的权限！');history.go(-1);</script>");
            Response.End();
        }
        else
        {

            this.Title = "招聘管理";


            if (!IsPostBack)
            {
                selDiploma.DataSource = new ComFuns().GetComFun("4");
                selDiploma.DataTextField = "fun_name";
                selDiploma.DataBind();
                selFlag.DataSource = new ComFuns().GetComFun("11");
                selFlag.DataTextField = "fun_name";
                selFlag.DataBind();
            }
            txtRectDate2.Attributes.Add("readonly", "readonly");
            txtRectDate1.Attributes.Add("readonly", "readonly");

            UCPager1.Grd = gvRect;
            UCPager1.DataSetName = "rectEmps";
        }
    }

    private void GvRectBindData()
    {
        DataSet ds = new DataSet();
        string flag = "";

        if(rdoDelet.Checked)
        {
            ds = new Rects().GetRect(txtRectCd.Text, txtRectName.Text, txtIdCard.Text, selDiploma.SelectedValue, txtRectDate1.Text, txtRectDate2.Text, 0, flag);
            gvRect.DataSource = ds;
            int i = ds.Tables["rects"].Rows.Count;

            UCPager1.TotalRecords = i;
        }
        else if (rdoQuery.Checked)
        {
            if (selFlag.SelectedValue == "合格")
                flag = "0";
            else if (selFlag.SelectedValue == "不合格")
                flag = "1";
            else if (selFlag.SelectedValue == "已录用")
                flag = "2";
            else
                flag = "";

            ds = new Rects().GetRect(txtRectCd.Text, txtRectName.Text, txtIdCard.Text, selDiploma.SelectedValue, txtRectDate1.Text, txtRectDate2.Text, 1, flag);
            gvRect.DataSource = ds;
            int i = ds.Tables["rects"].Rows.Count;

            UCPager1.TotalRecords = i;
        }

        Session["rectEmps"] = ds;
        gvRect.DataBind();

        UCPager1.UCdatabound();
    }

    protected void selDiploma_DataBound(object sender, EventArgs e)
    {
        selDiploma.Items.Insert(0, new ListItem("", ""));
        selDiploma.SelectedIndex = 0;
    }

    protected void selFlag_DataBound(object sender, EventArgs e)
    {
        selFlag.Items.Insert(0, new ListItem("全部", ""));
        selFlag.SelectedIndex = 0;
    }

    protected void btnQuery_Click(object sender, EventArgs e)
    {
        this.GvRectBindData();
    }
    protected void lnkOk_Click(object sender, EventArgs e)
    {
        Rects rects = new Rects();
        int rows = gvRect.Rows.Count;
        for (int i = 0; i < rows; i++)
        {
            if (((CheckBox)gvRect.Rows[i].FindControl("chkRect")).Checked)
            {
                string rectCd = gvRect.Rows[i].Cells[2].Text;
                rects.RectUpdate(rectCd, "0");
            }
        }
        this.GvRectBindData();
    }

    protected void gvRect_PageIndexChanged(object sender, EventArgs e)
    {
        UCPager1.UCGridView_PageIndexChanged();
    }
    protected void gvRect_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvRect.PageIndex = e.NewPageIndex;
        this.GvRectBindData();
    }

    protected void gvRect_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType != DataControlRowType.DataRow)
            return;

        e.Row.Cells[1].Text = Convert.ToDateTime(e.Row.Cells[1].Text).ToShortDateString();
        if (e.Row.Cells[5].Text != "未知")
            e.Row.Cells[5].Text = Convert.ToDateTime(e.Row.Cells[5].Text).ToShortDateString();

        if (e.Row.Cells[9].Text == "不合格")
        {
            e.Row.Cells[9].ForeColor = Color.Red;
        }

        if (e.Row.Cells[9].Text == "合格")
        {
            e.Row.Cells[9].ForeColor = Color.Blue;
        }

        if (e.Row.Cells[9].Text == "已录用")
        {
            ((CheckBox)e.Row.FindControl("chkRect")).Enabled = false;
        }
    }
    protected void lnkPrint_Click(object sender, EventArgs e)
    {
        if (gvRect.Rows.Count > 0)
        {
            Response.Redirect("~/ExportToExcel.aspx?ds=rectEmps&template=recruitManager");
        }
    }
    protected void lnkNo_Click(object sender, EventArgs e)
    {
        Rects rects = new Rects();
        int rows = gvRect.Rows.Count;
        for (int i = 0; i < rows; i++)
        {
            if (((CheckBox)gvRect.Rows[i].FindControl("chkRect")).Checked)
            {
                string rectCd = gvRect.Rows[i].Cells[2].Text;
                rects.RectUpdate(rectCd, "1");
            }
        }
        this.GvRectBindData();
    }
}

