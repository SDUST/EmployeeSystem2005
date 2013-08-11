<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UCPagerV2.ascx.cs" Inherits="UserControls_UCPagerV2" %>
<table style="width: 440px; height: 1px">
    <tr>
        <td align="right" style="width: 198px; height: 11px; text-align: left" valign="top">
            <asp:LinkButton ID="LnkFirst" runat="server" Font-Underline="False" OnClick="LnkFirst_Click" CausesValidation="False" >首页</asp:LinkButton>
            <asp:LinkButton ID="LnkUp" runat="server" Font-Underline="False" OnClick="LnkUp_Click" CausesValidation="False" >上一页</asp:LinkButton>
            <asp:LinkButton ID="LnkDown" runat="server" Font-Underline="False" OnClick="LnkDown_Click" CausesValidation="False" >下一页</asp:LinkButton>
            <asp:LinkButton ID="LnkLast" runat="server" Font-Underline="False" OnClick="LnkLast_Click" CausesValidation="False" >尾页</asp:LinkButton><asp:DropDownList ID="DDLpage" runat="server" AutoPostBack="True" Height="20px"
                 Width="35px" OnSelectedIndexChanged="DDLpage_SelectedIndexChanged">
            </asp:DropDownList></td>
        <td align="left" style="width: 169px; height: 11px; text-align: right" valign="middle">
            <asp:Label ID="Label1" runat="server" Text="第0页"></asp:Label>
            <asp:Label ID="Label2" runat="server" Text="/"></asp:Label>
            <asp:Label ID="Label3" runat="server" Text="第0页"></asp:Label>
            <asp:Label ID="Label4" runat="server" Text="共0条记录"></asp:Label>
        </td>
    </tr>
</table>
