<%@ Page Language="C#" AutoEventWireup="true" CodeFile="userLimitSetAdd.aspx.cs"
    Inherits="userLimitSetModify" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>用户权限</title>
    <base target="_self" />
</head>

<script language="JavaScript" src="../Script/CommonFunction.js" type="text/javascript">	</script>

<script language="JavaScript" src="../Script/ErrMessage.js" type="text/javascript">	</script>

<script language="javascript" type="text/javascript">
			function fsBtnSave(){
				/*验证用户编号非空*/
				if(!verify("txtUserCd",0,0,0,8,1)){
					return false;
				}
				/*验证用户编号长度*/
				if(!verify("txtUserCd",1,20,0,8,2)){
					return false;
				}
				/*验证用户编号格式*/
				if(!verify("txtUserCd",2,0,5,8,9)){
					return false;
				}
				
				/*验证用户名称非空*/
				if(!verify("txtUserName",0,0,0,8,3)){
					return false;
				}
				/*验证用户名称长度*/
				if(!verify("txtUserName",1,20,0,8,4)){
					return false;
				}
				/*验证密码非空*/
				if(!verify("txtPassword",0,0,0,8,5)){
					return false;
				}
				/*验证密码长度*/
				if(!verify("txtPassword",1,20,0,8,6)){
					return false;
				}
				/*验证确认密码非空*/
				if(!verify("txtPassAgain",0,0,0,8,7)){
					return false;
				}
				/*验证确认密码长度*/
				if(!verify("txtPassAgain",1,20,0,8,8)){
					return false;
				}

				var traget=document.getElementById("oldPass");
				if(traget != null && traget.style.display==""){
					/*验证旧密码非空*/
					if(!verify("txtPassOld",0,0,0,8,7)){
						return false;
					}
					/*验证旧密码长度*/
					if(!verify("txtPassOld",1,20,0,8,8)){
						return false;
					}
					
				}  
                
				 return true;              
			}	
           /*新增用户时隐藏旧密码*/
			function oldPassHide(){
				var oldPass = document.getElementById("PassOld");
				oldPass.style.display="none";
			}
			/*修正用户时设置登录ID与旧密码为只读*/
			function idReadOnly(){
				var txtUserCd = document.getElementById("txtUserCd");
				var txtOldPass = document.getElementById("txtPassOld");
				txtUserCd.readOnly = true;
				txtUserCd.style.backgroundColor = 'gainsboro';
				
			}
			/*新增用户时密码的输入校验*/
			function passCheck(){
				var pass = document.getElementById("txtPassword");
				var passCheck = document.getElementById("txtPassAgain");
				if(pass.value != passCheck.value){
					alert(getMsg("8","0"));
					return false;
				}
			}

</script>

<body>
    <form id="frmMain" runat="server">
        <div>
            <center title="用户权限－－网页对话框">
                <table cellpadding="0" cellspacing="0" style="border-right: teal 1px solid; border-top: teal 1px solid;
                    border-left: teal 1px solid; width: 333px; border-bottom: teal 1px solid;">
                    <tr>
                        <td colspan="3" style="background-color: #669999; height: 22px;" align="left">
                            <span style="color: #ffffff">
                                <asp:Label ID="lblTitle" runat="server" Text="Label"></asp:Label></span></td>
                    </tr>
                    <tr style="font-size: 10pt">
                        <td style="width: 131px; height: 31px; text-align: right">
                            <span><span>登录ID:&nbsp; </span></span>&nbsp;&nbsp;</td>
                        <td colspan="2" style="height: 31px" align="left">
                            <asp:TextBox ID="txtUserCd" runat="server" Width="128px" CssClass="INPUT" MaxLength="20"></asp:TextBox></td>
                    </tr>
                    <tr style="font-size: 9pt">
                        <td style="width: 131px; height: 31px; text-align: right">
                            <span>用户名:</span><span style="font-size: 10pt"> &nbsp; &nbsp; </span>
                        </td>
                        <td colspan="2" style="height: 31px; font-size: 10pt;" align="left">
                            <asp:TextBox ID="txtUserName" runat="server" MaxLength="20" CssClass="INPUT" Width="128px"></asp:TextBox></td>
                    </tr>
                    <tr id="PassOld" style="font-size: 10pt">
                        <td style="width: 131px; height: 100%; text-align: right">
                            &nbsp;旧密码: &nbsp; &nbsp;
                        </td>
                        <td colspan="2" style="height: 31px" align="left">
                            <asp:TextBox ID="txtPassOld" runat="server" Width="128px" MaxLength="20" CssClass="readonly"
                                ReadOnly="True"></asp:TextBox></td>
                    </tr>
                    <tr style="font-size: 9pt">
                        <td style="width: 131px; height: 31px; text-align: right">
                            <span style="font-size: 10pt">密码:</span> &nbsp; &nbsp;</td>
                        <td colspan="2" style="height: 31px; font-size: 9pt;" align="left">
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Width="128px" MaxLength="20"
                                CssClass="INPUT"></asp:TextBox></td>
                    </tr>
                    <tr style="font-size: 9pt">
                        <td style="width: 131px; height: 31px; text-align: right">
                            <span>确认密码: &nbsp;</span> &nbsp;
                        </td>
                        <td colspan="2" style="height: 31px" align="left">
                            <asp:TextBox ID="txtPassAgain" runat="server" TextMode="Password" Width="128px" MaxLength="20"
                                CssClass="INPUT"></asp:TextBox>
                            &nbsp; &nbsp;&nbsp;
                        </td>
                    </tr>
                    <tr style="font-size: 9pt">
                        <td colspan="3" style="height: 25px; text-align: center">
                            <asp:Button ID="btnSave" runat="server" CssClass="button" Font-Size="Small" Text="提 交"
                                Width="54px" OnClick="btnSave_Click" />
                            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<asp:Button ID="btnCancel" runat="server"
                                CssClass="button" Font-Size="Small" OnClientClick="window.close();return false;"
                                Text="关 闭" Width="54px" /></td>
                    </tr>
                </table>
            </center>
        </div>
    </form>
</body>
</html>
