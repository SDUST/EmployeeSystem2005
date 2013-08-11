<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="addWorkAttendInfo.aspx.cs" Inherits="addWorkAttendInfo" Title="补录考勤数据"
    StylesheetTheme="MainStyle" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript" src="../Script/CommonFunction.js"></script>

    <%--<script language="javascript" type="text/javascript">
    // <!CDATA[
    
    function imgDateTime_onclick() {
    fPopUpCalendarDlg(document.all.txtDate);
    }
    
    // ]]>
    </script>--%>

    <br />
    <div style="text-align: center">
        <table style="border-right: #39867b 1px solid; border-top: #39867b 1px solid; border-left: #39867b 1px solid;
            border-bottom: #39867b 1px solid" cellspacing="0" cellpadding="0">
            <tbody>
                <tr>
                    <td style="background-image: url(../images/topBar_bg.gif); height: 22px" align="left"
                        colspan="6">
                        录入考勤数据
                    </td>
                </tr>
                <tr style="height: 30px">
                    <td style="width: 80px">
                        编 号</td>
                    <td align="left" style="width: 140px">
                        <asp:UpdatePanel id="udpEmpCd" runat="server">
                            <contenttemplate>
<asp:TextBox id="txtEmpCd" runat="server" Width="60px" __designer:dtid="562949953421326" Columns="20" AutoPostBack="True" __designer:wfdid="w22" OnTextChanged="txtEmpCd_TextChanged"></asp:TextBox> <asp:RequiredFieldValidator id="rfvEmpCd" runat="server" __designer:dtid="562949953421326" ControlToValidate="txtEmpCd" ErrorMessage="请输入编号" __designer:wfdid="w23">*</asp:RequiredFieldValidator> 
</contenttemplate>
                        </asp:UpdatePanel>
                    </td>
                    <td style="width: 80px">
                        姓 名</td>
                    <td align="left" style="width: 140px">
                        <asp:UpdatePanel id="udpEmpName" runat="server">
                            <contenttemplate>
<asp:TextBox id="txtEmpName" runat="server" Width="60px" Height="14px" BorderWidth="1px" __designer:dtid="562949953421329" CssClass="readonly" Columns="20" __designer:wfdid="w11"></asp:TextBox> 
</contenttemplate>
                        </asp:UpdatePanel>
                    </td>
                    <td style="width: 80px">
                        日 期</td>
                    <td align="left" style="width: 140px">
                        <asp:TextBox ID="txtAttendanceDate" runat="server" Width="70px" Columns="20" CssClass="readonly"
                            Height="14px"></asp:TextBox>
                        <asp:ImageButton ID="imgDate" runat="server" ImageUrl="~/images/datetime.gif" OnClientClick="fPopUpCalendarDlg(document.all.ctl00_ContentPlaceHolder1_txtAttendanceDate); return false;">
                        </asp:ImageButton>
                        <asp:RequiredFieldValidator ID="rfvAttendanceDate" runat="server" ErrorMessage="请选择日期"
                            ControlToValidate="txtAttendanceDate">*</asp:RequiredFieldValidator>
                        <%--<img src="images/datetime.gif" id="imgDateTime" onclick="return fPopUpCalendarDlg(document.all.txtDate)" />--%>
                    </td>
                </tr>
                <tr style="height: 30px">
                    <td>
                        开始时间</td>
                    <td align="left">
                        <asp:TextBox ID="txtCardTimeStart" runat="server" Width="70px"></asp:TextBox>格式：8:00
                        <asp:RequiredFieldValidator ID="rfvCardTimeStart" runat="server" ErrorMessage="请输入开始时间"
                            ControlToValidate="txtCardTimeStart" Display="Dynamic">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                ID="revCardTimeStart" runat="server" ErrorMessage="开始时间格式不正确" ControlToValidate="txtCardTimeStart"
                                Display="Dynamic" ValidationExpression="^([0-9]|1[0-9]|2[0-3]):[0-5][0-9]$">*</asp:RegularExpressionValidator>
                    </td>
                    <td>
                        结束时间</td>
                    <td align="left">
                        <asp:TextBox ID="txtCardTimeEnd" runat="server" Width="70px" Columns="20"></asp:TextBox>格式：17:30
                        <asp:RequiredFieldValidator ID="rfvCardTimeEnd" runat="server" ErrorMessage="请输入结束时间"
                            ControlToValidate="txtCardTimeEnd" Display="Dynamic">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                ID="revCardTimeEnd" runat="server" ControlToValidate="txtCardTimeEnd" Display="Dynamic"
                                ErrorMessage="结束时间格式不正确" ValidationExpression="^([0-9]|1[0-9]|2[0-3]):[0-5][0-9]$">*</asp:RegularExpressionValidator></td>
                    <td>
                        加班时数</td>
                    <td align="left">
                        <asp:TextBox ID="txtOvertime" runat="server" Width="70px"></asp:TextBox>
                        <%--<asp:RequiredFieldValidator ID="rfvOvertime" runat="server" ErrorMessage="请输入加班时数"
                            ControlToValidate="txtOvertime" Display="Dynamic">*</asp:RequiredFieldValidator>--%>
                        <asp:CompareValidator ID="cvOvertime" runat="server" ControlToValidate="txtOvertime"
                            ErrorMessage="时数输入不正确" Operator="DataTypeCheck" Type="Double" Display="Dynamic">*</asp:CompareValidator></td>
                </tr>
                <tr style="height: 30px">
                    <td>
                        休假区分</td>
                    <td align="left">
                        <%--<asp:UpdatePanel id="udpVacClass" runat="server">
                            <contenttemplate>--%>
                        <asp:DropDownList ID="selVacClass" runat="server" DataSourceID="odsVacClasses"
                            DataTextField="fun_name" DataValueField="combine_cd" OnSelectedIndexChanged="selVacClass_SelectedIndexChanged"
                            AutoPostBack="True">
                        </asp:DropDownList>
                        <%--</contenttemplate>
                        </asp:UpdatePanel>--%>
                    </td>
                    <td>
                        休假时/天数</td>
                    <td align="left">
                        <%--<asp:UpdatePanel id="udpVacTime" runat="server">
                            <contenttemplate>--%>
                        <asp:TextBox ID="txtVacTime" runat="server" Width="70px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvVacTime" runat="server" ControlToValidate="txtVacTime"
                            ErrorMessage="请输入休假时/天数" Display="Dynamic" Enabled="False">*</asp:RequiredFieldValidator><asp:CompareValidator
                                ID="cvVacTime" runat="server" ControlToValidate="txtVacTime" ErrorMessage="休假时/天数输入不正确"
                                Display="Dynamic" Type="Double" Operator="DataTypeCheck">*</asp:CompareValidator>
                        <%--</contenttemplate>
                        </asp:UpdatePanel>--%>
                    </td>
                    <td>
                        迟 到</td>
                    <td align="left">
                        <asp:CheckBox ID="chkLateTime" runat="server" /></td>
                </tr>
            </tbody>
        </table>
        <table>
            <tbody>
                <tr>
                    <td>
                        <asp:Button ID="btnSave" OnClick="btnSave_Click" runat="server" Width="100px" CssClass="button"
                            Text="保 存"></asp:Button></td>
                </tr>
            </tbody>
        </table>
    </div>
    <asp:RequiredFieldValidator ID="rfvEmpName" runat="server" ControlToValidate="txtEmpName"
        ErrorMessage="不存在此员工编号">&nbsp</asp:RequiredFieldValidator>
    <asp:ValidationSummary ID="vs" runat="server" ShowMessageBox="True" ShowSummary="False" />
    <asp:ObjectDataSource ID="odsVacClasses" runat="server" SelectMethod="GetVacClasses"
        TypeName="Business.Vacations"></asp:ObjectDataSource>
</asp:Content>
