using System;
using System.Collections.Generic;
using System.Text;

namespace Entity
{
    public class t_pj_evaluation
    {
        string emp_cd;
        string evaluation_date;
        string evaluation_class;
        string evaluation_emp_name;
        int flag;
        string evaluation_memo;
        //int chkflg;
        //string dateBegin;
        //string dateEnd;
        //public string DateBegin
        //{
        //    set { dateBegin = value; }
        //    get { return dateBegin; }
        //}

        //public string DateEnd
        //{
        //    set { dateEnd = value; }
        //    get { return dateEnd; }
        //}

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
        //public int Chkflg
        //{
        //    set { chkflg = value; }
        //    get { return chkflg; }
        //}
    }
}
