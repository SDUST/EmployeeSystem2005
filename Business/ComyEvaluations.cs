using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using Entity;
using DataAccess;

namespace Business
{
    public class ComyEvaluations
    {
        //根据条件获取公司评价
        public DataSet GetCompanyEvaluation(string emp_cd, string emp_name, string dept_cd, string pj_cd, string evaluation_class, DateTime dateBegin, DateTime dateEnd)
        {

            string[] paras = new string[] { "@emp_cd", "@emp_name", "@dept_cd", "@pj_cd", "@evaluation_class", "@dateBegin", "@dateEnd" };
            object[] values = new object[] { emp_cd, emp_name, dept_cd, pj_cd, evaluation_class, dateBegin, dateEnd };
            if (dateBegin == DateTime.MinValue)
                values[5] = null;
            if (dateEnd == DateTime.MinValue)
                values[6] = null;
            DataSet ds = DataAccess.DataBaseAccess.GetDataSet("p_GetCompanyEvaluation", "comy", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        //插入公司评价
        public void ComyEvaluationInsert(ComyEvaluation comy_evalu)
        {
            string[] paras = new string[] { "@chkflg", "@emp_cd", "@evaluation_date", "@evaluation_class", "@evaluation_emp_name", "@flag", "@evaluation_memo" };
            object[] values = new object[] { 10, comy_evalu.Emp_cd, comy_evalu.Evaluation_date, comy_evalu.Evaluation_class, comy_evalu.Evaluation_emp_name, comy_evalu.Flag, comy_evalu.Evaluation_memo };
            DataAccess.DataBaseAccess.CheckAccess("P_t_comy_evaluation_insert", CommandType.StoredProcedure, paras, values);
        }
        //根据emp_cd获取公司评价
        public DataSet GetComyEvaluationByEmpcd(string emp_cd)
        {
            string[] paras = new string[] { "@emp_cd" };
            object[] values = new object[] { emp_cd };
            DataSet ds = DataAccess.DataBaseAccess.GetDataSet("Getcomy_evaluationByemp_cd", "comyemp_cd", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        //核对评价日期是否已经存在。
        public bool CheckComDate(string emp_cd, DateTime date)
        {
            string[] paras = new string[] { "@result", "@emp_cd", "@date" };
            object[] values = new object[] { 10, emp_cd, date };
            return DataAccess.DataBaseAccess.CheckAccess("Check_Com_Date", CommandType.StoredProcedure, paras, values);
        }




    }
}
