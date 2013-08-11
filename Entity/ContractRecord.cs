using System;
using System.Collections.Generic;
using System.Text;

namespace Entity
{
    public class ContractRecord
    {
        string emp_cd;
        DateTime end_date;
        DateTime start_date;
        string record_memo;
        string flag;
        string contract_date;
        string contract_memo;
        public string Emp_cd
        {
            set { emp_cd = value; }
            get { return emp_cd; }
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
        public string Contract_date
        {
            set { contract_date = value; }
            get { return contract_date; }
        }
        public string Contract_memo
        {
            set { contract_memo = value; }
            get { return contract_memo; }
        }

        public DateTime End_date
        {
            set { end_date = value; }
            get { return end_date; }
        }
        public DateTime Start_date
        {
            set { start_date = value; }
            get { return start_date; }
        }
    }
}
