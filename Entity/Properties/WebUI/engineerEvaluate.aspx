<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="engineerEvaluate.aspx.cs" Inherits="engineerEvaluate" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<script type="text/javascript" src="Script/CommonFunction.js"></script>

    <table cellpadding="0" cellspacing="0" style="width: 789px; height: 202px;">
        <tr>
            <td colspan="3" style="width: 100%;
                height: 39px; border-top-width: 1px; border-left-width: 1px; border-left-color: #0099cc; border-bottom-width: 1px; border-bottom-color: #0099cc; border-top-color: #0099cc; border-right-width: 1px; border-right-color: #0099cc;" valign="top">
                <table cellpadding="0" cellspacing="0" style="vertical-align: top; width: 100%; height: 39px; border-right: #339999 1px solid; border-top: #339999 1px solid; border-left: #339999 1px solid; border-bottom: #339999 1px solid;">
                    <tr style="background-image: url(images/topbg.gif)">
                        <td colspan="7" style="text-align: left;">
                            <span style="font-size: 10pt">员工信息查询</span></td>
                    </tr>
                    <tr>
                        <td valign="top">
                            编号<asp:TextBox ID="txtEmpCd" runat="server" Width="80px"></asp:TextBox></td>
                        <td valign="top">
                            姓名<asp:TextBox ID="txtEmpName" runat="server" Width="80px"></asp:TextBox></td>
                        <td valign="top" style="text-align: center">
                            部门<asp:DropDownList ID="selDeptCd" runat="server" DataSourceID="SqlDataSource1" DataTextField="dept_name"
                                DataValueField="dept_cd" OnDataBound="selDeptCd_DataBound" Width="80px">
                            </asp:DropDownList>
                        </td>
                        <td valign="top">
                            工程<asp:DropDownList ID="selPjCd" runat="server" DataSourceID="SqlDataSource2" DataTextField="dept_name"
                                DataValueField="dept_cd" OnDataBound="selPjCd_DataBound" Width="80px">
                            </asp:DropDownList>
                        </td>
                        <td valign="top">
                            评价月<asp:DropDownList ID="selContract" runat="server" DataSourceID="SqlDataSource3"
                                DataTextField="fun_name" DataValueField="combine_cd" OnDataBound="selContract_DataBound"
                                Width="80px">
                            </asp:DropDownList>
                        </td>
                        <td valign="top">
                            评价区分<asp:DropDownList ID="selTime" runat="server" DataSourceID="SqlDataSource4" DataTextField="fun_name"
                                DataValueField="combine_cd" OnDataBound="selTime_DataBound" Width="80px">
                            </asp:DropDownList>
                        </td>
                        <td valign="top">
                            <asp:Button ID="btnQuery" runat="server" CssClass="button" OnClick="btnQuery_Click"
                                Text="查询" Width="55px" /></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="height: 146px" valign="top">
                <table cellpadding="0" cellspacing="0" width="100%" style="border-right: #339999 1px solid; border-top: #339999 1px solid; border-left: #339999 1px solid; border-bottom: #339999 1px solid">
                    <tr>
                        <td colspan="4" style="height: 5px; text-align: justify">
                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tr style="background-image: url(images/topBar_bg.gif)">
                                    <td align="left" style="height: 15px">
                                        <span style="font-size: 10pt; font-family: 宋体">员工信息管理</span></td>
                                    <td align="right" style="height: 15px">
                                        <asp:LinkButton ID="lnkPrint" runat="server">打印报表</asp:LinkButton>&nbsp;
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" rowspan="2" style="height: 111px">
                            <asp:GridView ID="GVEmps" runat="server" AutoGenerateColumns="False" DataKeyNames="emp_cd"
                                OnRowDataBound="GVEmps_RowDataBound" Width="100%" AllowPaging="True" OnPageIndexChanged="GVEmps_PageIndexChanged" OnPageIndexChanging="GVEmps_PageIndexChanging" PageSize="15">
                                <Columns>
                                    <asp:BoundField DataField="emp_cd" HeaderText="编号">
                                        <HeaderStyle BackColor="DarkCyan" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="emp_name" HeaderText="姓名">
                                        <HeaderStyle BackColor="DarkCyan" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="dept_name" HeaderText="部门">
                                        <HeaderStyle BackColor="DarkCyan" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="duty_name" HeaderText="职务">
                                        <HeaderStyle BackColor="DarkCyan" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="pj_name" HeaderText="工程">
                                        <HeaderStyle BackColor="DarkCyan" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="evaluation_date" HeaderText="评价时间">
                                        <HeaderStyle BackColor="DarkCyan" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="fun_name" HeaderText="评价区分">
                                        <HeaderStyle BackColor="DarkCyan" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="评价">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkAddNew" runat="server" CommandName="select" OnClick="lnkAddNew_Click">评价</asp:LinkButton>&nbsp;
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle BackColor="Teal" />
                                <PagerSettings FirstPageText="首页" LastPageText="最后一页" Mode="NextPreviousFirstLast"
                                    NextPageText="下一页" PreviousPageText="上一页" />
                                <PagerStyle HorizontalAlign="Center" VerticalAlign="Bottom" />
                            </asp:GridView>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SanXI_EmpConnectionString %>"
                                SelectCommand="SELECT [dept_cd], [dept_name], [dept_class] FROM [tb_dept] WHERE ([dept_class] = @dept_class)">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="0" Name="dept_class" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SanXI_EmpConnectionString %>"
                                SelectCommand="SELECT * FROM [tb_dept] WHERE ([dept_class] = @dept_class)">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="1" Name="dept_class" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:SanXI_EmpConnectionString %>"
                                SelectCommand="SELECT * FROM [tb_com_fun] WHERE ([fun_class_cd] = @fun_class_cd)">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="9" Name="fun_class_cd" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:SanXI_EmpConnectionString %>"
                                SelectCommand="SELECT * FROM [tb_com_fun] WHERE ([fun_class_cd] = @fun_class_cd)">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="8" Name="fun_class_cd" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
    <br />
</asp:Content>

