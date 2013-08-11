using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;

using System.ComponentModel;

using Entity;
using DataAccess;

namespace Business
{
    /// <summary>
    /// 
    /// </summary>
    [DataObject(true)]
    public class Users
    {
        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataSet GetUsers(string userCd, string userName)
        {
            string[] paras = new string[] { "@userCd","@userName"};
            object[] values = new object[] { userCd,userName};
            return DataBaseAccess.GetDataSet("p_GetUsers", "users", CommandType.StoredProcedure, paras, values);
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataSet GetUserName(string userCd)
        {
            string[] paras = new string[] { "@userCd" };
            object[] values = new object[] { userCd };
            return DataBaseAccess.GetDataSet("p_GetUserName", "users", CommandType.StoredProcedure, paras, values);
        }

        public DataSet GetUser(string userCd)
        {
            string[] paras = new string[] { "@userCd"};
            object[] values = new object[] {userCd};
            return DataBaseAccess.GetDataSet("p_GetUser", "users", CommandType.StoredProcedure, paras, values);
        }

        public int UserInsert(string userCd, string userName, string password)
        {
            string[] paras = new string[] { "@user_cd", "@user_name", "@password" };
            object[] values = new object[] { userCd, userName, password };
            return DataBaseAccess.ExecuteSql("p_tb_user_insert", CommandType.StoredProcedure, paras, values);
        }

        public int UserUpdate(string olduser_cd, string userName, string password)
        {
            string[] paras = new string[] {"@old_user_cd", "@user_name", "@password"};
            object[] values = new object[] {olduser_cd,userName,password};
            return DataBaseAccess.ExecuteSql("p_tb_user_update", CommandType.StoredProcedure, paras,values);
        }
        public int UserDelete(string userCd)
        {
            string[] paras = new string[] { "@user_cd"};
            object[] values = new object[] {userCd};
            return DataAccess.DataBaseAccess.ExecuteSqlWhitOutPut("p_tb_user_delete", CommandType.StoredProcedure, paras,values);
        }

        public int CheckUser(string userCd)
        {
            string[] paras = new string[] {"@userCd" };
            object[] values = new object[] { userCd };
            return DataAccess.DataBaseAccess.ExecuteSqlWhitOutPut("p_CheckUser", CommandType.StoredProcedure, paras,values);
        }

        public int LoginCheck(string userCd)
        {
            object value;
            string[] paras = new string[] { "@userCd" };
            object[] values = new object[] { userCd };
            DataBaseAccess.ExecuteSql("p_LoginCheck", CommandType.StoredProcedure, paras, values, "@chkflg", out value, SqlDbType.Int);
            return (int)value;
        }

        public string Login(string userCd)
        {
            object value;
            string[] paras = new string[] { "@userCd" };
            object[] values = new object[] { userCd };
            DataAccess.DataBaseAccess.ExecuteSql("p_Login", CommandType.StoredProcedure, paras, values, "@pwd", out value, SqlDbType.VarChar);
            return value.ToString();
        }
    }
}
