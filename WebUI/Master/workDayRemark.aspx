<%@ Page Language="C#" AutoEventWireup="true" CodeFile="workDayRemark.aspx.cs" Inherits="Master_workDayRemark" Buffer="false" Theme="MainStyle" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>工作日备注</title>
    <base target=_self />
    <script type="text/javascript" src="/Script/CommonFunction.js"></script>
    <script language="javascript" type="text/javascript">
            resizeTo(300,300);

			function closeCheck(){
				if(confirm(getMsg(13,2))){
					window.close();
				}else{
					return false;
				}
			}
			
			function commitCheck(){
			    //if(document.all("txtDayMemo").value==null||document.all("txtDayMemo").value==""){
				//	alert(getMsg(13,23));
				//	return false;
				//}else 
				if(document.all("txtDayMemo").value!=null||document.all("txtDayMemo").value!=""){
					var intLen = document.all("txtDayMemo").value.length;
					if(intLen>50){
						alert("备注只能输入50个字符，请重新填写备注！");
						document.all("txtDayMemo").focus();
						return false;
					}
				}else if(!confirm(getMsg(13,22))){
					return false;
				}
			}
		</script>
</head>
<body>
    <form id="form1" runat="server">
    <table class="border" cellSpacing="1" cellPadding="1" align="center">
				<tr class="title">
					<td style="HEIGHT: 22px"><asp:label id="lblTitle" runat="server" Width="200px"></asp:label></td>
				</tr>
				<tr>
					<td align="left">&nbsp;日期类型&nbsp;
						<asp:dropdownlist id="selFlag" runat="server" Width="140px">
							<asp:ListItem Selected="True"></asp:ListItem>
							<asp:ListItem Value="平日">平日</asp:ListItem>
							<asp:ListItem Value="公休日">公休日</asp:ListItem>
							<asp:ListItem Value="法定节假日">法定节假日</asp:ListItem>
						</asp:dropdownlist>
					</td>
				</tr>
				<tr>
					<td style="WIDTH: 200px" align="left">&nbsp;备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
				</tr>
				<tr>
					<td style="WIDTH: 200px"><asp:textbox id="txtDayMemo" runat="server" Width="232px" Height="102px" TextMode="MultiLine"
							MaxLength="50"></asp:textbox></td>
				</tr>
			</table>
			<table align="center" border="0" style="width: 94px; height: 1px">
				<tr height="20">
				</tr>
				<tr align="center" height="20">
					<td><INPUT class="button" id="btnSave" type="button" value="确定" name="button" runat="server" onserverclick="btnSave_ServerClick"></td>
					<td><input class="button" id="btnClose" onclick="window.close();" type="button" value="关闭" name="Submit"></td>
				</tr>
			</table>
    </form>
</body>
</html>
