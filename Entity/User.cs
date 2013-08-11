using System;
using System.Collections.Generic;
using System.Text;

namespace Entity
{
    public class User
    {
        string uCd;
        string uName;
        string password;

        public string User_cd
        {
            set { uCd = value; }
            get { return uCd; }
        }
        public string User_Name
        {
            set { uName = value; }
            get { return uName; }
        }
        public string PassWord
        {
            set { password = value; }
            get { return password; }
        }
    }
}
