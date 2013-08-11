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
    public class UserPopedeom
    {
        [DataObjectMethod(DataObjectMethodType.Select)]
        public bool GetPopedom(string pageId, string userCd)
        {
            DataSet ds = new Popedoms().GetPopedom(userCd);
            bool result=true;

            foreach (DataRow row in ds.Tables[0].Rows)
            {
                if (pageId != row[0].ToString())
                    result = false;
                else
                {
                    result = true;
                    break;
                } 
            }
            return result;
        }
    }
}
