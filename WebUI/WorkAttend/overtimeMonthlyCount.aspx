<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="overtimeMonthlyCount.aspx.cs" Inherits="WorkAttend_overtimeMonthlyCount"
    Title="月加班统计" %>

<%@ Register Src="../UserControls/UCPager.ascx" TagName="UCPager" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <div style="text-align: center">
        <asp:UpdatePanel id="udp" runat="server">
            <contenttemplate>
        <table class="border" cellspacing="0" width="770">
            <tbody>
                <tr>
                    <td style="height: 22px; text-align: left" class="topbg" colspan="2">
                        加班检索</td>
                </tr>
                <tr>
                    <td align="left">
                        编号<asp:TextBox ID="txtEmpCd" runat="server" Width="60px"></asp:TextBox>
                        姓名<asp:TextBox ID="txtEmpName" runat="server" Width="60px"></asp:TextBox>
                        部门<asp:DropDownList ID="selDept" runat="server" DataSourceID="odsDepts" DataTextField="dept_name"
                            DataValueField="dept_cd" OnDataBound="selDept_DataBound">
                        </asp:DropDownList>
                        工程<asp:DropDownList ID="selPj" runat="server" DataSourceID="odsPjs" DataTextField="dept_name"
                            DataValueField="dept_cd" OnDataBound="selPj_DataBound">
                        </asp:DropDownList>
                        查询年月<asp:TextBox ID="txtMonthQuer" runat="server" Width="70px"></asp:TextBox>
                        区分<asp:DropDownList ID="selEmpClass" runat="server" DataSourceID="odsEmpClass" DataTextField="fun_name"
                            DataValueField="fun_cd" OnDataBound="selEmpClass_DataBound">
                        </asp:DropDownList></td>
                    <td>
                        <asp:Button ID="btnQuery" OnClick="btnQuery_Click" runat="server" Text="查 询" CssClass="button">
                        </asp:Button></td>
                </tr>
            </tbody>
        </table>
        <br />
        <table class="border" cellspacing="0" cellpadding="0" width="770">
            <tbody>
                <tr>
                    <td style="background-image: url(../images/topBar_bg.gif); text-align: left" class="title">
                        月加班统计</td>
                    <td style="background-image: url(../images/topBar_bg.gif); text-align: right" class="title">
                        <asp:LinkButton ID="lnkReport" OnClick="lnkReport_Click" runat="server" CausesValidation="False">打印报表</asp:LinkButton>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td valign="top" colspan="2">
                        <asp:GridView ID="gv" runat="server" Width="100%" BorderWidth="1px" OnDataBound="gv_DataBound"
                            AllowPaging="True" AutoGenerateColumns="False" PageSize="15">
                            <PagerSettings Visible="False"></PagerSettings>
                            <Columns>
                                <asp:BoundField DataField="EMP_CD" HeaderText="编号">
                                    <ItemStyle Height="20px" HorizontalAlign="Left"></ItemStyle>
                                    <HeaderStyle BackColor="#539D93" Width="70px" Height="20px" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="emp_name" HeaderText="姓名">
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    <HeaderStyle BackColor="#539D93" Width="70px" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="comOvertime" HeaderText="一般加班">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle BackColor="#539D93" Width="70px" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="genOvertime" HeaderText="公休加班">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle BackColor="#539D93" Width="70px" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="fdOvertime" HeaderText="法定假日加班">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle BackColor="#539D93" Width="100px" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="proComOvertime" HeaderText="试用期一般加班">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle BackColor="#539D93" Width="100px" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="proGenOvertime" HeaderText="试用期公休加班">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle BackColor="#539D93" Width="100px" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="prodfdOvertime" HeaderText="试用期法定假日加班">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle BackColor="#539D93" Width="120px" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="total" HeaderText="合计">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle BackColor="#539D93" ForeColor="White"></HeaderStyle>
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:GridView ID="gvTotal" runat="server" Width="100%" BorderWidth="1px" AutoGenerateColumns="False"
                            ShowHeader="False">
                            <Columns>
                                <asp:BoundField DataField="EMP_CD" HeaderText="编号">
                                    <ItemStyle BackColor="#539D93" Width="70px" Height="20px" ForeColor="White" HorizontalAlign="Left">
                                    </ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="emp_name" HeaderText="姓名">
                                    <ItemStyle BackColor="#539D93" Width="70px" ForeColor="White" HorizontalAlign="Left">
                                    </ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="comOvertime" HeaderText="一般加班">
                                    <ItemStyle BackColor="#539D93" Width="70px" ForeColor="White" HorizontalAlign="Right">
                                    </ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="genOvertime" HeaderText="公休加班">
                                    <ItemStyle BackColor="#539D93" Width="70px" ForeColor="White" HorizontalAlign="Right">
                                    </ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="fdOvertime" HeaderText="法定假日加班">
                                    <ItemStyle BackColor="#539D93" Width="100px" ForeColor="White" HorizontalAlign="Right">
                                    </ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="proComOvertime" HeaderText="试用期一般加班">
                                    <ItemStyle BackColor="#539D93" Width="100px" ForeColor="White" HorizontalAlign="Right">
                                    </ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="proGenOvertime" HeaderText="试用期公休加班">
                                    <ItemStyle BackColor="#539D93" Width="100px" ForeColor="White" HorizontalAlign="Right">
                                    </ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="prodfdOvertime" HeaderText="试用期法定假日加班">
                                    <ItemStyle BackColor="#539D93" Width="120px" ForeColor="White" HorizontalAlign="Right">
                                    </ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="total" HeaderText="合计">
                                    <ItemStyle BackColor="#539D93" ForeColor="White" HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
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
    <%--<asp:CompareValidator ID="cvMonthQuer" runat="server" ErrorMessage="年月输入不正确" ControlToValidate="txtMonthQuer" Operator="DataTypeCheck" Type="Date" Text="&nbsp"></asp:CompareValidator>--%>
    <asp:RequiredFieldValidator ID="rfvMonthQuer" runat="server" ControlToValidate="txtMonthQuer"
        ErrorMessage="年月必须输入" Text="&nbsp"></asp:RequiredFieldValidator>
    <asp:RegularExpressionValidator ID="revMonthQuer" runat="server" ControlToValidate="txtMonthQuer"
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
    <asp:ObjectDataSource ID="odsEmpClass" runat="server" SelectMethod="GetComFun" TypeName="Business.ComFuns"
        OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:Parameter DefaultValue="7" Name="fun_class_cd" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <%--<asp:ObjectDataSource ID="ods" runat="server" TypeName="Business.Attendances" SelectMethod="GetOvertimesMonthly">
        <SelectParameters>
            <asp:Parameter Name="empCd" Type="String" />
            <asp:Parameter Name="empName" Type="String" />
            <asp:Parameter Name="deptCd" Type="String" />
            <asp:Parameter Name="pjCd" Type="String" DefaultValue="" />
            <asp:Parameter DefaultValue="0001-1-1 0:00:00" Name="attendanceDate" Type="DateTime" />
            <asp:Parameter Name="empClass" Type="String" DefaultValue="" />
        </SelectParameters>
    </asp:ObjectDataSource>--%>
    <%--<asp:ObjectDataSource ID="odsTotal" runat="server" TypeName="Business.Attendances"
        SelectMethod="GetOvertimesMonthlyTotal">
        <SelectParameters>
            <asp:Parameter Name="empCd" Type="String" DefaultValue="" />
            <asp:Parameter Name="empName" Type="String" />
            <asp:Parameter DefaultValue="" Name="deptCd" Type="String" />
            <asp:Parameter Name="pjCd" Type="String" />
            <asp:Parameter DefaultValue="0001-1-1 0:00:00" Name="attendanceDate" Type="DateTime" />
            <asp:Parameter Name="empClass" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>--%>
</asp:Content>
