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
    /// 对系统管理操作的方法
    /// </summary>
    [DataObject(true)]

    public class WorkTimeSet
    {
        /// <summary>
        /// 对工作时间范围的设定
        /// </summary>
        /// <param name="on_duty">上班时间</param>
        /// <param name="off_duty">下班时间</param>
        [DataObjectMethod(DataObjectMethodType.Update)]

        public void WorktimeUpdate(string on_duty, string off_duty)
        {
            string[] paras = new string[] { "@on_duty", "@off_duty" };
            object[] paraValues = new object[] { on_duty, off_duty };
            DataBaseAccess.ExecuteSql("dbo.tb_worktime_update", CommandType.StoredProcedure, paras, paraValues);

        }



        /// <summary>
        /// 取工作时间表里的工作时间
        /// </summary>
        /// <returns>返回当前存在的上下班时间</returns>
        [DataObjectMethod(DataObjectMethodType.Select)]

        public DataSet GetWorktime()
        {
            return DataBaseAccess.GetDataSet("tb_worktime_get", "tb_worktime_get", CommandType.StoredProcedure);
        }
    }
}