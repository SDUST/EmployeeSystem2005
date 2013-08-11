using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Entity;
using DataAccess;
using System.ComponentModel;

namespace Business
{
    /// <summary>
    /// 用于操作数据库中tb_dept表的数据的Depts类
    /// </summary>
    [DataObject(true)]
    public class Depts
    {
        /// <summary>
        /// 根据部门区分获取部门或工程（应用于部门和工程的下拉框）
        /// </summary>
        /// <param name="dept_class">部门区分</param>
        /// <returns></returns>
        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataSet GetDeptOrPj(int dept_class)
        {
            string[] paras = new string[] { "@dept_class" };
            object[] values = new object[] { dept_class };
            return DataBaseAccess.GetDataSet("GetDeptOrPj", "deptOrpj", CommandType.StoredProcedure, paras, values);
        }

        //B组
        /// <summary>
        /// 查询部门名称或工程名称，将信息存入数据集，并返回该数据集，工程分配页面
        /// </summary>
        /// <param name="deptclass">部门区分</param>
        /// <returns>返回该数据集</returns>
        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataSet GetDeptNameOrPjName(string deptclass)
        {
            string[] paras = new string[] { "@DeptClass" };
            object[] values = new object[] { deptclass };
            return DataBaseAccess.GetDataSet("p_GetDeptNameOrPjName", "depts", CommandType.StoredProcedure, paras, values);
        }

        //E 组
        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataSet GetDepts(string Dept_cd, string Dept_name, string Dept_class, string pj_cd)
        {
            string[] paras = new string[] { "@eid", "@name", "@deptid", "@pjid" };
            object[] values = new object[] { Dept_cd, Dept_name, Dept_class, pj_cd };

            DataSet ds = DataBaseAccess.GetDataSet("GetDepts", "Depts", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataSet GetDeptPjBydeptcd(string Dept_cd)
        {
            string[] paras = new string[] { "@dept_cd" };
            object[] values = new object[] { Dept_cd };

            DataSet ds = DataBaseAccess.GetDataSet("GetDeptPjBydeptcd", "Depts", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataSet GetParentDeptname()
        {

            DataSet ds = DataBaseAccess.GetDataSet("getparent_dept_name", "dept", CommandType.StoredProcedure);
            return ds;
        }
        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataSet GetdeptByDeptcd(string Dept_cd)
        {
            string[] paras = new string[] { "@dept_cd" };
            object[] values = new object[] { Dept_cd };

            DataSet ds = DataBaseAccess.GetDataSet("GetdeptByDeptcd", "Depts", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataSet Getdeptname()
        {

            DataSet ds = DataBaseAccess.GetDataSet("Getdeptname", "dept", CommandType.StoredProcedure);
            return ds;
        }
        [DataObjectMethod(DataObjectMethodType.Insert)]
        public int DeptInsert(Dept newDept)
        {
            string[] paras = new string[] { "@dept_cd", "@dept_name", "@parent_dept_cd", "@dept_class ", "@manager" };
            object[] values = new object[] { newDept.DeptCd, newDept.DeptName, newDept.ParentDeptCd, newDept.DeptClass, newDept.Manager };

            int i=DataBaseAccess.ExecuteSqlWhitOutPut("dept_insert", CommandType.StoredProcedure, paras, values);
            return i;
        }
        [DataObjectMethod(DataObjectMethodType.Update)]
        public int DeptUpdate(Dept newDept)
        {
            string[] paras = new string[] { "@old_dept_cd", "@dept_cd", "@dept_name", "@parent_dept_cd", "@dept_class ", "@manager" };
            object[] values = new object[] { newDept.OldDeptCd, newDept.DeptCd, newDept.DeptName, newDept.ParentDeptCd, newDept.DeptClass, newDept.Manager };

            int i = DataBaseAccess.ExecuteSqlWhitOutPut("dept_update", CommandType.StoredProcedure, paras, values);
            return i;
            
        }
    }
}
