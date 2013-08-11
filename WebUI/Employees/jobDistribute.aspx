<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="jobDistribute.aspx.cs" Inherits="jobDistribute" Title="工程分配" %>

<%@ Register Src="../UserControls/UCPagerV2.ascx" TagName="UCPager" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script language="JavaScript" src="../Script/CommonFunction.js" type="text/javascript">	</script>

    <script language="JavaScript" src="../Script/ErrMessage.js" type="text/javascript">	</script>

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

    &nbsp;<center>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <contenttemplate>
<TABLE class="border" cellSpacing=0 cellPadding=0 width="95%" border=0><TBODY><TR class="topbg "><TD style="TEXT-ALIGN: left" height=22>员工信息检索</TD></TR><TR><TD style="HEIGHT: 24px; TEXT-ALIGN: left"><TABLE width="100%"><TBODY><TR><TD style="HEIGHT: 14px; TEXT-ALIGN: left" colSpan=1 rowSpan=3>编号<asp:TextBox id="txtEmpCd" runat="server" Width="60px" Height="15px" MaxLength="20" CssClass="INPUT"></asp:TextBox></TD><TD style="HEIGHT: 14px" colSpan=1 rowSpan=3>姓名 <asp:TextBox id="txtEmpName" runat="server" Width="60px" Height="15px" MaxLength="20" CssClass="INPUT"></asp:TextBox></TD><TD style="HEIGHT: 14px" colSpan=1 rowSpan=3>部门 <asp:DropDownList id="selDept" runat="server" Width="90px" CssClass="INPUT" OnDataBound="selDept_DataBound"></asp:DropDownList> </TD><TD style="HEIGHT: 14px" colSpan=1 rowSpan=3>工程 <asp:DropDownList id="selPj" runat="server" Width="98px" CssClass="INPUT" OnDataBound="selPj_DataBound"></asp:DropDownList></TD><TD style="HEIGHT: 14px" colSpan=1 rowSpan=3><asp:CheckBox id="chkPj" runat="server" Text="未分配工程" TextAlign="Left"></asp:CheckBox></TD><TD style="HEIGHT: 14px" colSpan=3 rowSpan=3><asp:Button id="btnQuery" onclick="btnQuery_Click" runat="server" Width="63px" Height="20px" CssClass="button" Text="查 询" OnClientClick="return verifyData();"></asp:Button></TD></TR><TR></TR><TR></TR></TBODY></TABLE>&nbsp;&nbsp;&nbsp;&nbsp;</TD></TR></TBODY></TABLE><BR /><BR /><TABLE cellSpacing=0 cellPadding=0 width="95%"><TBODY><TR><TD style="WIDTH: 320px; HEIGHT: 23px; TEXT-ALIGN: left">选择工程 <asp:DropDownList id="selSelectPj" runat="server" Width="98px" OnDataBound="selSelectPj_DataBound" OnSelectedIndexChanged="selSelectPj_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList></TD><TD style="WIDTH: 126px; HEIGHT: 23px"></TD><TD style="HEIGHT: 23px"></TD></TR><TR><TD style="BORDER-TOP-WIDTH: 1px; BORDER-LEFT-WIDTH: 1px; BACKGROUND-IMAGE: url(../images/topBar_bg.gif); BORDER-BOTTOM-WIDTH: 1px; WIDTH: 320px; BACKGROUND-REPEAT: repeat-x; HEIGHT: 19px; TEXT-ALIGN: left; BORDER-RIGHT-WIDTH: 1px">相应工程员工列表</TD><TD style="WIDTH: 126px; HEIGHT: 19px"></TD><TD style="BORDER-TOP-WIDTH: 1px; BORDER-LEFT-WIDTH: 1px; BORDER-LEFT-COLOR: teal; BACKGROUND-IMAGE: url(../images/topBar_bg.gif); BORDER-BOTTOM-WIDTH: 1px; BORDER-BOTTOM-COLOR: teal; BORDER-TOP-COLOR: teal; BACKGROUND-REPEAT: repeat-x; HEIGHT: 19px; TEXT-ALIGN: left; BORDER-RIGHT-WIDTH: 1px; BORDER-RIGHT-COLOR: teal">备选员工列表</TD></TR><TR><TD style="WIDTH: 320px; HEIGHT: 408px" vAlign=top rowSpan=2><asp:Panel id="Panel1" runat="server" Width="100%" Height="392px" ScrollBars="Auto" Visible="False"><asp:GridView id="gvEmp2" runat="server" Width="100%" Visible="False" PageSize="20" BorderColor="Teal" AutoGenerateColumns="False"><Columns>
<asp:BoundField DataField="emp_cd" HeaderText="编号">
<ItemStyle HorizontalAlign="Right"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="emp_name" HeaderText="姓名">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="dept_name" HeaderText="工程">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
</asp:BoundField>
</Columns>

<HeaderStyle BackColor="#669999"></HeaderStyle>
</asp:GridView> </asp:Panel> </TD><TD style="WIDTH: 126px; HEIGHT: 408px" vAlign=middle align=center rowSpan=2><asp:Button id="btnSave" class="button" onclick="btnSave_Click" runat="server" Width="78px" Text="<—确认分配"></asp:Button></TD><TD style="HEIGHT: 408px" vAlign=top rowSpan=2><asp:GridView style="VERTICAL-ALIGN: middle" id="gvEmp1" runat="server" Width="100%" Visible="False" AutoGenerateColumns="False" BorderColor="Teal" AllowPaging="True" PageSize="15" OnPageIndexChanging="gvEmp1_PageIndexChanging" OnPageIndexChanged="gvEmp1_PageIndexChanged">
<PagerSettings Visible="False"></PagerSettings>
<Columns>
<asp:TemplateField HeaderText="选择"><HeaderTemplate>
                                            <a href="#" onclick="checkAll();">选择</a>
                                            <%-- <asp:LinkButton ID="lbtnSelect" runat="server" OnClick="lbtnSelect_Click">选择</asp:LinkButton>--%>
                                        
</HeaderTemplate>

<ItemStyle Width="40px"></ItemStyle>
<ItemTemplate>
<asp:CheckBox id="chkEmp" runat="server"></asp:CheckBox> <asp:HiddenField id="HiddenField1" runat="server" Value='<%# Eval("emp_cd") %>'></asp:HiddenField>
</ItemTemplate>
</asp:TemplateField>
<asp:BoundField DataField="emp_cd" HeaderText="编号"></asp:BoundField>
<asp:BoundField DataField="emp_name" HeaderText="姓名"></asp:BoundField>
<asp:BoundField DataField="dept_name" HeaderText="工程"></asp:BoundField>
<asp:BoundField DataField="区分" HeaderText="区分"></asp:BoundField>
</Columns>

<HeaderStyle BackColor="#669999"></HeaderStyle>
</asp:GridView> <uc1:UCPager id="UCPager1" runat="server"></uc1:UCPager> </TD></TR><TR></TR><TR><TD style="HEIGHT: 12px" colSpan=3 rowSpan=1>&nbsp;</TD></TR></TBODY></TABLE>
</contenttemplate>
        </asp:UpdatePanel>
    </center>
    <input id="valchk" type="hidden" value="0" name="valchk"/>
</asp:Content>
