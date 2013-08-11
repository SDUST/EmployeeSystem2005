using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using DataAccess;
using Entity;

namespace Business
{
    public class Vacations
    {
        public DataSet GetVacClasses()
        {
            return DataBaseAccess.GetDataSet("GetVacClasses", "VacClasses", CommandType.StoredProcedure);
        }
    }
}
