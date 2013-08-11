using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;


namespace DataAccess
{
    /// <summary>
    /// �����������ݿ������ݿ�������ݴ���
    /// </summary>
    public static class DataBaseAccess
    {
        static SqlCommand cmd = null;
        static SqlConnection conn = null;
        static SqlDataAdapter sda = null;
        static SqlDataReader sdr = null;
        static SqlParameter param = null;

        #region  ���캯�����ڳ�ʼ����������
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

        #region ִ��һ�������ѯһ�����ݼ������ظ����ݼ�
        /// <summary>
        /// ִ��һ�������ѯһ�����ݼ������ظ����ݼ�
        /// </summary>
        /// <param name="sqlText">Ҫִ�е�SQL�����ߴ洢������</param>
        /// <param name="tableName">DataSet �еı���</param>
        /// <param name="commandType">�������ͣ�SQL ����洢������</param>
        /// <returns> DateSet ����</returns>
        public static DataSet GetDataSet(string sqlText, string tableName, CommandType commandType)
        {
            cmd = PrepareCommand(sqlText, commandType, null, null);

            DataSet ds = new DataSet();
            sda.SelectCommand = cmd;
            sda.Fill(ds, tableName);
            return ds;
        }
        #endregion

        #region ִ��һ�������ѯһ�����ݼ������ظ����ݼ�(������)
        /// <summary>
        /// ִ��һ�������ѯһ�����ݼ������ظ����ݼ�
        /// </summary>
        /// <param name="sqlText">Ҫִ�е� SQL �����ߴ洢������</param>
        /// <param name="tableName">DataSet �еı���</param>
        /// <param name="commandType">�������ͣ�SQL����洢������</param>
        /// <param name="paras">����������</param>
        /// <param name="values">����ֵ����</param>
        /// <returns>DateSet����</returns>
        public static DataSet GetDataSet(string sqlText, string tableName, CommandType commandType, string[] paras, object[] values)
        {
            if (paras.Length != values.Length)
                throw new Exception("��������ȷ�Ĳ����Ͳ�����");

            cmd = PrepareCommand(sqlText, commandType, paras, values);
            
            DataSet ds = new DataSet();
           sda.SelectCommand = cmd;
           sda.Fill(ds, tableName);
           conn.Close();
            return ds;
        }
        #endregion

        #region ִ��һ�������ѯһ�����ݼ������ظ����ݼ�(������)
        /// <summary>
        /// ִ��һ�������ѯһ�����ݼ������ظ����ݼ�
        /// </summary>
        /// <param name="commandText">Ҫִ�е�SQL�����ߴ洢������</param>
        /// <param name="tableName">dataset����</param>
        /// <param name="commandType">SQL��仹�Ǵ洢����</param>
        /// <param name="paras">������������</param>
        /// <returns>Ҫ���ص�DateSet����</returns>
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

        #region ִ��һ����������ݿ��������ɾ����(���������)
        /// <summary>
        /// ִ��һ����������ݿ��������ɾ����
        /// </summary>
        /// <param name="sqlText">Sql�����ߴ洢������</param>
        /// <param name="commandType">sql�����ߴ洢����</param>
        /// <param name="paras">����������</param>
        /// <param name="values">����ֵ����</param>
        /// <param name="para">���������</param>
        /// <param name="value">�������ֵ</param>
        /// <returns>����Ӱ�������</returns>
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


        #region ִ��һ����������ݿ��������ɾ����(���������)
        /// <summary>
        /// ִ��һ����������ݿ��������ɾ����
        /// </summary>
        /// <param name="sqlText">Sql�����ߴ洢������</param>
        /// <param name="commandType">sql�����ߴ洢����</param>
        /// <param name="paras">����������</param>
        /// <param name="values">����ֵ����</param>
        /// <returns>����Ӱ�������</returns>
        public static int ExecuteSql(string sqlText, CommandType commandType, string[] paras, object[] values)
        {
            int count;
            object outvalue;
            string para = null;
            count = ExecuteSql(sqlText, commandType, paras, values, para, out outvalue,SqlDbType.Int);
            return count;
        }
        #endregion

        #region ִ��һ����������ݿ��������ɾ����
        /// <summary>
        /// ִ��һ����������ݿ��������ɾ����
        /// </summary>
        /// <param name="sqlText">Sql�����ߴ洢������</param>
        /// <param name="commandType">sql�����ߴ洢����</param>
        /// <returns>����Ӱ�������</returns>
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
        /// ִ��һ�����ݿ�����
        /// </summary>
        /// <param name="commandText">�����ı��������� SQL ����洢������</param>
        /// <param name="commandType">�������ͣ�Text �� StoredProcedure</param>
        /// <param name="paras">Ϊ�����ṩ������SqlParameter ��������</param>
        /// <returns>ִ��������Ӱ�쵽������</returns>
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

        //E ��
        public static int ExecuteSqlWhitOutPut(string sqlString, CommandType commandType, string[] paras, object[] paraValues)
        {
            if (paras.Length != paraValues.Length)
                throw new Exception("���ṩ�ʵ��Ĳ�������ֵ");

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
        /// ����һ���������
        /// </summary>
        /// <param name="sqlString">�����ı���SQL ����洢��������</param>
        /// <param name="cmdType">�������ͣ�Text �� StoredProcedure</param>
        /// <param name="paraNames">����������</param>
        /// <param name="paraValues">����ֵ����</param>
        /// <returns>�ѹ���õ��������</returns>
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
        /// ��ȡһ�����ݣ�������������
        /// </summary>
        /// <param name="sqlString">�洢���̵����ƻ�SQL���</param>
        /// <param name="cmdType">SQL�����Ǵ洢����</param>
        /// <returns>���ص������ݵļ���</returns>        
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
        /// ��ȡһ�����ݣ���������
        /// </summary>
        /// <param name="sqlString">SQL����洢������</param>
        /// <param name="cmdType">sqlString��SQL��仹�Ǵ洢����</param>
        /// <param name="paras">����������</param>
        /// <param name="values">����ֵ����</param>
        /// <returns>���ص������ݵ�����</returns>
        public static object[] GetValues(string sqlString, CommandType cmdType, string[] paras, object[] values)
        {
            if(paras.Length!=values.Length)
                throw new Exception("��������ȷ�Ĳ���");
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
        /// ִ��һ������ѡȡ�������ݵ� SQL ������ظ�����������ɵ�����
        /// </summary>
        /// <param name="commandText">�����ı���SQL ����洢������</param>
        /// <param name="commandType">�������ͣ�Text �� StoredProcedure</param>
        /// <param name="paras">����������</param>
        /// <param name="values">����ֵ����</param>
        /// <param name="para">���������</param>
        /// <param name="value">���ڷ����������ֵ</param>
        /// <param name="type">�����������������</param>
        /// <returns>��ѯ����������ɵ�����</returns>
        public static object[] GetValues(string commandText, CommandType commandType, string[] paras, object[] values,string para,out object value,SqlDbType type)
        {

            if (paras.Length != values.Length)
                throw new Exception("��������ȷ�Ĳ���");
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
        /// �������� DataSet �е��������뵽���ݿ���
        /// </summary>
        /// <param name="dataSet">DataSet �������е����ݽ������뵽���ݿ���</param>
        /// <param name="commandText">�����ı���SQL ����洢������</param>
        /// <param name="commandType">�������ͣ�Text �� StoredProcedure</param>
        /// <param name="paras">��Ҫ�Ĳ�������ɵ�����</param>
        /// <returns>ָʾ�Ƿ�ɹ���������</returns>
        public static bool InsertDataToDB(DataSet dataSet, string commandText, CommandType commandType, string[] paras)
        {
            //��� DataSet ���Ƿ��������
            if (dataSet == null || dataSet.Tables.Count == 0 || dataSet.Tables[0].Rows.Count == 0)
                return false;
            
            int colCnt=dataSet.Tables[0].Columns.Count;

            //�����е����Ƿ������
            if (colCnt != paras.Length)
            {
                throw new Exception("��������ȷ�Ĳ���");
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
