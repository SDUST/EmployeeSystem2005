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
    /// ���ڲ������ݿ���t_popedom������ݵ�Popedoms��
    /// </summary>
    [DataObject(true)]
    public class Popedoms
    {
        /// <summary>
        /// �û�Ȩ�޸��£�Ӧ�����û�Ȩ����������ҳ����ʾΪ��������ʱ
        /// </summary>
        /// <param name="logCd">��¼ID</param>
        /// <param name="funCd">���ܱ��</param>
        /// <param name="chkflg">OutPut����������0��ɹ���1��ʧ��</param>
        /// <returns>����ִ�к�Ӱ�������</returns>
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
