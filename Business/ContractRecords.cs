using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using Entity;
using DataAccess;

namespace Business
{
    public class ContractRecords
    {
        //����Ա����ϸҳ����޸�--��ͬ��ǩ��
       public void ContractRecordInsert(ContractRecord con_record)
        {
           
            string[] paras = new string[] { "@emp_cd", "@start_date", "@end_date"};
            object[] values = new object[] { con_record.Emp_cd, con_record.Start_date, con_record.End_date};
            DataAccess.DataBaseAccess.ExecuteSql("t_contract_record_insert", CommandType.StoredProcedure, paras, values);
        }
    }
}
