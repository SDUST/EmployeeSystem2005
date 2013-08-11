<%@ Page Language="C#" AutoEventWireup="true" CodeFile="engineerEvaluateAdd.aspx.cs"
    Inherits="engineerEvaluateAdd" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
<title>工程评价画面</title>
    <base target="_self" />

    <script type="text/javascript" src="../Script/CommonFunction.js"></script>
    <script type="text/javascript" src="../Script/ErrMessage.js"></script>

   
</head>
<body>
    <form id="form1" runat="server">
        <table style="border-right: #339999 1px solid; border-top: #339999 1px solid; border-left: #339999 1px solid; border-bottom-width: 1px; border-bottom-color: #339999; width: 600px;">
            <tr style="background-image: url(../images/topBar_bg.gif)">
                <td colspan="3">
                    <span style="font-size: 10pt">编号</span>：<asp:Label ID="Label1" runat="server" Text="Label"
                        Width="52px"></asp:Label><span style="font-size: 10pt">姓名</span>：<asp:Label ID="Label2"
                            runat="server" Text="Label" Width="56px"></asp:Label></td>
            </tr>
            <tr>
                <td valign="top" style="width: 206px; height: 25px;">
                    <span style="font-size: 10pt">评价日期</span><asp:TextBox ID="txtDate" runat="server"
                        Width="70px"></asp:TextBox>
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/datetime.gif"
                        OnClientClick="fPopUpCalendarDlg(document.all.txtDate);return false;" />
                </td>
                <td valign="top" style="width: 249px; height: 25px;">
                    <span style="font-size: 10pt">评价区分</span><asp:DropDownList ID="selClass" runat="server"
                        DataSourceID="SqlDataSource1" DataTextField="fun_name" DataValueField="combine_cd"
                        OnDataBound="selClass_DataBound" Width="140px">
                    </asp:DropDownList>
                    &nbsp;&nbsp;</td>
                <td valign="top" style="height: 25px; width: 127px;">
                    &nbsp;<span style="font-size: 10pt">评价人</span><asp:TextBox ID="txtEmpName" runat="server"
                        Width="60px"></asp:TextBox></td>
            </tr>
        </table>
        <table style="height: 89px; border-right: #339999 1px solid; border-top: #339999 1px solid;
            border-left: #339999 1px solid; border-bottom: #339999 1px solid; width: 600px;">
            <tr>
                <td colspan="1" style="width: 40px" valign="middle">
                    <span style="font-size: 12pt">备注</span></td>
                <td valign="top" colspan="4" style="width: 547px">
                    <asp:TextBox ID="txtMemo" runat="server" Height="72px" TextMode="MultiLine" Width="97%"></asp:TextBox></td>
            </tr>
        </table>
        <div style="OVERFLOW-X: hidden; OVERFLOW: scroll; WIDTH: 600px; HEIGHT: 200px">
        <table width="610">
            <tr>
                <td colspan="5" rowspan="1" style="height: 50px" valign="top">
                    <asp:GridView ID="GVevaluation" runat="server" AutoGenerateColumns="False" DataSourceID="ObjectDataSource1"
                        Width="582px" Height="114px" OnRowDataBound="GVevaluation_RowDataBound">
                        <Columns>
                            <asp:BoundField DataField="evaluation_date" HeaderText="评价日期" >
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fun_name" HeaderText="评价标准" />
                            <asp:BoundField DataField="evaluation_memo" HeaderText="备注" />
                        </Columns>
                        <HeaderStyle BackColor="Teal" />
                        <FooterStyle HorizontalAlign="Center" />
                    </asp:GridView>
                </td>
            </tr>
        </table>
        </div>
        <table width="600">
            <tr>
                <td rowspan="3" style="width: 259px; text-align: right; height: 22px;">
                    &nbsp; &nbsp;
                    <asp:Button ID="btnSave" runat="server" CssClass="button" OnClick="btnSave_Click"
                        Text="确认" /></td>
                <td rowspan="3" style="width: 46px; height: 22px;">
                </td>
                <td rowspan="3" style="width: 288px; height: 22px">
                    <asp:Button ID="btnClose" runat="server" CausesValidation="False" CssClass="button"
                        OnClientClick="window.close();return true;" Text="关闭" /></td>
            </tr>
            <tr>
            </tr>
            <tr>
            </tr>
        </table>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetPjEbyEmpcd"
            TypeName="Business.Pjevaluations">
            <SelectParameters>
                <asp:QueryStringParameter Name="emp_cd" QueryStringField="emp_cd" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:dbEmpConnectionString %>"
            SelectCommand="SELECT * FROM [tb_com_fun] WHERE ([fun_class_cd] = @fun_class_cd)">
            <SelectParameters>
                <asp:Parameter DefaultValue="8" Name="fun_class_cd" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
