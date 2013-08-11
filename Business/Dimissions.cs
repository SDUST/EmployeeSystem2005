using System;
using System.Collections.Generic;
using System.Text;
using Entity;
using System.Data;
using System.ComponentModel;
using DataAccess;

namespace Business
{
    public class Dimissions
    {
        /// <summary>
        /// 添加员工离职登记信息（用于ResignationRegisterAdd页）
        /// </summary>
        /// <param name="dim">离职信息的实体类</param>
        [DataObjectMethod(DataObjectMethodType.Insert)]
        public void PEmpInsert(Dimission dim)
        {
            string[] paras = new string[] { "@EmpCd", "@dimission_date", "@dimission_memo", "@emp_card", "@timecard", "@wage_card", "@tools", "@ark_key", "@dorm_key" };
            object[] values = new object[] { dim.Emp_cd, dim.Dimission_date, dim.Dimission_memo, dim.Emp_card, dim.Timecard, dim.Wage_card, dim.Tools, dim.Ark_key, dim.Drom_key };
            DataBaseAccess.ExecuteSql("p_tb_emp_insert", CommandType.StoredProcedure, paras, values);
        }
        /// <summary>
        /// 根据条件获取员工信息（用于ResignationRegister页）
        /// </summary>
        /// <param name="emp_cd">员工编号</param>
        /// <param name="emp_name">员工姓名</param>
        /// <param name="dept_cd">部门编号</param>
        /// <param name="pj_cd">工程编号</param>
        /// <returns>包含要获取员工信息的数据集</returns>
        public DataSet GetEmpByCondition(string emp_cd, string emp_name, string dept_cd, string pj_cd)
        {
            string[] paras = new string[] { "@eid", "@name", "@deptid", "@pjid" };
            object[] values = new object[] { emp_cd, emp_name, dept_cd, pj_cd };
            DataSet ds = DataBaseAccess.GetDataSet("GetEmpsAndDutyName", "emp", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        /// <summary>
        /// 根据员工编号获取职务及入职，离职日期等离职信息（用于resignEmpQuery页）
        /// </summary>
        /// <param name="emp_cd">员工编号</param>
        /// <param name="emp_name">员工姓名</param>
        /// <param name="dept_cd">部门编号</param>
        /// <param name="pj_cd">工程编号</param>
        /// <returns>包含员工离职信息的数据集</returns>
        public DataSet GetEmpsAndDate(string emp_cd, string emp_name, string dept_cd, string pj_cd)
        {
            string[] paras = new string[] { "@eid", "@name", "@deptid", "@pjid" };
            object[] values = new object[] { emp_cd, emp_name, dept_cd, pj_cd };
            DataSet ds = DataBaseAccess.GetDataSet("GetEmpsAndDate", "emp", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        /// <summary>
        /// 根据员工编号获取离职信息（用于ResignationEmpDetail页）
        /// </summary>
        /// <param name="emp_cd">员工编号</param>
        /// <returns>包含要获取员工的离职信息的数据集</returns>
        public DataSet GetResignationEmpInfobyId(string emp_cd)
        {
            string[] paras = new string[] { "@empid " };
            object[] values = new object[] { emp_cd };
            DataSet ds = DataBaseAccess.GetDataSet("GetResignationEmpInfobyId", "empInfo", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        /// <summary>
        /// 根据条件获取离职员工考勤信息（用于resignWorkAttendQuery页）
        /// </summary>
        /// <param name="emp_cd">员工编号</param>
        /// <param name="emp_name">员工姓名</param>
        /// <param name="dept_cd">部门编号</param>
        /// <param name="pj_cd">工程编号</param>
        /// <param name="month">查询月份</param>
        /// <returns>包含将要获取的离职员工考勤信息</returns>
        public DataSet GetResignEmpByMonth(string emp_cd, string emp_name, string dept_cd, string pj_cd, string month)
        {
            string[] paras = new string[] { "@eid", "@name", "@deptid", "@pjid", "@month" };
            object[] values = new object[] { emp_cd, emp_name, dept_cd, pj_cd, month };
            DataSet ds = DataBaseAccess.GetDataSet("GetResignEmpByMonth", "emp", CommandType.StoredProcedure, paras, values);
            return ds;
        }
    }
}
