using System;
using System.Collections.Generic;
using System.Text;

using System.IO;
using System.Net;
using System.Net.Mail;

namespace Common
{
    public class CommonOperation
    {
        /// <summary>
        /// 对给定的字符串进行加密处理，返回一个长度为32个字符的字符串，
        /// </summary>
        /// <param name="pSeed">要加密的字符串</param>
        /// <returns>加密后的结果</returns>
        public static string MD5(string pSeed)
        {
            return System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(pSeed, "MD5").ToLower();
        }

        /// <summary>
        /// 以当前时间（精确到毫秒）生成一个具有唯一性的文件名
        /// </summary>
        /// <returns>生成的文件名</returns>
        public static string GenerateFileName()
        {
            return DateTime.Now.ToString("yyyyMMddHmmssffff");
        }

        /// <summary>
        /// 将指定文件移到新位置，并提供指定新文件名的选项。
        /// </summary>
        /// <param name="sourceFileName">源文件名</param>
        /// <param name="destFileName">目标文件名</param>
        /// <returns>文件移动是否成功</returns>
        public static bool MoveFile(string sourceFileName, string destFileName)
        {
            try
            {
                System.IO.File.Move(sourceFileName, destFileName);
            }
            catch
            {
                return false;
            }
            return true;
        }

        /// <summary>
        /// 删除指定的文件，返回 bool值指示是否删除成功
        /// </summary>
        /// <param name="path">要删除的文件</param>
        /// <returns>是否成功删除文件</returns>
        public static bool DeleteFile(string path)
        {
            try
            {
                if (File.Exists(path))
                {
                    File.Delete(path);
                }
            }
            catch
            {
                return false;
            }
            return true;
        }


        /// <summary>
        /// 创建指定的目录
        /// </summary>
        /// <param name="path">要创建的目录</param>
        /// <returns>是否成功创建目录</returns>
        public static bool CreateDirectory(string path)
        {
            try
            {
                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }
            }
            catch
            {
                return false;
            }
            return true;
        }

        public static string SendEmail(string pTitle, string pBody, string pSendTo, string pSendFrom, string pSMTP, string pSMTPUser, string pSMTPPassword)
        {
            SmtpClient smtp = new SmtpClient();
            smtp.Host = pSMTP;  //设定电子邮件服务器(主机名或IP地址)
            smtp.Credentials = new NetworkCredential(pSMTPUser, pSMTPPassword);

            MailMessage msg = new MailMessage();    //实例化一个电子邮件对象
            msg.Body = pBody;   //设定电子邮件主体内容
            msg.From = new MailAddress(pSendFrom);  //设定发件人地址
            msg.To.Add(pSendTo);    //设定收件人地址

            msg.IsBodyHtml = true;  //设定邮件主体是否以HTML格式显示
            msg.Subject = pTitle;   //设定邮件主题

            try
            {
                smtp.Send(msg); //发送邮件
            }
            catch (SmtpException e)
            {
                return e.StatusCode.ToString();
            }
            catch (Exception e)
            {
                return e.ToString();
            }

            return "Success";
        }
    }
}
