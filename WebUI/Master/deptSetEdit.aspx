<%@ Page Language="C#" AutoEventWireup="true" CodeFile="deptSetEdit.aspx.cs" Inherits="DepartmentDetail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <script type="text/javascript" src="../Script/CommonFunction.js"></script>

    <script language="JavaScript" src="../Script/ErrMessage.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

            function fsBtnSave(){
                if(!verify("txtDeptCd",0,0,0,4,2)){
                return false;
                } 
                 
                if(!verify("txtDeptCd",2,0,5,4,3)){
			    return false;
			    }
			    
                if(!verify("txtDeptName",0,0,0,4,4)){
			    return false;
			    } 
			    
                if(!verify("txtDeptName",2,0,6,4,5)){
			    return false;
			    } 
			 
		     }				
    </script>

    <title>编辑部门信息</title>
    <base target="_self" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table align="center" border="0" cellpadding="0" cellspacing="0" class="border">
                <tr class="title">
                    <td width="96%" style="height: 20px; background-image: url(../images/topBar_bg.gif);">
                        部门设置<font color="#000000">&nbsp;</font></td>
                </tr>
                <tr>
                    <td>
                        <table align="center" border="0" cellpadding="2" cellspacing="1" width="100%">
                            <tr class="tdbg">
                                <td align="center" height="30" width="70">
                                    部门编号</td>
                                <td>
                                    <asp:TextBox ID="txtDeptCd" runat="server" CssClass="INPUT" Width="100px" ReadOnly="True"></asp:TextBox></td>
                                <td align="center" width="70">
                                    部门名称</td>
                                <td style="width: 118px">
                                    <asp:TextBox ID="txtDeptName" runat="server" CssClass="INPUT" Width="100px"></asp:TextBox></td>
                            </tr>
                            <tr class="tdbg">
                                <td align="center" height="30">
                                    管理部门</td>
                                <td>
                                    <asp:DropDownList ID="selParentDeptCd" runat="server" Width="100px" DataSourceID="odsGetDeptname"
                                        DataTextField="dept_name" DataValueField="dept_cd" OnDataBound="selParentDeptCd_DataBound">
                                    </asp:DropDownList></td>
                                <td align="center">
                                    区 &nbsp; &nbsp;分</td>
                                <td style="width: 118px">
                                    <asp:DropDownList ID="selDeptClass" runat="server" Width="100px" OnDataBound="selDeptClass_DataBound">
                                        <asp:ListItem Value="0">部门</asp:ListItem>
                                        <asp:ListItem Value="1">工程</asp:ListItem>
                                        <asp:ListItem Value="2">课</asp:ListItem>
                                        <asp:ListItem Value="3">班组</asp:ListItem>
                                    </asp:DropDownList></td>
                            </tr>
                            <tr class="tdbg">
                                <td align="center" height="30">
                                    担当</td>
                                <td>
                                    <asp:TextBox ID="txtManager" runat="server" CssClass="INPUT" Width="100px"></asp:TextBox></td>
                                <td align="center">
                                </td>
                                <td style="width: 118px">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table border="0" height="30" width="100%">
                <tr>
                    <td align="center">
                        <br />
                        &nbsp;<asp:Button ID="btnSave" runat="server" CssClass="button" Text="确定" Width="60px"
                            OnClientClick="return fsBtnSave();" OnClick="btnSave_Click" Height="18px" />
                        &nbsp; &nbsp; &nbsp;&nbsp;
                        <asp:Button ID="btnClose" runat="server" CssClass="button" Text="关闭" Width="60px"
                            OnClientClick="window.close();return false;" Height="19px" />&nbsp;<asp:ObjectDataSource ID="odsGetDeptname"
                                runat="server" SelectMethod="Getdeptname" TypeName="Business.Depts" OldValuesParameterFormatString="original_{0}">
                            </asp:ObjectDataSource>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
