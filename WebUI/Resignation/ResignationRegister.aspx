<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ResignationRegister.aspx.cs" Inherits="Resignation_ResignationRegister"
    Title="离职登记" %>

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
	            
	        ans=verify("<%=txtEmpName.ClientID %>",1,10,2,12,7);
	        if(ans==false)
	            return false;
	            	       
	   }
    </script>

    <table style="width: 796px">
        <tr>
            <td align="left" colspan="3" style="height: 84px; width: 806px;">
                <table style="border-right: #39867b 1px solid; border-top: #39867b 1px solid; border-left: #39867b 1px solid;
                    width: 100%; border-bottom: #39867b 1px solid; height: 62px">
                    <tr>
                        <td colspan="5" style="border-bottom: #39867b 1px solid; height: 21px; color: #ffffff;
                            background-color: #539b93;">
                            员工离职登记信息检索</td>
                    </tr>
                    <tr>
                        <td style="width: 100px; height: 21px">
                            编号
                            <asp:TextBox ID="txtEmpCd" runat="server" CssClass="INPUT" Height="15px" Width="60px" MaxLength="20"></asp:TextBox></td>
                        <td style="width: 100px; height: 21px">
                            姓名
                            <asp:TextBox ID="txtEmpName" runat="server" CssClass="INPUT" Height="15px" Width="60px"></asp:TextBox></td>
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
                            <asp:Button ID="btnDetail" runat="server" CssClass="button" OnClick="btnDetail_Click"
                                Text="查 询" Width="50px" OnClientClick="return verifyData();" /></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="width: 806px; height: 26px;">
                <table style="border-right: #39867b 1px solid; border-top: #39867b 1px solid; border-left: #39867b 1px solid;
                    width: 100%; border-bottom: #39867b 1px solid; height: 100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td colspan="3" style="background-image: url(../images/topBar_bg.gif); border-bottom: #39867b 1px solid;
                            background-repeat: repeat-x; height: 21px">
                            员工信息列表</td>
                    </tr>
                    <tr>
                        <td colspan="3" style="height: 20px" align="center">
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Height="100%"
                                Width="100%" DataSourceID="ObjectDataSource3" Visible="False" OnDataBound="GridView1_DataBound"
                                OnRowDataBound="GridView1_RowDataBound" OnPageIndexChanged="GridView1_PageIndexChanged"
                                AllowPaging="True" PageSize="15">
                                <FooterStyle BackColor="#7BB9B1" />
                                <Columns>
                                    <asp:BoundField HeaderText="编　号" DataField="emp_cd" >
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="姓　名" DataField="emp_name" >
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="部　门" DataField="dept_name" >
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="职　务" DataField="duty_name" >
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="工　程" DataField="pj_name" >
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="区　分" DataField="emp_class" >
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="合同履历">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnDetail" runat="server">查看</asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="操作">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnRegistered" runat="server" OnClick="btnRegistered_Click1">离职登记</asp:LinkButton>
                                        </ItemTemplate>
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
                            <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" SelectMethod="GetEmpByCondition"
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
                        </td>
                    </tr>
                </table>
                <table style="width: 796px; height: 1px">
                    <tr>
                        <td align="right" style="height: 11px; text-align: right" valign="top" colspan="2">
                        </td>
                    </tr>
                </table>
                <br />
                &nbsp;</td>
        </tr>
    </table>
    &nbsp;
</asp:Content>
