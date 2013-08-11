<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="resignEmpQuery.aspx.cs" Inherits="Resignation_resignEmpQuery" Title="离职员工查询" %>

<%@ Register Src="~/UserControls/UCPager.ascx" TagName="UCPager" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script language="javascript" type="text/javascript">	
		
		
	   function verifyData()
	   {
	        var ans;
            //ctl00_ContentPlaceHolder1_txtEmpCd
	        ans=verify("<%=txtEmpCd.ClientID %>",2,0,2,13,26);
	        if(ans==false)
	            return false;
	            
	            ans=verify("<%=txtEmpCd.ClientID %>",1,6,2,12,6);
	        if(ans==false)
	            return false;
	            
	      ans=verify("<%=txtEmpName.ClientID %>",1,10,6,12,7);
	        if(ans==false)
	            return false;
	      
	   }
    </script>

    <table cellpadding="0" cellspacing="0" style="width: 796px">
        <tr>
            <td align="left" colspan="3" style="width: 806px; height: 84px">
                <table style="border-right: #39867b 1px solid; border-top: #39867b 1px solid; border-left: #39867b 1px solid;
                    width: 100%; border-bottom: #39867b 1px solid; height: 62px">
                    <tr>
                        <td colspan="5" style="color: #ffffff; border-bottom: #39867b 1px solid; height: 21px;
                            background-color: #539b93">
                            员工信息检索</td>
                    </tr>
                    <tr>
                        <td style="width: 100px; height: 21px">
                            编号
                            <asp:TextBox ID="txtEmpCd" runat="server" CssClass="INPUT" Height="15px" Width="60px" MaxLength="20"></asp:TextBox></td>
                        <td style="width: 100px; height: 21px">
                            姓名
                            <asp:TextBox ID="txtEmpName" runat="server" CssClass="INPUT" Height="15px" Width="60px" MaxLength="20"></asp:TextBox></td>
                        <td style="width: 150px; height: 21px">
                            部门
                            <asp:DropDownList ID="selDept" runat="server" DataSourceID="ObjectDataSource1" DataTextField="dept_name"
                                DataValueField="dept_cd" Height="15px" OnDataBound="selDept_DataBound" Width="100px">
                            </asp:DropDownList><asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetDeptOrPj"
                                TypeName="Business.Depts">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="0" Name="dept_class" Type="Int32" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                        </td>
                        <td style="width: 150px; height: 21px">
                            工程
                            <asp:DropDownList ID="selPj" runat="server" DataSourceID="ObjectDataSource2" DataTextField="dept_name"
                                DataValueField="dept_cd" Height="15px" OnDataBound="selPj_DataBound" Width="100px">
                            </asp:DropDownList><asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="GetDeptOrPj"
                                TypeName="Business.Depts">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="3" Name="dept_class" Type="Int32" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                        </td>
                        <td style="height: 21px">
                            &nbsp;
                            <asp:Button ID="btnQuery" runat="server" CssClass="button" OnClick="btnQuery_Click"
                                Text="查 询" Width="50px" OnClientClick="return verifyData();" /></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="width: 806px; height: 25px">
                <table cellpadding="0" cellspacing="0" style="border-right: #39867b 1px solid; border-top: #39867b 1px solid;
                    border-left: #39867b 1px solid; width: 100%; border-bottom: #39867b 1px solid;
                    height: 100%">
                    <tr>
                        <td colspan="3" style="background-image: url(../images/topBar_bg.gif); border-bottom: #39867b 1px solid;
                            background-repeat: repeat-x; height: 21px">
                            离职员工信息</td>
                    </tr>
                    <tr>
                        <td colspan="3" style="height: 20px" align="center">
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="ObjectDataSource3"
                                Height="100%" PageSize="15" Visible="False" Width="100%" OnRowDataBound="GridView1_RowDataBound"
                                OnDataBound="GridView1_DataBound" OnPageIndexChanged="GridView1_PageIndexChanged"
                                AllowPaging="True">
                                <PagerSettings FirstPageText="首页" LastPageText="尾页" Mode="NextPreviousFirstLast"
                                    NextPageText="下一页" PreviousPageText="上一页" />
                                <FooterStyle BackColor="#7BB9B1" />
                                <Columns>
                                    <asp:BoundField DataField="emp_cd" HeaderText="编　号">
                                        <FooterStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="emp_name" HeaderText="姓　名">
                                        <FooterStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="dept_name" HeaderText="部　门">
                                        <FooterStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="duty_name" HeaderText="职　务">
                                        <FooterStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="pj_name" HeaderText="工　程">
                                        <FooterStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="join_date" HeaderText="入社日期">
                                        <FooterStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="dimission_date" HeaderText="离职日期" >
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="离职详细">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkResignDetail" runat="server">详细</asp:LinkButton>
                                        </ItemTemplate>
                                        <FooterStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="员工详细">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkEmpDetail" runat="server">详细</asp:LinkButton>
                                        </ItemTemplate>
                                        <FooterStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    <table style="width: 748px">
                                        <tr>
                                            <td align="center" style="width: 62px">
                                                工号</td>
                                            <td align="center" style="width: 65px">
                                                姓名</td>
                                            <td align="center" style="width: 78px">
                                                部门</td>
                                            <td align="center" style="width: 85px">
                                                职务</td>
                                            <td align="center" style="width: 83px">
                                                工程</td>
                                            <td align="center" style="width: 81px">
                                                区分</td>
                                            <td align="center" style="width: 123px">
                                                合同履历</td>
                                            <td align="center">
                                                操作</td>
                                        </tr>
                                        <tr>
                                            <td style="width: 62px; height: 21px">
                                            </td>
                                            <td style="width: 65px; height: 21px">
                                            </td>
                                            <td style="width: 78px; height: 21px">
                                            </td>
                                            <td style="width: 85px; height: 21px">
                                            </td>
                                            <td style="width: 83px; height: 21px">
                                            </td>
                                            <td style="width: 81px; height: 21px">
                                            </td>
                                            <td align="center" style="width: 123px; height: 21px">
                                                <asp:LinkButton ID="btnDetail" runat="server" PostBackUrl="~/ContractMessage/ContractLog.aspx">查　看</asp:LinkButton>
                                            </td>
                                            <td align="center" style="height: 21px">
                                                <asp:LinkButton ID="btnRegistered" runat="server" PostBackUrl="~/Resignation/ResignationRegisterAdd.aspx">离职登记</asp:LinkButton></td>
                                        </tr>
                                    </table>
                                </EmptyDataTemplate>
                                <HeaderStyle BackColor="#539B93" ForeColor="White" />
                            </asp:GridView>
                <uc1:UCPager ID="UCPager1" runat="server" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" SelectMethod="GetEmpsAndDate"
        TypeName="Business.Dimissions">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtEmpCd" DefaultValue=" " Name="emp_cd" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="txtEmpName" DefaultValue=" " Name="emp_name" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="selDept" DefaultValue=" " Name="dept_cd" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="selPj" DefaultValue=" " Name="pj_cd" PropertyName="SelectedValue"
                Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
