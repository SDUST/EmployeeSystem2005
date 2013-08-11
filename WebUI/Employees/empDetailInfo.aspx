<%@ Page Language="C#" AutoEventWireup="true" CodeFile="empDetailInfo.aspx.cs" Inherits="empDetailInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server"> 
<title>员工详细信息</title>
  <base target="_self" /> 
    <script type="text/javascript" src="../Script/CommonFunction.js"></script>
</head>

<body>
    <form id="form1" runat="server">
        <div style="text-align: left" title="员工详细画面">
            <table style="width: 750px">
                <tr>
                    <td colspan="3" style="height: 189px">
                        <table style="border-right: #339999 1px solid; border-top: #339999 1px solid; border-left: #339999 1px solid;
                            border-bottom: #339999 1px solid; height: 152px" width="100%" cellpadding="2" cellspacing="1">
                            <tr style="background-image: url(../images/topBar_bg.gif)">
                                <td colspan="7" style="height: 22px">
                                    <span style="font-size: 10pt;background-repeat: repeat-x;">基本资料</span></td>
                            </tr>
                            <tr>
                                <td style="width: 75px; height: 23px">
                                    姓 &nbsp; &nbsp; &nbsp;&nbsp; 名</td>
                                <td style="width: 105px; height: 23px">
                                    <asp:TextBox ID="txtEmpName" runat="server" Width="70px" MaxLength="20"></asp:TextBox></td>
                                <td style="width: 77px; height: 23px">
                                    性 &nbsp; &nbsp; &nbsp; &nbsp;别</td>
                                <td style="width: 126px; height: 23px">
                                    <asp:DropDownList ID="selSex" runat="server" Width="50px">
                                        <asp:ListItem Value="1">男</asp:ListItem>
                                        <asp:ListItem Selected="True" Value="0">女</asp:ListItem>
                                    </asp:DropDownList></td>
                                <td style="width: 79px; height: 23px">
                                    出生日期</td>
                                <td style="width: 104px; height: 23px">
                                    <asp:TextBox ID="txtBirthday" runat="server" Width="70px"></asp:TextBox>
                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/datetime.gif" OnClientClick="fPopUpCalendarDlg(document.all.txtBirthday);return false;" /></td>
                                <td rowspan="5" style="text-align: center">
                                    &nbsp;<asp:Image ID="Image1" runat="server" Width="80px" Height="110px" />&nbsp;<br />
                                    <asp:Button ID="btnPhoto" runat="server" Text="上传" CssClass="button" Visible="False" OnClick="btnPhoto_Click" CausesValidation="False" /></td>
                            </tr>
                            <tr>
                                <td style="width: 75px; height: 24px;">
                                    身份证号</td>
                                <td style="width: 105px; height: 24px;">
                                    <asp:TextBox ID="txtIDCard" runat="server" Width="105px" MaxLength="18"></asp:TextBox></td>
                                <td style="width: 77px; height: 24px;">
                                    婚姻状态</td>
                                <td style="width: 126px; height: 24px;">
                                    <asp:DropDownList ID="selMarry" runat="server" Width="60px">
                                        <asp:ListItem Value="0">未婚</asp:ListItem>
                                        <asp:ListItem Value="1">已婚</asp:ListItem>
                                    </asp:DropDownList></td>
                                <td style="width: 79px; height: 24px;">
                                    <span style="font-size: 10pt; font-family: 宋体">
                                    最高学历</span></td>
                                <td style="width: 104px; font-size: 10pt; font-family: 宋体; height: 24px;">
                                    <asp:DropDownList ID="selDiploma" runat="server" DataSourceID="SqlDataSource2" DataTextField="fun_name"
                                        DataValueField="combine_cd" OnDataBound="selDiploma_DataBound" Width="60px">
                                    </asp:DropDownList></td>
                            </tr>
                            <tr style="font-size: 9pt; font-family: Times New Roman">
                                <td style="width: 75px; height: 24px;">
                                    籍贯省份</td>
                                <td style="width: 105px; height: 24px;">
                                    <asp:DropDownList ID="selHomeplace" runat="server" DataSourceID="SqlDataSource3"
                                        DataTextField="fun_name" DataValueField="fun_name" OnDataBound="selHomeplace_DataBound">
                                    </asp:DropDownList></td>
                                <td style="width: 77px; height: 24px;">
                                    民 &nbsp; &nbsp; &nbsp;&nbsp; 族</td>
                                <td style="width: 126px; height: 24px;">
                                    <asp:DropDownList ID="selNation" runat="server" DataSourceID="SqlDataSource1" DataTextField="fun_name"
                                        DataValueField="fun_name" OnDataBound="selNation_DataBound" Width="100px">
                                    </asp:DropDownList></td>
                                <td style="width: 79px; height: 24px;">
                                    邮 &nbsp; &nbsp; &nbsp;&nbsp; 编</td>
                                <td style="width: 104px; height: 24px;">
                                    <asp:TextBox ID="txtPostalcode" runat="server" Width="70px" MaxLength="6"></asp:TextBox></td>
                            </tr>
                            <tr style="font-size: 9pt; font-family: Times New Roman">
                                <td style="width: 75px">
                                    联 系 人</td>
                                <td style="width: 105px">
                                    <asp:TextBox ID="txtLinkman" runat="server" Width="70px" MaxLength="20"></asp:TextBox></td>
                                <td style="width: 77px">
                                    联系电话</td>
                                <td style="width: 126px">
                                    <asp:TextBox ID="txtPhone" runat="server" Width="70px" MaxLength="20"></asp:TextBox></td>
                                <td style="width: 79px">
                                    电子邮件</td>
                                <td style="width: 104px">
                                    <asp:TextBox ID="txtEmail" runat="server" Width="90px" MaxLength="20"></asp:TextBox></td>
                            </tr>
                            <tr style="font-size: 9pt; font-family: Times New Roman">
                                <td style="width: 75px; height: 26px;">
                                    合同区分</td>
                                <td style="width: 105px; height: 26px;">
                                    <asp:DropDownList ID="selContract_class" runat="server" DataSourceID="SqlDataSource4"
                                        DataTextField="fun_name" DataValueField="combine_cd" OnDataBound="selContract_class_DataBound"
                                        Width="90px">
                                    </asp:DropDownList></td>
                                <td style="width: 77px; height: 26px;">
                                    家庭住址</td>
                                <td style="width: 126px; height: 26px;">
                                    <asp:TextBox ID="txtAddress" runat="server" Width="150px" MaxLength="20"></asp:TextBox></td>
                                <td colspan="2" style="height: 26px">
                                    <asp:FileUpload ID="fupPhoto" runat="server" Visible="False" Width="154px" /></td>
                            </tr>
                        </table>
                    </td>
                </tr>
              <tr><td colspan="4"></td></tr>
                <tr style="font-size: 9pt; font-family: Times New Roman">
                    <td colspan="3">
                        <table style="height: 60px; border-right: #009999 1px solid; border-top: #009999 1px solid;
                            border-left: #009999 1px solid; border-bottom: #009999 1px solid;" width="100%" cellpadding="2" cellspacing="1">
                            <tr style="background-image: url(../images/topBar_bg.gif)">
                                <td colspan="9" style="height: 22px; text-align: left;">
                                    <span>公司资料</span></td>
                            </tr>
                            <tr>
                                <td style="width: 67px; height: 16px; text-align: left;">
                                    编 &nbsp; &nbsp; &nbsp;&nbsp; 号</td>
                                <td style="width: 97px; height: 16px">
                                    <asp:TextBox ID="txtEmpCd" runat="server" Width="70px" MaxLength="20" ></asp:TextBox></td>
                                <td style="width: 67px; height: 16px; text-align: left;">
                                    卡编号</td>
                                <td style="width: 115px; height: 16px">
                                    <asp:TextBox ID="txtTimecard" runat="server" Width="70px" MaxLength="20"></asp:TextBox></td>
                                <td style="width: 72px; height: 16px; text-align: left;">
                                    部 &nbsp; &nbsp; &nbsp; 门</td>
                                <td style="width: 52px; height: 16px; text-align: left;">
                                    <asp:DropDownList ID="selDept" runat="server" DataSourceID="SqlDataSource5" DataTextField="dept_name"
                                        DataValueField="dept_cd" OnDataBound="selDept_DataBound" Width="100px">
                                    </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:dbEmpConnectionString %>"
                                        SelectCommand="SELECT * FROM [tb_dept] WHERE ([dept_class] = @dept_class)">
                                        <SelectParameters>
                                            <asp:Parameter DefaultValue="0" Name="dept_class" Type="String" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </td>
                                <td style="width: 69px; height: 16px; text-align: left;">
                                    工 &nbsp; &nbsp; &nbsp; 程</td>
                                <td style="width: 79px; height: 16px; text-align: left;" colspan="2">
                                    <asp:DropDownList ID="selPj" runat="server" DataSourceID="SqlDataSource7" DataTextField="dept_name"
                                        DataValueField="dept_cd" OnDataBound="selPj_DataBound" Width="80px">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 67px; text-align: left;">
                                    入职时间</td>
                                <td style="width: 97px">
                                    <asp:TextBox ID="txtJoinDate" runat="server" Width="70px"></asp:TextBox>
                                    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/datetime.gif" OnClientClick="fPopUpCalendarDlg(document.all.txtJoinDate);return false;" /></td>
                                <td style="width: 67px; text-align: left;">
                                    职 务</td>
                                <td style="width: 115px">
                                    <asp:TextBox ID="txtDutyName" runat="server" Width="70px"></asp:TextBox>
                                    <asp:Button ID="btnUpdate" runat="server" Text="变更" CssClass="button" OnClick="btnUpdate_Click" /></td>
                                <td style="width: 72px; text-align: left;">
                                    技术等级</td>
                                <td style="width: 52px; text-align: left;">
                                    <asp:TextBox ID="txtLevel" runat="server" Width="70px" ReadOnly="True"></asp:TextBox></td>
                                <td style="width: 69px; text-align: left;">
                                    员工区分</td>
                                <td style="width: 79px; text-align: left;" colspan="2">
                                    <asp:DropDownList ID="selEmpClass" runat="server" Width="85px">
                                        <asp:ListItem Selected="True"></asp:ListItem>
                                        <asp:ListItem Value="0">试用期员工</asp:ListItem>
                                        <asp:ListItem Value="1">正式员工</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 67px; text-align: left; height: 25px;">
                                    合同起始日</td>
                                <td style="width: 97px; height: 25px;">
                                    <asp:TextBox ID="txtStartDate" runat="server" Width="70px"></asp:TextBox>
                                    <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/images/datetime.gif" OnClientClick="fPopUpCalendarDlg(document.all.txtStartDate);return false;" /></td>
                                <td style="width: 67px; text-align: left; height: 25px;">
                                    合同结束日</td>
                                <td style="width: 115px; height: 25px;">
                                    <asp:TextBox ID="txtEndDate" runat="server" Width="70px"></asp:TextBox>
                                    <asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="~/images/datetime.gif" OnClientClick="fPopUpCalendarDlg(document.all.txtEndDate);return false;" /></td>
                                <td style="width: 72px; text-align: left; height: 25px;">
                                    入社前工龄</td>
                                <td style="width: 52px; text-align: left; height: 25px;">
                                    <asp:TextBox ID="txtForwardWorkYear" runat="server" Width="70px" ReadOnly="True"></asp:TextBox></td>
                                <td style="width: 69px; text-align: left; height: 25px;">
                                    入社后工龄</td>
                                <td colspan="2" style="width: 79px; text-align: left; height: 25px;">
                                    <asp:TextBox ID="txtAfterWorkYear" runat="server" Width="70px" ReadOnly="True"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td style="width: 67px; text-align: left;">
                                    宿 &nbsp; &nbsp; &nbsp;&nbsp; 舍</td>
                                <td style="width: 97px">
                                    <asp:TextBox ID="txtDorm" runat="server" Width="70px" MaxLength="20"></asp:TextBox></td>
                                <td style="width: 67px; text-align: left;">
                                    床 位</td>
                                <td style="width: 115px">
                                    <asp:TextBox ID="txtBed" runat="server" Width="70px" MaxLength="20"></asp:TextBox></td>
                                <td style="width: 72px; text-align: left;">
                                    备 注</td>
                                <td colspan="4" style="text-align: left">
                                    <asp:TextBox ID="txtMemo" runat="server" Width="168px" MaxLength="50"></asp:TextBox></td>
                            </tr> 
                        </table>
                    </td>
                </tr>
                <tr style="font-size: 9pt; font-family: Times New Roman">
                    <td style="text-align: right">
                        <asp:Button ID="btnSave" runat="server" Text="确认" Width="65px" CssClass="button"
                            OnClick="btnSave_Click" /></td>
                    <td>
                    </td>
                    <td>
                        <asp:Button ID="btnClose" runat="server" Text="关闭" Width="65px" CssClass="button"
                            OnClientClick="window.close();return false;" /></td>
                </tr>
            </table>
            <br />
            <br />
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:dbEmpConnectionString %>"
                SelectCommand="SELECT * FROM [tb_com_fun] WHERE ([fun_class_cd] = @fun_class_cd)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="4" Name="fun_class_cd" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:dbEmpConnectionString %>"
                SelectCommand="SELECT * FROM [tb_com_fun] WHERE ([fun_class_cd] = @fun_class_cd)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="5" Name="fun_class_cd" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:dbEmpConnectionString %>"
                SelectCommand="SELECT * FROM [tb_com_fun] WHERE ([fun_class_cd] = @fun_class_cd)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="6" Name="fun_class_cd" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:dbEmpConnectionString %>"
                SelectCommand="SELECT * FROM [tb_com_fun] WHERE ([fun_class_cd] = @fun_class_cd)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="fun_class_cd" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:dbEmpConnectionString %>"
                SelectCommand="SELECT * FROM [tb_dept] WHERE ([dept_class] = @dept_class)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="3" Name="dept_class" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetDeptOrPj"
            TypeName="Business.Depts" OldValuesParameterFormatString="original_{0}">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="dept_class" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </form>
</body>
</html>
