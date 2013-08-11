using System;
using System.Collections.Generic;
using System.Text;

namespace Entity
{
    public class MstUser
    {
        string userID = "";
        string copID = "";
        string userNam = "";
        string passWord = "";
        string uim = "";
        string mialAds = "";
        float defaultKey = 0.0f;
        float logerCnt = 0.0f;
        DateTime loginTim = new DateTime(1753, 1, 1);
        string userKub = "";
        string dwnlodauth = "";
        float userDecide = 0.0f;
        DateTime expirtnDate;
        float delflg = 0.0f;
        DateTime crtTim = new DateTime(1753, 1, 1);
        string crtUsr = "";
        string crtCop = "";
        DateTime updTim = new DateTime(1753, 1, 1);
        string updUsr = "";
        string updCop = "";
        public string UserID
        {
            get
            {
                return userID;
            }
            set
            {
                userID = value;
            }
        }
        public string CopID
        {
            get
            {
                return copID;
            }
            set
            {
                copID = value;
            }
        }
        public string UserNam
        {
            get
            {
                return userNam;
            }
            set
            {
                userNam = value;
            }
        }
        public string PassWord
        {
            get
            {
                return passWord;
            }
            set
            {
                passWord = value;
            }
        }
        public string Uim
        {
            get
            {
                return uim;
            }
            set
            {
                uim = value;
            }
        }
        public string MialAds
        {
            get
            {
                return mialAds;
            }
            set
            {
                mialAds = value;
            }
        }
        public float DefaultKey
        {
            get
            {
                return defaultKey;
            }
            set
            {
                defaultKey = value;
            }
        }
        public float LogerCnt
        {
            get
            {
                return logerCnt;
            }
            set
            {
                logerCnt = value;
            }
        }
        public DateTime LoginTim
        {
            get
            {
                return loginTim;
            }
            set
            {
                loginTim = value;
            }
        }
        public string UserKub
        {
            get
            {
                return userKub;
            }
            set
            {
                userKub = value;
            }
        }
        public string Dwnlodauth
        {
            get
            {
                return dwnlodauth;
            }
            set
            {
                dwnlodauth = value;
            }
        }
        public float UserDecide
        {
            get
            {
                return userDecide;
            }
            set
            {
                userDecide = value;
            }
        }
        public DateTime ExpirtnDate
        {
            get
            {
                return expirtnDate;
            }
            set
            {
                expirtnDate = value;
            }
        }
        public float Delflg
        {
            get
            {
                return delflg;
            }
            set
            {
                delflg = value;
            }
        }
        public DateTime CrtTim
        {
            get
            {
                return crtTim;
            }
            set
            {
                crtTim = value;
            }
        }
        public string CrtUsr
        {
            get
            {
                return crtUsr;
            }
            set
            {
                crtUsr = value;
            }
        }
        public string CrtCop
        {
            get
            {
                return crtCop;
            }
            set
            {
                crtCop = value;
            }
        }
        public DateTime UpdTim
        {
            get
            {
                return updTim;
            }
            set
            {
                updTim = value;
            }
        }
        public string UpdUsr
        {
            get
            {
                return updUsr;
            }
            set
            {
                updUsr = value;
            }
        }
        public string UpdCop
        {
            get
            {
                return updCop;
            }
            set
            {
                updCop = value;
            }
        }

    }
}
