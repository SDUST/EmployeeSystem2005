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

public partial class jobDistribute : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userCd"] == null)
            Response.Redirect("~/Login.aspx");

        if (!new UserPopedeom().GetPopedom("jobDistribute", Session["userCd"].ToString()))
        {
            Response.Write("<script language = 'javascript'>alert('抱歉！您没有访问该页的权限！');history.go(-1);</script>");
            Response.End();
        }
        else
        {
            this.Page.Title = "工程分配";

            UCPager1.Grd = gvEmp1;
            UCPager1.DataSetName = "selectedEmps";

            chkPj.AutoPostBack = true;
            if (chkPj.Checked)
                selPj.Enabled = false;
            else
                selPj.Enabled = true;


            if (!IsPostBack)
            {
                selDept.DataSource = new Depts().GetDeptNameOrPjName("0");
                selDept.DataTextField = "dept_name";
                selDept.DataValueField = "dept_cd";
                selDept.DataBind();
                selPj.DataSource = new Depts().GetDeptNameOrPjName("3");
                selPj.DataTextField = "dept_name";
                selPj.DataValueField = "dept_cd";
                selPj.DataBind();
                selSelectPj.DataSource = new Depts().GetDeptNameOrPjName("3");
                selSelectPj.DataTextField = "dept_name";
                selSelectPj.DataValueField = "dept_cd";
                selSelectPj.DataBind();

            }
        }
    }

    private void GvEmp1BindData()
    {
        DataSet ds = new DataSet();
        gvEmp1.Visible = true;
        Emps emps = new Emps();
        if (!chkPj.Checked)
        {
            ds = emps.GetEmps(txtEmpCd.Text, txtEmpName.Text, selDept.SelectedValue, selPj.SelectedValue, 0);
            gvEmp1.DataSource = ds;
            UCPager1.TotalRecords = ds.Tables[0].Rows.Count;
        }
        else
        {
            ds = emps.GetEmps(txtEmpCd.Text, txtEmpName.Text, selDept.SelectedValue, selPj.SelectedValue, 1);
            gvEmp1.DataSource = ds;
            UCPager1.TotalRecords = ds.Tables[0].Rows.Count;
        }


        Session["selectedEmps"] = ds;

        gvEmp1.DataBind();
        UCPager1.UCdatabound();
    }

    protected void btnQuery_Click(object sender, EventArgs e)
    {
        this.GvEmp1BindData();
    }


    protected void btnSave_Click(object sender, EventArgs e)
    {
        ArrayList al = new ArrayList();
        if (Session["chkEmps"] != null)
        {
            al = (ArrayList)Session["chkEmps"];
        }

        for (int i = 0; i < gvEmp1.Rows.Count; i++)
        {
            CheckBox ck = (CheckBox)gvEmp1.Rows[i].FindControl("chkEmp");
            HiddenField hf = (HiddenField)gvEmp1.Rows[i].FindControl("HiddenField1");
            if (ck.Checked && !al.Contains(hf.Value))
                al.Add(hf.Value);
            if (!ck.Checked && al.Contains(hf.Value))
                al.Remove(hf.Value);
        }

        Emps emps = new Emps();

        for (int m = 0; m < al.Count; m++)
            emps.EmpUpdate(al[m].ToString(), selSelectPj.SelectedValue);

        //int rows = gvEmp1.Rows.Count;

        //for (int i = 0; i < rows; i++)
        //{
        //    if (((CheckBox)gvEmp1.Rows[i].FindControl("chkEmp")).Checked)
        //    {
        //        string empCd = gvEmp1.Rows[i].Cells[1].Text;
        //        emps.EmpUpdate(empCd, selSelectPj.SelectedValue);
        //    }
        //}

        gvEmp2.DataSource = new Emps().GetEmpsAndPjNames(selSelectPj.SelectedValue);
        gvEmp2.DataBind();
        this.GvEmp1BindData();
    }
    protected void selSelectPj_SelectedIndexChanged(object sender, EventArgs e)
    {
        Panel1.Visible = true;
        gvEmp2.Visible = true;
        gvEmp2.DataSource = new Emps().GetEmpsAndPjNames(selSelectPj.SelectedValue);
        gvEmp2.DataBind();
    }

    protected void selDept_DataBound(object sender, EventArgs e)
    {
        selDept.Items.Insert(0, new ListItem("", ""));
        selDept.SelectedIndex = 0;
    }
    protected void selPj_DataBound(object sender, EventArgs e)
    {
        selPj.Items.Insert(0, new ListItem("", ""));
        selPj.SelectedIndex = 0;
    }
    protected void selSelectPj_DataBound(object sender, EventArgs e)
    {
        selSelectPj.Items.Insert(0, new ListItem("", ""));
        selSelectPj.SelectedIndex = 0;
    }

    protected void gvEmp1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        ArrayList al = new ArrayList();
        if (Session["chkEmps"] != null)
            al = (ArrayList)Session["chkEmps"];
        for (int i = 0; i < gvEmp1.Rows.Count; i++)
        {
            CheckBox ck = (CheckBox)gvEmp1.Rows[i].FindControl("chkEmp");
            HiddenField hf = (HiddenField)gvEmp1.Rows[i].FindControl("HiddenField1");
            if (ck.Checked && !al.Contains(hf.Value))
                al.Add(hf.Value);
            if (!ck.Checked && al.Contains(hf.Value))
                al.Remove(hf.Value);
        }
        Session["chkEmps"] = al;

        gvEmp1.PageIndex = e.NewPageIndex;
        this.GvEmp1BindData();
    }
    //不使用java脚本实现点击选择全部选中
    //protected void lbtnSelect_Click(object sender, EventArgs e)
    //{

    //    int rows = gvEmp1.Rows.Count;
    //    if (((LinkButton)gvEmp1.HeaderRow.FindControl("lbtnSelect")).Text == "选择")
    //    {
    //        for (int i = 0; i < rows; i++)
    //        {

    //            ((CheckBox)gvEmp1.Rows[i].FindControl("chkEmp")).Checked = true;

    //        }
    //        ((LinkButton)gvEmp1.HeaderRow.FindControl("lbtnSelect")).Text = "取消";
    //    }
    //    else
    //    {
    //        for (int i = 0; i < rows; i++)
    //        {

    //            ((CheckBox)gvEmp1.Rows[i].FindControl("chkEmp")).Checked = false;

    //        }
    //        ((LinkButton)gvEmp1.HeaderRow.FindControl("lbtnSelect")).Text = "选择";
    //    }
    //}

    protected void gvEmp1_PageIndexChanged(object sender, EventArgs e)
    {
        ArrayList al = new ArrayList();
        if (Session["chkEmps"] != null)
            al = (ArrayList)Session["chkEmps"];
        for (int i = 0; i < gvEmp1.Rows.Count; i++)
        {
            CheckBox ck = (CheckBox)gvEmp1.Rows[i].FindControl("chkEmp");
            HiddenField hf = (HiddenField)gvEmp1.Rows[i].FindControl("HiddenField1");
            if (al.Contains(hf.Value))
                ck.Checked = true;
            else
                ck.Checked = false;
        }
        UCPager1.UCGridView_PageIndexChanged();
    }


}