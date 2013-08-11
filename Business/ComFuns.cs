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
    /// ���ڲ������ݿ���tb_com_fun������ݵ�ComFuns��
    /// </summary>
    [DataObject(true)]
    public class ComFuns
    {
        /// <summary>
        /// ��ȡѧ���ͱ�ʶ�����Խ����������Ϣ�������ݼ��������ظ����ݼ���Ӧ������Ƹ����ҳ��
        /// </summary>
        /// <param name="fun_class_cd">�������ֱ��</param>
        /// <returns>���ظ����ݼ�</returns>
        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataSet GetComFun(string fun_class_cd)
        {
            string[] paras = new string[] { "@fun_class_cd" };
            object[] values = new object[] { fun_class_cd };
            return DataBaseAccess.GetDataSet("p_GetComFun", "degrees", CommandType.StoredProcedure, paras, values);
        }
    }
}
