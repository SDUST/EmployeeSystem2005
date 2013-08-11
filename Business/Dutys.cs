using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using Entity;
using DataAccess;
using System.ComponentModel;

namespace Business
{
    public class Dutys
    {
        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataSet GetDutyByEmpcd(string cd)
        {
            string[] paras = new string[] { "@emp_cd" };
            object[] values = new object[] { cd };
            DataSet ds = DataAccess.DataBaseAccess.GetDataSet("GetDutyByEmp_cd", "duty", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataSet GetDuty()
        {
            DataSet ds = DataAccess.DataBaseAccess.GetDataSet("GetDuty", "dutys", CommandType.StoredProcedure);
            return ds;
        }
        [DataObjectMethod(DataObjectMethodType.Insert)]
        public void InsertDutyChange(DutyRecord record)
        {
            string[] paras = new string[] { "@emp_cd", "@duty_name", "@record_date", "@record_memo" };
            object[] values = new object[] { record.Emp_cd, record.Duty_name, record.Record_date, record.Record_memo };
            DataAccess.DataBaseAccess.ExecuteSql("insertDutyChange", CommandType.StoredProcedure, paras, values);
        }
        [DataObjectMethod(DataObjectMethodType.Insert)]
        public int DutyIinsert(Duty newDuty)
        {
            string[] paras = new string[] { "@duty_cd", "@duty_name" };
            object[] values = new object[] { newDuty.Duty_cd, newDuty.Duty_name };

            int i = DataBaseAccess.ExecuteSqlWhitOutPut("p_tb_duty_insert", CommandType.StoredProcedure, paras, values);
            return i;
        }
        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataSet GetDutyBydutycd(string duty_cd)
        {
            string[] paras = new string[] { "@duty_cd" };
            object[] values = new object[] { duty_cd };

            DataSet ds = DataBaseAccess.GetDataSet("GetDutyBydutycd", "duty", CommandType.StoredProcedure, paras, values);
            return ds;
        }
        [DataObjectMethod(DataObjectMethodType.Update)]
        public void DutyUpdate(Duty newDuty)
        {
            string[] paras = new string[] { "@old_duty_cd", "@duty_cd", "@duty_name" };
            object[] values = new object[] { newDuty.Old_duty_cd, newDuty.Duty_cd, newDuty.Duty_name };

            DataBaseAccess.ExecuteSql("p_tb_duty_update", CommandType.StoredProcedure, paras, values);

        }
        [DataObjectMethod(DataObjectMethodType.Delete)]
        public int DutyDelete(Duty newDuty)
        {
            string[] paras = new string[] { "@duty_cd" };
            object[] values = new object[] { newDuty.Duty_cd };

            int i = DataBaseAccess.ExecuteSqlWhitOutPut("p_tb_duty_delete", CommandType.StoredProcedure, paras, values);
            return i;
        }
    }

}
