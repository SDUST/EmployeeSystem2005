<%@ Page Language="C#" AutoEventWireup="true" CodeFile="dutySetAdd.aspx.cs" Inherits="Master_dutySetAdd" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script language="JavaScript" src="../Script/CommonFunction.js" type="text/javascript">	</script>

<script language="JavaScript" src="../Script/ErrMessage.js" type="text/javascript">	</script>

<script language="javascript" type="text/javascript">
			function fsBtnSave(){
				/*验证职务编号非空*/
				if(!verify("txtDutyCd",0,0,0,7,0)){
					return false;
				}
				/*验证职务编号长度*/
				if(!verify("txtDutyCd",1,20,0,7,1)){
					return false;
				}
				/*验证职务编号输入规则*/
				if(!verify("txtDutyCd",2,0,5,7,4)){
					return false;
				}
				
				/*验证职务名称非空*/
				if(!verify("txtDutyName",0,0,0,7,2)){
					return false;
				}
				/*验证职务名称长度*/
				if(!verify("txtDutyName",1,20,0,7,3)){
					return false;
				} 
				
				return true;       
			}			
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>添加新职务</title>
    <base target="_self" />
</head>
<body style="text-align: center">
    <form id="frmMain" runat="server">
        <table style="width: 450px; height: 108px; border-right: #339933 1px solid; border-top: #339933 1px solid;
            border-left: #339933 1px solid; border-bottom: #339933 1px solid;">
            <tr>
                <td colspan="3" style="background-image: url(../images/topBar_bg.gif)">
                    职务新增</td>
            </tr>
            <tr>
                <td style="width: 160px; height: 21px; text-align: center">
                    职务番号</td>
                <td colspan="2" align="left">
                    <asp:TextBox ID="txtDutyCd" runat="server" CssClass="INPUT" MaxLength="20"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="width: 160px; text-align: center">
                    职务名称</td>
                <td colspan="2" align="left">
                    <asp:TextBox ID="txtDutyName" runat="server" CssClass="INPUT" MaxLength="20"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="3" style="text-align: center">
                    <br />
                    &nbsp;<asp:Button ID="btnSave" runat="server" CssClass="button" OnClick="btnSave_Click1"
                        OnClientClick="return fsBtnSave();" Text="提交" />
                    <asp:Button ID="btnClose" runat="server" CssClass="button" OnClientClick="window.close();return false;"
                        Text="关闭" /></td>
            </tr>
        </table>
    </form>
</body>
</html>
