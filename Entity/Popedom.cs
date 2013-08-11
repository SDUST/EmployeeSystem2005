using System;
using System.Collections.Generic;
using System.Text;

namespace Entity
{
    public class Popedom
    {
        string logCd;
        string logName;
        string funCd;
        string popedomClass;

        public string Log_cd
        {
            set { logCd = value; }
            get { return logCd; }
        }
       
        public string Log_name
        {
            set { logName = value; }
            get { return logName; }
        }
        public string Fun_cd
        {
            set { funCd = value; }
            get { return funCd; }
        }
        public string Popedom_Class
        {
            set { popedomClass = value; }
            get { return popedomClass; }
        }
    }
}
