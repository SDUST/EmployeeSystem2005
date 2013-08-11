<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="workAttendDaily.aspx.cs" Inherits="workAttendDaily" Title="出勤日报表" %>

<%@ Register Src="../UserControls/UCPager.ascx" TagName="UCPager" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript" src="../Script/CommonFunction.js"></script>
    <div style="text-align: center">
        <br />
        <asp:UpdatePanel ID="udp" runat="server">
            <contenttemplate>
        <table style="text-align: left" class="border" cellspacing="1" cellpadding="0" width="770">
            <tbody>
                <tr>
                    <td style="color: #ffffff; background-color: #539d93" class="title" colspan="2">
                        出勤日报检索</td>
                </tr>
                <tr>
                    <td>
                        出勤日期
                        <asp:TextBox ID="txtCardTime1" runat="server" Width="70px" Height="14px" Wrap="False"
                            Columns="20" CssClass="readonly"></asp:TextBox>
                        <asp:ImageButton ID="imgCardTime1" runat="server" ImageUrl="~/images/datetime.gif"
                            OnClientClick="fPopUpCalendarDlg(document.all.ctl00$ContentPlaceHolder1$txtCardTime1); return false;">
                        </asp:ImageButton>
                        ～
                        <asp:TextBox ID="txtCardTime2" runat="server" Width="70px" Height="14px" Columns="20"
                            CssClass="readonly"></asp:TextBox>
                        <asp:ImageButton ID="imgCardTime2" runat="server" ImageUrl="~/images/datetime.gif"
                            OnClientClick="fPopUpCalendarDlg(document.all.ctl00$ContentPlaceHolder1$txtCardTime2); return false;">
                        </asp:ImageButton>&nbsp;
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCardTime1"
                            ErrorMessage="请输入起始日期">&nbsp</asp:RequiredFieldValidator><asp:RequiredFieldValidator
                                ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtCardTime2"
                                ErrorMessage="请输入结束日期">&nbsp</asp:RequiredFieldValidator><asp:CompareValidator ID="CompareValidator1"
                                    runat="server" ControlToValidate="txtCardTime1" ErrorMessage="日期格式为yyyy/mm/dd"
                                    Type="Date" Operator="DataTypeCheck">&nbsp</asp:CompareValidator><asp:CompareValidator
                                        ID="CompareValidator2" runat="server" ControlToValidate="txtCardTime2" ErrorMessage="日期格式为yyyy/mm/dd"
                                        Type="Date" Operator="DataTypeCheck">&nbsp</asp:CompareValidator><asp:CompareValidator
                                            ID="CompareValidator3" runat="server" ControlToValidate="txtCardTime1" ErrorMessage="起始日期不小于终止日期"
                                            Type="Date" Operator="LessThanEqual" ControlToCompare="txtCardTime2">&nbsp</asp:CompareValidator></td>
                    <td>
                        <asp:Button ID="btnQuery" OnClick="btnQuery_Click" runat="server" CssClass="button"
                            Text="查 询"></asp:Button></td>
                </tr>
            </tbody>
        </table>
        <br />
        <table class="border" cellspacing="0" cellpadding="0" width="770">
            <tbody>
                <tr>
                    <td style="background-image: url(../images/topBar_bg.gif); text-align: left" class="title">
                        出勤日报表
                    </td>
                    <td style="background-image: url(../images/topBar_bg.gif); text-align: right" class="title"
                        align="right">
                        <asp:LinkButton ID="lnkPrint" OnClick="lnkPrint_Click" runat="server" CausesValidation="False">打印报表</asp:LinkButton>&nbsp;
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:GridView ID="gv" runat="server" Width="100%" BorderWidth="1px" OnPageIndexChanged="gv_PageIndexChanged"
                            PageSize="15" AllowPaging="True" AutoGenerateColumns="False" OnDataBound="gv_DataBound">
                            <PagerSettings Visible="False"></PagerSettings>
                            <Columns>
                                <asp:BoundField DataField="day_date" HeaderText="日期">
                                    <HeaderStyle BackColor="#539D93" Width="11%" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="yearVac" HeaderText="有薪假">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle BackColor="#539D93" Width="6%" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="illVac" HeaderText="病假">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle BackColor="#539D93" Width="5%" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="caseVac" HeaderText="事假">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle BackColor="#539D93" Width="5%" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="speVac" HeaderText="特别假">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle BackColor="#539D93" Width="7%" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="jobInjure" HeaderText="工伤">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle BackColor="#539D93" Width="6%" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="absent" HeaderText="旷工">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle BackColor="#539D93" Width="7%" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="whtAbsent" HeaderText="无故旷工">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle BackColor="#539D93" Width="8%" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="total" HeaderText="合计">
                                    <ItemStyle ForeColor="Blue" HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle BackColor="#539D93" Width="5%" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="attendance" HeaderText="出勤人数">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle BackColor="#539D93" Width="8%" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="manager" HeaderText="经理签字">
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    <HeaderStyle BackColor="#539D93" Width="11%" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="minister" HeaderText="管理部长">
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    <HeaderStyle BackColor="#539D93" Width="8%" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="secretary" HeaderText="制造部长">
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    <HeaderStyle BackColor="#539D93" Width="13%" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td style="background-color: #7bb9b1" colspan="2">
                        <uc1:UCPager ID="ucPager" runat="server"></uc1:UCPager>
                        <%--<asp:LinkButton ID="lnkFirstPage" OnClick="lnkFirstPage_Click" runat="server">首页</asp:LinkButton>
                                <asp:LinkButton ID="lnkPriviousPage" OnClick="lnkPriviousPage_Click" runat="server">上一页</asp:LinkButton>
                                <asp:LinkButton ID="lnkNextPage" OnClick="lnkNextPage_Click" runat="server">下一页</asp:LinkButton>
                                <asp:LinkButton ID="lnkLastPage" OnClick="lnkLastPage_Click" runat="server">尾页</asp:LinkButton>
                                <asp:DropDownList ID="selPage" runat="server" Width="35px" AutoPostBack="True" OnSelectedIndexChanged="selPage_SelectedIndexChanged">
                                </asp:DropDownList>
                                第<asp:Label ID="lblCurrentPage" runat="server" Text=" "></asp:Label>页/共<asp:Label
                                    ID="lblTotolPageCount" runat="server" Text=" "></asp:Label>页 共<asp:Label ID="lblRecordCount"
                                        runat="server" Text=" "></asp:Label>条记录--%>
                    </td>
                </tr>
            </tbody>
        </table>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowSummary="False"
            ShowMessageBox="True"></asp:ValidationSummary>
        </contenttemplate>
        </asp:UpdatePanel>
    </div>
    <asp:ObjectDataSource ID="odsDepts" runat="server" SelectMethod="GetDeptNameOrPjName"
        TypeName="Business.Depts" OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:Parameter DefaultValue="0" Name="deptClass" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsPjs" runat="server" SelectMethod="GetDeptNameOrPjName"
        TypeName="Business.Depts" OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:Parameter DefaultValue="1" Name="deptClass" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="AttendancesSelect" TypeName="Business.Attendances"
        OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:Parameter Name="attendanceDateBegin" Type="DateTime" />
            <asp:Parameter Name="attendanceDateEnd" Type="DateTime" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
