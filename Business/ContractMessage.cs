using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using DataAccess;

namespace Business
{
    public class ContractMessage

    {
        /// <summary>
        /// 通过员工编号获取合同信息（应用于ContractLog页）
        /// </summary>
        /// <param name="emp_cd">员工编号</param>
        /// <returns>包含要获取员工合同信息的数据集</returns>
        public DataSet GetContractRecord(string emp_cd)
        {
            string[] paras = new string[] { "@emp_cd" };
            object[] values = new object[] { emp_cd };
            DataSet ds = DataBaseAccess.GetDataSet("GetContractRecord", "contract", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        /// <summary>
        /// 根据条件查询员工信息（应用于contractContinueManager页）
        /// </summary>
        /// <param name="emp_cd">员工编号</param>
        /// <param name="emp_name">员工姓名</param>
        /// <param name="dept_cd">部门号</param>
        /// <param name="pj_cd">工程号</param>
        /// <param name="start_date">合同期间的起始日期</param>
        /// <param name="end_date">合同期间的结束日期</param>
        /// <returns>包含要获取员工信息的数据集</returns>
        public DataSet GetEmpInfoByContractDate(string emp_cd, string emp_name, string dept_cd, string pj_cd, string start_date, string end_date)
        {
            string[] paras = new string[] { "@eid", "@name", "@deptid", "@pjid", "@dateBegin", "@dateEnd" };
            object[] values = new object[] { emp_cd, emp_name, dept_cd, pj_cd, start_date, end_date };
            DataSet ds = DataBaseAccess.GetDataSet("GetEmpInfoByContractDate", "emp", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        /// <summary>
        /// 按查询条件（包括查询年月）查询合同结束时间(应用于contractContinue页)
        /// </summary>
        /// <param name="emp_cd">员工编号</param>
        /// <returns>包含要获取员工合同结束时间的数据集</returns>
        public DataSet GetContractEndDate(string emp_cd)
        {
            string[] paras = new string[] { "@eid" };
            object[] values = new object[] { emp_cd };
            DataSet ds = DataBaseAccess.GetDataSet("GetContractEndDate", "end_Date", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        /// <summary>
        /// 单个员工合同续签（应用于contractContinue页）
        /// </summary>
        /// <param name="emp_cd">员工编号</param>
        /// <param name="startDate">合同开始日期</param>
        /// <param name="endDate">合同结束日期</param>
        /// <param name="conDate">和同年</param>
        /// <param name="memo">备注</param>
        public void OneContractContinue(string emp_cd,DateTime startDate,DateTime endDate,string conDate,string memo)
        {
            string[] paras = new string[] { "@eid" ,"@startDate","@endDate","@conDate","@memo"};
            object[] values = new object[] { emp_cd ,startDate,endDate,conDate,memo};
            DataBaseAccess.ExecuteSql("p_OneContractContinue", CommandType.StoredProcedure, paras, values);           
        }

        // 批量续签（应用于contractContinueManager页）
        public int ContractRecordInsert(string emp_cd, string startdate, int conDate, int conFlag, string conMemo)
        {
            string[] paras = new string[] { "@emp_cd", "@start_Date", "@contract_Date","@contractFlag", "@contract_Memo" };
            object[] values = new object[] {emp_cd,startdate, conDate, conFlag, conMemo };
            int i = DataBaseAccess.ExecuteSqlWhitOutPut("p_t_contract_record_insert", CommandType.StoredProcedure, paras, values);
            return i;
        }
        /// <summary>
        /// 按员工编号和查询年月查询员工合同终止前的考勤信息（应用于ContractFinishWorkAttend页的“某月出勤表”GridView5）
        /// </summary>
        /// <param name="emp_cd">员工编号</param>
        /// <param name="date">查询年月</param>
        /// <returns>要获取的合同终止考勤信息</returns>
        public DataSet GetSearchChkInfoSql(string emp_cd, string date)
        {
            string[] paras = new string[] { "@emp_cd", "@datetime" };
            object[] values = new object[] { emp_cd, date };
            DataSet ds = DataBaseAccess.GetDataSet("GetSearchChkInfoSql", "empInfo", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        //应用于ContractFinishWorkAttend页的“某月出勤表”GridView1
        public DataSet GetSearchEmpInfoSql(string emp_cd)
        {
            string[] paras = new string[] { "@emp_cd" };
            object[] values = new object[] { emp_cd };
            DataSet ds = DataBaseAccess.GetDataSet("GetSearchEmpInfoSql", "empInfo", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        //应用于ContractFinishWorkAttend页的“加班日报表”GridView3
        public DataSet GetSearchConInfoSql(string emp_cd, string date)
        {
            string[] paras = new string[] { "@emp_cd","@datetime" };
            object[] values = new object[] { emp_cd ,date};
            DataSet ds = DataBaseAccess.GetDataSet("GetSearchConInfoSql", "empInfoBydate", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        //应用于ContractFinishWorkAttend页的“加班日报表”GridView2
        public DataSet GetSearchOverTimeSql(string emp_cd, string date)
        {
            string[] paras = new string[] { "@emp_cd", "@datetime" };
            object[] values = new object[] { emp_cd, date };
            DataSet ds = DataBaseAccess.GetDataSet("GetSearchOverTimeSql", "empInfoBydate", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        //应用于ContractFinishWorkAttend页的“月加班统计表（单位时）”GridView4
        public DataSet GetMonthTotalInfoSql(string emp_cd, string date)
        {
            string[] paras = new string[] { "@emp_cd", "@datetime" };
            object[] values = new object[] { emp_cd, date };
            DataSet ds = DataBaseAccess.GetDataSet("GetMonthTotalInfoSql", "empInfoBydate", CommandType.StoredProcedure, paras, values);
            return ds;
        }

        
    }
}