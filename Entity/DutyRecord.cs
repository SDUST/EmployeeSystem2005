using System;
using System.Collections.Generic;
using System.Text;

namespace Entity
{
    public class DutyRecord
    {
        string emp_cd;
        string duty_name;
        DateTime record_date;
        string record_memo;
        string flag;
        public string Emp_cd
        {
            set { emp_cd = value; }
            get { return emp_cd; }
        }
        public string Duty_name
        {
            set { duty_name = value; }
            get { return duty_name; }
        }
        public DateTime Record_date
        {
            set { record_date = value; }
            get { return record_date; }
        }
        
        public string Record_memo
        {
            set { record_memo = value; }
            get { return record_memo; }
        }
        public string Flag
        {
            set { flag = value; }
            get { return flag; }
        }

    }
}
