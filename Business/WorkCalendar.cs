using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using DataAccess;

namespace Business
{
    /// <summary>
    /// �������������ú͸���
    /// </summary>
    public class WorkCalendar
    {
        /// <summary>
        /// ��ȡָ���ꡢ�·ݵ�������Ϣ
        /// </summary>
        /// <param name="year">���</param>
        /// <param name="month">�·�</param>
        /// <returns>����ָ����ݺ��·ݵ��������ڵ���Ϣ�� DataSet ����</returns>
        public DataSet GetCalendar(int year, int month)
        {
            string[] paras = new string[] { "@year", "@month" };
            object[] values = new object[] { year, month };
            DataSet dsWorkCalendar = DataBaseAccess.GetDataSet("p_tb_calendar_get", "WorkCalendar", CommandType.StoredProcedure, paras, values);
            return dsWorkCalendar;
        }

        /// <summary>
        /// ����ָ�����ꡢ�¡��ջ�ȡָ�����ڵ���Ϣ
        /// ���ص������е�һ��Ϊ�������ͱ�ʶ���ڶ���Ϊ��ע��Ϣ
        /// </summary>
        /// <param name="year">���</param>
        /// <param name="month">�·�</param>
        /// <param name="day">��</param>
        /// <returns>����ָ��������Ϣ������</returns>
        public object[] GetDayInfo(int year, int month, int day)
        {
            string[] paras = new string[] { "@year", "@month", "@day" };
            object[] values = new object[] { year, month, day };

            object[] returnValue = DataBaseAccess.GetValues("p_tb_calendar_getday", CommandType.StoredProcedure, paras, values);
            return returnValue;
        }

        /// <summary>
        /// ����������ָ�����ڵ���Ϣ
        /// </summary>
        /// <param name="year">���</param>
        /// <param name="month">�·�</param>
        /// <param name="day">��</param>
        /// <param name="flag">�������ͱ�ʶ</param>
        /// <param name="memo">������ע</param>
        public bool UpdateCalendar(int year, int month, int day, string flag, string memo)
        {
            string[] paras = new string[] { "@year", "@month", "@day", "@calendar_flag", "@calendar_memo" };
            object[] values = new object[] { year, month, day, flag, memo };

            object chkFlag = 0;
            DataAccess.DataBaseAccess.ExecuteSql("p_tb_calendar_update", CommandType.StoredProcedure, paras, values,"@chkflg", out chkFlag, SqlDbType.Int);
            return (int)chkFlag == 0 ? true : false;
        }
    }
}
