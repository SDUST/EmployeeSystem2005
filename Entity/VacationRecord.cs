using System;
using System.Collections.Generic;
using System.Text;

namespace Entity
{
    public class VacationRecord
    {
        string empCd;
        string vacClass;
        DateTime vacDate;
        decimal vacTime;
        public string EmpCd
        {
            get { return empCd; }
            set { empCd = value; }
        }
        public string VacClass
        {
            get { return vacClass; }
            set { vacClass = value; }
        }
        public DateTime VacDate
        {
            get { return vacDate; }
            set { vacDate = value; }
        }
        public decimal VacTime
        {
            get { return vacTime; }
            set { vacTime = value; }
        }
    }
}
