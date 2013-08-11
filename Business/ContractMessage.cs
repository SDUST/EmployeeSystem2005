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
        /// ͨ��Ա����Ż�ȡ��ͬ��Ϣ��Ӧ����ContractLogҳ��
        /// </summary>
        /// <param name="emp_cd">Ա�����</param>
        /// <returns>����Ҫ��ȡԱ����ͬ��Ϣ�����ݼ�</returns>
        public DataSet GetContractRecord(string emp_cd)
        {
            string[] paras = new string[] { "@emp_cd" };
            object[] values = new object[] { emp_cd };
            DataSet ds = DataBaseAccess.GetDataSet("GetContractRecord", "contract", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        /// <summary>
        /// ����������ѯԱ����Ϣ��Ӧ����contractContinueManagerҳ��
        /// </summary>
        /// <param name="emp_cd">Ա�����</param>
        /// <param name="emp_name">Ա������</param>
        /// <param name="dept_cd">���ź�</param>
        /// <param name="pj_cd">���̺�</param>
        /// <param name="start_date">��ͬ�ڼ����ʼ����</param>
        /// <param name="end_date">��ͬ�ڼ�Ľ�������</param>
        /// <returns>����Ҫ��ȡԱ����Ϣ�����ݼ�</returns>
        public DataSet GetEmpInfoByContractDate(string emp_cd, string emp_name, string dept_cd, string pj_cd, string start_date, string end_date)
        {
            string[] paras = new string[] { "@eid", "@name", "@deptid", "@pjid", "@dateBegin", "@dateEnd" };
            object[] values = new object[] { emp_cd, emp_name, dept_cd, pj_cd, start_date, end_date };
            DataSet ds = DataBaseAccess.GetDataSet("GetEmpInfoByContractDate", "emp", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        /// <summary>
        /// ����ѯ������������ѯ���£���ѯ��ͬ����ʱ��(Ӧ����contractContinueҳ)
        /// </summary>
        /// <param name="emp_cd">Ա�����</param>
        /// <returns>����Ҫ��ȡԱ����ͬ����ʱ������ݼ�</returns>
        public DataSet GetContractEndDate(string emp_cd)
        {
            string[] paras = new string[] { "@eid" };
            object[] values = new object[] { emp_cd };
            DataSet ds = DataBaseAccess.GetDataSet("GetContractEndDate", "end_Date", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        /// <summary>
        /// ����Ա����ͬ��ǩ��Ӧ����contractContinueҳ��
        /// </summary>
        /// <param name="emp_cd">Ա�����</param>
        /// <param name="startDate">��ͬ��ʼ����</param>
        /// <param name="endDate">��ͬ��������</param>
        /// <param name="conDate">��ͬ��</param>
        /// <param name="memo">��ע</param>
        public void OneContractContinue(string emp_cd,DateTime startDate,DateTime endDate,string conDate,string memo)
        {
            string[] paras = new string[] { "@eid" ,"@startDate","@endDate","@conDate","@memo"};
            object[] values = new object[] { emp_cd ,startDate,endDate,conDate,memo};
            DataBaseAccess.ExecuteSql("p_OneContractContinue", CommandType.StoredProcedure, paras, values);           
        }

        // ������ǩ��Ӧ����contractContinueManagerҳ��
        public int ContractRecordInsert(string emp_cd, string startdate, int conDate, int conFlag, string conMemo)
        {
            string[] paras = new string[] { "@emp_cd", "@start_Date", "@contract_Date","@contractFlag", "@contract_Memo" };
            object[] values = new object[] {emp_cd,startdate, conDate, conFlag, conMemo };
            int i = DataBaseAccess.ExecuteSqlWhitOutPut("p_t_contract_record_insert", CommandType.StoredProcedure, paras, values);
            return i;
        }
        /// <summary>
        /// ��Ա����źͲ�ѯ���²�ѯԱ����ͬ��ֹǰ�Ŀ�����Ϣ��Ӧ����ContractFinishWorkAttendҳ�ġ�ĳ�³��ڱ�GridView5��
        /// </summary>
        /// <param name="emp_cd">Ա�����</param>
        /// <param name="date">��ѯ����</param>
        /// <returns>Ҫ��ȡ�ĺ�ͬ��ֹ������Ϣ</returns>
        public DataSet GetSearchChkInfoSql(string emp_cd, string date)
        {
            string[] paras = new string[] { "@emp_cd", "@datetime" };
            object[] values = new object[] { emp_cd, date };
            DataSet ds = DataBaseAccess.GetDataSet("GetSearchChkInfoSql", "empInfo", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        //Ӧ����ContractFinishWorkAttendҳ�ġ�ĳ�³��ڱ�GridView1
        public DataSet GetSearchEmpInfoSql(string emp_cd)
        {
            string[] paras = new string[] { "@emp_cd" };
            object[] values = new object[] { emp_cd };
            DataSet ds = DataBaseAccess.GetDataSet("GetSearchEmpInfoSql", "empInfo", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        //Ӧ����ContractFinishWorkAttendҳ�ġ��Ӱ��ձ���GridView3
        public DataSet GetSearchConInfoSql(string emp_cd, string date)
        {
            string[] paras = new string[] { "@emp_cd","@datetime" };
            object[] values = new object[] { emp_cd ,date};
            DataSet ds = DataBaseAccess.GetDataSet("GetSearchConInfoSql", "empInfoBydate", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        //Ӧ����ContractFinishWorkAttendҳ�ġ��Ӱ��ձ���GridView2
        public DataSet GetSearchOverTimeSql(string emp_cd, string date)
        {
            string[] paras = new string[] { "@emp_cd", "@datetime" };
            object[] values = new object[] { emp_cd, date };
            DataSet ds = DataBaseAccess.GetDataSet("GetSearchOverTimeSql", "empInfoBydate", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        //Ӧ����ContractFinishWorkAttendҳ�ġ��¼Ӱ�ͳ�Ʊ���λʱ����GridView4
        public DataSet GetMonthTotalInfoSql(string emp_cd, string date)
        {
            string[] paras = new string[] { "@emp_cd", "@datetime" };
            object[] values = new object[] { emp_cd, date };
            DataSet ds = DataBaseAccess.GetDataSet("GetMonthTotalInfoSql", "empInfoBydate", CommandType.StoredProcedure, paras, values);
            return ds;
        }

        
    }
}