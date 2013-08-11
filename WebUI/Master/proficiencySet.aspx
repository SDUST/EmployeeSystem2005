<%@ Page Language="C#" AutoEventWireup="true" CodeFile="proficiencySet.aspx.cs" Inherits="proficiencySet"
    Title="保有工数熟练度设置" %>
<script language="JavaScript" src="../Script/CommonFunction.js" type="text/javascript">	</script>

<script language="JavaScript" src="../Script/ErrMessage.js" type="text/javascript">	</script>

<script language="javascript" type="text/javascript">
			function fsBtnSave(){
				/*验证熟练度为整数或小数*/
				if(!verify("txtFiveYear",0,0,0,13,30)){
					return false;
				}
				if(!verify("txtFourYear",0,0,0,13,30)){
					return false;
				}
				if(!verify("txtThreeYear",0,0,0,13,30)){
					return false;
				}
				if(!verify("txtTwoYear",0,0,0,13,30)){
					return false;
				}
				if(!verify("txtOneYear",0,0,0,13,30)){
					return false;
				}
				if(!verify("txtSixMonth",0,0,0,13,30)){
					return false;
				}
				if(!verify("txtThreeMonth",0,0,0,13,30)){
					return false;
				}
				if(!verify("txtTwoMonth",0,0,0,13,30)){
					return false;
				}
				if(!verify("txtOneMonth",0,0,0,13,30)){
					return false;
				}
				if(!verify("txtZeroMonth",0,0,0,13,30)){
					return false;
				}
				if(!verify("txtPLead",0,0,0,13,30)){
					return false;
				}
				if(!verify("txtSLead",0,0,0,13,30)){
					return false;
				}
				if(!verify("txtOther",0,0,0,13,30)){
					return false;
				}

				
				return true;       
			}			
</script>
<html>
<head runat="server">
    <title>熟练度设置</title>
    <base target="_self" />
</head>
<body>
    <form runat="server" id="form1">
        <table align="center" border="0" cellpadding="2" cellspacing="0" class="border" width="90%">
            <tr class="title">
                <td align="left" class="0" style="height: 20px; background-image: url(../images/topBar_bg.gif); width: 700px; text-align: justify;">
                    <span class="style3">熟练度设置 &nbsp;</span>&nbsp;
                </td>
                <td align="right" class="0" style="background-image: url(../images/topBar_bg.gif);
                    width: 700px; height: 20px; text-align: right">
                    <asp:Label ID="txtPjName" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="2" style="height: 147px">
                    <table align="center" border="0" cellpadding="0" cellspacing="0" class="border" width="700">
                        <tr class="topbg">
                            <td align="center" class="topbg" width="157" style="height: 20px">
                                作业经验时间
                            </td>
                            <td align="center" class="topbg" width="110" style="height: 20px">
                                五年以上</td>
                            <td align="center" class="topbg" width="110" style="height: 20px">
                                四年以上
                            </td>
                            <td align="center" class="topbg" width="110" style="height: 20px">
                                三年以上
                            </td>
                            <td align="center" class="topbg" width="110" style="height: 20px">
                                两年以上</td>
                            <td align="center" width="110" style="height: 20px">
                                一年以上</td>
                        </tr>
                        <tr class="border">
                            <td align="center" class="border" width="157" style="height: 20px">
                                熟练度
                            </td>
                            <td align="center" class="border" width="110" style="height: 20px">
                                <asp:TextBox ID="txtFiveYear" runat="server" CssClass="input" Width="70px" MaxLength="4"></asp:TextBox>
                            </td>
                            <td align="center" class="border" width="110" style="height: 20px">
                                <asp:TextBox ID="txtFourYear" runat="server" CssClass="input" Width="70px" MaxLength="4"></asp:TextBox>
                            </td>
                            <td align="center" class="border" width="110" style="height: 20px">
                                <asp:TextBox ID="txtThreeYear" runat="server" CssClass="input" Width="70px" MaxLength="4"></asp:TextBox>
                            </td>
                            <td align="center" class="border" width="110" style="height: 20px">
                                <asp:TextBox ID="txtTwoYear" runat="server" CssClass="input" Width="70px" MaxLength="4"></asp:TextBox>
                            </td>
                            <td align="center" width="110" style="height: 20px">
                                <asp:TextBox ID="txtOneYear" runat="server" CssClass="input" Width="70px" MaxLength="4"></asp:TextBox>
                            </td>
                        </tr>
                        <tr class="topbg">
                            <td align="center" class="topbg" height="20">
                                作业经验时间
                            </td>
                            <td align="center" height="20" width="110">
                                6个月以上～1年
                            </td>
                            <td align="center" height="20" width="110">
                                3个月以上～6个月
                            </td>
                            <td align="center" height="20" width="110">
                                2个月以上～3个月
                            </td>
                            <td align="center" height="20" width="110">
                                1个月以上～2个月</td>
                            <td align="center" height="20" width="110">
                                0～1个月
                            </td>
                        </tr>
                        <tr>
                            <td align="center" class="border" style="height: 20px">
                                熟练度
                            </td>
                            <td align="center" class="border" style="height: 20px" width="110">
                                <asp:TextBox ID="txtSixMonth" runat="server" CssClass="input" Width="70px" MaxLength="4"></asp:TextBox>
                            </td>
                            <td align="center" class="border" style="height: 20px" width="110">
                                <asp:TextBox ID="txtThreeMonth" runat="server" CssClass="input" Width="70px" MaxLength="4"></asp:TextBox>
                            </td>
                            <td align="center" class="border" style="height: 20px" width="110">
                                <asp:TextBox ID="txtTwoMonth" runat="server" CssClass="input" Width="70px" MaxLength="4"></asp:TextBox>
                            </td>
                            <td align="center" class="border" style="height: 20px" width="110">
                                <asp:TextBox ID="txtOneMonth" runat="server" CssClass="input" Width="70px" MaxLength="4"></asp:TextBox>
                            </td>
                            <td align="center" class="border" style="height: 20px" width="110">
                                <asp:TextBox ID="txtZeroMonth" runat="server" CssClass="input" Width="70px" MaxLength="4"></asp:TextBox>
                            </td>
                        </tr>
                        <tr class="topbg">
                            <td align="center" class="topbg" height="20">
                                作业经验时间
                            </td>
                            <td align="center" height="20" width="110">
                                工程长
                            </td>
                            <td align="center" height="20" width="110">
                                班长
                            </td>
                            <td align="center" height="20" width="110">
                                作业准备及其他</td>
                        </tr>
                        <tr>
                            <td align="center" class="border" style="height: 22px">
                                熟练度
                            </td>
                            <td align="center" class="border" width="110" style="height: 22px">
                                <asp:TextBox ID="txtPLead" runat="server" CssClass="input" Width="70px" MaxLength="4"></asp:TextBox>
                            </td>
                            <td align="center" class="border" width="110" style="height: 22px">
                                <asp:TextBox ID="txtSLead" runat="server" CssClass="input" Width="70px" MaxLength="4"></asp:TextBox>
                            </td>
                            <td align="center" class="border" width="110" style="height: 22px">
                                <asp:TextBox ID="txtOther" runat="server" CssClass="input" Width="70px" MaxLength="4"></asp:TextBox>
                            </td>
                            <td align="left" width="154" style="height: 22px">
                                </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table align="center">
            <tr align="center">
                <td style="width: 30px">
                    <asp:Button ID="btnSave" runat="server" CssClass="button" Text="保存" Width="50px"
                        OnClientClick="return fsBtnSave();" OnClick="btnSave_Click" />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
