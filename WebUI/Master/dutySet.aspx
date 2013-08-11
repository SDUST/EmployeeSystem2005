<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="dutySet.aspx.cs" Inherits="Master_dutySet" Title="职务设置" %>

<%@ Register Src="../UserControls/UCPager.ascx" TagName="UCPager" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript" src="../Script/CommonFunction.js"></script>
    <asp:UpdatePanel id="UpdatePanel1" runat="server">
        <contenttemplate>
<TABLE style="BORDER-RIGHT: #339933 1px solid; BORDER-TOP: #339933 1px solid; BORDER-LEFT: #339933 1px solid; WIDTH: 800px; BORDER-BOTTOM: #339933 1px solid" cellSpacing=0 cellPadding=0><TBODY><TR><TD style="BACKGROUND-IMAGE: url(../images/topBar_bg.gif); WIDTH: 400px; HEIGHT: 18px" align=left>职务设置</TD><TD style="BACKGROUND-IMAGE: url(../images/topBar_bg.gif); WIDTH: 400px; HEIGHT: 18px" align=right colSpan=2><asp:LinkButton id="lnkAdd" runat="server" Font-Underline="False" OnClientClick='fPopUpPage1("dutySetAdd.aspx",480,170)' OnClick="lnkAdd_Click">新增记录    </asp:LinkButton>&nbsp;&nbsp;&nbsp; </TD></TR><TR><TD style="HEIGHT: 153px; TEXT-ALIGN: center" vAlign=top colSpan=3><asp:GridView id="GridView1" runat="server" Width="800px" PageSize="15" AutoGenerateColumns="False" DataSourceID="odsDutyGet" OnRowDataBound="GridView1_RowDataBound" DataKeyNames="duty_cd" OnRowDeleting="GridView1_RowDeleting" OnDataBound="GridView1_DataBound" OnPageIndexChanged="GridView1_PageIndexChanged" AllowPaging="True">
<PagerSettings Visible="False"></PagerSettings>
<Columns>
<asp:BoundField DataField="duty_cd" HeaderText="职务编号">
<ItemStyle Width="120px"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="duty_name" HeaderText="职务名称">
<ItemStyle Width="550px"></ItemStyle>
</asp:BoundField>
<asp:TemplateField HeaderText="操作">
<ItemStyle Width="80px"></ItemStyle>
<ItemTemplate>
<asp:LinkButton id="lnkModi" runat="server" Font-Underline="False" __designer:wfdid="w13" OnClick="lnkModi_Click">修正</asp:LinkButton><SPAN style="FONT-SIZE: 10pt"> <SPAN style="COLOR: #ffffff">| </SPAN></SPAN><asp:LinkButton id="lnkDel" runat="server" CommandName="delete" __designer:wfdid="w14">删除</asp:LinkButton> 
</ItemTemplate>
</asp:TemplateField>
</Columns>

<HeaderStyle CssClass="topbg"></HeaderStyle>
</asp:GridView><uc1:UCPager id="UCPager1" runat="server"></uc1:UCPager></TD></TR><TR><TD colSpan=3></TD></TR></TBODY></TABLE><asp:ObjectDataSource id="odsDutyGet" runat="server" SelectMethod="GetDuty" TypeName="Business.Dutys" DataObjectTypeName="Entity.Duty" DeleteMethod="DutyDelete"></asp:ObjectDataSource> 
</contenttemplate>
    </asp:UpdatePanel>
</asp:Content>
