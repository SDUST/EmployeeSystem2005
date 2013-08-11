<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="resignWorkAttendQuery.aspx.cs" Inherits="Resignation_resignWorkAttendQuery"
    Title="离职考勤查询" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script language="javascript" type="text/javascript">	
		
		
	   function verifyData()
	   {
	        var ans;
            //ctl00_ContentPlaceHolder1_txtEmpCd
	        ans=verify("<%=txtEmpCd.ClientID %>",2,0,2,13,26);
	        if(ans==false)
	            return false;
	            
	        ans=verify("<%=txtEmpName.ClientID %>",1,10,6,12,7);
	        if(ans==false)
	            return false;
	        
	        
	        ans=verify("<%=txtMonth.ClientID %>",2,0,1,4,1);
            if(ans==false)
	            return false;
	   }
    </script>

    <table cellpadding="0" cellspacing="0" style="width: 796px; height: 60px;">
        <tr>
            <td align="left" colspan="3" style="width: 806px; height: 84px">
                <table style="border-right: #39867b 1px solid; border-top: #39867b 1px solid; border-left: #39867b 1px solid;
                    width: 100%; border-bottom: #39867b 1px solid; height: 50px">
                    <tr>
                        <td colspan="6" style="color: #ffffff; border-bottom: #39867b 1px solid; height: 21px;
                            background-color: #539b93">
                            出勤月报检查</td>
                    </tr>
                    <tr>
                        <td style="width: 100px; height: 21px" valign="top">
                            编号
                            <asp:TextBox ID="txtEmpCd" runat="server" CssClass="INPUT" Height="15px" Width="60px"></asp:TextBox></td>
                        <td style="width: 100px; height: 21px" valign="top">
                            姓名
                            <asp:TextBox ID="txtEmpName" runat="server" CssClass="INPUT" Height="15px" Width="60px"></asp:TextBox></td>
                        <td style="width: 150px; height: 21px" valign="top">
                            部门&nbsp;<asp:DropDownList ID="selDept" runat="server" DataSourceID="ObjectDataSource1"
                                DataTextField="dept_name" DataValueField="dept_cd" Height="15px" Width="100px"
                                OnDataBound="selDept_DataBound">
                            </asp:DropDownList><asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetDeptOrPj"
                                TypeName="Business.Depts">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="0" Name="dept_class" Type="Int32" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                        </td>
                        <td style="width: 150px; height: 21px" valign="top">
                            工程&nbsp;<asp:DropDownList ID="selPj" runat="server" DataSourceID="ObjectDataSource2"
                                DataTextField="dept_name" DataValueField="dept_cd" Height="15px" Width="100px"
                                OnDataBound="selPj_DataBound">
                            </asp:DropDownList><asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="GetDeptOrPj"
                                TypeName="Business.Depts">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="3" Name="dept_class" Type="Int32" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                        </td>
                        <td style="width: 156px; height: 21px" valign="top">
                            查询月份
                            <asp:TextBox ID="txtMonth" runat="server" CssClass="INPUT" Height="15px" Width="50px"></asp:TextBox></td>
                        <td style="height: 21px" valign="top">
                            &nbsp;
                            <asp:Button ID="btnQuery" runat="server" CssClass="button" Text="查 询" Width="50px"
                                OnClick="btnQuery_Click" OnClientClick="return verifyData();" /></td>
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
                            background-repeat: repeat-x; height: 21px;">
                            离职员工列表</td>
                        <td align="right" colspan="1" style="background-image: url(../images/topBar_bg.gif);
                            border-bottom: #39867b 1px solid; background-repeat: repeat-x; height: 21px;">
                            &nbsp;<asp:LinkButton ID="lnkReport" runat="server" OnClick="lnkReport_Click">打印报表</asp:LinkButton></td>
                    </tr>
                    <tr>
                        <td colspan="3" style="height: 20px; width: 40%;" align="left" valign="top">
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="ObjectDataSource3"
                                Visible="False" Width="100%" PageSize="15" OnRowDataBound="GridView1_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="工号" HeaderText="编号" >
                                        <ItemStyle HorizontalAlign="Left" Width="25%" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="姓名" HeaderText="姓名" >
                                        <ItemStyle HorizontalAlign="Left" Width="25%" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="工程" HeaderText="工程" >
                                        <ItemStyle HorizontalAlign="Left" Width="25%" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="区分" HeaderText="区分" >
                                        <ItemStyle HorizontalAlign="Left" Width="25%" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                </Columns>
                                <HeaderStyle BackColor="#539B93" ForeColor="White" />
                            </asp:GridView>
                            <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" SelectMethod="GetResignEmpByMonth"
                                TypeName="Business.Dimissions" OldValuesParameterFormatString="original_{0}">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="txtEmpCd" Name="emp_cd" PropertyName="Text"
                                        Type="String" />
                                    <asp:ControlParameter ControlID="txtEmpName" Name="emp_name" PropertyName="Text"
                                        Type="String" />
                                    <asp:ControlParameter ControlID="selDept" Name="dept_cd" PropertyName="SelectedValue"
                                        Type="String" />
                                    <asp:ControlParameter ControlID="selPj" Name="pj_cd" PropertyName="SelectedValue"
                                        Type="String" />
                                    <asp:ControlParameter ControlID="txtMonth" Name="month" PropertyName="Text"
                                        Type="String" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                        </td>
                        <td colspan="1" style="height: 20px; width: 60%;" valign="top">
                            <asp:Panel ID="Panel1" runat="server" Height="25px" ScrollBars="Horizontal" Width="500px">
                                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="ObjectDataSource3"
                                    Visible="False" Width="800px" PageSize="15">
                                    <Columns>
                                        <asp:BoundField DataField="一般加班" HeaderText="一般加班" >
                                            <ItemStyle Height="14px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="试用期一般加班" HeaderText="试用期一般加班" />
                                        <asp:BoundField DataField="公休加班" HeaderText="公休加班" />
                                        <asp:BoundField DataField="试用期公休加班" HeaderText="试用期公休加班" />
                                        <asp:BoundField DataField="合计" HeaderText="合计" />
                                        <asp:BoundField DataField="旷工" HeaderText="旷工" />
                                        <asp:BoundField DataField="病假" HeaderText="病假" />
                                        <asp:BoundField DataField="婚假" HeaderText="婚假" />
                                        <asp:BoundField DataField="产假" HeaderText="产假" />
                                        <asp:BoundField DataField="丧假" HeaderText="丧假" />
                                        <asp:BoundField DataField="工伤" HeaderText="工伤" />
                                        <asp:BoundField DataField="事假" HeaderText="事假" />
                                        <asp:BoundField DataField="迟到早退" HeaderText="迟到早退" />
                                    </Columns>
                                    <HeaderStyle BackColor="#539B93" ForeColor="White" />
                                    <RowStyle HorizontalAlign="Right" />
                                </asp:GridView>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
