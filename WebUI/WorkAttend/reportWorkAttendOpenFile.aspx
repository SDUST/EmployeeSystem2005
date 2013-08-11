<%@ Page Language="C#" AutoEventWireup="true" CodeFile="reportWorkAttendOpenFile.aspx.cs"
    Inherits="WorkAttend_reportWorkAttendOpenFile" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
<title>导入考勤表</title>
    <base target="_self" />
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align: center">
            <table style="width: 380px" cellspacing="0" cellpadding="0">
                <tr>
                    <td style="height: 25px; text-align: left">
                        请选择要导入Excel文件的路径：
                    </td>
                </tr>
                <tr>
                    <td style="height: 52px">
                        <asp:FileUpload ID="fuImportData" runat="server" Height="22px" Width="95%" />
                    </td>
                </tr>
                <tr align="center" style="height: 40px">
                    <td>
                        <asp:Button ID="btnImportData" runat="server" CssClass="button" Text="导入数据库" OnClick="btnImportData_Click" />
                        <asp:Button ID="btnClose" runat="server" CssClass="button" Text="关闭" OnClientClick='if(confirm("确定要关闭吗？"))window.close(); return false;' />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
