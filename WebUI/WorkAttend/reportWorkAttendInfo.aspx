<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="reportWorkAttendInfo.aspx.cs" Inherits="WorkAttend_reportWorkAttendInfo"
    Title="导入考勤数据" %>

<%@ Register Src="../UserControls/UCPager.ascx" TagName="UCPager" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <div style="text-align: center">
        <asp:UpdatePanel ID="udp" runat="server">
            <contenttemplate>
        <table class="border" cellspacing="0" cellpadding="0" width="80%">
            <tbody>
                <tr>
                    <td style="background-image: url(../images/topBar_bg.gif)" class="title" align="left">
                        考勤导入记录</td>
                    <td style="background-image: url(../images/topBar_bg.gif)" class="title" align="right">
                        <asp:LinkButton ID="lnkImport" runat="server" CausesValidation="false" OnClientClick="window.showModalDialog('reportWorkAttendOpenFile.aspx?Mode=New','','dialogWidth:380px;dialogHeight:150px;status: No;help: No; scroll:NO');"
                            OnClick="lnkImport_Click">导入考勤</asp:LinkButton>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:GridView ID="gv" runat="server" Width="100%" AutoGenerateColumns="False" DataSourceID="ods"
                            AllowPaging="True" OnDataBound="gv_DataBound" OnRowDataBound="gv_RowDataBound"
                            PageSize="15">
                            <Columns>
                                <asp:BoundField DataField="record_time" HeaderText="导入时间">
                                    <ItemStyle Width="25%"></ItemStyle>
                                    <HeaderStyle BackColor="#539D93" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="record_sum" HeaderText="导入记录">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle BackColor="#539D93" Width="25%" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="flag" HeaderText="状态">
                                    <HeaderStyle BackColor="#539D93" Width="25%" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td style="background-color: #7bb9b1" colspan="2">
                        <uc1:UCPager ID="ucPager" runat="server"></uc1:UCPager>
                    </td>
                </tr>
            </tbody>
        </table>
        </contenttemplate>
        </asp:UpdatePanel>
    </div>
    <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="CheckRecordsSelect" TypeName="Business.Attendances">
    </asp:ObjectDataSource>
</asp:Content>
