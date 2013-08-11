using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using Entity;
using DataAccess;

namespace Business
{
    public class Calendars
    {
        public DataSet GetCalendar()
        {

            DataSet ds = DataBaseAccess.GetDataSet("SELECT * from tb_calendar", "Calendar", CommandType.Text);
            return ds;
        }
    }
}
