<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DetailInfo.aspx.cs" Inherits="empDetailInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>员工详细信息</title>
    <script type="text/javascript"  src="../Script/CommonFunction.js"></script>
</head>
<body>

    <form id="form1" runat="server">
    <div>
        <table cellpadding="0" cellspacing="0" style="width: 750px">
            <tr>
                <td colspan="3" style="height: 180px; width: 750px;" valign="top">
                    <table cellpadding="0" cellspacing="0" style="border-right: #339999 1px solid; border-top: #339999 1px solid;
                        border-left: #339999 1px solid; border-bottom: #339999 1px solid; height: 152px"
                        width="100%">
                        <tr style="background-image: url(../images/topBar_bg.gif)">
                            <td colspan="7" style="height: 22px">
                                <span style="font-size: 10pt; background-repeat: repeat-x">基本资料</span></td>
                        </tr>
                        <tr>
                            <td style="width: 75px; height: 23px">
                    姓 &nbsp; &nbsp; &nbsp;&nbsp; 名</td>
                            <td style="width: 105px; height: 23px">
                                <asp:TextBox ID="txtEmpName" runat="server" MaxLength="20" Width="70px" ReadOnly="True"></asp:TextBox></td>
                            <td style="width: 77px; height: 23px">
                    性 &nbsp; &nbsp; &nbsp; &nbsp;别</td>
                            <td style="width: 126px; height: 23px">
                                <asp:TextBox ID="txtSex" runat="server" Width="50px"></asp:TextBox></td>
                            <td style="width: 79px; height: 23px">
                    出生日期</td>
                            <td style="width: 104px; height: 23px">
                                <asp:TextBox ID="txtBirthday" runat="server" ReadOnly="True" Width="70px"></asp:TextBox>
                            </td>
                            <td rowspan="5" style="text-align: center">
                                <span style="font-size: 10pt; font-family: 宋体">&nbsp;</span><asp:Image ID="Image1"
                                    runat="server" Height="110px" Width="80px" />&nbsp;</td>
                        </tr>
                        <tr style="font-size: 9pt; font-family: Times New Roman">
                            <td style="width: 75px; height: 24px">
                    身份证号</td>
                            <td style="width: 105px; height: 24px">
                                <asp:TextBox ID="txtIDCard" runat="server" MaxLength="18" Width="105px" ReadOnly="True"></asp:TextBox></td>
                            <td style="width: 77px; height: 24px">
                    婚姻状态</td>
                            <td style="width: 126px; height: 24px">
                                <asp:TextBox ID="txtMarry" runat="server" Width="50px"></asp:TextBox></td>
                            <td style="width: 79px; height: 24px">
                                <span>
                    最高学历</span></td>
                            <td style="font-size: 10pt; width: 104px; font-family: 宋体; height: 24px">
                                <asp:TextBox ID="txtDiploma" runat="server" Width="60px"></asp:TextBox></td>
                        </tr>
                        <tr style="font-size: 9pt; font-family: Times New Roman">
                            <td style="width: 75px">
                    籍贯省份</td>
                            <td style="width: 105px">
                                <asp:TextBox ID="txtHomeplace" runat="server" ReadOnly="True" Width="70px"></asp:TextBox></td>
                            <td style="width: 77px">
                    民 &nbsp; &nbsp; &nbsp;&nbsp; 族</td>
                            <td style="width: 126px">
                                <asp:TextBox ID="txtNation" runat="server" Width="100px"></asp:TextBox></td>
                            <td style="width: 79px">
                    邮 &nbsp; &nbsp; &nbsp;&nbsp; 编</td>
                            <td style="width: 104px">
                                <asp:TextBox ID="txtPostalcode" runat="server" MaxLength="6" Width="70px" ReadOnly="True"></asp:TextBox></td>
                        </tr>
                        <tr style="font-size: 9pt; font-family: Times New Roman">
                            <td style="width: 75px">
                    联 系 人</td>
                            <td style="width: 105px">
                                <asp:TextBox ID="txtLinkman" runat="server" MaxLength="20" Width="70px" ReadOnly="True"></asp:TextBox></td>
                            <td style="width: 77px">
                    联系电话</td>
                            <td style="width: 126px">
                                <asp:TextBox ID="txtPhone" runat="server" MaxLength="20" Width="70px" ReadOnly="True"></asp:TextBox></td>
                            <td style="width: 79px">
                    电子邮件</td>
                            <td style="width: 104px">
                                <asp:TextBox ID="txtEmail" runat="server" MaxLength="20" Width="90px" ReadOnly="True"></asp:TextBox></td>
                        </tr>
                        <tr style="font-size: 9pt; font-family: Times New Roman">
                            <td style="width: 75px">
                    合同区分</td>
                            <td style="width: 105px">
                                <asp:TextBox ID="txtContract_class" runat="server" Width="90px"></asp:TextBox></td>
                            <td style="width: 77px">
                    家庭住址</td>
                            <td style="width: 126px">
                                <asp:TextBox ID="txtAddress" runat="server" MaxLength="20" Width="150px" ReadOnly="True"></asp:TextBox></td>
                            <td colspan="2">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                </td>
            </tr>
            <tr style="font-size: 9pt; font-family: Times New Roman">
                <td colspan="3" style="width: 750px">
                    <table cellpadding="2" cellspacing="1" style="border-right: #009999 1px solid; border-top: #009999 1px solid;
                        border-left: #009999 1px solid; border-bottom: #009999 1px solid; height: 60px"
                        width="100%">
                        <tr style="background-image: url(../images/topBar_bg.gif)">
                            <td colspan="9" style="height: 22px; text-align: left">
                                <span style="border-bottom-width: 1px; border-bottom-color: #39867b">公司资料</span></td>
                        </tr>
                        <tr>
                            <td style="width: 67px; height: 16px; text-align: left">
                    编 &nbsp; &nbsp; &nbsp;&nbsp; 号</td>
                            <td style="width: 97px; height: 16px">
                                <asp:TextBox ID="txtEmpCd" runat="server" MaxLength="20"
                                    Width="70px" ReadOnly="True"></asp:TextBox></td>
                            <td style="width: 67px; height: 16px; text-align: left">
                    卡编号</td>
                            <td style="width: 115px; height: 16px">
                                <asp:TextBox ID="txtTimecard" runat="server" MaxLength="20" Width="70px" ReadOnly="True"></asp:TextBox></td>
                            <td style="width: 72px; height: 16px; text-align: left">
                    部 &nbsp; &nbsp; &nbsp; 门</td>
                            <td style="width: 52px; height: 16px; text-align: left">
                                <asp:TextBox ID="txtDept" runat="server" Width="100px"></asp:TextBox></td>
                            <td style="width: 69px; height: 16px; text-align: left">
                    工 &nbsp; &nbsp; &nbsp; 程</td>
                            <td colspan="2" style="width: 79px; height: 16px; text-align: left">
                                <asp:TextBox ID="txtPj" runat="server" Width="85px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 67px; text-align: left">
                    入职时间</td>
                            <td style="width: 97px">
                                <asp:TextBox ID="txtJoinDate" runat="server" ReadOnly="True" Width="70px"></asp:TextBox>
                            </td>
                            <td style="width: 67px; text-align: left">
                    职 务</td>
                            <td style="width: 115px">
                                <asp:TextBox ID="txtDutyName" runat="server" ReadOnly="True" Width="70px"></asp:TextBox>
                            </td>
                            <td style="width: 72px; text-align: left">
                    技术等级</td>
                            <td style="width: 52px; text-align: left">
                                <asp:TextBox ID="txtLevel" runat="server" Width="70px" ReadOnly="True"></asp:TextBox></td>
                            <td style="width: 69px; text-align: left">
                    员工区分</td>
                            <td colspan="2" style="width: 79px; text-align: left">
                                <asp:TextBox ID="txtEmpClass" runat="server" Width="85px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 67px; height: 25px; text-align: left">
                    合同起始日</td>
                            <td style="width: 97px; height: 25px">
                                <asp:TextBox ID="txtStartDate" runat="server" ReadOnly="True" Width="70px"></asp:TextBox>
                            </td>
                            <td style="width: 67px; height: 25px; text-align: left">
                    合同结束日</td>
                            <td style="width: 115px; height: 25px">
                                <asp:TextBox ID="txtEndDate" runat="server" ReadOnly="True" Width="70px"></asp:TextBox>
                            </td>
                            <td style="width: 72px; height: 25px; text-align: left">
                    入社前工龄</td>
                            <td style="width: 52px; height: 25px; text-align: left">
                                <asp:TextBox ID="txtForwardWorkYear" runat="server" Width="70px" ReadOnly="True"></asp:TextBox></td>
                            <td style="width: 69px; height: 25px; text-align: left">
                    入社后工龄</td>
                            <td colspan="2" style="width: 79px; height: 25px; text-align: left">
                                <asp:TextBox ID="txtAfterWorkYear" runat="server" Width="70px" ReadOnly="True"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 67px; text-align: left">
                    宿 &nbsp; &nbsp; &nbsp;&nbsp; 舍</td>
                            <td style="width: 97px">
                                <asp:TextBox ID="txtDorm" runat="server" MaxLength="20" Width="70px" ReadOnly="True"></asp:TextBox></td>
                            <td style="width: 67px; text-align: left">
                    床 位</td>
                            <td style="width: 115px">
                                <asp:TextBox ID="txtBed" runat="server" MaxLength="20" Width="70px" ReadOnly="True"></asp:TextBox></td>
                            <td style="width: 72px; text-align: left">
                    备 注</td>
                            <td colspan="4" style="text-align: left">
                                <asp:TextBox ID="txtMemo" runat="server" MaxLength="50" Width="168px" ReadOnly="True"></asp:TextBox></td>
                        </tr>
                    </table>
                    &nbsp; &nbsp; &nbsp;
                </td>
            </tr>
            <tr style="font-size: 9pt; font-family: Times New Roman">
                <td align="center" colspan="3" style="width: 750px">
        <asp:Button ID="Button1" runat="server" CssClass="button" Text="关闭" OnClientClick="window.close();return false;" /></td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
