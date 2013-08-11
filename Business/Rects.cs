using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;

using System.ComponentModel;

using Entity;
using DataAccess;

namespace Business
{
    [DataObject(true)]
    public class Rects
    {
        public DataSet GetRect(string rect_cd, string rect_name, string id_card, string diploma, string rectDate1, string rectDate2, int isRect, string flag)
        {
            string[] paras = new string[] { "@rectCd", "@rectName", "@idCard", "@diploma", "@rectDate1", "@rectDate2", "@isRect", "@flag" };
            object[] values = new object[] { rect_cd, rect_name, id_card, diploma, rectDate1, rectDate2, isRect,flag};
            return DataBaseAccess.GetDataSet("p_GetRect", "rects", CommandType.StoredProcedure, paras, values);
        }

        public int RectUpdate(string rect_cd, string flag)
        {
            object value;
            string[] paras = new string[] { "@rect_Cd", "@flag" };
            object[] values = new object[] { rect_cd, flag };
            DataBaseAccess.ExecuteSql("p_t_rect_update", CommandType.StoredProcedure, paras, values, "@chkflg",out value,SqlDbType.Int);
            return (int)value;
        }
    }
}
