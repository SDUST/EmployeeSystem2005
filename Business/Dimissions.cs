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
        /// ���Ա����ְ�Ǽ���Ϣ������ResignationRegisterAddҳ��
        /// </summary>
        /// <param name="dim">��ְ��Ϣ��ʵ����</param>
        [DataObjectMethod(DataObjectMethodType.Insert)]
        public void PEmpInsert(Dimission dim)
        {
            string[] paras = new string[] { "@EmpCd", "@dimission_date", "@dimission_memo", "@emp_card", "@timecard", "@wage_card", "@tools", "@ark_key", "@dorm_key" };
            object[] values = new object[] { dim.Emp_cd, dim.Dimission_date, dim.Dimission_memo, dim.Emp_card, dim.Timecard, dim.Wage_card, dim.Tools, dim.Ark_key, dim.Drom_key };
            DataBaseAccess.ExecuteSql("p_tb_emp_insert", CommandType.StoredProcedure, paras, values);
        }
        /// <summary>
        /// ����������ȡԱ����Ϣ������ResignationRegisterҳ��
        /// </summary>
        /// <param name="emp_cd">Ա�����</param>
        /// <param name="emp_name">Ա������</param>
        /// <param name="dept_cd">���ű��</param>
        /// <param name="pj_cd">���̱��</param>
        /// <returns>����Ҫ��ȡԱ����Ϣ�����ݼ�</returns>
        public DataSet GetEmpByCondition(string emp_cd, string emp_name, string dept_cd, string pj_cd)
        {
            string[] paras = new string[] { "@eid", "@name", "@deptid", "@pjid" };
            object[] values = new object[] { emp_cd, emp_name, dept_cd, pj_cd };
            DataSet ds = DataBaseAccess.GetDataSet("GetEmpsAndDutyName", "emp", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        /// <summary>
        /// ����Ա����Ż�ȡְ����ְ����ְ���ڵ���ְ��Ϣ������resignEmpQueryҳ��
        /// </summary>
        /// <param name="emp_cd">Ա�����</param>
        /// <param name="emp_name">Ա������</param>
        /// <param name="dept_cd">���ű��</param>
        /// <param name="pj_cd">���̱��</param>
        /// <returns>����Ա����ְ��Ϣ�����ݼ�</returns>
        public DataSet GetEmpsAndDate(string emp_cd, string emp_name, string dept_cd, string pj_cd)
        {
            string[] paras = new string[] { "@eid", "@name", "@deptid", "@pjid" };
            object[] values = new object[] { emp_cd, emp_name, dept_cd, pj_cd };
            DataSet ds = DataBaseAccess.GetDataSet("GetEmpsAndDate", "emp", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        /// <summary>
        /// ����Ա����Ż�ȡ��ְ��Ϣ������ResignationEmpDetailҳ��
        /// </summary>
        /// <param name="emp_cd">Ա�����</param>
        /// <returns>����Ҫ��ȡԱ������ְ��Ϣ�����ݼ�</returns>
        public DataSet GetResignationEmpInfobyId(string emp_cd)
        {
            string[] paras = new string[] { "@empid " };
            object[] values = new object[] { emp_cd };
            DataSet ds = DataBaseAccess.GetDataSet("GetResignationEmpInfobyId", "empInfo", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        /// <summary>
        /// ����������ȡ��ְԱ��������Ϣ������resignWorkAttendQueryҳ��
        /// </summary>
        /// <param name="emp_cd">Ա�����</param>
        /// <param name="emp_name">Ա������</param>
        /// <param name="dept_cd">���ű��</param>
        /// <param name="pj_cd">���̱��</param>
        /// <param name="month">��ѯ�·�</param>
        /// <returns>������Ҫ��ȡ����ְԱ��������Ϣ</returns>
        public DataSet GetResignEmpByMonth(string emp_cd, string emp_name, string dept_cd, string pj_cd, string month)
        {
            string[] paras = new string[] { "@eid", "@name", "@deptid", "@pjid", "@month" };
            object[] values = new object[] { emp_cd, emp_name, dept_cd, pj_cd, month };
            DataSet ds = DataBaseAccess.GetDataSet("GetResignEmpByMonth", "emp", CommandType.StoredProcedure, paras, values);
            return ds;
        }
    }
}
