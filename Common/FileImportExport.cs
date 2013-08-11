using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Xml;

using Microsoft.Office.Interop.Excel;
using Microsoft.Office.Interop;

namespace Common
{
    public enum FileType
    {
        Excel,
        XML
    }

    /// <summary>
    /// 实现文件数据的导入、导出功能
    /// </summary>
    public static class FileImportExport
    {
        /// <summary>
        /// 将一个 Excel 文件中的数据导入到 DataSet 中，并返回该 DataSet
        /// </summary>
        /// <param name="fileName">要从中导入数据的 Excel 文件（带路径）</param>
        /// <returns>包含导入的数据的 DataSet 对象</returns>
        public static DataSet ImportDataFromExcel(string fileName)
        {
            if (fileName == null || fileName == string.Empty || !File.Exists(fileName))
                return null;

            DateTime beforeTime = DateTime.Now;

            Microsoft.Office.Interop.Excel.ApplicationClass excel = new ApplicationClass();//建立 Excel 应用程序对象
            Microsoft.Office.Interop.Excel.Workbook workBook;
            Microsoft.Office.Interop.Excel.Worksheet workSheet;
            //workBook = excel.Application.Workbooks.Open(fileName, 2, true, null, null, null, true, null, null, null, null, null, false, null, null);
            //加载指定的 Excel 文件
            workBook = excel.Application.Workbooks.Add(fileName);

            excel.Visible = false;
            excel.DisplayAlerts = false;

            //获取文档中最后一个工作表
            //workSheet = (Microsoft.Office.Interop.Excel.Worksheet)workBook.Sheets[workBook.Sheets.Count];

            //取得当前活动的工作表
            workSheet = (Microsoft.Office.Interop.Excel.Worksheet)workBook.ActiveSheet;

            string strConn = " Provider = Microsoft.Jet.OLEDB.4.0 ; Data Source = " + fileName + ";Extended Properties=Excel 8.0";//连接字符串

            //从工作表中取得数据
            OleDbDataAdapter excelDA = new OleDbDataAdapter("select * from [" + workSheet.Name + "$]", strConn);

            DataSet ExcelDs = new DataSet();//建立数据集,用于存放导入Excel的数据

            try
            {
                excelDA.Fill(ExcelDs, "ExcelInfo");//填充DataSet
            }
            catch (Exception ee)
            {
                throw ee;
            }
            finally
            {
                workBook.Close(null, null, null);
                excel.Quit();
                excel = null;
                KillExcelProcess(beforeTime);//停掉正在使用的 Excel 进程
            }
            return ExcelDs;//返回DataSet
        }

        /// <summary>
        /// 将一个 XML  文档中的数据导入到一个 DataSet 中
        /// </summary>
        /// <param name="fileName">要从中导入数据的 XML 文档（带路径）</param>
        /// <param name="dataSet">数据被导入到 DataSet 中，由此参数返回</param>
        /// <returns>指示导入数据是否成功</returns>
        public static bool ImportDataFromXML(string fileName, ref DataSet dataSet)
        {
            if (fileName == null || fileName == string.Empty || !File.Exists(fileName))
                return false;

            dataSet.ReadXml(fileName);
            return true;
        }

        /// <summary>
        /// 将 DataSet 中的数据导入到指定的 Excel 文件中，可以使用预先定义的模板
        /// </summary>
        /// <param name="dataSet">要从中导出数据的 DataSet 对象</param>
        /// <param name="fileName">要向其中导入数据的 Excel 文件（包含路径）</param>
        /// <param name="templateFileName">要使用的模板文件名（包含路径）</param>
        /// <param name="startRow">向 Excel 文件中写入数据时起始行的索引</param>
        /// <param name="startColumn">向 Excel 文件中写入数据时起始列的索引</param>
        public static void ExportDataToExcel(DataSet dataSet, string fileName, string templateFileName, int startRow, int startColumn)
        {
            DateTime beforeTime = DateTime.Now;

            Microsoft.Office.Interop.Excel.ApplicationClass excel = new ApplicationClass();//建立 Excel 应用程序对象
            Microsoft.Office.Interop.Excel.Workbook workBook;
            Microsoft.Office.Interop.Excel.Worksheet workSheet;

            //定义行、列的索引
            int rowIndex = 1;
            int colIndex = 0;

            //标示是否使用模板文件
            bool hasTemplate = false;

            //检验起始行和列的索引
            if (startRow < 1) startRow = 1;
            if (startColumn < 1) startColumn = 1;

            //检查是否使用模板文件
            if (templateFileName != null && Path.GetExtension(templateFileName) == ".xls" && File.Exists(templateFileName))
            {
                hasTemplate = true;
                workBook = excel.Application.Workbooks.Add(templateFileName);//以指定的文件作为模板建立一个新 Excel 文档，即工作簿
            }
            else
            {
                workBook = excel.Application.Workbooks.Add(true);//为 Excel 应用程序对象添加一个工作簿，即建立一个 Excel 文档
            }

            workSheet = (Microsoft.Office.Interop.Excel.Worksheet)workBook.ActiveSheet;//获取当前活动的工作表
            System.Data.DataTable table = dataSet.Tables[0];//获取 DataSet 中的 DataTable

            //如果没有模板，则为空表格添加列名
            if (!hasTemplate)
            {
                colIndex = startColumn;
                foreach (DataColumn col in table.Columns)//填充表头
                {
                    workSheet.Cells[1, colIndex] = col.Caption;//以 DataTable 中的字段名作为列名
                    //excel.Cells[1, colIndex] = col.ColumnName;//指定列填充数据
                    colIndex++;//列索引值递增
                }
            }

            rowIndex = startRow;
            foreach (DataRow row in table.Rows)//向表格中填充数据
            {
                colIndex = startColumn;
                foreach (DataColumn col in table.Columns)
                {
                    workSheet.Cells[rowIndex, colIndex] = row[col.ColumnName].ToString();
                    colIndex++;
                }
                rowIndex++;
            }

            excel.Visible = false;//Excel 不可见，只在内存中操作            
            excel.DisplayAlerts = false;//设定是否显示警告信息
            //保存 Excel 文档
            workBook.SaveAs(fileName, Microsoft.Office.Interop.Excel.XlFileFormat.xlExcel7, null, null, null, null, Microsoft.Office.Interop.Excel.XlSaveAsAccessMode.xlNoChange, null, null, null, null, null);
            //excel.ActiveWorkbook.SaveAs(strExcelFileName, Microsoft.Office.Interop.Excel.XlFileFormat.xlExcel7, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Microsoft.Office.Interop.Excel.XlSaveAsAccessMode.xlNoChange, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing);

            workBook.Close(null, null, null);
            excel.Quit();//退出 Excel 应用程序
            excel = null;
            GC.Collect();//垃圾回收

            KillExcelProcess(beforeTime);//停掉使用的 Excel 进程
        }

        /// <summary>
        /// 将 DataSet 中的数据导出到 XML 文档中
        /// </summary>
        /// <param name="dataSet">要从中导出数据的 DataSet 对象</param>
        /// <param name="fileName">数据导出到的目标 XML 文件（包含路径）</param>
        /// <returns>导出数据是否成功</returns>
        public static bool ExportDataToXML(DataSet dataSet, string fileName)
        {
            //创建一个 XML 文档对象
            XmlDocument doc = new XmlDocument();

            //获取 DataSet 中的数据表
            System.Data.DataTable table = dataSet.Tables[0];

            //以表名创建 XML 文档的根元素并添加到文档中
            string rootName = "<" + table.TableName + "></" + table.TableName + ">";
            //为文档添加 XML 声明
            doc.LoadXml("<?xml version=\"1.0\" encoding=\"utf-8\"?>" + rootName);

            //获取 XML 文档的根元素
            XmlElement root = doc.DocumentElement;

            XmlElement row = null, col = null;

            foreach (DataRow dr in table.Rows)
            {
                row = doc.CreateElement("DataRow");//对于每一行，创建一个名为 DataRow 的元素
                foreach (DataColumn dc in table.Columns)
                {
                    col = doc.CreateElement(dc.ColumnName);//对于每一列，创建一个以字段名为名称的元素
                    col.InnerText = dr[dc].ToString();
                    row.AppendChild(col);
                }
                root.AppendChild(row);
            }

            doc.Save(fileName);

            return true;
        }

        /// <summary>
        /// 实现文件的下载
        /// </summary>
        /// <param name="page">页面对象</param>
        /// <param name="serverFileName">要被下载到客户端的服务器文件名（包含路径）</param>
        /// <param name="clientFileName">文件被下载到客户端时的默认的文件名（不含路径）</param>
        /// <param name="fileType">要下载的文件的类型</param>
        public static void FileDownLoad(System.Web.UI.Page page, string serverFileName, string clientFileName, FileType fileType)
        {
            if (serverFileName == null || !System.IO.File.Exists(serverFileName))
                throw new Exception("服务器文件不存在");

            switch (fileType)
            {
                case FileType.Excel:
                    if (clientFileName == null || clientFileName == "")
                        clientFileName = "temp.xls";
                    //page.Response.ContentType = "application/ms-excel";
                    break;
                case FileType.XML:
                    if (clientFileName == null || clientFileName == "")
                        clientFileName = "temp.xml";
                    break;
                default:
                    if (clientFileName == null || clientFileName == "")
                        clientFileName = "temp";
                    break;
            }

            string temp = string.Format("attachment;filename={0}", clientFileName);
            page.Response.ClearHeaders();
            page.Response.Clear();
            page.Response.Buffer = true;
            page.Response.ContentEncoding = System.Text.Encoding.Default;

            page.Response.AppendHeader("Content-disposition", temp);

            page.Response.ContentType = "application/octet-stream";

            page.Response.WriteFile(serverFileName);

            page.Response.End();
        }

        /// <summary>
        /// 停掉在指定时间之后、当前时间之前启动的 Excel 进程
        /// </summary>
        /// <param name="beforeTime">起始时间</param>
        private static void KillExcelProcess(DateTime beforeTime)
        {
            DateTime startTime;
            DateTime afterTime = DateTime.Now;

            System.Diagnostics.Process[] process = System.Diagnostics.Process.GetProcessesByName("EXCEL");

            foreach (System.Diagnostics.Process proc in process)
            {
                startTime = proc.StartTime;
                if (startTime > beforeTime && startTime < afterTime)
                    proc.Kill();
            }
        }
    }
}

