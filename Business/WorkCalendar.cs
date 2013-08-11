using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using DataAccess;

namespace Business
{
    /// <summary>
    /// 工作日历的设置和更新
    /// </summary>
    public class WorkCalendar
    {
        /// <summary>
        /// 获取指定年、月份的日历信息
        /// </summary>
        /// <param name="year">年份</param>
        /// <param name="month">月份</param>
        /// <returns>包含指定年份和月份的所有日期的信息的 DataSet 对象</returns>
        public DataSet GetCalendar(int year, int month)
        {
            string[] paras = new string[] { "@year", "@month" };
            object[] values = new object[] { year, month };
            DataSet dsWorkCalendar = DataBaseAccess.GetDataSet("p_tb_calendar_get", "WorkCalendar", CommandType.StoredProcedure, paras, values);
            return dsWorkCalendar;
        }

        /// <summary>
        /// 根据指定的年、月、日获取指定日期的信息
        /// 返回的数据中第一项为日历类型标识，第二项为备注信息
        /// </summary>
        /// <param name="year">年份</param>
        /// <param name="month">月份</param>
        /// <param name="day">日</param>
        /// <returns>包含指定日期信息的数组</returns>
        public object[] GetDayInfo(int year, int month, int day)
        {
            string[] paras = new string[] { "@year", "@month", "@day" };
            object[] values = new object[] { year, month, day };

            object[] returnValue = DataBaseAccess.GetValues("p_tb_calendar_getday", CommandType.StoredProcedure, paras, values);
            return returnValue;
        }

        /// <summary>
        /// 更新日历中指定日期的信息
        /// </summary>
        /// <param name="year">年份</param>
        /// <param name="month">月份</param>
        /// <param name="day">日</param>
        /// <param name="flag">日历类型标识</param>
        /// <param name="memo">日历备注</param>
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
