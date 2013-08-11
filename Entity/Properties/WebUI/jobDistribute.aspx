<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="jobDistribute.aspx.cs" Inherits="jobDistribute" Title="Untitled Page" %>

<%@ Register Src="UserControls/UCPagerV2.ascx" TagName="UCPager" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script language="JavaScript" src="Script/CommonFunction.js" type="text/javascript">	</script>

    <script language="JavaScript" src="Script/ErrMessage.js" type="text/javascript">	</script>

    <script language="javascript" type="text/javascript">
         function checkAll(){
			var a = document.getElementsByTagName("input");
			if(document.all("valchk").value=="1"){
			for (var i=0; i<a.length; i++)
				if (a[i].type == "checkbox" && a[i].id!="ctl00_ContentPlaceHolder1_chkPj" ) a[i].checked = false;
				document.all("valchk").value="0";
			}
			else{
			for (var i=0; i<a.length; i++)
				if (a[i].type == "checkbox" && a[i].id!="ctl00_ContentPlaceHolder1_chkPj") a[i].checked = true;
				document.all("valchk").value="1";
			}		
		 }
		 
		   function verifyData() {
	        var ans;
	        ans=verify("<%=txtEmpCd.ClientID %>",2,0,2,13,26);
	        if(ans==false)
	            return false;
	    }
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <center>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <contenttemplate>
<TABLE class="border" cellSpacing=0 cellPadding=0 width="95%" border=0><TBODY><TR class="topbg "><TD style="TEXT-ALIGN: left" height=22>员工信息检索</TD></TR><TR><TD style="HEIGHT: 24px">编&nbsp; 号 <asp:TextBox id="txtEmpCd" runat="server" Width="100px" CssClass="INPUT" MaxLength="20"></asp:TextBox>&nbsp; &nbsp;姓&nbsp; 名 <asp:TextBox id="txtEmpName" runat="server" Width="100px" CssClass="INPUT" MaxLength="20"></asp:TextBox>&nbsp; &nbsp;部&nbsp; 门 <asp:DropDownList id="selDept" runat="server" Width="100px" CssClass="INPUT" OnDataBound="selDept_DataBound">
                            </asp:DropDownList> &nbsp; 工&nbsp; 程 <asp:DropDownList id="selPj" runat="server" Width="100px" CssClass="INPUT" OnDataBound="selPj_DataBound">
                            </asp:DropDownList> &nbsp;&nbsp; <asp:CheckBox id="chkPj" runat="server" TextAlign="Left" Text="未分配工程"></asp:CheckBox>&nbsp;&nbsp;&nbsp; &nbsp;<asp:Button id="btnQuery" onclick="btnQuery_Click" runat="server" Width="63px" Height="20px" CssClass="button" Text="查 询" OnClientClick="return verifyData();"></asp:Button></TD></TR></TBODY></TABLE><BR /><BR /><TABLE cellSpacing=0 cellPadding=0 width="95%"><TBODY><TR><TD style="WIDTH: 320px; HEIGHT: 23px; TEXT-ALIGN: left">选择工程 <asp:DropDownList id="selSelectPj" runat="server" Width="100px" OnDataBound="selSelectPj_DataBound" AutoPostBack="True" OnSelectedIndexChanged="selSelectPj_SelectedIndexChanged">
                            </asp:DropDownList></TD><TD style="WIDTH: 126px; HEIGHT: 23px"></TD><TD style="HEIGHT: 23px"></TD></TR><TR><TD style="BORDER-TOP-WIDTH: 1px; BORDER-LEFT-WIDTH: 1px; BACKGROUND-IMAGE: url(images/topBar_bg.gif); BORDER-BOTTOM-WIDTH: 1px; WIDTH: 320px; BACKGROUND-REPEAT: repeat-x; HEIGHT: 21px; BORDER-RIGHT-WIDTH: 1px">相应工程员工列表</TD><TD style="WIDTH: 126px; HEIGHT: 21px"></TD><TD style="BORDER-TOP-WIDTH: 1px; BORDER-LEFT-WIDTH: 1px; BORDER-LEFT-COLOR: teal; BACKGROUND-IMAGE: url(images/topBar_bg.gif); BORDER-BOTTOM-WIDTH: 1px; BORDER-BOTTOM-COLOR: teal; BORDER-TOP-COLOR: teal; BACKGROUND-REPEAT: repeat-x; HEIGHT: 21px; BORDER-RIGHT-WIDTH: 1px; BORDER-RIGHT-COLOR: teal">被选员工列表</TD></TR><TR><TD style="WIDTH: 320px; HEIGHT: 408px" vAlign=top rowSpan=2><asp:Panel id="Panel1" runat="server" Width="100%" Height="392px" ScrollBars="Auto" Visible="False">
                                <asp:GridView ID="gvEmp2" runat="server" PageSize="20" AutoGenerateColumns="False"
                                    BorderColor="Teal" Visible="False" Width="100%">
                                    <HeaderStyle BackColor="#669999" />
                                    <Columns>
                                        <asp:BoundField DataField="emp_cd" HeaderText="编号" />
                                        <asp:BoundField DataField="emp_name" HeaderText="姓名" />
                                        <asp:BoundField DataField="dept_name" HeaderText="工程" />
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel> </TD><TD style="WIDTH: 126px; HEIGHT: 408px" vAlign=middle align=center rowSpan=2><asp:Button id="btnSave" class="button" onclick="btnSave_Click" runat="server" Width="78px" Text="<—确认分配"></asp:Button></TD><TD style="HEIGHT: 408px" vAlign=top rowSpan=2>&nbsp;&nbsp; <asp:GridView style="VERTICAL-ALIGN: middle" id="gvEmp1" runat="server" Width="100%" Visible="False" OnPageIndexChanged="gvEmp1_PageIndexChanged" OnPageIndexChanging="gvEmp1_PageIndexChanging" PageSize="15" AllowPaging="True" BorderColor="Teal" AutoGenerateColumns="False">
                                <HeaderStyle BackColor="#669999" />
                                <Columns>
                                    <asp:TemplateField HeaderText="选择">
                                        <ItemStyle Width="40px" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkEmp" runat="server" />
                                        </ItemTemplate>
                                        <HeaderTemplate>
                                            <a href="#" onclick="checkAll();">选择</a>
                                            <%-- <asp:LinkButton ID="lbtnSelect" runat="server" OnClick="lbtnSelect_Click">选择</asp:LinkButton>--%>
                                        </HeaderTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="编号" DataField="emp_cd" />
                                    <asp:BoundField DataField="emp_name" HeaderText="姓名" />
                                    <asp:BoundField DataField="dept_name" HeaderText="工程" />
                                    <asp:BoundField DataField="区分" HeaderText="区分" />
                                </Columns>
                            </asp:GridView> <uc1:UCPager id="UCPager1" runat="server"></uc1:UCPager> </TD></TR><TR></TR><TR><TD colSpan=3 rowSpan=1>&nbsp;</TD></TR></TBODY></TABLE>
</contenttemplate>
        </asp:UpdatePanel>
    </center>
    <input id="valchk" type="hidden" value="0" name="valchk"/>
</asp:Content>
