<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="workTimeSet.aspx.cs" Inherits="Master_workTimeSet" Title="工作时间设置" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript" src="../Script/CommonFunction.js"></script>

    <div style="text-align: center">

        <script src="Script/CommonFunction.js" type="text/javascript"></script>
        <asp:UpdatePanel id="UpdatePanel1" runat="server">
                <contenttemplate>
<TABLE style="BORDER-RIGHT: purple 1px solid; BORDER-TOP: purple 1px solid; BORDER-LEFT: purple 1px solid; WIDTH: 410px; BORDER-BOTTOM: purple 1px solid; HEIGHT: 40px" class="border"><TBODY><TR><TD style="BACKGROUND-IMAGE: url(../images/topBar_bg.gif); BORDER-BOTTOM: #39867b 1px solid; HEIGHT: 10px; TEXT-ALIGN: left" vAlign=top align=center colSpan=4>工作时间设置</TD></TR><TR><TD style="BORDER-RIGHT: #39867b 1px solid; WIDTH: 80px; HEIGHT: 10px" vAlign=middle align=center>上班时间</TD><TD style="BORDER-RIGHT: #39867b 1px solid; WIDTH: 100px; HEIGHT: 10px" vAlign=top align=center><asp:TextBox id="txtOnDuty" runat="server" Width="80px"></asp:TextBox></TD><TD style="BORDER-RIGHT: #39867b 1px solid; WIDTH: 80px; HEIGHT: 10px">下班时间</TD><TD style="WIDTH: 100px; HEIGHT: 10px" vAlign=top align=center><asp:TextBox id="txtOffDuty" runat="server" Width="80px"></asp:TextBox></TD></TR><TR><TD style="BORDER-TOP: #39867b 1px solid; HEIGHT: 20px; TEXT-ALIGN: center" vAlign=top align=center colSpan=4><asp:Button id="lnkSave" onclick="lnkSave_Click" runat="server" Width="42px" Height="21px" CssClass="button" OnClientClick="return workTimeCheck(document.all.ctl00_ContentPlaceHolder1_txtOnDuty.value,document.all.ctl00_ContentPlaceHolder1_txtOffDuty.value);" Text="保存"></asp:Button></TD></TR></TBODY></TABLE>
</contenttemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
