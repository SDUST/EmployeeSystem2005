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

public partial class UserControls_UCPagerV2 : System.Web.UI.UserControl
{
    GridView grd = null; 
    int totalRecords = 0;
    string dataSetName="";

    /// <summary>
    /// 代码绑定的翻页控件
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DDLpage.Enabled = false;
            LnkUp.Enabled = false;
            LnkFirst.Enabled = false;
            LnkDown.Enabled = false;
            LnkLast.Enabled = false;
        }
    }
    /// <summary>
    /// 共n页，当前是第m页；根据n值为DropDownList(DDLpage)插入Index和Values
    /// </summary>
    public void UCdatabound()
    {
        Label3.Text = "共" + grd.PageCount.ToString() + "页";
        Label1.Text = "第" + Convert.ToString(Convert.ToInt32(grd.PageIndex.ToString()) + 1) + "页";

        DDLpage.Items.Clear();
        int dlpagecount = Convert.ToInt32(grd.PageCount.ToString());
        for (int i = 1; i <= dlpagecount; i++)
        {
            string j = Convert.ToString(i);
            DDLpage.Items.Insert((i - 1), j);
        }
        UCGridView_PageIndexChanged();
    }
    /// <summary>
    /// 设置按钮的属性(是否为服务器控件)
    /// </summary>
    public void UCGridView_PageIndexChanged()
    {
        if (grd.Rows.Count != 0)
        {
            Label1.Text = "第" + Convert.ToString(Convert.ToInt32(grd.PageIndex.ToString()) + 1) + "页";
        }
        if (grd.Rows.Count == 0)
        {
            Label1.Text = "第0页";
        }
        DDLpage.Text = Convert.ToString(grd.PageIndex + 1);

        if (grd.PageIndex == 0)
        {
            LnkFirst.Enabled = false;
            LnkUp.Enabled = false;
            DDLpage.Enabled = false;
        }
        else
        {
            LnkFirst.Enabled = true;
            LnkUp.Enabled = true;
            DDLpage.Enabled = true;
        }
        if (grd.PageIndex == (Convert.ToInt32(grd.PageCount.ToString()) - 1) || grd.Rows.Count == 0)
        {
            LnkLast.Enabled = false;
            LnkDown.Enabled = false;
        }
        else
        {
            LnkLast.Enabled = true;
            LnkDown.Enabled = true;
            DDLpage.Enabled = true;
        }

        DataSet ds = (DataSet)Session[dataSetName];
        grd.DataSource = ds;
        grd.DataMember = ds.Tables[0].TableName;

        grd.DataBind();
    }
    /// <summary>
    /// 以下为实现翻页功能
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void LnkFirst_Click(object sender, EventArgs e)
    {
        grd.PageIndex = 0;
        UCGridView_PageIndexChanged();
    }
    protected void LnkUp_Click(object sender, EventArgs e)
    {
        grd.PageIndex = grd.PageIndex - 1;
        UCGridView_PageIndexChanged();
    }
    protected void LnkDown_Click(object sender, EventArgs e)
    {
        grd.PageIndex = grd.PageIndex + 1;
        UCGridView_PageIndexChanged();
    }
    protected void LnkLast_Click(object sender, EventArgs e)
    {
        int lastpage = (Convert.ToInt32(grd.PageCount.ToString()) - 1);
        grd.PageIndex = lastpage;
        UCGridView_PageIndexChanged();
    }
    protected void DDLpage_SelectedIndexChanged(object sender, EventArgs e)
    {
        grd.PageIndex = (DDLpage.SelectedIndex);
        UCGridView_PageIndexChanged();
    }


    /// <summary>
    /// 创建GridView对象，实现对GridView的操作
    /// </summary>
    public GridView Grd
    {
        set { grd = value; }
        get { return grd; }
    }
    public int TotalRecords
    {
        set
        {
            totalRecords = value;
            Label4.Text = "共" + totalRecords.ToString() + "条记录";
        }
        get { return totalRecords; }
    }

    public string DataSetName
    {
        set { this.dataSetName = value; }
    }
}
