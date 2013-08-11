<%@ Page Language="C#" AutoEventWireup="true" CodeFile="contractContinue.aspx.cs"
    Inherits="Contract_contractContinue" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <base target="_self" />
    <title>合同续签</title>
</head>

<script type="text/javascript" src="../Script/CommonFunction.js"></script>
<script type="text/javascript" src="../Script/ErrMessage.js"></script>
<script type="text/JavaScript">
			Date.prototype.toDateString=
function(){ 
				var strMonth=(this.getMonth()+parseInt(1)).toString() 
				var strDate=this.getDate().toString() 
				return this.getFullYear()+"/"+((strMonth.length==1)?("0"+strMonth):(strMonth))+"/"+((strDate.length==1)?("0"+strDate):(strDate)); 
			}			
			function setContractEndDate(){
				var str= document.all("txtStartDate").value;
				var contractDate = document.all("txtContractDate").value;
				var temp
				var temp2
				if((str!=null&&str!="")&&(contractDate!=null&&contractDate!="")){
					temp = new Date(Date.parse(str.replace(/-/g,"\/"))) 
					temp2 = new Date(temp.getFullYear()+parseInt(contractDate),temp.getMonth(),temp.getDate()-1) 
					document.all("txtEndDate").value = temp2.toDateString();
				}				
			}
			
			function verifyData()
	   {
	        var ans;
	        ans=verify("txtContractDate",0,0,2,13,15);
	        if(ans==false)
	            return false;
	        
            ans=verify("txtContractDate",2,0,2,13,16);
	        if(ans==false)
	            return false;	      
	   }
			
</script>

<body>
    <form id="form1" runat="server">
        <div style="text-align: center">
            <table style="width: 490px; height: 200px; border-right: #39867b 1px solid; border-top: #39867b 1px solid;
                border-left: #39867b 1px solid; border-bottom: #39867b 1px solid; text-align: center;">
                <tr>
                    <td style="background-image: url(../images/topBar_bg.gif); background-repeat: repeat-x;
                        height: 19px;" align="left" colspan="3" valign="top">
                        员工姓名：<asp:Label ID="empName" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td style="color: white; background-color: #39867b; height: 18px; width: 182px;">
                        签订日期</td>
                    <td style="color: white; background-color: #39867b; height: 18px; width: 165px;">
                        合同期（年）</td>
                    <td style="color: white; background-color: #39867b; height: 18px; width: 163px;">
                        结束日期</td>
                </tr>
                <tr>
                    <td style="width: 182px" align="center">
                        <asp:TextBox ID="txtStartDate" runat="server" Width="70px" CssClass="INPUT" Height="15px"></asp:TextBox>&nbsp;<asp:ImageButton
                            ID="ImageButton1" runat="server" ImageUrl="~/images/datetime.gif" OnClientClick="fPopUpCalendarDlg(document.all.txtStartDate);return false;" /></td>
                    <td style="width: 165px;" align="center">
                        <asp:TextBox ID="txtContractDate" runat="server" CssClass="INPUT" Height="15px" Width="42px"></asp:TextBox></td>
                    <td style="width: 163px;" align="center">
                        &nbsp;<asp:TextBox ID="txtEndDate" runat="server" CssClass="INPUT" Height="15px" Width="70px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="color: white; background-color: #39867b; height: 21px;" colspan="3">
                        备注</td>
                </tr>
                <tr>
                    <td colspan="3" style="vertical-align: top; height: 100px;">
                        <asp:TextBox ID="txtmemo" runat="server" Height="143px" TextMode="MultiLine" Width="95%"></asp:TextBox></td>
                </tr>
            </table>
        </div>
        <div style="text-align: center">
            &nbsp;<br />
            <asp:Button ID="btnSave" runat="server" Text="确定" CssClass="button" OnClick="btnSave_Click" OnClientClick='return verifyData();' />&nbsp; &nbsp;
            &nbsp;&nbsp;
            <asp:Button ID="btnClose" runat="server" Text="关闭" CssClass="button" OnClientClick="window.close();return false;" /></div>
    </form>
</body>
</html>
