<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>登录页面</title>
    <style type="text/css">
BODY {
    FONT-SIZE: 9pt; MARGIN: 0px; OVERFLOW: hidden; COLOR: #e8e8e8; FONT-FAMILY: "宋体"; BACKGROUND-COLOR: #0066cc
}
.tabbk {
    BORDER-TOP-WIDTH: 1px; BORDER-LEFT-WIDTH: 1px; BORDER-LEFT-COLOR: #ffffff; BORDER-TOP-COLOR: #ffffff; BORDER-BOTTOM: #ffffff 1px solid; BORDER-RIGHT-WIDTH: 1px; BORDER-RIGHT-COLOR: #ffffff
}
.tabgbk2 {
    BORDER-TOP: #ffffff 1px solid; BORDER-LEFT-WIDTH: 1px; BORDER-LEFT-COLOR: #ffffff; BORDER-BOTTOM-WIDTH: 1px; BORDER-BOTTOM-COLOR: #ffffff; BORDER-RIGHT-WIDTH: 1px; BORDER-RIGHT-COLOR: #ffffff
}
A:link {
    FONT-SIZE: 9pt; COLOR: #ffffff; FONT-FAMILY: "宋体"; TEXT-DECORATION: none
}
A:visited {
    FONT-SIZE: 9pt; COLOR: #ffffff; FONT-FAMILY: "宋体"; TEXT-DECORATION: none
}
A:hover {
    FONT-WEIGHT: bolder; FONT-SIZE: 9pt; COLOR: #ffffff; FONT-FAMILY: "宋体"; TEXT-DECORATION: none
}
A:active {
    FONT-FAMILY: "宋体"; TEXT-DECORATION: none; D: #ffffff
}
.kuan {
    BORDER-RIGHT: #000000 1px solid; BORDER-TOP: #000000 1px solid; FONT-SIZE: 9pt; BACKGROUND-IMAGE: url(images/bbg.gif); BORDER-LEFT: #000000 1px solid; COLOR: #000000; BORDER-BOTTOM: #000000 1px solid; FONT-FAMILY: "宋体"
}
.kuan2 {
    BORDER-RIGHT: #666666 1px solid; BORDER-TOP: #eaeaea 1px solid; FONT-SIZE: 10pt; BORDER-LEFT: #eaeaea 1px solid; BORDER-BOTTOM: #666666 1px solid; BACKGROUND-COLOR: #eaeaea; height:18px
}
TD {
    FONT-SIZE: 9pt; COLOR: #e8e8e8; FONT-FAMILY: "宋体"
}
</style>
</head>
<body>
    <form id="myForm" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <table class="tabbk" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td width="943px" bgcolor="#0066cc" height="184">
                </td>
            </tr>
        </table>
        <table height="395px" cellspacing="0" cellpadding="0" width="100%" background="images/jian.gif"
            border="0">
            <tr>
                <td valign="top">
                    <table cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr>
                            <td valign="top">
                                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                    <tr>
                                        <td style="width: 77px">
                                        </td>
                                        <td height="146" style="width: 194px">
                                            <img src="images/Logo.gif" /></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 77px; height: 18px;">
                                        </td>
                                        <td style="width: 194px; height: 18px;">
                                            <div align="center">
                                                &nbsp;</div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 77px">
                                        </td>
                                        <td style="width: 194px">
                                            <div align="center">
                                                &nbsp;</div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 14px; width: 77px;">
                                        </td>
                                        <td style="height: 14px; width: 194px;">
                                            <div align="center">
                                                最佳访问分辨率：1024 X 768</div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td valign="top" width="57%">
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                            <tr>
                                                <td style="height: 151px">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 27px">
                                                    <div align="center">
                                                        &nbsp;<font color="#FFFFFF"><span id="lblPagetext">请输入您的用户名和密码后登陆</span></font></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center">
                                                    <table cellspacing="0" cellpadding="0" width="100%" border="0" height="60">
                                                        <tr>
                                                            <td style="height: 24px; width: 242px;">
                                                                <div align="right">
                                                                    <font color="#FFFFFF">登录ID：</font>
                                                            </td>
                                                            <td style="height: 24px; text-align: left;">
                                                                <asp:TextBox ID="txtUser" runat="server" Width="100px" OnTextChanged="txtUser_TextChanged"
                                                                    AutoPostBack="True" MaxLength="20"></asp:TextBox>
                                                                <asp:Label ID="lblUser" runat="server" ForeColor="Yellow" Text="登录ID不存在！" Visible="False"></asp:Label>
                                                                <asp:Label ID="lblUserCd" runat="server" ForeColor="Yellow" Text="登录ID不能为空！" Visible="False"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="height: 24px; width: 242px;">
                                                                <div align="right">
                                                                    <font color="#FFFFFF">密 码：</font>
                                                            </td>
                                                            <td style="height: 24px; text-align: left;">
                                                                <asp:TextBox ID="txtPwd" runat="server" Width="100px" TextMode="Password" MaxLength="20"></asp:TextBox>
                                                                <asp:Label ID="lblPwd" runat="server" ForeColor="Yellow" Text="密码不能为空！" Visible="False"></asp:Label>
                                                        </tr>
                                                        <tr>
                                                            <td height="10" style="width: 242px">
                                                            </td>
                                                            <td>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    &nbsp;
                                                    <asp:Label ID="lblLogin" runat="server" ForeColor="Yellow" Text="您输入的登录ID或密码错误,请重新输入！"
                                                        Visible="False"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td align="center" style="height: 23px">
                                                    <asp:Button ID="btnLogin" runat="server" CssClass="kuan2" Text="登陆系统" OnClick="btnLogin_Click" />
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td style="height: 13px; text-align: center;">
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table height="100%" cellspacing="0" cellpadding="0" width="100%" align="center"
            bgcolor="#0066cc" border="0">
            <tr>
                <td width="287" height="23">
                </td>
                <td width="295">
                </td>
                <td width="423">
                </td>
            </tr>
            <tr>
                <td height="38">
                </td>
                <td>
                </td>
                <td rowspan="2">
                    <p>
                        ·<span class="hui1">版权所有 Presoft 有限公司<br>
                        </span>
                        <br>
                        &nbsp·<span class="hui1">技术支持 Presoft 有限公司</span>
                    </p>
                </td>
            </tr>
            <tr>
                <td height="1">
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td height="18">
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
