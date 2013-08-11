using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using Business;
using Entity;

namespace Business
{
    public class Pjevaluations
    {
        //����������ȡ��������
        public DataSet GetEvaluation(Pjevaluation pj_evalu, Emp emp)
        {
            string[] paras = new string[] { "@emp_cd", "@emp_name", "@dept_cd", "@pj_cd", "@evaluation_class", "@evaluation_date" };
            object[] values = new object[] { emp.Emp_cd, emp.Emp_name, emp.Dept_cd, emp.Pj_cd, pj_evalu.Evaluation_class, pj_evalu.Evaluation_date };
            DataSet ds = DataAccess.DataBaseAccess.GetDataSet("p_GetEvaluation", "pj", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        //����emp_cd��ȡ��������
        public DataSet GetPjEByEmpcd(string emp_cd)
        {
            string[] paras = new string[] { "@emp_cd" };
            object[] values = new object[] { emp_cd };
            DataSet ds = DataAccess.DataBaseAccess.GetDataSet("GetPj_Ebyemp_cd", "comyemp_cd", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        //���빤������
        public void PjEvaluationInsert(Pjevaluation pj_evalu)
        {
            string[] paras = new string[] { "@chkflg", "@emp_cd", "@evaluation_date", "@evaluation_class", "@evaluation_emp_name", "@flag", "@evaluation_memo" };
            object[] values = new object[] { 1, pj_evalu.Emp_cd, pj_evalu.Evaluation_date, pj_evalu.Evaluation_class, pj_evalu.Evaluation_emp_name, pj_evalu.Flag, pj_evalu.Evaluation_memo };
            DataAccess.DataBaseAccess.CheckAccess("p_t_pj_evaluation_insert", CommandType.StoredProcedure, paras, values);
        }
        //�˶����������Ƿ����
        public bool CheckPjDate(string emp_cd, DateTime date)
        {
            string[] paras = new string[] { "@result", "@emp_cd", "@date" };
            object[] values = new object[] { 10, emp_cd, date };
            return DataAccess.DataBaseAccess.CheckAccess("Check_pj_Date", CommandType.StoredProcedure, paras, values);
        }
    }
}