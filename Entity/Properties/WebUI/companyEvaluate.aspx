<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="companyEvaluate.aspx.cs" Inherits="companyEvaluate" Title="Untitled Page" %>

<%@ Register Src="UserControls/UCPager.ascx" TagName="UCPager" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<script type="text/javascript" src="Script/CommonFunction.js"></script>
    <table style="width: 767px; border-top-width: 1px; border-left-width: 1px; border-left-color: #339999;
        border-bottom-width: 1px; border-bottom-color: #339999; border-top-color: #339999;
        border-right-width: 1px; border-right-color: #339999;">
        <tr>
            <td colspan="3" valign="top">
                <table style="border-right: #339999 1px solid; border-top: #339999 1px solid; border-left: #339999 1px solid;
                    border-bottom: #339999 1px solid;" width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr style="background-image: url(images/topbg.gif)">
                        <td colspan="6">
                            <span style="font-size: 10pt">员工信息检索</span></td>
                    </tr>
                    <tr>
                        <td style="height: 23px">
                            编号<asp:TextBox ID="txtEmpCd" runat="server" Width="88px"></asp:TextBox></td>
                        <td style="height: 23px">
                            姓名<asp:TextBox ID="txtEmpName" runat="server" Width="88px"></asp:TextBox></td>
                        <td style="height: 23px">
                            部门<asp:DropDownList ID="selDeptCd" runat="server" DataSourceID="SqlDataSource1" DataTextField="dept_name"
                                DataValueField="dept_cd" Width="88px" OnDataBound="selDeptCd_DataBound">
                            </asp:DropDownList>
                        </td>
                        <td style="height: 23px">
                            工程<asp:DropDownList ID="selPjCd" runat="server" DataSourceID="SqlDataSource2" DataTextField="dept_name"
                                DataValueField="dept_cd" Width="88px" OnDataBound="selPjCd_DataBound">
                            </asp:DropDownList>
                        </td>
                        <td style="height: 23px">
                            区分<asp:DropDownList ID="selContract" runat="server" Width="88px" DataSourceID="ObjectDataSource1" DataTextField="fun_name" DataValueField="combine_cd" OnDataBound="selContract_DataBound">
                            </asp:DropDownList>&nbsp;
                        </td>
                        <td style="height: 23px">
                            <asp:Button ID="btnQuery" runat="server" CssClass="button" Text="查询" Width="55px" OnClick="btnQuery_Click" /></td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            开始日期
                            <asp:TextBox ID="txtBegin" runat="server" Width="88px"></asp:TextBox>
                            <asp:ImageButton ID="imageBegin" runat="server" ImageUrl="~/images/datetime.gif" OnClientClick="fPopUpCalendarDlg(document.all.ctl00_ContentPlaceHolder1_txtBegin);return false;" />
                            ～结束日期
                            <asp:TextBox ID="txtTermination" runat="server" Width="88px"></asp:TextBox>
                            <asp:ImageButton ID="imageEnd" runat="server" ImageUrl="~/images/datetime.gif" OnClientClick="fPopUpCalendarDlg(document.all.ctl00_ContentPlaceHolder1_txtTermination);return false;" /></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td colspan="3" >
                <table style="border-right: #339999 1px solid; border-top: #339999 1px solid; border-left: #339999 1px solid;
                    border-bottom: #339999 1px solid;" width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr style="background-image: url(images/topBar_bg.gif)">
                        <td style="width: 633px; height: 17px;" colspan="2">
                            <span style="font-size: 10pt">员工信息管理</span></td>
                        <td style="text-align: right; height: 17px;">
                            <asp:LinkButton ID="lnkPrint" runat="server">打印报表</asp:LinkButton></td>
                    </tr>
                    <tr>
                        <td colspan="3" rowspan="2"  valign="top">
                            <asp:GridView ID="GVEmps" runat="server" AutoGenerateColumns="False" DataKeyNames="emp_cd"
                                Visible="False" Width="100%" OnRowDataBound="GVEmps_RowDataBound" AllowPaging="True" OnDataBound="GVEmps_DataBound" OnPageIndexChanged="GVEmps_PageIndexChanged"  PageSize="15" DataSourceID="ObjectDataSource3">
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
                                    <asp:BoundField DataField="fun_name" HeaderText="评价">
                                        <HeaderStyle BackColor="DarkCyan" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="evaluation_date" HeaderText="评价时间">
                                        <HeaderStyle BackColor="DarkCyan" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="evaluation_memo" HeaderText="备注">
                                        <HeaderStyle BackColor="DarkCyan" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="评价">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkAddNew" runat="server" CommandName="select" OnClick="lnkAddNew_Click">评价</asp:LinkButton>&nbsp;
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle BackColor="Teal" />
                                <PagerSettings Visible="False" />
                            </asp:GridView>
                            &nbsp;
                <center><uc1:UCPager ID="UCPager1" runat="server" /></center>
                        </td>
                    </tr>
                    <tr>
                    </tr>
                </table>
                <br />
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
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetCEC"
        TypeName="Bussiness.Emps"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="p_GetCompanyEvaluation"
        TypeName="Bussiness.t_comy_evaluations">
        <SelectParameters>
            <asp:SessionParameter Name="comy_evalu" SessionField="query_comy_evalu" Type="Object" />
            <asp:SessionParameter Name="emp" SessionField="query_emp" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" SelectMethod="GetCompanyEvaluation"
        TypeName="Bussiness.Comyevaluations">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtEmpCd" Name="emp_cd" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtEmpName" Name="emp_name" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="selDeptCd" Name="dept_cd" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="selPjCd" Name="pj_cd" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="selContract" Name="evaluation_class" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="txtBegin" Name="dateBegin" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtTermination" Name="dateEnd" PropertyName="Text"
                Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    &nbsp;
    &nbsp;&nbsp;
    <br />
</asp:Content>
