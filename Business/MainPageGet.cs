using System;
using System.Collections.Generic;
using System.Text;
using Entity;
using DataAccess;
using System.Data;

namespace Business
{
    public class MainPageGet
    {
        public DataSet NotEmp()
        {

            DataSet ds = DataBaseAccess.GetDataSet("SELECT COUNT(ISNULL(pj_cd,1)) con1 FROM tb_emp WHERE pj_cd IS null or pj_cd=''", "NotEmp", CommandType.Text);
            return ds;
        }
        public DataSet NotContract()
        {

            DataSet ds = DataBaseAccess.GetDataSet("SELECT  COUNT(ds.emp_cd) con2 FROM (SELECT emp_cd FROM t_contract_record  WHERE flag='1'AND end_date-getdate()<60  AND end_date-getdate()>0) ds", "NotContract", CommandType.Text);
            return ds;
        }
        public DataSet RecordTime()
        {

            DataSet ds = DataBaseAccess.GetDataSet("SELECT CONVERT(varchar(16),ti.jk,120) date FROM(SELECT MAX(record_time)AS jk FROM t_chk_record  WHERE flag='³É¹¦') ti", "RecordTime", CommandType.Text);
            return ds;
        }
        public DataSet NotContractDate()
        {
            DataSet ds = DataBaseAccess.GetDataSet("SELECT t_contract_record.emp_cd FROM t_contract_record ,tb_emp WHERE flag='1'AND end_date-getdate()<60 	AND end_date-getdate()>0 and t_contract_record.emp_cd=tb_emp.emp_cd and tb_emp.job_class='0'", "NotContractDate", CommandType.Text);
            return ds;
        }
    }
}
