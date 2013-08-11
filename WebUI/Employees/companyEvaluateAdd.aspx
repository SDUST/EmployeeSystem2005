<%@ Page Language="C#" AutoEventWireup="true" CodeFile="companyEvaluateAdd.aspx.cs"
    Inherits="companyEvaluateAdd" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>公司评价新增</title>
    <base target="_self" />
    <script type="text/javascript" src="../Script/CommonFunction.js"></script>
    <script type="text/javascript">
    </script>    
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table style="border-right: #339999 1px solid; border-top: #339999 1px solid; border-left: #339999 1px solid;height: 150px; border-bottom: #339999 1px solid" width="438">
                <tr style="background-image: url(images/topBar_bg.gif)">
                    <td colspan="3" style="height: 19px; background-image: url(../images/topBar_bg.gif); width: 433px;">
                        编号：<asp:Label ID="lblemp_cd" runat="server" Text="Label" Width="45px"></asp:Label>姓名：<asp:Label
                            ID="lblemp_name" runat="server" Text="Label" Width="80px"></asp:Label></td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 24px; width: 433px;">
                        评价日期<asp:TextBox ID="txtEvaluationDate" runat="server" Width="70px"></asp:TextBox>
                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/datetime.gif" OnClientClick="fPopUpCalendarDlg(document.all.txtEvaluationDate);return false;" />&nbsp;
                        &nbsp;评价区分<asp:DropDownList ID="selEvaluationClass" runat="server" DataTextField="fun_name"
                            DataValueField="combine_cd" Width="52px" DataSourceID="SqlDataSource1" OnDataBound="selEvaluationClass_DataBound">
                        </asp:DropDownList>&nbsp; &nbsp; &nbsp;&nbsp; 评价人<asp:TextBox ID="txtEvaluationEmpName" runat="server"
                            Width="60px"></asp:TextBox>&nbsp;&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 6px; text-align: left; width: 433px;" valign="top">
                        &nbsp;备注：</td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 4px; text-align: right; width: 433px;" valign="top">
                        <asp:TextBox ID="txtEvaluationMemo" runat="server" Height="95px" TextMode="MultiLine"
                            Width="89%"></asp:TextBox></td>
                </tr>
                </table>
                <div style="OVERFLOW-X: hidden;OVERFLOW: scroll; WIDTH: 435px; HEIGHT: 120px;">
               <table style="border-right: #339999 1px solid; border-top: #339999 1px solid; border-left: #339999 1px solid;
                width: 424px;height: 100px; border-bottom: #339999 1px solid">
                <tr>
                    <td colspan="3" style="width: 414px">
                        <asp:GridView ID="GVComy_Evalu" runat="server" AutoGenerateColumns="False" DataSourceID="ObjectDataSource1"
                            Width="438px" OnRowDataBound="GVComy_Evalu_RowDataBound" Height="1px">
                            <Columns>
                                <asp:BoundField DataField="evaluation_date" HeaderText="评价日期" >
                                    <FooterStyle ForeColor="White" Width="90px" />
                                    <ControlStyle Width="90px" />
                                    <ItemStyle Width="90px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="evaluation_class" HeaderText="评价标准" >
                                    <FooterStyle ForeColor="White" Width="90px" />
                                    <ItemStyle Width="90px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="evaluation_memo" HeaderText="备注" >
                                    <FooterStyle ForeColor="White" Width="50px" />
                                    <ItemStyle Width="50px" />
                                </asp:BoundField>
                            </Columns>
                            <HeaderStyle BackColor="Teal" />
                        </asp:GridView>
                        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetComyEvaluationByEmpcd"
                            TypeName="Business.Comyevaluations">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="emp_cd" QueryStringField="emp_cd" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </td>
                </tr>
            </table>
            </div>
            <table width="438">
                <tr>
                    <td colspan="2" rowspan="3" style="width: 26px; text-align: right; height: 22px;">
                    </td>
                    <td colspan="1" rowspan="3" style="width: 26px; text-align: right; height: 22px;">
                        <asp:Button ID="btnSave" runat="server" CssClass="button" Text="确认" OnClick="btnSave_Click" /></td>
                    <td rowspan="3" style="text-align: left; width: 221px; height: 22px;">
                        <asp:Button ID="btnClose" runat="server" CssClass="button" Text="关闭" OnClientClick='if(confirm("确定要关闭吗？"))window.close(); return false;' /></td>
                </tr>
            </table>
            </div>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:dbEmpConnectionString %>"
                SelectCommand="SELECT * FROM [tb_com_fun] WHERE ([fun_class_cd] = @fun_class_cd)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="10" Name="fun_class_cd" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
    </form>
</body>
</html>
