using System;
using System.Collections.Generic;
using System.Text;

namespace Entity
{
    public  class Proficiency
    {

        string pj_cd;
        string five_year;
        string four_year;
        //string three_year;
        //string two_year;
        //string one_year;
        string six_month;
        string three_month;
        string two_month;
        string one_month;
        string zero_month;
        string p_lead;
        string s_lead;
        string other;


        public string Pj_cd
        {
            set { pj_cd = value; }
            get { return pj_cd; }
        }

        public string Five_year
        {
            set { five_year = value; }
            get { return five_year; }
        }

        public string Four_year
        {
            set { four_year = value; }
            get { return four_year; }
        }

        public string Three_year
        {
            set { three_month = value; }
            get { return three_month; }
        }

        public string Two_year
        {
            set { two_month = value; }
            get { return two_month; }
        }

        public string One_year
        {
            set { one_month = value; }
            get { return one_month; }
        }

        public string Six_month
        {
            set { six_month = value; }
            get { return six_month; }
        }

        public string Three_month
        {
            set { three_month = value; }
            get { return three_month; }
        }

        public string Two_month
        {
            set { two_month = value; }
            get { return two_month; }
        }

        public string One_month
        {
            set { one_month = value; }
            get { return one_month; }
        }

        public string Zero_month
        {
            set { zero_month = value; }
            get { return zero_month; }
        }

        public string P_lead
        {
            set { p_lead = value; }
            get { return p_lead; }
        }

        public string S_lead
        {
            set { s_lead = value; }
            get { return s_lead; }
        }

        public string Other
        {
            set { other = value; }
            get { return other; }
        }
    }

}
