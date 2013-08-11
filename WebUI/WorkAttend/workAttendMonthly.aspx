<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="workAttendMonthly.aspx.cs" Inherits="WorkAttend_workAttendMonthly"
    Title="出勤月报表" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <div style="text-align: center">
        <asp:UpdatePanel ID="udp" runat="server">
            <contenttemplate>
        <table class="border" cellspacing="0" width="804">
            <tbody>
                <tr>
                    <td style="height: 22px; text-align: left" class="topbg">
                        出勤月报检索</td>
                </tr>
                <tr>
                    <td align="left">
                        编号
                        <asp:TextBox ID="txtEmpCd" runat="server" Width="60px" MaxLength="20"></asp:TextBox>
                        姓名
                        <asp:TextBox ID="txtEmpName" runat="server" Width="60px" MaxLength="20" Columns="20"></asp:TextBox>
                        部门
                        <asp:DropDownList ID="selDept" runat="server" DataSourceID="odsDepts" DataTextField="dept_name"
                            DataValueField="dept_cd" OnDataBound="selDept_DataBound">
                        </asp:DropDownList>
                        工程
                        <asp:DropDownList ID="selPj" runat="server" DataSourceID="odsPjs" DataTextField="dept_name"
                            DataValueField="dept_cd" OnDataBound="selPj_DataBound">
                        </asp:DropDownList>
                        查询年月
                        <asp:TextBox ID="txtAttendanceDate" runat="server" Width="70px" MaxLength="20"></asp:TextBox>
                        &nbsp; &nbsp; &nbsp;
                        <asp:Button ID="btnQuery" OnClick="btnQuery_Click" runat="server" Text="查 询" CssClass="button">
                        </asp:Button>
                    </td>
                </tr>
            </tbody>
        </table>
        <br />
        <table class="border" cellspacing="0" cellpadding="0" width="804">
            <tbody>
                <tr>
                    <td style="background-image: url(../images/topBar_bg.gif); text-align: left" class="title">
                        <asp:Label ID="lblYear" runat="server" Text="&nbsp;"></asp:Label>年<asp:Label ID="lblMonth"
                            runat="server" Text="&nbsp;"></asp:Label>月出勤表</td>
                    <td style="background-image: url(../images/topBar_bg.gif); text-align: right" class="title">
                        <asp:LinkButton ID="lnkPrint" OnClick="lnkPrint_Click" runat="server" CausesValidation="False">打印报表</asp:LinkButton>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:GridView ID="gv" runat="server" Width="430px" BorderWidth="1px" OnDataBound="gv_DataBound"
                            AllowPaging="True" AutoGenerateColumns="False" PageSize="15">
                            <PagerSettings Visible="False" />
                            <Columns>
                                <asp:BoundField DataField="EMP_CD" HeaderText="编号">
                                    <HeaderStyle Width="20%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="emp_name" HeaderText="姓名">
                                    <HeaderStyle Width="20%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="dept_name" HeaderText="部门">
                                    <HeaderStyle Width="20%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="pj_name" HeaderText="工程">
                                    <HeaderStyle Width="20%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="join_date" HeaderText="入社日期">
                                    <HeaderStyle Width="20%" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                            </Columns>
                            <RowStyle Height="20px" HorizontalAlign="Left" />
                            <HeaderStyle BackColor="#539D93" ForeColor="White" Height="20px" />
                        </asp:GridView>
                    </td>
                    <td valign="top">
                        <asp:Panel ID="p" runat="server" Width="372px" ScrollBars="Horizontal" Visible="False">
                            <asp:GridView ID="gvDays" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                BorderWidth="1px" PageSize="15" Width="1704px">
                                <PagerSettings Visible="False" />
                                <Columns>
                                    <asp:BoundField DataField="one" HeaderText="1">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="two" HeaderText="2">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="three" HeaderText="3">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="four" HeaderText="4">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="five" HeaderText="5">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="six" HeaderText="6">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="seven" HeaderText="7">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="eight" HeaderText="8">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="nine" HeaderText="9">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ten" HeaderText="10">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="eleven" HeaderText="11">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twelve" HeaderText="12">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="thirteen" HeaderText="13">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="fourteen" HeaderText="14">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="fifteen" HeaderText="15">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="sixteen" HeaderText="16">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="seventeen" HeaderText="17">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="eighteen" HeaderText="18">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ninteen" HeaderText="19">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twenty" HeaderText="20">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twentyone" HeaderText="21">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twentytwo" HeaderText="22">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twentythree" HeaderText="23">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twentyfour" HeaderText="24">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twentyfive" HeaderText="25">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twentysix" HeaderText="26">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twentyseven" HeaderText="27">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twentyeight" HeaderText="28">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twentynine" HeaderText="29">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="thirty" HeaderText="30">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="thirtyone" HeaderText="31">
                                        <HeaderStyle Width="30px" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="旷工" DataField="kg">
                                        <HeaderStyle Width="50px" />
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="无故旷工" DataField="wgkg">
                                        <HeaderStyle Width="50px" />
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="病假" DataField="bj">
                                        <HeaderStyle Width="50px" />
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="婚假" DataField="hj">
                                        <HeaderStyle Width="50px" />
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="产假" DataField="cj">
                                        <HeaderStyle Width="50px" />
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="丧假" DataField="sj">
                                        <HeaderStyle Width="50px" />
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="工伤" DataField="gs">
                                        <HeaderStyle Width="50px" />
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="事假" DataField="shj">
                                        <HeaderStyle Width="60px" />
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="迟到早退" DataField="cd">
                                        <HeaderStyle Width="60px" />
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="有薪假已用天数" DataField="use_day">
                                        <HeaderStyle Width="100px" />
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="有薪假剩余天数" DataField="left_day">
                                        <HeaderStyle Width="100px" />
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                </Columns>
                                <HeaderStyle BackColor="#539D93" Height="20px" ForeColor="White" />
                                <RowStyle Height="20px" />
                            </asp:GridView>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td style="height: 24px; background-color: #7bb9b1" colspan="2">
                        <asp:LinkButton ID="lnkFirstPage" OnClick="lnkFirstPage_Click" runat="server" CausesValidation="False">首页</asp:LinkButton>
                        <asp:LinkButton ID="lnkPriviousPage" OnClick="lnkPriviousPage_Click" runat="server" CausesValidation="False">上一页</asp:LinkButton>
                        <asp:LinkButton ID="lnkNextPage" OnClick="lnkNextPage_Click" runat="server" CausesValidation="False">下一页</asp:LinkButton>
                        <asp:LinkButton ID="lnkLastPage" OnClick="lnkLastPage_Click" runat="server" CausesValidation="False">尾页</asp:LinkButton>
                        <asp:DropDownList ID="selPage" runat="server" AutoPostBack="True" OnSelectedIndexChanged="selPage_SelectedIndexChanged">
                        </asp:DropDownList>
                        &nbsp; &nbsp; &nbsp; &nbsp;
                        第<asp:Label ID="lblCurrentPage" runat="server" FileResume>&nbsp</asp:Label>页/共<asp:Label
                            ID="lblTotolPageCount" runat="server" FileResume>&nbsp</asp:Label>页 共<asp:Label ID="lblRecordCount"
                                runat="server" FileResume>&nbsp</asp:Label>条记录</td>
                </tr>
            </tbody>
        </table>
        </contenttemplate>
        </asp:UpdatePanel>
    </div>
    <asp:RequiredFieldValidator ID="rfvAttendanceDate" runat="server" ControlToValidate="txtAttendanceDate"
        ErrorMessage="必须输入年月" Text="&nbsp"></asp:RequiredFieldValidator>
    <asp:RegularExpressionValidator ID="revMonthQuer" runat="server" ControlToValidate="txtAttendanceDate"
        ErrorMessage="年月输入不正确" Text="&nbsp" ValidationExpression="^(\d{4}|\d{2})(/|-)?(?:0[1-9]|1[0-2]|[1-9])$"></asp:RegularExpressionValidator>
    <asp:ValidationSummary ID="vs" runat="server" ShowMessageBox="True" ShowSummary="False" />
    <asp:ObjectDataSource ID="odsDepts" runat="server" SelectMethod="GetDeptNameOrPjName"
        TypeName="Business.Depts" OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:Parameter DefaultValue="0" Name="deptClass" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsPjs" runat="server" SelectMethod="GetDeptNameOrPjName"
        TypeName="Business.Depts" OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:Parameter DefaultValue="3" Name="deptClass" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="AttendancesSelectMonthly"
        TypeName="Business.Attendances">
        <SelectParameters>
            <asp:Parameter DefaultValue="" Name="empCd" Type="String" />
            <asp:Parameter Name="empName" Type="String" />
            <asp:Parameter DefaultValue="" Name="deptCd" Type="String" />
            <asp:Parameter DefaultValue="" Name="pjCd" Type="String" />
            <asp:Parameter DefaultValue="0001-1-1 0:00:00" Name="attendanceDate" Type="DateTime" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
