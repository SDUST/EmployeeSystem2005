<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ContractLog.aspx.cs" Inherits="ContractMessage_ContractLog" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>合同履历</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table style="border-right: #339999 1px solid; border-top: #339999 1px solid; border-left: #339999 1px solid;
                width: 485px; border-bottom: #339999 1px solid" cellpadding="0" cellspacing="0">
                <tr align="left"  style="background-image: url(../images/topBar_bg.gif)">
                <td colspan="3" style="height: 20px"  >
                    <asp:Label ID="Label1" runat="server" Text="员工姓名："></asp:Label><asp:Label ID="empName"
                        runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td  style="width: 485px; height: 120px;" valign="top">
                    <asp:Panel ID="Panel1" runat="server" Height="120px" ScrollBars="Vertical" Width="465px">
                    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1"
                        HorizontalAlign="Center" Width="100%" AutoGenerateColumns="False">
                        <HeaderStyle BackColor="#539B93" ForeColor="White" />
                        <Columns>
                            <asp:BoundField DataField="鉴定日期" HeaderText="签订日期" >
                                <ItemStyle />
                                <HeaderStyle Width="110px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="结束日期" HeaderText="结束日期" >
                                <HeaderStyle Width="110px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="合同期（年）" HeaderText="合同期（年）" >
                                <HeaderStyle Width="110px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="备注" HeaderText="备 注" >
                                <HeaderStyle Width="110px" />
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                    </asp:Panel>
                </td>
            </tr>
        </table>
        <br />
        <table cellpadding="0" cellspacing="0" style="width: 480px">
            <tr>
                <td align="center" colspan="3" rowspan="3">
                    <asp:Button ID="btnClose" runat="server" BackColor="#D7E8DF" BorderColor="#39867B"
            BorderWidth="1px" CssClass="button" Text="关闭" OnClick="btnClose_Click" OnClientClick="window.close();return false;" /></td>
            </tr>
            <tr>
            </tr>
            <tr>
            </tr>
        </table>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetContractRecord"
                        TypeName="Business.ContractMessage">
                        <SelectParameters>
                            <asp:QueryStringParameter DefaultValue="" Name="emp_cd" QueryStringField="eid" Type="String" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                </div>
    </form>
</body>
</html>
