<%@ Page Language="C#" AutoEventWireup="true" CodeFile="userLimitSetManager.aspx.cs"
    Inherits="userLimitSetManager" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>用户权限设置管理</title>
    <base target="_self" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <center>
                <table style="border-top-width: 1px; border-left-width: 1px; border-left-color: teal;
                    border-bottom-width: 1px; border-bottom-color: teal; border-top-color: teal;
                    border-right-width: 1px; border-right-color: teal; width: 542px;" class="border">
                    <tr>
                        <td colspan="3" style="background-color: #669999; text-align: left;">
                            <span style="font-size: 10pt; color: #ffffff">用户权限管理</span></td>
                    </tr>
                    <tr>
                        <td style="background-image: url(../images/topBar_bg.gif); background-repeat: repeat;
                            text-align: left;" colspan="3">
                            登录ID：<asp:Label ID="lblUserCd" runat="server" Text="Label" Width="15px"></asp:Label>
                            &nbsp; &nbsp; 用户名：<asp:Label ID="lblUserName" runat="server" Text="Label"></asp:Label></td>
                    </tr>
                    <tr>
                        <td colspan="3" rowspan="2" valign="top">
                            <asp:Panel ID="p" runat="server" Width="518px" ScrollBars="Vertical" Height="400px" BorderWidth="0px">
                                <asp:GridView ID="gvUserManager" runat="server" AutoGenerateColumns="False" Width="100%">
                                    <Columns>
                                        <asp:BoundField DataField="fun_cd" HeaderText="功能编号">
                                        </asp:BoundField>
                                        <asp:BoundField DataField="operation" HeaderText="业务名称">
                                        </asp:BoundField>
                                        <asp:BoundField DataField="fun_name" HeaderText="功能名称">
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="权限选择">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkPopedomClass" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle BackColor="#669999" ForeColor="White" />
                                </asp:GridView>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                    </tr>
                </table>
            </center>
            <center>
            <br />
                <asp:Button ID="btnSave" runat="server" CssClass="button" Font-Size="Small" Text="确 定"
                    Width="80px" Height="20px" OnClick="btnSave_Click" />
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<asp:Button ID="btnCancel"
                    runat="server" CssClass="button" Font-Size="Small" Text="关 闭" Width="80px" Height="20px"
                    OnClientClick="window.close();return false;" /><br />
            </center>
        </div>
    </form>
</body>
</html>
