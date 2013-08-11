<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="overtimeDaily.aspx.cs" Inherits="WorkAttend_overtimeDaily" Title="加班日报表" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <br />
    <div style="text-align: center">
        <asp:UpdatePanel ID="udp" runat="server">
            <contenttemplate>
        <table class="border" cellspacing="0" width="804">
            <tbody>
                <tr>
                    <td style="height: 22px; text-align: left" class="topbg" colspan="2">
                        加班日报检索</td>
                </tr>
                <tr>
                    <td align="left">
                        编号
                        <asp:TextBox ID="txtEmpCd" runat="server" Width="60px" MaxLength="20"></asp:TextBox>
                        姓名
                        <asp:TextBox ID="txtEmpName" runat="server" Width="60px" MaxLength="20"></asp:TextBox>
                        部门
                        <asp:DropDownList ID="selDept" runat="server" DataValueField="dept_cd" DataTextField="dept_name"
                            DataSourceID="odsDepts" OnDataBound="selDept_DataBound">
                        </asp:DropDownList>
                        工程
                        <asp:DropDownList ID="selPj" runat="server" DataValueField="dept_cd" DataTextField="dept_name"
                            DataSourceID="odsPjs" OnDataBound="selPj_DataBound">
                        </asp:DropDownList>
                        查询年月
                        <asp:TextBox ID="txtAttendanceDate" runat="server" Width="70px" MaxLength="20"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="查询年月不能为空"
                            ControlToValidate="txtAttendanceDate" Display="Dynamic">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                ID="revMonthQuer" runat="server" ErrorMessage="年月输入不正确" ControlToValidate="txtAttendanceDate"
                                Display="Dynamic" ValidationExpression="^(\d{4}|\d{2})(/|-)?(?:0[1-9]|1[0-2]|[1-9])$"
                                Text="*"></asp:RegularExpressionValidator>
                    </td>
                    <td>
                        <asp:Button ID="btnQuery" OnClick="btnQuery_Click" runat="server" Text="查 询" CssClass="button">
                        </asp:Button></td>
                </tr>
            </tbody>
        </table>
        <br />
        <table class="border" cellspacing="0" cellpadding="0" width="804">
            <tbody>
                <tr>
                    <td style="background-image: url(../images/topBar_bg.gif); text-align: left" class="title">
                        加班日报表</td>
                    <td style="background-image: url(../images/topBar_bg.gif); text-align: right" class="title">
                        <asp:LinkButton ID="lnkPrint" OnClick="lnkPrint_Click" runat="server" CausesValidation="False">打印报表</asp:LinkButton>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:GridView ID="gv" runat="server" Width="430px" BorderWidth="1px" OnDataBound="gv_DataBound"
                            PageSize="15" AutoGenerateColumns="False" AllowPaging="True">
                            <PagerSettings Visible="False"></PagerSettings>
                            <Columns>
                                <asp:BoundField DataField="EMP_CD" HeaderText="编号">
                                    <ItemStyle Height="20px" HorizontalAlign="Left"></ItemStyle>
                                    <HeaderStyle Width="20%" Height="20px" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="emp_name" HeaderText="姓名">
                                    <ItemStyle Height="20px" HorizontalAlign="Left"></ItemStyle>
                                    <HeaderStyle Width="20%" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="sy" HeaderText="试用期合计">
                                    <ItemStyle Height="20px" HorizontalAlign="Left"></ItemStyle>
                                    <HeaderStyle Width="20%" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="zs" HeaderText="正式合计">
                                    <ItemStyle Height="20px" HorizontalAlign="Left"></ItemStyle>
                                    <HeaderStyle Width="20%" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="qb" HeaderText="总合计">
                                    <ItemStyle Height="20px" HorizontalAlign="Left"></ItemStyle>
                                    <HeaderStyle Width="20%" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                            </Columns>
                            <HeaderStyle BackColor="#539D93"></HeaderStyle>
                        </asp:GridView>
                        <asp:GridView ID="gvTotal" runat="server" Width="430px" BorderWidth="1px" OnDataBound="gvTotal_DataBound"
                            PageSize="15" AutoGenerateColumns="False" ShowHeader="False">
                            <Columns>
                                <asp:BoundField DataField="EMP_CD">
                                    <ItemStyle Width="20%" Height="20px" ForeColor="White"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="emp_name">
                                    <ItemStyle Width="20%" Height="20px" ForeColor="White" HorizontalAlign="Left"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="sy">
                                    <ItemStyle Width="20%" Height="20px" ForeColor="White" HorizontalAlign="Left"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="zs">
                                    <ItemStyle Width="20%" Height="20px" ForeColor="White" HorizontalAlign="Left"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="qb">
                                    <ItemStyle Width="20%" Height="20px" ForeColor="White" HorizontalAlign="Left"></ItemStyle>
                                </asp:BoundField>
                            </Columns>
                            <RowStyle BackColor="#539D93"></RowStyle>
                        </asp:GridView>
                    </td>
                    <td valign="top">
                        <asp:Panel ID="p" runat="server" Width="372px" ScrollBars="Horizontal" Visible="False">
                            <asp:GridView ID="gvDays" runat="server" Width="1023px" AllowPaging="True" AutoGenerateColumns="False"
                                OnDataBound="gvDays_DataBound" PageSize="15" BorderWidth="1px">
                                <PagerSettings Visible="False"></PagerSettings>
                                <Columns>
                                    <asp:BoundField DataField="one" HeaderText="1">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" Height="20px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="two" HeaderText="2">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="three" HeaderText="3">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="four" HeaderText="4">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="five" HeaderText="5">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="six" HeaderText="6">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="seven" HeaderText="7">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="eight" HeaderText="8">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="nine" HeaderText="9">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ten" HeaderText="10">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="eleven" HeaderText="11">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twelve" HeaderText="12">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="thirteen" HeaderText="13">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="fourteen" HeaderText="14">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="fifteen" HeaderText="15">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="sixteen" HeaderText="16">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="seventeen" HeaderText="17">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="eighteen" HeaderText="18">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ninteen" HeaderText="19">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twenty" HeaderText="20">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twentyone" HeaderText="21">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twentytwo" HeaderText="22">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twentythree" HeaderText="23">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twentyfour" HeaderText="24">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twentyfive" HeaderText="25">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twentysix" HeaderText="26">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twentyseven" HeaderText="27">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twentyeight" HeaderText="28">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twentynine" HeaderText="29">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="thirty" HeaderText="30">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="thirtyone" HeaderText="31">
                                        <ItemStyle Height="20px" HorizontalAlign="Right"></ItemStyle>
                                        <HeaderStyle Width="30px" ForeColor="White"></HeaderStyle>
                                    </asp:BoundField>
                                </Columns>
                                <HeaderStyle BackColor="#539D93"></HeaderStyle>
                            </asp:GridView>
                            <asp:GridView ID="gvDaysTotal" runat="server" Width="1023px" AutoGenerateColumns="False"
                                OnDataBound="gvDaysTotal_DataBound" PageSize="15" BorderWidth="1px" ShowHeader="False">
                                <Columns>
                                    <asp:BoundField DataField="one">
                                        <ItemStyle Width="30px" Height="20px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="two">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="three">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="four">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="five">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="six">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="seven">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="eight">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="nine">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ten">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="eleven">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twelve">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="thirteen">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="fourteen">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="fifteen">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="sixteen">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="seventeen">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="eighteen">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ninteen">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twenty">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twentyone">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twentytwo">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twentythree">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twentyfour">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twentyfive">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twentysix">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twentyseven">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twentyeight">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="twentynine">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="thirty">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="thirtyone">
                                        <ItemStyle Width="30px" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                </Columns>
                                <RowStyle BackColor="#539D93"></RowStyle>
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
                        第<asp:Label ID="lblCurrentPage" runat="server" Text=" "></asp:Label>页/共<asp:Label
                            ID="lblTotolPageCount" runat="server" Text=" "></asp:Label>页 共<asp:Label ID="lblRecordCount"
                                runat="server" Text=" "></asp:Label>条记录</td>
                </tr>
            </tbody>
        </table>
        </contenttemplate>
        </asp:UpdatePanel>
    </div>
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
    <asp:ObjectDataSource ID="ods" runat="server" TypeName="Business.Attendances" SelectMethod="GetOvertimesDaily">
        <SelectParameters>
            <asp:Parameter Name="empCd" Type="String" DefaultValue="" />
            <asp:Parameter Name="empName" Type="String" />
            <asp:Parameter DefaultValue="" Name="deptCd" Type="String" />
            <asp:Parameter Name="pjCd" Type="String" />
            <asp:Parameter DefaultValue="0001-1-1 0:00:00" Name="attendanceDate" Type="DateTime" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
