using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;


namespace DataAccess
{
    /// <summary>
    /// 用于连接数据库与数据库进行数据处理
    /// </summary>
    public static class DataBaseAccess
    {
        static SqlCommand cmd = null;
        static SqlConnection conn = null;
        static SqlDataAdapter sda = null;
        static SqlDataReader sdr = null;
        static SqlParameter param = null;

        #region  构造函数用于初始化数据连接
        static DataBaseAccess()
        {
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["dbEmpConnectionString"].ConnectionString);
            //conn = new SqlConnection("server=.;uid=sa;pwd=sa;database=EmpDB");
            cmd = new SqlCommand();
            cmd.Connection = conn;
            param = new SqlParameter();
            sda = new SqlDataAdapter();

        }

        #endregion

        #region 执行一个命令查询一个数据集并返回该数据集
        /// <summary>
        /// 执行一个命令查询一个数据集并返回该数据集
        /// </summary>
        /// <param name="sqlText">要执行的SQL语句或者存储过程名</param>
        /// <param name="tableName">DataSet 中的表名</param>
        /// <param name="commandType">命令类型，SQL 语句或存储过程名</param>
        /// <returns> DateSet 对象</returns>
        public static DataSet GetDataSet(string sqlText, string tableName, CommandType commandType)
        {
            cmd = PrepareCommand(sqlText, commandType, null, null);

            DataSet ds = new DataSet();
            sda.SelectCommand = cmd;
            sda.Fill(ds, tableName);
            return ds;
        }
        #endregion

        #region 执行一个命令查询一个数据集并返回该数据集(带参数)
        /// <summary>
        /// 执行一个命令查询一个数据集并返回该数据集
        /// </summary>
        /// <param name="sqlText">要执行的 SQL 语句或者存储过程名</param>
        /// <param name="tableName">DataSet 中的表名</param>
        /// <param name="commandType">命令类型，SQL语句或存储过程名</param>
        /// <param name="paras">参数名数组</param>
        /// <param name="values">参数值数组</param>
        /// <returns>DateSet对象</returns>
        public static DataSet GetDataSet(string sqlText, string tableName, CommandType commandType, string[] paras, object[] values)
        {
            if (paras.Length != values.Length)
                throw new Exception("请输入正确的参数和参数名");

            cmd = PrepareCommand(sqlText, commandType, paras, values);
            
            DataSet ds = new DataSet();
           sda.SelectCommand = cmd;
           sda.Fill(ds, tableName);
           conn.Close();
            return ds;
        }
        #endregion

        #region 执行一个命令查询一个数据集并返回该数据集(带参数)
        /// <summary>
        /// 执行一个命令查询一个数据集并返回该数据集
        /// </summary>
        /// <param name="commandText">要执行的SQL语句或者存储过程名</param>
        /// <param name="tableName">dataset表名</param>
        /// <param name="commandType">SQL语句还是存储过程</param>
        /// <param name="paras">参数对象数组</param>
        /// <returns>要返回的DateSet对象</returns>
        public static DataSet GetDataSet(string commandText, string tableName, CommandType commandType, SqlParameter[] paras)
        {
            cmd.CommandText = commandText;
            cmd.CommandType = commandType;

            cmd.Parameters.Clear();
            foreach (SqlParameter para in paras)
                cmd.Parameters.Add(para);

            sda.SelectCommand = cmd;

            DataSet ds = new DataSet();
            sda.Fill(ds, tableName);

            return ds;
        }
        #endregion

        #region 执行一个命令对数据库进行增，删，改(有输出参数)
        /// <summary>
        /// 执行一个命令对数据库进行增，删，改
        /// </summary>
        /// <param name="sqlText">Sql语句或者存储过程名</param>
        /// <param name="commandType">sql语句或者存储过程</param>
        /// <param name="paras">参数名数组</param>
        /// <param name="values">参数值数组</param>
        /// <param name="para">输出参数名</param>
        /// <param name="value">输出参数值</param>
        /// <returns>返回影响的行数</returns>
        public static int ExecuteSql(string sqlText, CommandType commandType, string[] paras, object[] values, string para, out object value,SqlDbType type)
        {

            cmd = PrepareCommand(sqlText, commandType, paras, values);
            if (para != null)
            {     
                SqlParameter pram = new SqlParameter(para, type);
                if (type == SqlDbType.VarChar)
                    pram.Size = 2000;
                cmd.Parameters.Add(pram);
                cmd.Parameters[para].Direction = ParameterDirection.Output;
            }

            try
            {

                if (conn.State != ConnectionState.Open)
                    conn.Open();
            }
            catch (Exception ex)
            {
                throw ex;
            }

            int count;
            count=cmd.ExecuteNonQuery();
            if (para != null)
            {
                value = cmd.Parameters[para].Value;

            }
            else
                value = null;
            conn.Close();
            return count;
            
        }
        #endregion


        #region 执行一个命令对数据库进行增，删，改(无输出参数)
        /// <summary>
        /// 执行一个命令对数据库进行增，删，改
        /// </summary>
        /// <param name="sqlText">Sql语句或者存储过程名</param>
        /// <param name="commandType">sql语句或者存储过程</param>
        /// <param name="paras">参数名数组</param>
        /// <param name="values">参数值数组</param>
        /// <returns>返回影响的行数</returns>
        public static int ExecuteSql(string sqlText, CommandType commandType, string[] paras, object[] values)
        {
            int count;
            object outvalue;
            string para = null;
            count = ExecuteSql(sqlText, commandType, paras, values, para, out outvalue,SqlDbType.Int);
            return count;
        }
        #endregion

        #region 执行一个命令对数据库进行增，删，改
        /// <summary>
        /// 执行一个命令对数据库进行增，删，改
        /// </summary>
        /// <param name="sqlText">Sql语句或者存储过程名</param>
        /// <param name="commandType">sql语句或者存储过程</param>
        /// <returns>返回影响的行数</returns>
        public static int ExecuteSql(string sqlText, CommandType commandType)
        {
            cmd = PrepareCommand(sqlText, commandType, null, null);

            if (conn.State != ConnectionState.Open)
                conn.Open();
            int count;
            count = cmd.ExecuteNonQuery();
            conn.Close();
            return count;
        }
        #endregion

        /// <summary>
        /// 执行一个数据库命令
        /// </summary>
        /// <param name="commandText">命令文本，可以是 SQL 语句或存储过程名</param>
        /// <param name="commandType">命令类型，Text 或 StoredProcedure</param>
        /// <param name="paras">为命令提供参数，SqlParameter 对象数组</param>
        /// <returns>执行命令所影响到的行数</returns>
        public static int ExecuteSql(string commandText, CommandType commandType, SqlParameter[] paras)
        {
            cmd.CommandText = commandText;
            cmd.CommandType = commandType;

            cmd.Parameters.Clear();
            foreach (SqlParameter para in paras)
                cmd.Parameters.Add(para);

            if (conn.State == ConnectionState.Closed)
                conn.Open();
            int count = cmd.ExecuteNonQuery();
            conn.Close();

            return count;
        }

        public static bool CheckAccess(string commandText, CommandType commandType, string[] paras, object[] values)
        {
            cmd.Parameters.Clear();
            bool result = false;
            cmd.CommandText = commandText;
            cmd.CommandType = commandType;
            cmd.Parameters.Add(paras[0], SqlDbType.Int);
            cmd.Parameters[0].Direction = ParameterDirection.Output;

            int count = paras.Length;
            for (int i = 1; i < count; i++)
            {
                cmd.Parameters.AddWithValue(paras[i], values[i]);
            }

            if (conn.State == ConnectionState.Open)
                conn.Close();
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();


            if (Convert.ToInt32(cmd.Parameters[paras[0]].Value) == 0)
            {
                result = true;
            }
            return result;
        }

        //E 组
        public static int ExecuteSqlWhitOutPut(string sqlString, CommandType commandType, string[] paras, object[] paraValues)
        {
            if (paras.Length != paraValues.Length)
                throw new Exception("请提供适当的参数及其值");

            cmd = PrepareCommand(sqlString, commandType, paras, paraValues);

            param = cmd.Parameters.Add("@chkflg", SqlDbType.Int);
            param.Direction = ParameterDirection.Output;

            if (conn.State == ConnectionState.Closed)
                conn.Open();

            conn.Close();
            conn.Open();
            int cnt = cmd.ExecuteNonQuery();
            int s = Convert.ToInt32(cmd.Parameters["@chkflg"].Value);

            conn.Close();

            return s;
        }

        /// <summary>
        /// 构造一个命令对象
        /// </summary>
        /// <param name="sqlString">命令文本，SQL 语句或存储过程名称</param>
        /// <param name="cmdType">命令类型，Text 或 StoredProcedure</param>
        /// <param name="paraNames">参数名数组</param>
        /// <param name="paraValues">参数值数组</param>
        /// <returns>已构造好的命令对象</returns>
        private static SqlCommand PrepareCommand(string sqlString, CommandType cmdType, string[] paraNames, object[] paraValues)
        {
            cmd.CommandText = sqlString;
            cmd.CommandType = cmdType;
            cmd.Parameters.Clear();

            if (paraNames != null)
            {
                int count = paraNames.Length;
                for (int i = 0; i < count; i++)
                {
                    cmd.Parameters.AddWithValue(paraNames[i], paraValues[i]);
                }
            }
            return cmd;
        }
        
        /// <summary>
        /// 获取一行数据，（不带参数）
        /// </summary>
        /// <param name="sqlString">存储过程的名称或SQL语句</param>
        /// <param name="cmdType">SQL或者是存储过程</param>
        /// <returns>返回单行数据的集合</returns>        
        public static object[] GetValues(string sqlString, CommandType cmdType)
        {
            object[] value = null;
            cmd=PrepareCommand(sqlString, cmdType, null, null);
            conn.Open();
            sdr = cmd.ExecuteReader();
            int count = sdr.FieldCount;
            if (sdr.Read())
            {
                value = new object[count];
                for (int i = 0; i < count; i++)
                {
                    value[i] = sdr.GetValue(i);
                }
            }
            sdr.Close();
            conn.Close();
            return value;

        }

        /// <summary>
        /// 获取一行数据（带参数）
        /// </summary>
        /// <param name="sqlString">SQL语句或存储过程名</param>
        /// <param name="cmdType">sqlString是SQL语句还是存储过程</param>
        /// <param name="paras">参数名数组</param>
        /// <param name="values">参数值数组</param>
        /// <returns>返回单行数据的数组</returns>
        public static object[] GetValues(string sqlString, CommandType cmdType, string[] paras, object[] values)
        {
            if(paras.Length!=values.Length)
                throw new Exception("请输入正确的参数");
            object[] value = null;
            cmd = PrepareCommand(sqlString, cmdType,paras,values);
            conn.Open();
            sdr = cmd.ExecuteReader();
            int count = sdr.FieldCount;
            if (sdr.Read())
            { 
                value=new object[count];
                for (int i = 0; i < count; i++)
                {
                    value[i] = sdr.GetValue(i);
                }
            }
            sdr.Close();
            conn.Close();
            return value;
        }

        /// <summary>
        /// 执行一个用于选取单行数据的 SQL 命令，返回该行数据所组成的数组
        /// </summary>
        /// <param name="commandText">命令文本，SQL 语句或存储过程名</param>
        /// <param name="commandType">命令类型，Text 或 StoredProcedure</param>
        /// <param name="paras">参数名数组</param>
        /// <param name="values">参数值数组</param>
        /// <param name="para">输出参数名</param>
        /// <param name="value">用于返回输出参数值</param>
        /// <param name="type">输出参数的数据类型</param>
        /// <returns>查询到的数据组成的数组</returns>
        public static object[] GetValues(string commandText, CommandType commandType, string[] paras, object[] values,string para,out object value,SqlDbType type)
        {

            if (paras.Length != values.Length)
                throw new Exception("请输入正确的参数");
            object[] returnValues = null;
            cmd = PrepareCommand(commandText, commandType, paras, values);
            cmd.Connection.Open();
            SqlParameter pram = new SqlParameter(para,type);
            cmd.Parameters.Add(pram);
            cmd.Parameters[para].Direction = ParameterDirection.Output;
            sdr = cmd.ExecuteReader();

            if (sdr.Read())
            {
                int count = sdr.FieldCount;
                returnValues = new object[count];
                for (int i = 0; i < count; i++)
                {
                    returnValues[i] = sdr.GetValue(i);
                }
            }

            sdr.Close();
            cmd.Connection.Close();

            value = cmd.Parameters[para].Value;
            return returnValues;
        }

        /// <summary>
        /// 将给定的 DataSet 中的数据输入到数据库中
        /// </summary>
        /// <param name="dataSet">DataSet 对象，其中的数据将被插入到数据库中</param>
        /// <param name="commandText">命令文本，SQL 语句或存储过程名</param>
        /// <param name="commandType">命令类型，Text 或 StoredProcedure</param>
        /// <param name="paras">需要的参数名组成的数组</param>
        /// <returns>指示是否成功插入数据</returns>
        public static bool InsertDataToDB(DataSet dataSet, string commandText, CommandType commandType, string[] paras)
        {
            //检查 DataSet 中是否包含数据
            if (dataSet == null || dataSet.Tables.Count == 0 || dataSet.Tables[0].Rows.Count == 0)
                return false;
            
            int colCnt=dataSet.Tables[0].Columns.Count;

            //检查表中的列是否与参数
            if (colCnt != paras.Length)
            {
                throw new Exception("请输入正确的参数");
            }

            sda = new SqlDataAdapter();

            cmd = new SqlCommand(commandText, conn);
            cmd.CommandType = commandType;
            for (int i = 0; i < colCnt; i++)
            {
                cmd.Parameters.Add(paras[i], SqlDbType.VarChar,50).SourceColumn = dataSet.Tables[0].Columns[i].ColumnName;
            }
            sda.InsertCommand = cmd;

            sda.Update(dataSet, dataSet.Tables[0].TableName);

            return true;
        }
    }
}
