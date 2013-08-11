<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="contractContinueManager.aspx.cs" Inherits="Contract_contractContinueManager"
    Title="合同续签管理" %>

<%@ Register Src="~/UserControls/UCPager.ascx" TagName="UCPager" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<script type="text/javascript" src="../Script/CommonFunction.js"></script>
    <script language="javascript" type="text/javascript">	
		function checkAll()
		{
			var a = document.getElementsByTagName("input");
			if(document.all("valchk").value=="1"){
			for (var i=0; i<a.length; i++)
				if (a[i].type == "checkbox" && a[i].id!="chk" ) a[i].checked = false;
				document.all("valchk").value="0";
			}
			else
			{
			for (var i=0; i<a.length; i++)
				if (a[i].type == "checkbox" && a[i].id!="chk") a[i].checked = true;
				document.all("valchk").value="1";
			}		
		}
	   function Isnull()
	   {
	        var flag=0;
	        var a = document.getElementsByTagName("input");
	        for (var i=0; i<a.length; i++)
	        {
		        if ( a[i].checked != true )
		            {} 
		        else
		            {
		            flag=1;
		            break;
		            }
		    }
		    if(flag==0)
	        {window.alert("没有选择！！");
	        return false;
	        }
	        else{
	        window.alert("成功！！");
	        flag=0;
	        return true;}
	   }
	   function verifyData()
	   {
	        var ans;
	        ans=verify("<%=txtEmpCd.ClientID %>",2,0,2,13,26);
	        if(ans==false)
	            return false;
	            
	        ans=verify("<%=txtEmpCd.ClientID %>",1,6,2,12,6);
	        if(ans==false)
	            return false;
	            
	        ans=verify("<%=txtEmpName.ClientID %>",1,10,2,12,7);
	        if(ans==false)
	            return false;
	            
	            
	        var value1=document.getElementById("<%=txtBecomeDueFrom.ClientID %>").value;
	        var value2=document.getElementById("<%=txtBecomeDueto.ClientID %>").value;
	        ans=dateCheck(value1,value2);
	        if(ans==false)
	           return false;
	   }
    </script>

    <table cellpadding="0" cellspacing="0" style="width: 796px">
        <tr>
            <td align="left" colspan="3" style="width: 803px; height: 84px">
                <table style="border-right: #39867b 1px solid; border-top: #39867b 1px solid; border-left: #39867b 1px solid;
                    width: 100%; border-bottom: #39867b 1px solid; height: 62px">
                    <tr>
                        <td colspan="5" style="color: #ffffff; border-bottom: #39867b 1px solid; height: 21px;
                            background-color: #539b93">
                            员工信息检索</td>
                    </tr>
                    <tr>
                        <td style="width: 150px; height: 21px">
                            编 &nbsp;&nbsp; 号
                            <asp:TextBox ID="txtEmpCd" runat="server" CssClass="INPUT" Height="15px" Width="60px"
                                MaxLength="20"></asp:TextBox></td>
                        <td style="width: 126px; height: 21px">
                            姓名
                            <asp:TextBox ID="txtEmpName" runat="server" CssClass="INPUT" Height="15px" Width="60px"
                                MaxLength="20"></asp:TextBox></td>
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
                            <asp:Button ID="btnQuery" runat="server" CssClass="button" OnClick="btnQuery_Click"
                                Text="查 询" Width="50px" OnClientClick="return verifyData();" /></td>
                    </tr>
                    <tr>
                        <td colspan="5" style="height: 21px">
                            合同期间
                            <asp:TextBox ID="txtBecomeDueFrom" runat="server" CssClass="INPUT" Height="15px"
                                Width="70px"></asp:TextBox>&nbsp;<asp:ImageButton ID="ImageButton1" runat="server"
                                    ImageUrl="~/images/datetime.gif" OnClientClick="fPopUpCalendarDlg(document.all.ctl00$ContentPlaceHolder1$txtBecomeDueFrom);return false;" />&nbsp;
                            <strong>~ </strong>
                            <asp:TextBox ID="txtBecomeDueto" runat="server" CssClass="INPUT" Height="15px" Width="70px"></asp:TextBox>&nbsp;<asp:ImageButton
                                ID="ImageButton2" runat="server" ImageUrl="~/images/datetime.gif" OnClientClick="fPopUpCalendarDlg(document.all.ctl00$ContentPlaceHolder1$txtBecomeDueto);return false;" /></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="width: 803px; height: 25px">
                <table cellpadding="0" cellspacing="0" style="border-right: #39867b 1px solid; border-top: #39867b 1px solid;
                    border-left: #39867b 1px solid; width: 100%; border-bottom: #39867b 1px solid;
                    height: 100%">
                    <tr>
                        <td colspan="3" style="background-image: url(../images/topBar_bg.gif); border-bottom: #39867b 1px solid;
                            background-repeat: repeat-x; height: 22px; width: 376px;">
                            员工列表</td>
                        <td align="right" colspan="1" style="background-image: url(../images/topBar_bg.gif);
                            width: 426px; border-bottom: #39867b 1px solid; background-repeat: repeat-x;
                            height: 22px">
                            <span style="color: blue">
                                <asp:LinkButton ID="btnCon" runat="server" OnClick="btnCon_Click" OnClientClick="return Isnull();">批量续签</asp:LinkButton>&nbsp;&nbsp;&nbsp;
                            </span></td>
                    </tr>
                    <tr>
                        <td colspan="4" style="height: 20px" align="center">
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="ObjectDataSource3"
                                Visible="False" Width="100%" OnRowDataBound="GridView1_RowDataBound" OnDataBound="GridView1_DataBound"
                                OnPageIndexChanged="GridView1_PageIndexChanged" AllowPaging="True" PageSize="15">
                                <Columns>
                                    <asp:TemplateField>
                                        <HeaderStyle ForeColor="Blue" HorizontalAlign="Center" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                        <ItemTemplate>
                                            &nbsp;<asp:CheckBox ID="chk" runat="server" />
                                        </ItemTemplate>
                                        <HeaderTemplate>
                                            <a href="#" onclick="checkAll();">选择</a>
                                        </HeaderTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="emp_cd" HeaderText="编号">
                                        <HeaderStyle ForeColor="White" HorizontalAlign="Center" Width="90px" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="emp_name" HeaderText="姓名">
                                        <HeaderStyle ForeColor="White" HorizontalAlign="Center" Width="90px" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="dept_name" HeaderText="部门">
                                        <HeaderStyle ForeColor="White" HorizontalAlign="Center" Width="90px" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="duty_name" HeaderText="职务">
                                        <HeaderStyle ForeColor="White" HorizontalAlign="Center" Width="90px" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="pj_name" HeaderText="工程">
                                        <HeaderStyle ForeColor="White" HorizontalAlign="Center" Width="90px" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="emp_class" HeaderText="区分">
                                        <HeaderStyle ForeColor="White" HorizontalAlign="Center" Width="90px" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="合同履历">
                                        <HeaderStyle ForeColor="White" HorizontalAlign="Center" Width="90px" />
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkDetail" runat="server">查看</asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="合同续签">
                                        <HeaderStyle ForeColor="White" HorizontalAlign="Center" Width="90px" />
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkOption" runat="server" OnClick="lnkOption_Click">续签</asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle BackColor="#539B93" />
                            </asp:GridView>
                            <uc1:UCPager ID="UCPager1" runat="server" />
                            <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" SelectMethod="GetEmpInfoByContractDate"
                                TypeName="Business.ContractMessage">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="txtEmpCd" DefaultValue=" " Name="emp_cd" PropertyName="Text"
                                        Type="String" />
                                    <asp:ControlParameter ControlID="txtEmpName" DefaultValue=" " Name="emp_name" PropertyName="Text"
                                        Type="String" />
                                    <asp:ControlParameter ControlID="selDept" DefaultValue=" " Name="dept_cd" PropertyName="SelectedValue"
                                        Type="String" />
                                    <asp:ControlParameter ControlID="selPj" DefaultValue=" " Name="pj_cd" PropertyName="SelectedValue"
                                        Type="String" />
                                    <asp:ControlParameter ControlID="txtBecomeDueFrom" DefaultValue=" " Name="start_date"
                                        PropertyName="Text" Type="String" />
                                    <asp:ControlParameter ControlID="txtBecomeDueto" DefaultValue=" " Name="end_date"
                                        PropertyName="Text" Type="String" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                        </td>
                    </tr>
                </table>
                <input id="valchk" type="hidden" value="0" name="valchk"/>
            </td>
        </tr>
    </table>
</asp:Content>
