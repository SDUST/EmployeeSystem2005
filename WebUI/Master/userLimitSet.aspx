<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="userLimitSet.aspx.cs" Inherits="userLimitSet" Title="百易人事管理系统" %>

<%@ Register Src="../UserControls/UCPagerV2.ascx" TagName="UCPager" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script language="JavaScript" src="../Script/CommonFunction.js" type="text/javascript">	</script>

    <script language="JavaScript" src="../Script/ErrMessage.js" type="text/javascript">	</script>

    <script language="javascript" type="text/javascript">
	    
          //弹出页面
          function fPopUpPage(page,width,heigh){
             window.showModalDialog(page, "", "dialogWidth:"+width+"px; dialogHeight:"+heigh+"px; status:no; directories:yes;scrollbars:no;Resizable=no; "  );
             return false;
         }
    </script>


    <center>
        <br />
        <asp:UpdatePanel id="UpdatePanel1" runat="server">
            <contenttemplate>
<TABLE style="BORDER-RIGHT: teal 1px solid; BORDER-TOP: teal 1px solid; BORDER-LEFT: teal 1px solid; BORDER-BOTTOM: teal 1px solid" cellSpacing=0 cellPadding=0 width="100%"><TBODY><TR><TD style="HEIGHT: 18px; BACKGROUND-COLOR: #669999" colSpan=3><SPAN style="COLOR: #ffffff">用户权限检索</SPAN></TD><TD style="HEIGHT: 18px; BACKGROUND-COLOR: #669999" colSpan=1></TD></TR><TR><TD style="WIDTH: 171px; HEIGHT: 19px"><SPAN style="FONT-SIZE: 10pt">登录ID</SPAN> <asp:TextBox id="txtUserCd" runat="server" Width="111px" MaxLength="20" CssClass="INPUT"></asp:TextBox></TD><TD style="WIDTH: 185px; HEIGHT: 19px"><SPAN style="FONT-SIZE: 10pt">用户名</SPAN> <asp:TextBox id="txtUserName" runat="server" Width="111px" MaxLength="20" CssClass="INPUT"></asp:TextBox></TD><TD style="WIDTH: 188px; HEIGHT: 19px"><SPAN style="FONT-SIZE: 10pt"></SPAN></TD><TD style="HEIGHT: 19px; TEXT-ALIGN: right"><SPAN style="FONT-SIZE: 10pt"><asp:Button id="btnQuery" onclick="btnQuery_Click" runat="server" Width="68px" Height="20px" CssClass="button" Text="查 询" Font-Size="X-Small"></asp:Button></SPAN></TD></TR></TBODY></TABLE><BR /><TABLE style="BORDER-RIGHT: #539d93 1px solid; BORDER-TOP: #539d93 1px solid; BORDER-LEFT: #539d93 1px solid; BORDER-BOTTOM: #539d93 1px solid" cellSpacing=0 cellPadding=0 width="100%"><TBODY><TR><TD style="BACKGROUND-IMAGE: url(../images/topBar_bg.gif); BACKGROUND-REPEAT: repeat-x; HEIGHT: 22px; TEXT-ALIGN: left" colSpan=1>用户权限设置</TD><TD style="BACKGROUND-IMAGE: url(../images/topBar_bg.gif); BACKGROUND-REPEAT: repeat-x; HEIGHT: 22px; TEXT-ALIGN: right" colSpan=3><SPAN></SPAN><asp:LinkButton id="lnkLimitAdd" onclick="lnkLimitAdd_Click1" runat="server" Width="75px" Height="20px" Font-Size="Small" OnClientClick="fPopUpPage('userLimitSetAdd.aspx?mode=addnew',355,230)">新增记录</asp:LinkButton> </TD></TR><TR><TD style="BORDER-TOP: #539d93 1px solid" vAlign=top colSpan=4 rowSpan=2><asp:GridView id="gvUsers" runat="server" Width="100%" OnRowDeleting="gvUsers_RowDeleting" DataKeyNames="user_cd" OnRowDataBound="gvUsers_RowDataBound" Visible="False" OnPageIndexChanging="gvUsers_PageIndexChanging" BorderColor="Teal" AutoGenerateColumns="False" AllowPaging="True" OnPageIndexChanged="gvUsers_PageIndexChanged">
<PagerSettings Visible="False"></PagerSettings>
<Columns>
<asp:BoundField DataField="user_cd" HeaderText="登录ID"></asp:BoundField>
<asp:BoundField DataField="user_name" HeaderText="用户名"></asp:BoundField>
<asp:TemplateField HeaderText="权限管理">
<ItemStyle HorizontalAlign="Right"></ItemStyle>
<ItemTemplate>
                                        <table width="100%">
                                            <tbody>
                                                <tr>
                                                    <td style="text-align: center" colspan="3" rowspan="3">
                                                        <asp:LinkButton ID="lnkLimitManager" OnClick="lnkLimitManager_Click" runat="server"
                                                            Height="20px" Font-Size="Small">管理</asp:LinkButton></td>
                                                </tr>
                                                <tr>
                                                </tr>
                                                <tr>
                                                </tr>
                                            </tbody>
                                        </table>
                                    
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="操作">
<ItemStyle HorizontalAlign="Right"></ItemStyle>
<ItemTemplate>
                                        <table width="100%">
                                            <tbody>
                                                <tr>
                                                    <td style="text-align: center" width="50%">
                                                        &nbsp;<asp:LinkButton ID="lnkLimitModify" OnClick="lnkLimitModify_Click" runat="server"
                                                            Height="20px" Font-Size="Small">修正</asp:LinkButton></td>
                                                    <td style="text-align: center" width="50%">
                                                        <asp:LinkButton ID="lnkLimitDelete" runat="server" Height="20px" Font-Size="Small"
                                                            OnClientClick="return confirm('确定要删除这个用户吗？')" CommandName="delete">删除</asp:LinkButton></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    
</ItemTemplate>
</asp:TemplateField>
</Columns>

<HeaderStyle BackColor="#669999" ForeColor="White"></HeaderStyle>
</asp:GridView> <uc1:UCPager id="UCPager1" runat="server"></uc1:UCPager> </TD></TR><TR></TR></TBODY></TABLE>
</contenttemplate>
        </asp:UpdatePanel>
        <br />
        &nbsp;</center>
</asp:Content>
