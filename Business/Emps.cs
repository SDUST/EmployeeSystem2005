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
    [DataObject(true)]
    public class Emps
    {
        //A ��

        /// <summary>
        /// ���ݸ�����������Ա��
        /// </summary>
        /// <param name="emp">Ҫ���ҵ�Emp����</param>
        /// <returns>���ذ���������Ա����Ϣ�����ݼ�</returns>
        public DataSet GetEmps(Emp emp)
        {
            string[] paras = new string[] { "@emp_cd", "@emp_name", "@dept_cd", "@pj_cd", "@contract_class", "@marry" };
            object[] values = new object[] { emp.Emp_cd, emp.Emp_name, emp.Dept_cd, emp.Pj_cd, emp.Contract_class, emp.Marry };
            DataSet ds = DataAccess.DataBaseAccess.GetDataSet("P_GetEmps", "Emp", CommandType.StoredProcedure, paras, values);
            return ds;
        }

        public bool EmpDelete(string emp_cd)
        {
            string[] paras = new string[] { "@chkflg", "@emp_cd" };
            object[] values = new object[] { 0, emp_cd };
            bool result = DataAccess.DataBaseAccess.CheckAccess("p_tb_emp_delete", CommandType.StoredProcedure, paras, values);
            return result;
        }
        //����Ա����Ż�ȡ���ڴ�Ա����������Ϣ��
        //Ա�����ȡ
        public DataSet GetEmpByEmpcd(string emp_cd)
        {
            string[] paras = new string[] { "@emp_cd" };
            object[] values = new object[] { emp_cd };
            DataSet ds = DataAccess.DataBaseAccess.GetDataSet("GetEmpByemp_cd", "Emp1", CommandType.StoredProcedure, paras, values);
            return ds;
        }


        //����Ա����Ż�ȡ��Ա����ͬ��Ϣ��Ӧ����DetailInfoҳ��
        //��ͬ��ǩ���ȡ
        public DataSet GetContractTimeByEmpcd(string emp_cd)
        {
            string[] paras = new string[] { "@emp_cd" };
            object[] values = new object[] { emp_cd };
            DataSet ds = DataAccess.DataBaseAccess.GetDataSet("GetContractTimeByemp_cd", "Emp2", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        //ְ�����������ȡ
        public DataSet GetDutyNameByEmpcd(string emp_cd)
        {
            string[] paras = new string[] { "@emp_cd" };
            object[] values = new object[] { emp_cd };
            DataSet ds = DataAccess.DataBaseAccess.GetDataSet("GetDutyNameByemp_cd", "Emp3", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        //����Ա����ϸҳ�Ĳ��뷽��
        public void EmpDetailInsert(Emp emp, ContractRecord con_record)
        {
            string[] paras = new string[] { "@emp_name", "@sex", "@birthday", "@id_card", "@marry", "@diploma", "@homeplace", "@nation", "@postalcode", "@linkman", "@phone", "@email", "@contract_class", "@address", "@emp_cd", "@timecard", "@dept_cd", "@pj_cd", "@join_date", "@emp_class", "@forward_work_year", "@dorm", "@bed", "@emp_memo", "@photo", "@start_date", "@end_date", "@flag" };
            object[] values = new object[] { emp.Emp_name, emp.Sex, emp.Birthday, emp.Id_card, emp.Marry, emp.Diploma, emp.Homeplace, emp.Nation, emp.Postalcode, emp.Linkman, emp.Phone, emp.Email, emp.Contract_class, emp.Address, emp.Emp_cd, emp.Timecard, emp.Dept_cd, emp.Pj_cd, emp.Join_date, emp.Emp_class, emp.Forward_work_year, emp.Dorm, emp.Bed, emp.Emp_memo, emp.Photo, con_record.Start_date, con_record.End_date, con_record.Flag };
            DataAccess.DataBaseAccess.ExecuteSql("emp_detail_insert", CommandType.StoredProcedure, paras, values);
        }

        /// <summary>
        /// ���Ա����Ϣ
        /// </summary>
        /// <param name="emp">Ҫ��ӵ�Emp����</param>
        public void EmpInsert(Emp emp)
        {
            string[] paras = new string[] { "@emp_name", "@sex", "@birthday", "@id_card", "@marry", "@diploma", "@homeplace", "@nation", "@postalcode", "@linkman", "@phone", "@email", "@contract_class", "@address", "@emp_cd", "@timecard", "@dept_cd", "@pj_cd", "@join_date", "@emp_class", "@forward_work_year", "@dorm", "@bed", "@emp_memo" };
            object[] values = new object[] { emp.Emp_name, emp.Sex, emp.Birthday, emp.Id_card, emp.Marry, emp.Diploma, emp.Homeplace, emp.Nation, emp.Postalcode, emp.Linkman, emp.Phone, emp.Email, emp.Contract_class, emp.Address, emp.Emp_cd, emp.Timecard, emp.Dept_cd, emp.Pj_cd, emp.Join_date, emp.Emp_class, emp.Forward_work_year, emp.Dorm, emp.Bed, emp.Emp_memo };
            DataBaseAccess.ExecuteSql("Tb_Emp_Insert", CommandType.StoredProcedure, paras, values);
        }
        //����Ա����ϸҳ����޸�--Ա����
        public void EmpUpdate(Emp emp)
        {
            string[] paras = new string[] { "@id_card", "@marry", "@diploma", "@postalcode", "@linkman", "@phone", "@email", "@contract_class", "@address", "@old_emp_cd", "@timecard", "@dept_cd", "@pj_cd", "@emp_class", "@dorm", "@bed", "@emp_memo" };
            object[] values = new object[] { emp.Id_card, emp.Marry, emp.Diploma, emp.Postalcode, emp.Linkman, emp.Phone, emp.Email, emp.Contract_class, emp.Address, emp.Emp_cd, emp.Timecard, emp.Dept_cd, emp.Pj_cd, emp.Emp_class, emp.Dorm, emp.Bed, emp.Emp_memo };
            DataAccess.DataBaseAccess.ExecuteSql("tb_emp_update", CommandType.StoredProcedure, paras, values);
        }
        //��ȡ��˾��������
        public DataSet GetCEC()
        {
            DataSet ds = DataAccess.DataBaseAccess.GetDataSet("GetCEC", "componyevalution", CommandType.StoredProcedure);
            return ds;
        }

        public DataSet GetEmpMoveQuery(string begindate, string enddate)
        {
            string[] paras = new string[] { "@begindate", "@enddate" };
            object[] values = new object[] { begindate, enddate };
            return DataAccess.DataBaseAccess.GetDataSet("Get_empMoveQuery", "empMoveQuery", CommandType.StoredProcedure, paras, values);
        }

        public DataSet GetEmps(string emp_cd, string emp_name, string dept_cd, string pj_cd, int selPjCd)
        {
            string[] paras = new string[] { "@EmpCd", "@EmpName", "@DeptCd", "@PjCd", "@selPjCd" };
            object[] values = new object[] { emp_cd, emp_name, dept_cd, pj_cd, selPjCd };
            DataSet ds = DataAccess.DataBaseAccess.GetDataSet("GetEmps", "emps", CommandType.StoredProcedure, paras, values);
            return ds;
        }

        public DataSet GetEmpsAndPjNames(string pj_cd)
        {
            string[] paras = new string[] { "@PjCd" };
            object[] values = new object[] { pj_cd };
            DataSet ds = DataAccess.DataBaseAccess.GetDataSet("p_GetEmpsAndPjNames", "emps", CommandType.StoredProcedure, paras, values);
            return ds;
        }

        public int EmpUpdate(string emp_cd, string pj_cd)
        {
            string[] paras = new string[] { "@emp_cd", "@pj_cd "};
            object[] values = new object[] { emp_cd, pj_cd };
            return DataBaseAccess.ExecuteSqlWhitOutPut("p_tb_emp_update", CommandType.StoredProcedure, paras, values);
        }


        //D ��
        /// <summary>
        /// ͨ��Ա����Ż�ȡԱ������
        /// </summary>
        /// <param name="emp"></param>
        /// <returns></returns>
        public DataSet GetEmpNameByEmpId(string emp_cd)
        {
            string[] paras = new string[] { "@empid" };
            object[] values = new object[] { emp_cd };
            DataSet ds = DataBaseAccess.GetDataSet("GetEmpNameByEmpId", "EmpName", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        /// <summary>
        /// ����Ա����Ż�ȡԱ����Ϣ��Ӧ����ResignationRegisterAddҳ��
        /// </summary>
        /// <param name="emp_id"></param>
        /// <returns></returns>
        public DataSet GetEmpInfoByEmpID(string emp_id)
        {
            string[] paras = new string[] { "@empid" };
            object[] values = new object[] { emp_id };
            DataSet ds = DataBaseAccess.GetDataSet("GetEmpInfobyId", "emp", CommandType.StoredProcedure, paras, values);
            return ds;
        }

        //����Ա����Ż�ȡ���ڴ�Ա����������Ϣ��
        //Ա�����ȡ
        public DataSet GetEmpByEmpcdGroupD(string emp_cd)
        {
            string[] paras = new string[] { "@emp_cd" };
            object[] values = new object[] { emp_cd };
            DataSet ds = DataAccess.DataBaseAccess.GetDataSet("GetEmpByemp_cdGroupD", "Emp1", CommandType.StoredProcedure, paras, values);
            return ds;
        }

    }
}
