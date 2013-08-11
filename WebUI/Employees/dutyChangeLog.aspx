<%@ Page Language="C#" AutoEventWireup="true" CodeFile="dutyChangeLog.aspx.cs" Inherits="dutyChangeLog" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <base target="_self" />

    <script language="javascript" type="text/javascript" src="../Script/CommonFunction.js">
   
    </script>

    <title>职务变更履历</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table style="border-right: #339999 1px solid; border-top: #339999 1px solid; border-left: #339999 1px solid;
                width: 423px; border-bottom: #339999 1px solid; height: 89px" cellpadding="2" cellspacing="1">
                <tr style="background-image: url(../images/topBar_bg.gif)">
                    <td colspan="3" style="background-image: url(../images/topBar_bg.gif); height: 1px">
                        员工姓名：<asp:Label ID="empName" runat="server" Width="79px"></asp:Label></td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:GridView ID="GVDuty" runat="server" DataSourceID="ObjectDataSource1" Width="100%"
                            AutoGenerateColumns="False" OnRowDataBound="GVDuty_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="duty_name" HeaderText="职务" />
                                <asp:BoundField DataField="record_date" HeaderText="任命日期" />
                                <asp:BoundField DataField="record_memo" HeaderText="备注" />
                            </Columns>
                            <HeaderStyle BackColor="Teal" />
                        </asp:GridView>
                        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetDutyByEmpcd" TypeName="Business.Dutys">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="cd" QueryStringField="emp_cd_duty" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height: 25px;">
                        职务<asp:DropDownList ID="dutyName" runat="server" DataSourceID="ObjectDataSource2"
                            DataTextField="duty_name" DataValueField="duty_name" Width="70px" OnDataBound="dutyName_DataBound">
                        </asp:DropDownList>
                    </td>
                    <td style="width: 110px; height: 25px;">
                        备注<asp:TextBox ID="recordMemo" runat="server" Width="70px"></asp:TextBox></td>
                    <td style="height: 25px; width: 194px;">
                        任命日期<asp:TextBox ID="recordDate" runat="server" Width="70px"></asp:TextBox>&nbsp;<asp:ImageButton
                            ID="ImageButton1" runat="server" ImageUrl="~/images/datetime.gif" OnClientClick="fPopUpCalendarDlg(document.all.recordDate);return false;" />
                        <asp:Button ID="btnUpdate" runat="server" CssClass="button" Text="变更" OnClick="btnUpdate_Click" /></td>
                </tr>
            </table>
        </div>
        <table style="width: 420px">
            <tr>
                <td colspan="3" rowspan="3" style="text-align: center">
                    <asp:Button ID="btnClose" runat="server" CssClass="button" Text="关闭" Width="53px"
                        OnClientClick=' CloseWin();return false;' OnClick="btnClose_Click1" /></td>
            </tr>
            <tr>
            </tr>
            <tr>
            </tr>
        </table>
        <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="GetDuty"
            TypeName="Business.Dutys"></asp:ObjectDataSource>
        &nbsp;
    </form>
</body>
</html>
