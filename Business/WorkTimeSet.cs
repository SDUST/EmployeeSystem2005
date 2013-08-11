using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.ComponentModel;

using DataAccess;

namespace Business
{
    /// <summary>
    /// ��ϵͳ��������ķ���
    /// </summary>
    [DataObject(true)]

    public class WorkTimeSet
    {
        /// <summary>
        /// �Թ���ʱ�䷶Χ���趨
        /// </summary>
        /// <param name="on_duty">�ϰ�ʱ��</param>
        /// <param name="off_duty">�°�ʱ��</param>
        [DataObjectMethod(DataObjectMethodType.Update)]

        public void WorktimeUpdate(string on_duty, string off_duty)
        {
            string[] paras = new string[] { "@on_duty", "@off_duty" };
            object[] paraValues = new object[] { on_duty, off_duty };
            DataBaseAccess.ExecuteSql("dbo.tb_worktime_update", CommandType.StoredProcedure, paras, paraValues);

        }



        /// <summary>
        /// ȡ����ʱ�����Ĺ���ʱ��
        /// </summary>
        /// <returns>���ص�ǰ���ڵ����°�ʱ��</returns>
        [DataObjectMethod(DataObjectMethodType.Select)]

        public DataSet GetWorktime()
        {
            return DataBaseAccess.GetDataSet("tb_worktime_get", "tb_worktime_get", CommandType.StoredProcedure);
        }
    }
}