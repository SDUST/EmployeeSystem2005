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
using Entity;

public partial class empDetailInfo : System.Web.UI.Page
{


    protected void Page_Load(object sender, EventArgs e)
    {
            DataSet ds_emp;
            DataSet ds_duty;
            DataSet ds_conttime;
            string emp_cd = Request.QueryString["eid"];

            Emps emps = new Emps();
            ds_conttime = emps.GetContractTimeByEmpcd(emp_cd);
            ds_duty = emps.GetDutyNameByEmpcd(emp_cd);
            //ds_emp = emps.GetEmpByemp_cdGroupD(emp_cd);
            ds_emp = emps.GetEmpByEmpcdGroupD(emp_cd);


            txtEmpCd.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["emp_cd"]);
            txtIDCard.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["id_card"]);
            txtPostalcode.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["postalcode"]);
            txtLinkman.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["linkman"]);
            txtPhone.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["phone"]);
            txtEmail.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["email"]);
            txtAddress.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["address"]);
            txtMemo.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["emp_memo"]);
            txtDorm.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["dorm"]);
            txtBed.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["bed"]);
            txtTimecard.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["timecard"]);
            txtStartDate.Text = Convert.ToString(ds_conttime.Tables["Emp2"].Rows[0]["start_date"]).Substring(0, 9);
            txtEndDate.Text = Convert.ToString(ds_conttime.Tables["Emp2"].Rows[0]["end_date"]).Substring(0, 9);
            if (ds_duty.Tables["Emp3"].Rows.Count == 0)
                txtDutyName.Text = "";
            else
                txtDutyName.Text = Convert.ToString(ds_duty.Tables["Emp3"].Rows[0]["duty_name"]);

            txtBirthday.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["birthday"]).Substring(0, 9);
            txtEmpName.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["emp_name"]);
            txtJoinDate.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["join_date"]).Substring(0, 9);
            txtForwardWorkYear.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["forward_work_year"]);

            txtAfterWorkYear.Text = (CalAge(Convert.ToDateTime(txtJoinDate.Text), DateTime.Now) / 365).ToString();
            if ((CalAge(Convert.ToDateTime(txtJoinDate.Text), DateTime.Now) / 30) < 4)
                txtLevel.Text = "新手";
            else if ((CalAge(Convert.ToDateTime(txtJoinDate.Text), DateTime.Now) / 30) < 6)
                txtLevel.Text = "准熟练要员";
            else
                txtLevel.Text = "熟练要员";
            if (Image1.ImageUrl != null)
                Image1.ImageUrl = "~/emp_photo/" + emp_cd + ".jpg";

            txtMarry.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["marry"]);
            txtEmpClass.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["emp_class"]);
            txtSex.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["sex"]);
            txtDiploma.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["diploma"]);
            txtNation.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["nation"]);
            txtHomeplace.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["homeplace"]);
            txtDept.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["dept_name"]);
            txtPj.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["pj_name"]);
            txtContract_class.Text = Convert.ToString(ds_emp.Tables["Emp1"].Rows[0]["Contract_cd"]);
    }

    private int CalAge(DateTime begin, DateTime end)
    {
        TimeSpan ts = end.Subtract(begin);
        ts = ts.Duration();
        int days = ts.Days;
        return days;
    }


}


