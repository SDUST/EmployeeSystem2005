using System;
using System.Collections.Generic;
using System.Text;

namespace Entity
{
    public class Duty
    {
        string duty_cd;
        string old_duty_cd;
        string duty_name;

        public string Duty_cd
        {
            set { duty_cd = value; }
            get { return duty_cd; }
        }
        public string Old_duty_cd
        {
            set { old_duty_cd = value; }
            get { return old_duty_cd; }
        }
        public string Duty_name
        {
            set { duty_name = value; }
            get { return duty_name; }
        }
    }
}
