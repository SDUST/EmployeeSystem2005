<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="empBaseInfo.aspx.cs" Inherits="empBaseInfo" Title="Untitled Page" %>

<%@ Register Src="UserControls-object/UCPager1.ascx" TagName="UCPager1" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript" src="Script/CommonFunction.js"></script>

    <table style="width: 768px; border-top-width: 1px; border-left-width: 1px; border-left-color: #339999;
        border-bottom-width: 1px; border-bottom-color: #339999; border-top-color: #339999;
        border-right-width: 1px; border-right-color: #339999;" cellpadding="0" cellspacing="0">
        <tr>
            <td colspan="3" style="border-right: #0099cc 1px solid; border-top: #0099cc 1px solid;
                border-left: #0099cc 1px solid; border-bottom: #0099cc 1px solid; width: 800px;
                height: 0px;" valign="top">
                <table width="100%" cellpadding="0" cellspacing="0" style="vertical-align: top">
                    <tr class="topbg">
                        <td colspan="7" style="text-align: left; vertical-align: middle;" valign="middle">
                            员工信息检索</td>
                    </tr>
                    <tr>
                        <td>
                            编号<asp:TextBox ID="txtEmpCd" runat="server" Width="70px" MaxLength="20"></asp:TextBox></td>
                        <td>
                            姓名<asp:TextBox ID="txtEmpName" runat="server" Width="70px" MaxLength="20"></asp:TextBox></td>
                        <td>
                            部门<asp:DropDownList ID="selDept" runat="server" Width="70px" DataSourceID="SqlDataSource1"
                                DataTextField="dept_name" DataValueField="dept_cd" OnDataBound="selDept_DataBound">
                            </asp:DropDownList>
                        </td>
                        <td>
                            工程<asp:DropDownList ID="selPj" runat="server" Width="70px" DataSourceID="SqlDataSource2"
                                DataTextField="dept_name" DataValueField="dept_cd" OnDataBound="selPj_DataBound">
                            </asp:DropDownList>
                        </td>
                        <td>
                            合同区分<asp:DropDownList ID="selContract" runat="server" Width="70px" DataSourceID="SqlDataSource3"
                                DataTextField="fun_name" DataValueField="combine_cd" OnDataBound="selContract_DataBound">
                            </asp:DropDownList>
                        </td>
                        <td>
                            婚姻状态<asp:DropDownList ID="selMarry" runat="server" Width="70px">
                                <asp:ListItem Selected="True"></asp:ListItem>
                                <asp:ListItem Value="1">已婚</asp:ListItem>
                                <asp:ListItem Value="0">未婚</asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:Button ID="btnQuery" runat="server" Text="查询" Width="55px" CssClass="button"
                                OnClick="btnQuery_Click" /></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="height: 12px">
            </td>
        </tr>
        <tr>
            <td valign="top">
                <table width="100%" cellpadding="0" cellspacing="0" style="border-right: #339999 1px solid;
                    border-left: #339999 1px solid; border-bottom: #339999 1px solid">
                    <tr>
                        <td colspan="4">
                            <table class="border" width="100%" border="0" cellpadding="0" cellspacing="0" style="border-top: #339999 1px solid;
                                border-right-style: solid; border-left-style: solid; border-bottom-style: solid">
                                <tr style="background-image: url(images/topBar_bg.gif)">
                                    <td align="left">
                                        <span style="font-size: 10pt; font-family: 宋体">员工信息管理</span></td>
                                    <td align="right">
                                        <asp:LinkButton ID="lnkPrint" runat="server">打印报表</asp:LinkButton>
                                        <asp:LinkButton ID="lnkAddNew" runat="server" OnClientClick="fPopUpEmpDetail('','addnew');return false;">新增记录</asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" rowspan="2" valign="top">
                            <asp:GridView ID="GVEmps" runat="server" Width="100%" Visible="False" AutoGenerateColumns="False"
                                EmptyDataText="No data available." DataKeyNames="emp_cd" OnRowDataBound="GVEmps_RowDataBound"
                                AllowPaging="True" PageSize="15" OnPageIndexChanging="GVEmps_PageIndexChanging"
                                OnPageIndexChanged="GVEmps_PageIndexChanged" OnRowDeleting="GVEmps_RowDeleting">
                                <Columns>
                                    <asp:BoundField DataField="emp_cd" HeaderText="编号">
                                        <HeaderStyle BackColor="#539D93" ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="emp_name" HeaderText="姓名">
                                        <HeaderStyle BackColor="#539D93" ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="dept_name" HeaderText="部门">
                                        <HeaderStyle BackColor="#539D93" ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="duty_name" HeaderText="职务">
                                        <HeaderStyle BackColor="#539D93" ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="pj_name" HeaderText="工程">
                                        <HeaderStyle BackColor="#539D93" ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="emp_class" HeaderText="员工区分">
                                        <HeaderStyle BackColor="#539D93" ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="contract_cd" HeaderText="合同区分">
                                        <HeaderStyle BackColor="#539D93" ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="marry" HeaderText="婚姻状况">
                                        <HeaderStyle BackColor="#539D93" ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="State" HeaderText="状态">
                                        <HeaderStyle BackColor="#539D93" ForeColor="White" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="操作">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkDetail" runat="server" CommandName="select" OnClick="lnkDetail_Click">详细</asp:LinkButton>
                                            <asp:LinkButton ID="lnkDelete" runat="server" CommandName="delete">删除</asp:LinkButton>
                                        </ItemTemplate>
                                        <HeaderStyle BackColor="#539D93" ForeColor="White" />
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle BackColor="Teal" />
                                <PagerSettings FirstPageText="" LastPageText="" NextPageText="" PreviousPageText=""
                                    Visible="False" />
                                <PagerStyle Height="20px" VerticalAlign="Bottom" HorizontalAlign="Center" />
                            </asp:GridView>
                            &nbsp;&nbsp;
                            <center>
                                <uc2:UCPager1 ID="UCPager1_1" runat="server"></uc2:UCPager1>
                                &nbsp;</center>
                        </td>
                    </tr>
                    <tr>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <br />
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
            <asp:Parameter DefaultValue="1" Name="fun_class_cd" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
