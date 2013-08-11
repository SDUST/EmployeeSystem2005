<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="recruitManager.aspx.cs" Inherits="recruitManager" Title="Untitled Page" %>

<%@ Register Src="../UserControls/UCPagerV2.ascx" TagName="UCPager" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script language="JavaScript" src="../Script/CommonFunction.js" type="text/javascript">	</script>

    <script language="JavaScript" src="../Script/ErrMessage.js" type="text/javascript">	</script>

    <script language="JavaScript" type="text/javascript">
        function checkAll() {
			var a = document.getElementsByTagName("input");
			if(document.all("valchk").value=="1"){
			for (var i=0; i<a.length; i++)
				if (a[i].type == "checkbox" && a[i].id!="chkEmp" ) a[i].checked = false;
				document.all("valchk").value="0";
			}
			else
			{
			for (var i=0; i<a.length; i++)
				if (a[i].type == "checkbox" && a[i].id!="chkEmp") a[i].checked = true;
				document.all("valchk").value="1";
			}		
		}
		
		function verifyData() {
	        var ans;
	        ans=verify("<%=txtRectCd.ClientID %>",2,0,2,13,26);
	        if(ans==false)
	            return false;
	            var anid;
	            anid=verify("<%=txtIdCard.ClientID %>",2,0,2,12,1);
	            if(anid==false)
	            return false;
	               
	        var date1=document.getElementById("ctl00_ContentPlaceHolder1_txtRectDate1").value;
	        var date2=document.getElementById("<%=txtRectDate2.ClientID %>").value;    
	        ans=dateCheck(date1,date2); 
	        if(ans==false)
	            return false;     
	    }
	    
	    //弹出页面
          function fPopUpPage(page,width,heigh){
             window.showModalDialog(page, "", "dialogWidth:"+width+"px; dialogHeight:"+heigh+"px; status:no; directories:yes;scrollbars:no;Resizable=no; "  );
             return false;
         }

    </script>

<%--<asp:ScriptManager id="ScriptManager1" runat="server">
    </asp:ScriptManager>--%>
    <center>
       <%--<asp:UpdatePanel id="UpdatePanel1" runat="server">
            <contenttemplate>--%>
<TABLE class="border" cellSpacing=0 cellPadding=0 width="95%" border=0><TBODY><TR class="topbg"><TD style="TEXT-ALIGN: left" colSpan=6 height=22>应聘员工信息检索</TD></TR><TR><TD style="WIDTH: 149px; HEIGHT: 23px; TEXT-ALIGN: left">&nbsp;编&nbsp; &nbsp; 号 &nbsp;<asp:TextBox id="txtRectCd" runat="server" Width="60px" Height="12px" CssClass="INPUT" MaxLength="20"></asp:TextBox></TD><TD style="WIDTH: 176px; HEIGHT: 23px; TEXT-ALIGN: left">姓&nbsp; 　名 &nbsp;<asp:TextBox id="txtRectName" runat="server" Width="60px" Height="12px" CssClass="INPUT" MaxLength="20"></asp:TextBox></TD><TD style="WIDTH: 259px; HEIGHT: 23px; TEXT-ALIGN: left">&nbsp;&nbsp; 身份证号 <asp:TextBox id="txtIdCard" runat="server" Width="120px" Height="12px" CssClass="INPUT" MaxLength="18"></asp:TextBox></TD><TD style="WIDTH: 105px; HEIGHT: 23px">学历 <asp:DropDownList id="selDiploma" runat="server" Width="65px" CssClass="INPUT" OnDataBound="selDiploma_DataBound"></asp:DropDownList></TD><TD style="HEIGHT: 23px" align=right><asp:Button id="btnQuery" onclick="btnQuery_Click" runat="server" Width="100px" Height="12px" CssClass="button" OnClientClick="return verifyData();" Text="查 询"></asp:Button></TD><TD style="HEIGHT: 23px" vAlign="center" width=30>&nbsp;</TD></TR><TR><TD style="HEIGHT: 46px; TEXT-ALIGN: left" colSpan=2>&nbsp;应聘日期&nbsp;&nbsp;<asp:TextBox id="txtRectDate1" runat="server" Width="60px" Height="12px" CssClass="readonly"></asp:TextBox> <asp:ImageButton id="ImageButton1" runat="server" ImageUrl="~/images/datetime.gif" Width="16px" OnClientClick="fPopUpCalendarDlg(document.all.ctl00_ContentPlaceHolder1_txtRectDate1);return false;"></asp:ImageButton>&nbsp;&nbsp; &nbsp;～&nbsp;&nbsp;<asp:TextBox id="txtRectDate2" runat="server" Width="60px" Height="12px" CssClass="readonly"></asp:TextBox>&nbsp;<asp:ImageButton id="ImageButton2" runat="server" ImageUrl="~/images/datetime.gif" Width="16px" OnClientClick="fPopUpCalendarDlg(document.all.ctl00_ContentPlaceHolder1_txtRectDate2);return false;"></asp:ImageButton></TD><TD style="WIDTH: 259px; HEIGHT: 46px"><asp:RadioButton id="rdoDelet" runat="server" Text="排除应聘过的" GroupName="rect" TextAlign="Left" Checked="True"></asp:RadioButton> &nbsp;<asp:RadioButton id="rdoQuery" runat="server" Text="查询应聘过的" GroupName="rect" TextAlign="Left"></asp:RadioButton> </TD><TD style="WIDTH: 105px; HEIGHT: 46px">标识 <asp:DropDownList id="selFlag" runat="server" Width="65px" Height="22px"  OnDataBound="selFlag_DataBound"></asp:DropDownList></TD><TD style="HEIGHT: 46px" align=right><asp:Button id="btnImport" runat="server" Width="100px" Height="12px" CssClass="button" OnClientClick="fPopUpPage('ImportFromExcel.aspx',500,150);" Text="导入招工表"></asp:Button></TD><TD style="HEIGHT: 46px">&nbsp;</TD></TR></TBODY></TABLE><BR /><TABLE cellSpacing=0 cellPadding=0 width="95%"><TBODY><TR><TD style="BACKGROUND-IMAGE: url(../images/topBar_bg.gif); WIDTH: 912px; BACKGROUND-REPEAT: repeat-x; HEIGHT: 6px; TEXT-ALIGN: left"><SPAN style="COLOR: #000000">应聘员工信息管理</SPAN></TD><TD align="right" class="tdbg" style="BACKGROUND-IMAGE: url(../images/topBar_bg.gif); BACKGROUND-REPEAT: repeat-x; HEIGHT: 6px; ALIGN: right; width: 279px; text-align: right;" colSpan=2 >
    <asp:LinkButton id="lnkPrint" onclick="lnkPrint_Click" runat="server" Height="19px">>>打印报表</asp:LinkButton><asp:LinkButton id="lnkOk" onclick="lnkOk_Click" runat="server" Height="19px" ForeColor="White">>>合格</asp:LinkButton><asp:LinkButton
        ID="lnkNo" runat="server" Height="19px" OnClick="lnkNo_Click">>>不合格</asp:LinkButton></TD></TR><TR><TD style="VERTICAL-ALIGN: top; HEIGHT: 386px" colSpan=3 rowSpan=2><asp:GridView style="VERTICAL-ALIGN: top" id="gvRect" runat="server" Width="100%" OnRowDataBound="gvRect_RowDataBound" OnPageIndexChanging="gvRect_PageIndexChanging" OnPageIndexChanged="gvRect_PageIndexChanged" AutoGenerateColumns="False" AllowPaging="True"><Columns>
<asp:TemplateField><HeaderTemplate>
                                        <a href="#" onclick="checkAll();">选择</a>
                                    
</HeaderTemplate>

<ItemStyle Width="40px"></ItemStyle>
<ItemTemplate>
<asp:CheckBox id="chkRect" runat="server"></asp:CheckBox> 
</ItemTemplate>
</asp:TemplateField>
<asp:BoundField DataField="rect_date" HeaderText="应聘日期">
<ItemStyle Width="80px" HorizontalAlign="Right"></ItemStyle>

<HeaderStyle ForeColor="White"></HeaderStyle>
</asp:BoundField>
<asp:BoundField DataField="rect_cd" HeaderText="编号">
<ItemStyle Width="80px" HorizontalAlign="Right"></ItemStyle>

<HeaderStyle ForeColor="White"></HeaderStyle>
</asp:BoundField>
<asp:BoundField DataField="rect_name" HeaderText="姓名">
<ItemStyle Width="80px" HorizontalAlign="Left"></ItemStyle>

<HeaderStyle ForeColor="White"></HeaderStyle>
</asp:BoundField>
<asp:BoundField DataField="sex" HeaderText="性别">
<ItemStyle Width="40px" HorizontalAlign="Left"></ItemStyle>

<HeaderStyle ForeColor="White"></HeaderStyle>
</asp:BoundField>
<asp:BoundField DataFormatString="{0:yyyy/MM/dd}" DataField="birthday" NullDisplayText="未知" HeaderText="出生日期">
<ItemStyle Width="80px" HorizontalAlign="Right"></ItemStyle>

<HeaderStyle ForeColor="White"></HeaderStyle>
</asp:BoundField>
<asp:BoundField DataField="id_card" HeaderText="身份证号">
<ItemStyle Width="120px" HorizontalAlign="Right"></ItemStyle>

<HeaderStyle ForeColor="White"></HeaderStyle>
</asp:BoundField>
<asp:BoundField DataField="diploma" NullDisplayText="未知" HeaderText="学历">
<ItemStyle Width="80px" HorizontalAlign="Left"></ItemStyle>

<HeaderStyle ForeColor="White"></HeaderStyle>
</asp:BoundField>
<asp:BoundField DataField="account_address" NullDisplayText="未知" HeaderText="户口所在地">
<ItemStyle Width="90px" HorizontalAlign="Left"></ItemStyle>

<HeaderStyle ForeColor="White"></HeaderStyle>
</asp:BoundField>
<asp:BoundField DataField="标识" HeaderText="标识">
<ItemStyle Width="50px" HorizontalAlign="Left"></ItemStyle>

<HeaderStyle ForeColor="White"></HeaderStyle>
</asp:BoundField>
</Columns>

<HeaderStyle BackColor="Teal"></HeaderStyle>
</asp:GridView> <uc1:UCPager id="UCPager1" runat="server"></uc1:UCPager> </TD></TR><TR></TR></TBODY></TABLE>
<%--</contenttemplate>
        </asp:UpdatePanel>--%>
    </center>
    <input id="valchk" type="hidden" value="0" name="valchk">
   </asp:Content>
