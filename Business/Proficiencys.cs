using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using Entity;
using DataAccess;

namespace Business
{
    public class Proficiencys
    {
        public int proficiencyUpdate(Proficiency newProficiency)
        {
            string[] paras = new string[] { "@old_pj_cd", "@five_year", "@four_year", "@three_year", "@two_year", "@one_year", "@six_month", "@three_month", "@two_month", "@one_month", "@zero_month", "@p_lead", "@s_lead", "@other"};
            object[] values = new object[] { newProficiency.Pj_cd,newProficiency.Five_year,newProficiency.Four_year,newProficiency.Three_year,newProficiency.Two_year,newProficiency.One_year,newProficiency.Six_month,newProficiency.Three_month,newProficiency.Two_month,newProficiency.One_month,newProficiency.Zero_month,newProficiency.P_lead,newProficiency.S_lead,newProficiency.Other};

            int i = DataBaseAccess.ExecuteSqlWhitOutPut("dbo.p_tb_proficiency_set_update", CommandType.StoredProcedure, paras, values);
            return i;
        }
        public DataSet GetProcficiency(string pjcd)
        {
            string[] paras = new string[] { "@pjcd"};
            object[] values = new object[] { pjcd };

            DataSet ds = DataBaseAccess.GetDataSet("procficiency_get", "procficiency", CommandType.StoredProcedure, paras, values);
           return ds;
        }
    }
}
