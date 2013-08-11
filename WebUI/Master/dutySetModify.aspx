<%@ Page Language="C#" AutoEventWireup="true" CodeFile="dutySetModify.aspx.cs" Inherits="Master_dutySetModify" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<script type="text/javascript" src="../Script/CommonFunction.js"></script>

    <script language="JavaScript" src="../Script/ErrMessage.js" type="text/javascript"></script>
    <title>修改职务</title>
    <base target="_self" />
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <table style="width: 450px; height: 108px; border-right: #339933 1px solid; border-top: #339933 1px solid;
            border-left: #339933 1px solid; border-bottom: #339933 1px solid;">
            <tr>
                <td colspan="3" style="background-image: url(../images/topBar_bg.gif)">
                    职务设置</td>
            </tr>
            <tr>
                <td style="width: 160px; text-align: center">
                    职务番号</td>
                <td colspan="2" align="left">
                    <asp:TextBox ID="txtDutyCd" runat="server" CssClass="INPUT" MaxLength="20" ReadOnly="True"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="width: 160px; text-align: center">
                    职务名称</td>
                <td colspan="2" align="left">
                    <asp:TextBox ID="txtDutyName" runat="server" CssClass="INPUT" MaxLength="20"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="3" style="height: 21px; text-align: center">
                    <br />
                    <asp:Button ID="btnSave" runat="server" CssClass="button" Text="提交" OnClick="btnSave_Click"/>
                    <asp:Button ID="btnClose" runat="server" CssClass="button" Text="关闭" OnClientClick="window.close();return false;" /></td>
            </tr>
        </table>
    </form>
</body>
</html>
