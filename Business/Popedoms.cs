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
    /// 用于操作数据库中t_popedom表的数据的Popedoms类
    /// </summary>
    [DataObject(true)]
    public class Popedoms
    {
        /// <summary>
        /// 用户权限更新，应用于用户权限设置新增页面显示为修正画面时
        /// </summary>
        /// <param name="logCd">登录ID</param>
        /// <param name="funCd">功能编号</param>
        /// <param name="chkflg">OutPut参数，返回0则成功，1则失败</param>
        /// <returns>命令执行后影响的行数</returns>
        [DataObjectMethod(DataObjectMethodType.Update)]
        public int PopedomUpdate(string logCd, string funCd)
        {
            object value;
            string[] paras = new string[] { "@old_log_cd", "@fun_cd_str" };
            object[] values = new object[] { logCd, funCd };
            DataBaseAccess.ExecuteSql("P_tb_popedom_update", CommandType.StoredProcedure, paras, values, "@chkflg", out value, SqlDbType.Int);
            return (int)value;
        }

        [DataObjectMethod(DataObjectMethodType.Update)]
        public DataSet GetPopedom(string logCd)
        {
            string[] paras = new string[] { "@logCd" };
            object[] values = new object[] { logCd };
            return DataBaseAccess.GetDataSet("p_GetPopedom", "popedom", CommandType.StoredProcedure, paras, values);
        }

    }
}
