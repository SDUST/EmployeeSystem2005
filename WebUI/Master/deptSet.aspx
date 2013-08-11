<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="deptSet.aspx.cs" Inherits="_Default" Title="部门设置" %>

<%@ Register Src="../UserControls/UCPager.ascx" TagName="UCPager" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<script type="text/javascript" src="../Script/CommonFunction.js"></script>
<TABLE class="border" cellSpacing=1 cellPadding=0 width=800 align=left border=0 style="border-right: #339933 1px solid; border-top: #339933 1px solid; border-left: #339933 1px solid; border-bottom: #339933 1px solid"><TBODY><TR class="topbg"><TD style="HEIGHT: 22px" align=left colSpan=8>部门信息检索</TD></TR><TR><TD style="WIDTH: 101px; HEIGHT: 42px">编号<asp:TextBox id="txtDeptCd" runat="server" Width="60px" CssClass="INPUT" MaxLength="20"></asp:TextBox></TD><TD style="WIDTH: 123px; HEIGHT: 42px">名称 <asp:TextBox id="txtDeptName" runat="server" Width="80px" CssClass="INPUT" MaxLength="20"></asp:TextBox></TD><TD style="WIDTH: 91px; HEIGHT: 42px">区分&nbsp;<asp:DropDownList id="selDeptClass" runat="server" Width="50px">
                    <asp:ListItem Selected="True"></asp:ListItem>
                    <asp:ListItem Value="0">部门</asp:ListItem>
                    <asp:ListItem Value="1">工程</asp:ListItem>
    <asp:ListItem Value="2">课</asp:ListItem>
    <asp:ListItem Value="3">班组</asp:ListItem>
                </asp:DropDownList></TD><TD style="WIDTH: 229px; HEIGHT: 42px">管理上级&nbsp;<asp:DropDownList id="selParent" runat="server" Width="125px" OnDataBound="selParent_DataBound" DataValueField="dept_cd" DataTextField="dept_name" DataSourceID="ObjectDataSource1">
                </asp:DropDownList></TD><TD style="HEIGHT: 42px">&nbsp;<FONT face="宋体"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<asp:Button id="btnQuery" onclick="btnQuery_Click" runat="server" CssClass="button" Text=" 查 询 "></asp:Button></FONT></TD></TR></TBODY></TABLE><BR /><BR /><BR />
    <br />
    <br />
    <BR /> 

    <asp:UpdatePanel id="UpdatePanel1" runat="server">
        <contenttemplate>
<TABLE style="BORDER-RIGHT: #339933 1px solid; BORDER-TOP: #339933 1px solid; BORDER-LEFT: #339933 1px solid; WIDTH: 788px; BORDER-BOTTOM: #339933 1px solid; HEIGHT: 1px" cellSpacing=0 cellPadding=0><TBODY><TR><TD style="BACKGROUND-IMAGE: url(../images/topBar_bg.gif); WIDTH: 400px; BACKGROUND-REPEAT: repeat; HEIGHT: 20px" colSpan=3>部门设置</TD><TD style="BACKGROUND-IMAGE: url(../images/topBar_bg.gif); WIDTH: 400px; BORDER-TOP-STYLE: none; BACKGROUND-REPEAT: repeat; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; HEIGHT: 20px; BORDER-BOTTOM-STYLE: none" align=right colSpan=1><asp:LinkButton id="lnkAdd" onclick="lnkAdd_Click" runat="server" OnClientClick='fPopUpPage1("deptAddNew.aspx",460,220)' Font-Underline="False">部门新增    </asp:LinkButton>&nbsp;&nbsp; </TD></TR><TR><TD colSpan=4><asp:GridView id="grd" runat="server" Width="800px" DataSourceID="odsGetDeptInfo" OnDataBound="grd_DataBound" OnRowDataBound="grd_RowDataBound" DataKeyNames="dept_cd" AutoGenerateColumns="False" AllowPaging="True" Visible="False" align="left" PageSize="15" OnPageIndexChanged="grd_PageIndexChanged">
<PagerSettings Visible="False"></PagerSettings>
<Columns>
<asp:BoundField DataField="dept_cd" HeaderText="部门编号"></asp:BoundField>
<asp:BoundField DataField="dept_name" HeaderText="部门名称"></asp:BoundField>
<asp:BoundField DataField="dept_class" HeaderText="区分"></asp:BoundField>
<asp:BoundField DataField="dept_name2" HeaderText="管理上级"></asp:BoundField>
<asp:TemplateField HeaderText="熟练度设置"><ItemTemplate>
<asp:LinkButton id="lnkSet" runat="server" __designer:wfdid="w31" OnClick="lnkSet_Click">设置</asp:LinkButton> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="编辑"><ItemTemplate>
<asp:LinkButton id="lnkEdit" onclick="lnkEdit_Click" runat="server" __designer:wfdid="w2">编辑</asp:LinkButton> 
</ItemTemplate>
</asp:TemplateField>
</Columns>

<RowStyle HorizontalAlign="Center"></RowStyle>

<HeaderStyle CssClass="topbg"></HeaderStyle>
</asp:GridView> </TD></TR><TR><TD style="HEIGHT: 8px; TEXT-ALIGN: center" colSpan=4><uc1:UCPager id="UCPager1" runat="server"></uc1:UCPager>&nbsp; </TD></TR></TBODY></TABLE><asp:ObjectDataSource id="odsGetDeptInfo" runat="server" SelectMethod="GetDepts" TypeName="Business.Depts" OldValuesParameterFormatString="original_{0}"><SelectParameters>
<asp:ControlParameter PropertyName="Text" Type="String" Name="Dept_cd" ControlID="txtDeptCd"></asp:ControlParameter>
<asp:ControlParameter PropertyName="Text" Type="String" Name="Dept_name" ControlID="txtDeptName"></asp:ControlParameter>
<asp:ControlParameter PropertyName="SelectedValue" Type="String" Name="Dept_class" ControlID="selDeptClass"></asp:ControlParameter>
<asp:ControlParameter PropertyName="SelectedValue" Type="String" Name="pj_cd" ControlID="selParent"></asp:ControlParameter>
</SelectParameters>
</asp:ObjectDataSource> <asp:ObjectDataSource id="ObjectDataSource1" runat="server" SelectMethod="GetParentDeptname" TypeName="Business.Depts" OldValuesParameterFormatString="original_{0}"></asp:ObjectDataSource> 
</contenttemplate>
    </asp:UpdatePanel>
    &nbsp;
</asp:Content>
