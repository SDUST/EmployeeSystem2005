using System;
using System.Collections.Generic;
using System.Text;

namespace Entity
{
    public class Pjevaluation
    {
        string emp_cd;
        string evaluation_date;
        string evaluation_class;
        string evaluation_emp_name;
        int flag;
        string evaluation_memo;

        public string Emp_cd
        {
            set { emp_cd = value; }
            get { return emp_cd; }
        }
        public string Evaluation_date
        {
            set { evaluation_date = value; }
            get { return evaluation_date; }
        }
        public string Evaluation_class
        {
            set { evaluation_class = value; }
            get { return evaluation_class; }
        }
        public string Evaluation_emp_name
        {
            set { evaluation_emp_name = value; }
            get { return evaluation_emp_name; }
        }
        public int Flag
        {
            set { flag = value; }
            get { return flag; }
        }
        public string Evaluation_memo
        {
            set { evaluation_memo = value; }
            get { return evaluation_memo; }
        }
    }
}