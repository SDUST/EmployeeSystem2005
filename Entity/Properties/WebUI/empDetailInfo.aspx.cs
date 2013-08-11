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
using Bussiness;
using Entity;
using System.Windows.Forms;


public partial class empDetailInfo : System.Web.UI.Page
{
    DataSet ds_emp;
    DataSet ds_duty;
    DataSet ds_conttime;
    protected void Page_Load(object sender, EventArgs e)
    {
        string emp_cd = Request.QueryString["emp_cd"];
        string mode = Request.QueryString["mode"];
        if (mode == "edit")
        {
            Emps emps = new Emps();
            ds_conttime = emps.GetContractTimeByEmpcd(emp_cd);
            ds_duty = emps.GetDutyNameByEmpcd(emp_cd);
            ds_emp = emps.GetEmpByEmpcd(emp_cd);
            if (!IsPostBack == true)
            {
                txtBirthday.ReadOnly = true;
                txtEmpName.ReadOnly = true;
                txtJoinDate.ReadOnly = true;
                txtForwardWorkYear.ReadOnly = true;
                txtAfterWorkYear.ReadOnly = true;
                selSex.Enabled = false;
                txtLevel.ReadOnly = true;
                ImageButton1.Visible = false;
                ImageButton2.Visible = false;
                selHomeplace.Enabled = false;
                selNation.Enabled = false;

                txtEmpCd.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["emp_cd"]);
                txtIDCard.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["id_card"]);
                selMarry.SelectedValue = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["marry"]);
                txtPostalcode.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["postalcode"]);
                txtLinkman.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["linkman"]);
                txtPhone.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["phone"]);
                txtEmail.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["email"]);
                txtAddress.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["address"]);
                txtMemo.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["emp_memo"]);
                txtDorm.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["dorm"]);
                txtBed.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["bed"]);
                txtTimecard.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["timecard"]);
                selEmpClass.SelectedValue = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["emp_class"]);
                txtStartDate.Text = Convert.ToDateTime(ds_conttime.Tables["Emp2"].Rows[0]["start_date"]).ToShortDateString();
                txtEndDate.Text = Convert.ToDateTime(ds_conttime.Tables["Emp2"].Rows[0]["end_date"]).ToShortDateString();
                if (ds_duty.Tables["Emp3"].Rows.Count == 0)
                    txtDutyName.Text = "";
                else
                    txtDutyName.Text = Convert.ToString(ds_duty.Tables["Emp3"].Rows[0]["duty_name"]);
                Session["startdate"] = txtStartDate.Text;
                Session["enddate"] = txtEndDate.Text;
            }
            txtBirthday.Text = Convert.ToDateTime(ds_emp.Tables["Emp1"].Rows[0]["birthday"]).ToShortDateString();
            txtEmpName.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["emp_name"]);
            txtJoinDate.Text = Convert.ToDateTime(ds_emp.Tables["Emp1"].Rows[0]["join_date"]).ToShortDateString();
            txtForwardWorkYear.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["forward_work_year"]);
            selSex.SelectedValue = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["sex"]);
            txtAfterWorkYear.Text = (CalAge(Convert.ToDateTime(txtJoinDate.Text), DateTime.Now) / 365).ToString();
            if ((CalAge(Convert.ToDateTime(txtJoinDate.Text), DateTime.Now) / 30) < 4)
                txtLevel.Text = "新手";
            else if ((CalAge(Convert.ToDateTime(txtJoinDate.Text), DateTime.Now) / 30) < 6)
                txtLevel.Text = "准熟练要员";
            else
                txtLevel.Text = "熟练要员";
            if (Image1.ImageUrl != null)
                Image1.ImageUrl = "~/emp_photo/" + emp_cd + ".jpg";
        }
        if (mode == "addnew")
        {
            fupPhoto.Visible = true;
            btnPhoto.Visible = true;
        }
    }
    protected void selDiploma_DataBound(object sender, EventArgs e)
    {
        if (!IsPostBack == true)
        {
            selDiploma.Items.Insert(0, "");
            selDiploma.SelectedIndex = 0;
            if (ds_emp != null && ds_emp.Tables["Emp1"].Rows[0]["diploma"] != null)
                selDiploma.SelectedValue = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["diploma"]);
        }
    }
    protected void selHomeplace_DataBound(object sender, EventArgs e)
    {
        selHomeplace.Items.Insert(0, "");
        selHomeplace.SelectedIndex = 0;
        if (ds_emp != null && ds_emp.Tables["Emp1"].Rows[0]["homeplace"] != null)
            selHomeplace.SelectedValue = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["homeplace"]);
    }
    protected void selNation_DataBound(object sender, EventArgs e)
    {
        selNation.Items.Insert(0, "");
        selNation.SelectedIndex = 0;
        if (ds_emp != null && ds_emp.Tables["Emp1"].Rows[0]["nation"] != null)
            selNation.SelectedValue = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["nation"]);

    }
    protected void selContract_class_DataBound(object sender, EventArgs e)
    {
        if (!IsPostBack == true)
        {
            selContract_class.Items.Insert(0, "");
            selContract_class.SelectedIndex = 0;
            if (ds_emp != null && ds_emp.Tables["Emp1"].Rows[0]["contract_class"] != null)
                selContract_class.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["contract_class"]);
        }
    }
    protected void selDept_DataBound(object sender, EventArgs e)
    {
        if (!IsPostBack == true)
        {
            selDept.Items.Insert(0, "");
            selDept.SelectedIndex = 0;
            if (ds_emp != null && ds_emp.Tables["Emp1"].Rows[0]["dept_cd"] != null)
                selDept.SelectedValue = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["dept_cd"]);
        }
    }
    protected void selPj_DataBound(object sender, EventArgs e)
    {
        if (!IsPostBack == true)
        {
            selPj.Items.Insert(0, "");
            selPj.SelectedIndex = 0;
            if (ds_emp != null && ds_emp.Tables["Emp1"].Rows[0]["pj_cd"] != null)
                selPj.SelectedValue = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["pj_cd"]);
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        string emp_cd = Request.QueryString["emp_cd"];
        string mode = Request.QueryString["mode"];
        if (mode == "addnew")
        {
            if (txtEmpCd.Text == "" && txtEmpName.Text == "")
            {
                ClientScript.RegisterStartupScript(GetType(), null, "<script language=\"javascript\">alert('员工编号不可为空！员工姓名不可为空！');</script>");
            }
            else if (txtEmpCd.Text != "" && txtEmpName.Text == "")
            {
                ClientScript.RegisterStartupScript(GetType(), null, "<script language=\"javascript\">alert('员工姓名不可为空！');</script>");
            }
            else if (txtEmpCd.Text == "" && txtEmpName.Text != "")
            {
                ClientScript.RegisterStartupScript(GetType(), null, "<script language=\"javascript\">alert('员工编号不可为空！');</script>");
            }
            else
                ClientScript.RegisterStartupScript(GetType(), null, "<script language=\"javascript\">fPopUpDuty(document.all.txtDutyName,'" + txtEmpCd.Text + "','addnew');</script>");
            //ClientScript.RegisterClientScriptBlock(this.GetType(), "ok", "<script>......</script>");
        }
        if (mode == "edit")
            ClientScript.RegisterStartupScript(GetType(), null, "<script language=\"javascript\">fPopUpDuty(document.all.txtDutyName,'" + txtEmpCd.Text + "','edit');</script>");
    }

    //根据入职时间计算入社后工龄和技术等级的时间函数
    private int CalAge(DateTime begin, DateTime end)
    {
        TimeSpan ts = end.Subtract(begin);
        ts = ts.Duration();
        int days = ts.Days;
        return days;
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string mode = Request.QueryString["mode"];
        if (mode == "edit")
        {
            Emp emp = new Emp();
            contract_record con_record = new contract_record();
            ContractRecords con_records = new ContractRecords();
            Emps emps = new Emps();

            emp.Id_card = txtIDCard.Text;
            emp.Marry = Convert.ToString(selMarry.SelectedValue);
            emp.Diploma = Convert.ToString(selDiploma.SelectedValue);
            emp.Postalcode = txtPostalcode.Text;
            emp.Linkman = txtLinkman.Text;
            emp.Phone = txtPhone.Text;
            emp.Email = txtEmail.Text;
            emp.Contract_class = Convert.ToString(selContract_class.SelectedValue);
            emp.Address = txtAddress.Text;
            emp.Dept_cd = Convert.ToString(selDept.SelectedValue);
            emp.Timecard = txtTimecard.Text;
            emp.Emp_cd = txtEmpCd.Text;
            emp.Pj_cd = Convert.ToString(selPj.SelectedValue);
            emp.Emp_class = Convert.ToString(selEmpClass.SelectedValue);
            emp.Dorm = txtDorm.Text;
            emp.Bed = txtBed.Text;
            emp.Emp_memo = txtMemo.Text;
            if (txtStartDate.Text != "")
                con_record.Start_date = Convert.ToDateTime(txtStartDate.Text);
            else
                con_record.Start_date = DateTime.Now;
            if (txtEndDate.Text != "")
                con_record.End_date = Convert.ToDateTime(txtEndDate.Text);
            else
                con_record.End_date = DateTime.Now;
            con_record.Emp_cd = txtEmpCd.Text;
            emps.EmpUpdate(emp);
            if (txtStartDate.Text != Convert.ToString(Session["startdate"]) || txtEndDate.Text != Convert.ToString(Session["enddate"]))
                con_records.ContractRecordInsert(con_record);
            ClientScript.RegisterStartupScript(GetType(), null, "<script language=\"javascript\">alert('更新成功！');window.close();</script>");

        }
        if (mode == "addnew")
        {
            if (txtEmpCd.Text == "" || txtEmpName.Text == "" || Image1.ImageUrl == "")
                MessageBox.Show("员工姓名、员工编号、相片不可为空！");
            else
            {
                Emp emp = new Emp();
                contract_record con_record = new contract_record();
                Emps emps = new Emps();

                emp.Emp_name = txtEmpName.Text;
                emp.Sex = Convert.ToString(selSex.SelectedValue);
                emp.Birthday = txtBirthday.Text;
                emp.Id_card = txtIDCard.Text;
                emp.Marry = Convert.ToString(selMarry.SelectedValue);
                emp.Diploma = Convert.ToString(selDiploma.SelectedValue);
                emp.Homeplace = Convert.ToString(selHomeplace.SelectedValue);
                emp.Nation = Convert.ToString(selNation.SelectedValue);
                emp.Postalcode = txtPostalcode.Text;
                emp.Linkman = txtLinkman.Text;
                emp.Phone = txtPhone.Text;
                emp.Email = txtEmail.Text;
                emp.Contract_class = Convert.ToString(selContract_class.SelectedValue);
                emp.Address = txtAddress.Text;
                emp.Dept_cd = Convert.ToString(selDept.SelectedValue);
                emp.Timecard = txtTimecard.Text;
                emp.Emp_cd = txtEmpCd.Text;
                emp.Pj_cd = Convert.ToString(selPj.SelectedValue);
                emp.Join_date = txtJoinDate.Text;
                emp.Emp_class = Convert.ToString(selEmpClass.SelectedValue);
                if (txtStartDate.Text != "")
                    con_record.Start_date = Convert.ToDateTime(txtStartDate.Text);
                else
                    con_record.Start_date = DateTime.Now;
                if (txtEndDate.Text != "")
                    con_record.End_date = Convert.ToDateTime(txtEndDate.Text);
                else
                    con_record.End_date = DateTime.Now;

                emp.Forward_work_year = txtForwardWorkYear.Text;
                emp.Dorm = txtDorm.Text;
                emp.Bed = txtBed.Text;
                emp.Emp_memo = txtMemo.Text;
                emp.Photo = txtEmpCd.Text + ".jpg";
                emps.EmpDetailInsert(emp, con_record);

                ClientScript.RegisterStartupScript(GetType(), null, "<script language=\"javascript\">alert('添加成功！');window.close();</script>");
            }
        }
    }
    protected void btnPhoto_Click(object sender, EventArgs e)
    {
        if (txtEmpCd.Text != "")
        {
            if (fupPhoto.HasFile != false)
            {
                if (Convert.ToString(fupPhoto.PostedFile.FileName.Split(new char[] { '.' })[1]) != "jpg")
                    ClientScript.RegisterStartupScript(GetType(), null, "<script language=\"javascript\">alert('图片必须为jpg格式！');</script>");
                else
                {
                    fupPhoto.PostedFile.SaveAs(Server.MapPath("~/emp_photo/" + txtEmpCd.Text + ".jpg"));
                    Image1.ImageUrl = "~/emp_photo/" + txtEmpCd.Text + ".jpg";
                }
            }
        }
        else
            ClientScript.RegisterStartupScript(GetType(), null, "<script language=\"javascript\">alert('编号不为空！');</script>");
    }
}


