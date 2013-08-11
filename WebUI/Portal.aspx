<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Portal.aspx.cs" Inherits="Portal" Title="初始页面" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table align="center" border="0" cellpadding="2" cellspacing="1" class="border" width="60%">
        <tr align="left">
            <td class="topbg" colspan="2" height="25" style="text-align: left">
                <strong>未完成项</strong></td>
        </tr>
        <tr>
            <td class="tdbg" height="23" width="50%">
                未分配工程员工:</td>
            <td class="tdbg" width="50%" style="text-align: left">
                <asp:Label ID="lblNotEmp" runat="server"></asp:Label><a href="#"></a></td>
        </tr>
        <tr>
            <td class="tdbg" height="23">
                合同即将到期员工:</td>
            <td class="tdbg" height="23">
                <asp:Label
                        ID="lblNotContract" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td height="23">
                最后导入考勤数据的时间:</td>
            <td height="23">
                 <asp:Label ID="lblRecordTime" runat="server"></asp:Label></td>
        </tr>
    </table>
</asp:Content>
