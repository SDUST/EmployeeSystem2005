using System;
using System.Collections.Generic;
using System.Text;

namespace Entity
{
    public class MstUnitUser
    {
        float unitID = 0.0f;
        string copID = "";
        string userID = "";
        float orderDis = 0.0f;
        DateTime crtTim = new DateTime(1753, 1, 1);
        string crtUsr = "";
        string crtCop = "";
        DateTime updTim = new DateTime(1753, 1, 1);
        string updUsr = "";
        string updCop = "";
        public float UnitID
        {
            get
            {
                return unitID;
            }
            set
            {
                unitID = value;
            }
        }
        public float OrderDis
        {
            get
            {
                return orderDis;
            }
            set
            {
                orderDis = value;
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
