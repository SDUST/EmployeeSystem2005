﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ResignationRegisterAdd.aspx.cs"
    Inherits="Resignation_ResignationRegisterAdd" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>离职登记</title>
    <base target="_self" />

    <script type="text/javascript" src="../Script/CommonFunction.js">
    
    </script>

</head>

<script language="javascript" type="text/javascript">

</script>

<body>
    <form id="form1" runat="server">
        <div style="text-align: center">
            <div title="离职登记">
                <table cellpadding="0" cellspacing="0" style="border-right: #39867b 1px solid; border-top: #39867b 1px solid;
                    border-left: #39867b 1px solid; width: 480px; border-bottom: #39867b 1px solid">
                    <tr>
                        <td align="left" colspan="4" style="background-image: url(../images/topBar_bg.gif);
                            border-bottom: #39867b 1px solid; height: 20px">
                            &nbsp; 离职登记</td>
                    </tr>
                    <tr>
                        <td align="center" style="width: 100px; height: 35px">
                            工 号</td>
                        <td align="left" style="width: 140px; height: 35px">
                            <asp:TextBox ID="txtEmpCd" runat="server" CssClass="INPUT" Height="15px" Width="90px"
                                ReadOnly="True"></asp:TextBox></td>
                        <td align="center" style="width: 100px; height: 35px">
                            姓 名</td>
                        <td align="left" style="width: 140px; height: 35px">
                            <asp:TextBox ID="txtEmpName" runat="server" CssClass="INPUT" Height="15px" Width="90px"
                                ReadOnly="True"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td align="center" style="width: 100px; height: 35px">
                            部 门</td>
                        <td align="left" style="width: 140px; height: 35px">
                            <asp:TextBox ID="txtDept" runat="server" CssClass="INPUT" Height="15px" Width="90px"
                                ReadOnly="True"></asp:TextBox></td>
                        <td align="center" style="width: 100px; height: 35px">
                            工 程</td>
                        <td align="left" style="width: 140px; height: 35px">
                            <asp:TextBox ID="txtPj" runat="server" CssClass="INPUT" Height="15px" Width="90px"
                                ReadOnly="True"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td align="center" style="width: 100px; height: 35px">
                            合同开始日</td>
                        <td align="left" style="width: 140px; height: 35px">
                            <asp:TextBox ID="txtContractBeginDate" runat="server" CssClass="INPUT" Height="15px"
                                Width="70px" ReadOnly="True"></asp:TextBox></td>
                        <td align="center" style="width: 100px; height: 35px">
                            合同结束日</td>
                        <td align="left" style="width: 140px; height: 35px">
                            <asp:TextBox ID="txtContractEndDate" runat="server" CssClass="INPUT" Height="15px"
                                Width="70px" ReadOnly="True"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td align="center" style="width: 100px; height: 35px">
                            入社日期</td>
                        <td align="left" style="width: 140px; height: 35px">
                            <asp:TextBox ID="txtJoinDate" runat="server" CssClass="INPUT" Height="15px" Width="70px"
                                ReadOnly="True"></asp:TextBox></td>
                        <td align="center" style="width: 100px; height: 35px">
                            辞职日期</td>
                        <td align="left" style="width: 140px; height: 35px">
                            <asp:TextBox ID="txtDimissionDate" runat="server" CssClass="INPUT" Height="15px"
                                Width="70px"></asp:TextBox>&nbsp;
                            <asp:ImageButton ID="ibDateTime" runat="server" ImageUrl="~/images/datetime.gif"
                                OnClientClick="fPopUpCalendarDlg(document.all.txtDimissionDate);return false;" /></td>
                    </tr>
                    <tr>
                        <td align="center" style="width: 100px; height: 65px">
                            备 注</td>
                        <td align="left" colspan="3" rowspan="2">
                            <asp:TextBox ID="txtContractMemo" runat="server" Height="119px" TextMode="MultiLine"
                                Width="371px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td align="center" style="width: 100px; height: 65px">
                        </td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" style="border-top-width: 1px; border-right: #39867b 1px solid;
                    border-left: #39867b 1px solid; width: 480px; border-top-color: #39867b; border-bottom: #39867b 1px solid">
                    <tr>
                        <td align="left" colspan="6" style="background-image: url(../images/topBar_bg.gif);
                            border-bottom: #39867b 1px solid; background-repeat: repeat; height: 20px">
                            &nbsp; 应缴物品</td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 76px; height: 35px">
                            工作卡</td>
                        <td align="center" style="width: 75px; height: 35px">
                            <asp:CheckBox ID="chkEmpCard" runat="server" /></td>
                        <td align="right" style="width: 78px; height: 35px">
                            考勤卡</td>
                        <td align="center" style="width: 76px; height: 35px">
                            <asp:CheckBox ID="chkTimeCard" runat="server" /></td>
                        <td align="right" style="width: 80px; height: 35px">
                            工资卡</td>
                        <td align="center" style="height: 35px">
                            <asp:CheckBox ID="chkWageCard" runat="server" /></td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 76px; height: 35px">
                            工具</td>
                        <td align="center" style="width: 75px; height: 35px">
                            <asp:CheckBox ID="chkTools" runat="server" /></td>
                        <td align="right" style="width: 78px; height: 35px">
                            更衣柜钥匙</td>
                        <td align="center" style="width: 76px; height: 35px">
                            <asp:CheckBox ID="chkArkKey" runat="server" /></td>
                        <td align="right" style="width: 80px; height: 35px">
                            宿舍钥匙</td>
                        <td align="center" style="height: 35px">
                            <asp:CheckBox ID="chkDormKey" runat="server" /></td>
                    </tr>
                </table>
                <br />
                <asp:Button ID="btnSave" runat="server" CssClass="button" Text="确 定" Width="50px"
                    OnClick="btnSave_Click" />
                &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;<asp:Button ID="btnClose" runat="server" CssClass="button"
                    Text="关 闭" Width="50px" OnClientClick="window.close();return false;" OnClick="btnClose_Click" />
            </div>
        </div>
    </form>
</body>
</html>
