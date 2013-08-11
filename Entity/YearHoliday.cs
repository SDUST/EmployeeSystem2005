using System;
using System.Collections.Generic;
using System.Text;

namespace Entity
{
    public class YearHoliday
    {
        string empCd;
        string year;
        decimal totalDay;
        decimal usedDay;
        public string EmpCd
        {
            get { return empCd; }
            set { empCd = value; }
        }
        public string Year
        {
            get { return year; }
            set { year = value; }
        }
        public decimal TotalDay
        {
            get { return totalDay; }
            set { totalDay = value; }
        }
        public decimal UsedDay
        {
            get { return usedDay; }
            set { usedDay = value; }
        }
    }
}
