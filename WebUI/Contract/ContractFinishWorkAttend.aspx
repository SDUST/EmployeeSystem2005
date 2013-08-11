<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ContractFinishWorkAttend.aspx.cs" Inherits="ContractMessage_ContractFinishWorkAttend"
    Title="合同中止考勤" %>

<%--<head runat="server">
</head>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server"
    ignoreParentFrozen="">

    <script language="javascript" type="text/javascript">	
		
		
	   function verifyData()
	   {
	        var ans;
            //ctl00_ContentPlaceHolder1_txtEmpCd
	        ans=verify("<%=txtEmpCd.ClientID %>",2,5,2,13,26);
	        if(ans==false)
	            return false;
	            
	        ans=verify("<%=txtEmpCd.ClientID %>",0,0,2,12,0);
	        if(ans==false)
	            return false;
	        
	        ans=verify("<%=txtEmpCd.ClientID %>",1,6,2,12,6);
	        if(ans==false)
	            return false;
	        
	        ans=verify("<%=selContract.ClientID %>",2,0,1,4,1);
            if(ans==false)
	            return false;
	            
	   }
    </script>

    <table border="0">
        <tr>
            <td colspan="3" style="height: 99px">
                <table style="border-right: #39867b 1px solid; border-top: #39867b 1px solid; border-left: #39867b 1px solid;
                    width: 100%; border-bottom: #39867b 1px solid; height: 62px">
                    <tr>
                        <td colspan="6" style="color: #ffffff; border-bottom: #39867b 1px solid; height: 21px;
                            background-color: #539b93">
                            合同终止考勤检索</td>
                    </tr>
                    <tr>
                        <td style="width: 100px; height: 21px">
                            编号
                            <asp:TextBox ID="txtEmpCd" runat="server" CssClass="INPUT" Height="15px" Width="60px"></asp:TextBox></td>
                        <td style="width: 100px; height: 21px">
                            姓名
                            <asp:TextBox ID="txtEmpName" runat="server" CssClass="INPUT" Height="15px" Width="60px"
                                ReadOnly="True" BackColor="#E0E0E0"></asp:TextBox></td>
                        <td style="width: 140px; height: 21px">
                            部门
                            <asp:DropDownList ID="selDept" runat="server" Height="15px" Width="100px" Enabled="False">
                            </asp:DropDownList></td>
                        <td style="width: 140px; height: 21px">
                            工程
                            <asp:DropDownList ID="selPj" runat="server" Height="15px" Width="100px" Enabled="False">
                            </asp:DropDownList></td>
                        <td style="width: 131px; height: 21px">
                            查询年月<asp:TextBox ID="selContract" runat="server" CssClass="INPUT" Width="70px" Height="15px"></asp:TextBox></td>
                        <td style="text-align: left;" align="right">
                            <asp:Button ID="btnQuery" runat="server" CssClass="button" Text="查 询" Width="50px"
                                OnClick="btnQuery_Click" OnClientClick="return verifyData();" /></td>
                    </tr>
                </table>
                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetSearchEmpInfoSql"
                    TypeName="Business.ContractMessage">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtEmpCd" DefaultValue=" " Name="emp_cd" PropertyName="Text"
                            Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="height: 14px">
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <table style="border-right: #39867b 1px solid; border-top: #39867b 1px solid; border-left: #39867b 1px solid;
                    width: 801px; border-bottom: #39867b 1px solid;" cellpadding="0" cellspacing="0">
                    <tr style="background-image: url(../images/topBar_bg.gif); width: 1024px; background-repeat: repeat-x;
                        height: 20px;">
                        <td colspan="2" style="border-bottom-width: 1px; border-bottom-color: #39867b;">
                            <asp:Label ID="lbContract" runat="server"></asp:Label></td>
                        <td align="right" style="border-bottom-width: 1px; border-bottom-color: #39867b;">
                            <asp:LinkButton ID="btn" runat="server" OnClick="btn_Click" Visible="False">打印报表</asp:LinkButton></td>
                    </tr>
                    <tr>
                        <td colspan="2" style="width: 300px;" valign="top">
                            <asp:GridView ID="GridView1" runat="server" Width="100%" AutoGenerateColumns="False"
                                DataSourceID="ObjectDataSource1" PageSize="15">
                                <Columns>
                                    <asp:BoundField DataField="emp_cd" HeaderText="编号">
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="emp_name" HeaderText="姓名" >
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="dept_name" HeaderText="部门" >
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="pj_name" HeaderText="工程" >
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="入社时间" DataField="join_date" >
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                </Columns>
                                <HeaderStyle BackColor="#539B93" ForeColor="White" />
                            </asp:GridView>
                        </td>
                        <td style="width: 500px;" valign="top">
                            <asp:Panel ID="Panel1" runat="server" Width="500px" ScrollBars="Horizontal" Visible="False">
                                <asp:GridView ID="GridView5" runat="server" Width="900px" AutoGenerateColumns="False"
                                    DataSourceID="ObjectDataSource5" PageSize="15">
                                    <Columns>
                                        <asp:BoundField DataField="one" HeaderText="1"></asp:BoundField>
                                        <asp:BoundField DataField="two" HeaderText="2" />
                                        <asp:BoundField DataField="three" HeaderText="3" />
                                        <asp:BoundField DataField="four" HeaderText="4" />
                                        <asp:BoundField DataField="five" HeaderText="5" />
                                        <asp:BoundField DataField="six" HeaderText="6" />
                                        <asp:BoundField DataField="seven" HeaderText="7" />
                                        <asp:BoundField DataField="eight" HeaderText="8" />
                                        <asp:BoundField DataField="nine" HeaderText="9" />
                                        <asp:BoundField DataField="ten" HeaderText="10" />
                                        <asp:BoundField DataField="eleven" HeaderText="11" />
                                        <asp:BoundField DataField="twelve" HeaderText="12" />
                                        <asp:BoundField DataField="thirteen" HeaderText="13" />
                                        <asp:BoundField DataField="fourteen" HeaderText="14" />
                                        <asp:BoundField DataField="fifteen" HeaderText="15" />
                                        <asp:BoundField DataField="sixteen" HeaderText="16" />
                                        <asp:BoundField DataField="seventeen" HeaderText="17" />
                                        <asp:BoundField DataField="eighteen" HeaderText="18" />
                                        <asp:BoundField DataField="ninteen" HeaderText="19" />
                                        <asp:BoundField DataField="twenty" HeaderText="20" />
                                        <asp:BoundField DataField="twentyone" HeaderText="21" />
                                        <asp:BoundField DataField="twentytwo" HeaderText="22" />
                                        <asp:BoundField DataField="twentythree" HeaderText="23" />
                                        <asp:BoundField DataField="twentyfour" HeaderText="24" />
                                        <asp:BoundField DataField="twentyfive" HeaderText="25" />
                                        <asp:BoundField DataField="twentysix" HeaderText="26" />
                                        <asp:BoundField DataField="twentyseven" HeaderText="27" />
                                        <asp:BoundField DataField="twentyeight" HeaderText="28" />
                                        <asp:BoundField DataField="twentynine" HeaderText="29" />
                                        <asp:BoundField DataField="thirty" HeaderText="30" />
                                        <asp:BoundField DataField="thirtyone" HeaderText="31" />
                                        <asp:BoundField DataField="kg" HeaderText="旷工" />
                                        <asp:BoundField DataField="wgkg" HeaderText="无故旷工" />
                                        <asp:BoundField DataField="bj" HeaderText="病假" />
                                        <asp:BoundField DataField="hj" HeaderText="婚假" />
                                        <asp:BoundField DataField="cj" HeaderText="产假" />
                                        <asp:BoundField DataField="sj" HeaderText="丧假" />
                                        <asp:BoundField DataField="gs" HeaderText="工伤" />
                                        <asp:BoundField DataField="shj" HeaderText="事假" />
                                        <asp:BoundField DataField="cd" HeaderText="年假" />
                                    </Columns>
                                    <HeaderStyle BackColor="#539B93" ForeColor="White" />
                                    <RowStyle HorizontalAlign="Right" />
                                </asp:GridView>
                            </asp:Panel>
                            <asp:ObjectDataSource ID="ObjectDataSource5" runat="server" SelectMethod="GetSearchChkInfoSql"
                                TypeName="Business.ContractMessage">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="txtEmpCd" DefaultValue=" " Name="emp_cd" PropertyName="Text"
                                        Type="String" />
                                    <asp:ControlParameter ControlID="selContract" DefaultValue=" " Name="date" PropertyName="Text"
                                        Type="String" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <table style="border-right: #39867b 1px solid; border-top: #39867b 1px solid; border-left: #39867b 1px solid;
                    width: 801px; border-bottom: #39867b 1px solid;" cellpadding="0" cellspacing="0">
                    <tr>
                        <td colspan="3" style="background-image: url(../images/topBar_bg.gif); width: 1024px;
                            background-repeat: repeat-x; height: 20px; border-bottom: #39867b 1px solid;">
                            <asp:Label ID="lbContractTime" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td colspan="2" style="width: 40%; vertical-align: top;" valign="top">
                            <asp:GridView ID="GridView3" runat="server" Width="100%" AutoGenerateColumns="False"
                                DataSourceID="ObjectDataSource2" PageSize="15">
                                <Columns>
                                    <asp:BoundField DataField="emp_cd" HeaderText="编号" >
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="emp_name" HeaderText="姓名" >
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="试用期合计" DataField="试用" >
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="正式合计" DataField="正式" >
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="总合计" DataField="全部" >
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                </Columns>
                                <HeaderStyle Width="70px" BackColor="#539B93" ForeColor="White" />
                            </asp:GridView>
                            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="GetSearchConInfoSql"
                                TypeName="Business.ContractMessage">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="txtEmpCd" DefaultValue=" " Name="emp_cd" PropertyName="Text"
                                        Type="String" />
                                    <asp:ControlParameter ControlID="selContract" Name="date" PropertyName="Text" Type="String"
                                        DefaultValue=" " />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                        </td>
                        <td style="width: 500px;" valign="top">
                            <asp:Panel ID="Panel2" runat="server" Width="500px" ScrollBars="Horizontal" Visible="False">
                                <asp:GridView ID="GridView2" runat="server" Width="800px" DataSourceID="ObjectDataSource3"
                                    AutoGenerateColumns="False" PageSize="15">
                                    <HeaderStyle BackColor="#539B93" ForeColor="White" />
                                    <Columns>
                                        <asp:BoundField DataField="one" HeaderText="1">
                                            <ItemStyle Height="14px" />
                                            <HeaderStyle Height="14px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="two" HeaderText="2" />
                                        <asp:BoundField DataField="three" HeaderText="3" />
                                        <asp:BoundField DataField="four" HeaderText="4" />
                                        <asp:BoundField DataField="five" HeaderText="5" />
                                        <asp:BoundField DataField="six" HeaderText="6" />
                                        <asp:BoundField DataField="seven" HeaderText="7" />
                                        <asp:BoundField DataField="eight" HeaderText="8" />
                                        <asp:BoundField DataField="nine" HeaderText="9" />
                                        <asp:BoundField DataField="ten" HeaderText="10" />
                                        <asp:BoundField DataField="eleven" HeaderText="11" />
                                        <asp:BoundField DataField="twelve" HeaderText="12" />
                                        <asp:BoundField DataField="thirteen" HeaderText="13" />
                                        <asp:BoundField DataField="fourteen" HeaderText="14" />
                                        <asp:BoundField DataField="fifteen" HeaderText="15" />
                                        <asp:BoundField DataField="sixteen" HeaderText="16" />
                                        <asp:BoundField DataField="seventeen" HeaderText="17" />
                                        <asp:BoundField DataField="eighteen" HeaderText="18" />
                                        <asp:BoundField DataField="ninteen" HeaderText="19" />
                                        <asp:BoundField DataField="twenty" HeaderText="20" />
                                        <asp:BoundField DataField="twentyone" HeaderText="21" />
                                        <asp:BoundField DataField="twentytwo" HeaderText="22" />
                                        <asp:BoundField DataField="twentythree" HeaderText="23" />
                                        <asp:BoundField DataField="twentyfour" HeaderText="24" />
                                        <asp:BoundField DataField="twentyfive" HeaderText="25" />
                                        <asp:BoundField DataField="twentysix" HeaderText="26" />
                                        <asp:BoundField DataField="twentyseven" HeaderText="27" />
                                        <asp:BoundField DataField="twentyeight" HeaderText="28" />
                                        <asp:BoundField DataField="twentynine" HeaderText="29" />
                                        <asp:BoundField DataField="thirdty" HeaderText="30" />
                                        <asp:BoundField DataField="thirdtyone" HeaderText="31" />
                                    </Columns>
                                    <RowStyle HorizontalAlign="Right" />
                                </asp:GridView>
                            </asp:Panel>
                            <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" SelectMethod="GetSearchOverTimeSql"
                                TypeName="Business.ContractMessage">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="txtEmpCd" DefaultValue=" " Name="emp_cd" PropertyName="Text"
                                        Type="String" />
                                    <asp:ControlParameter ControlID="selContract" DefaultValue="" Name="date" PropertyName="Text"
                                        Type="String" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="height: 19px">
                <table style="border-right: #39867b 1px solid; border-top: #39867b 1px solid; border-left: #39867b 1px solid;
                    width: 801px; border-bottom: #39867b 1px solid; height: 1px" cellpadding="0"
                    cellspacing="0">
                    <tr>
                        <td colspan="3" style="background-image: url(../images/topBar_bg.gif); width: 1391px;
                            background-repeat: repeat-x; height: 20px; border-bottom: #39867b 1px solid;">
                            <asp:Label ID="lb" runat="server" Text="月加班统计表(单位时)" Visible="False"></asp:Label></td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <asp:GridView ID="GridView4" runat="server" Width="100%" Height="25px" AutoGenerateColumns="False"
                                DataSourceID="ObjectDataSource4" PageSize="15">
                                <Columns>
                                    <asp:BoundField DataField="emp_cd" HeaderText="编号" >
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="emp_name" HeaderText="姓名" >
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="一般加班" DataField="一般加班" >
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="试用期一般加班" DataField="试用期一般加班" >
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="公休加班" DataField="公休加班" >
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="试用期公休加班" DataField="试用期公休加班" >
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="合计" DataField="全部" >
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                </Columns>
                                <HeaderStyle BackColor="#539B93" ForeColor="White" />
                            </asp:GridView>
                            <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" SelectMethod="GetMonthTotalInfoSql"
                                TypeName="Business.ContractMessage">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="txtEmpCd" DefaultValue=" " Name="emp_cd" PropertyName="Text"
                                        Type="String" />
                                    <asp:ControlParameter ControlID="selContract" DefaultValue=" " Name="date" PropertyName="Text"
                                        Type="String" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
