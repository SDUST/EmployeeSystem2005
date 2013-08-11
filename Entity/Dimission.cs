using System;
using System.Collections.Generic;
using System.Text;

namespace Entity
{
    public class Dimission
    {
        public Dimission()
        {
        }
        string emp_cd;
        string dimission_date;
        string dimission_memo;
        string emp_card;
        string timecard;
        string wage_card;
        string tools;
        string ark_key;
        string drom_key;

        public string Emp_cd
        {
            set { emp_cd = value; }
            get { return emp_cd; }
        }
        public string Dimission_date
        {
            set { dimission_date = value; }
            get { return dimission_date; }
        }
        public string Dimission_memo
        {
            set { dimission_memo = value; }
            get { return dimission_memo; }
        }
        public string Emp_card
        {
            set { emp_card = value; }
            get { return emp_card; }
        }
        public string Timecard
        {
            set { timecard = value; }
            get { return timecard; }
        }
        public string Wage_card
        {
            set { wage_card = value; }
            get { return wage_card; }
        }
        public string Tools
        {
            set { tools = value; }
            get { return tools; }
        }
        public string Ark_key
        {
            set { ark_key = value; }
            get { return ark_key; }
        }
        public string Drom_key
        {
            set { drom_key = value; }
            get { return drom_key; }
        }
    }
}
