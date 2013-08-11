<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ErrorPage.aspx.cs" Inherits="ErrorPage" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script language="javascript" type="text/javascript">
        function CheckError_onclick() {
　        var chk = document.getElementById("CheckError");
　        var divError = document.getElementById("errorMsg");
　        if(chk.checked)
　        {
            divError.style.display = "inline";
　        }
　        else
　        {
            divError.style.display = "none";
　        }
        }
    </script>
    <div style="MARGIN-TOP: 10px; MARGIN-LEFT: 5px">
				<table width="800px">
					<tr class="topbg" height="22">
						<td align="left">系统发生错误</td>
					</tr>
				</table>
				<table width="800px">
					<tr>
						<td style="WIDTH: 10%"></td>
						<td vAlign="top"><br>
							<br>
							<input style="width:100px; height:22px;" id="btnBack" onclick="history.go(-1);" type="button" value="后退">
							&nbsp; &nbsp; &nbsp; &nbsp; <input style="width:100px; height:22px;" id="btnLogin" onclick="location='Login.aspx';" type="button"
								value="重新登录">
							<br>
							<br>
							<input id="CheckError" onclick="CheckError_onclick();" type="checkbox">错误详细信息
							<br>
							<br>
							<div id="errorMsg" style="DISPLAY: none">错误画面：&nbsp;<asp:label id="ErrorUrlLabel" runat="server"></asp:label>
								<br>
								<br>
								错误详细：&nbsp;<asp:label id="ErrorMsgLabel" runat="server"></asp:label>
							</div>
						</td>
					</tr>
				</table>
			</div>

</asp:Content>
