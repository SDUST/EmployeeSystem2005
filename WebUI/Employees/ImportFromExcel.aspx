<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImportFromExcel.aspx.cs" Inherits="ImportFromExcel" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>导入页面</title>
    <base target="_self"/>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div>
            <div style="text-align: center">
                <table cellpadding="0" cellspacing="0" style="width: 380px">
                    <tr>
                        <td style="height: 25px; text-align: left">
                            请选择要导入的Excel文件或XML文件：
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 52px">
                            <asp:FileUpload ID="fuImportData" runat="server" Height="22px" Width="95%" />
                        </td>
                    </tr>
                    <tr align="center" style="height: 40px">
                        <td>
                            <asp:Button ID="btnImportData" runat="server" CssClass="button" 
                                Text="导入数据" OnClick="btnImportData_Click" />
                            &nbsp; &nbsp;
                            <asp:Button ID="btnClose" runat="server" CssClass="button" OnClientClick='if(confirm("确定要关闭吗？"))window.close(); return false;'
                                Text="关闭" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    
    </div>
    </form>
</body>
</html>
