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
    /// 用于操作数据库中tb_com_fun表的数据的ComFuns类
    /// </summary>
    [DataObject(true)]
    public class ComFuns
    {
        /// <summary>
        /// 获取学历和标识（面试结果），将信息存入数据集，并返回该数据集，应用于招聘管理页面
        /// </summary>
        /// <param name="fun_class_cd">功能区分编号</param>
        /// <returns>返回该数据集</returns>
        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataSet GetComFun(string fun_class_cd)
        {
            string[] paras = new string[] { "@fun_class_cd" };
            object[] values = new object[] { fun_class_cd };
            return DataBaseAccess.GetDataSet("p_GetComFun", "degrees", CommandType.StoredProcedure, paras, values);
        }
    }
}
