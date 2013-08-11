<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="empMoveQuery.aspx.cs" Inherits="empMoveQuery" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript" src="Script/CommonFunction.js"></script>
    

    <table style="width: 792px; height: 258px;" cellpadding="0" cellspacing="0">
        <tr>
            <td colspan="3" style="border-right: #0099cc 1px solid; border-top: #0099cc 1px solid;
                border-left: #0099cc 1px solid; border-bottom: #0099cc 1px solid; width: 100%;
                height: 26px;" valign="top">
                <table width="100%" cellpadding="0" cellspacing="0" style="vertical-align: top">
                    <tr style="background-image: url(images/topbg.gif)">
                        <td colspan="7" style="text-align: left; vertical-align: top; height: 18px;">
                            <span style="font-size: 10pt">
                            检索</span></td>
                    </tr>
                    <tr>
                        <td style="width: 511px">
                            查询月份<asp:TextBox ID="txtYear1" runat="server"></asp:TextBox>
                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/datetime.gif"
                                OnClientClick="fPopUpCalendarDlg(document.all.ctl00_ContentPlaceHolder1_txtYear1);return false;" />~<asp:TextBox ID="txtYear2" runat="server"></asp:TextBox>
                            <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/datetime.gif"
                                OnClientClick="fPopUpCalendarDlg(document.all.ctl00_ContentPlaceHolder1_txtYear2);return false;" /></td>
                        <td style="text-align: right">
                            <asp:Button ID="btnQuery" runat="server" Text="查询" Width="55px" CssClass="button"
                                OnClick="btnQuery_Click" /></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="3" valign="top" style="height: 12px">
            </td>
        </tr>
        <tr>
            <td valign="top" style="height: 211px">
                <table cellpadding="0" cellspacing="0" style="width: 100%">
                    <tr>
                        <td colspan="4" style="text-align: justify; height: 14px;">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr style="background-image: url(images/topBar_bg.gif)">
                                    <td align="left" style="height: 11px">
                                        <span style="font-size: 10pt; font-family: 宋体">在籍者移动状况</span></td>
                                    <td align="right" style="height: 11px">
                                        <asp:LinkButton ID="lnkPrint" runat="server">打印报表</asp:LinkButton>&nbsp;
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" rowspan="2" style="height: 221px" valign="top">
                            <table border="0" align="center" cellpadding="2" cellspacing="1" style="width: 100%">
                                <tr align="center" class="topbg">
                                    <td width="60px" rowspan="2" align="center">
                                        月份</td>
                                    <td rowspan="2" align="center" style="width: 60px">
                                        月初人数</td>
                                    <td width="60px" rowspan="2" align="center">
                                        月末人数</td>
                                    <td rowspan="2" align="center" style="width: 60px">
                                        入社人数</td>
                                    <td rowspan="2" align="center" style="width: 60px">
                                        辞职人数</td>
                                    <td colspan="5" align="center">
                                        平均年龄</td>
                                    <td colspan="2" align="center">
                                        婚姻状况</td>
                                </tr>
                                <tr align="center" class="topbg" height="20px">
                                    <td width="50px" align="center">
                                        18-20</td>
                                    <td align="center" style="width: 50px">
                                        20-25</td>
                                    <td align="center" style="width: 50px">
                                        25-30</td>
                                    <td width="50px" align="center">
                                        30以上</td>
                                    <td width="50px" align="center">
                                        平均</td>
                                    <td width="50px" align="center">
                                        已婚</td>
                                    <td align="center" style="width: 50px">
                                        未婚</td>
                                </tr>
                            </table>
                            <asp:GridView ID="GVMoveQuery" runat="server" Width="100%" Visible="False" ShowHeader="False"
                                AutoGenerateColumns="False" AllowPaging="True" OnPageIndexChanged="GVMoveQuery_PageIndexChanged" OnPageIndexChanging="GVMoveQuery_PageIndexChanging">
                                <Columns>
                                    <asp:BoundField DataField="月份">
                                        <ItemStyle Width="60px"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="月初人数">
                                        <ItemStyle Width="60px"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="月末人数">
                                        <ItemStyle Width="60px"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="入社人数">
                                        <ItemStyle Width="60px"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="辞职人数">
                                        <ItemStyle Width="60px"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="从18到20">
                                        <ItemStyle Width="50px"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="从20到25">
                                        <ItemStyle Width="50px"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="从25到30">
                                        <ItemStyle Width="50px"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="从30到以上">
                                        <ItemStyle Width="50px"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="平均">
                                        <ItemStyle Width="50px"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="已婚">
                                        <ItemStyle Width="50px"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="未婚">
                                        <ItemStyle Width="50px"></ItemStyle>
                                    </asp:BoundField>
                                </Columns>
                                <PagerSettings FirstPageText="首页" LastPageText="最后一页" Mode="NextPreviousFirstLast"
                                    NextPageText="下一页" PreviousPageText="上一页" />
                                <RowStyle HorizontalAlign="Center" VerticalAlign="Bottom" />
                                <PagerStyle HorizontalAlign="Center" VerticalAlign="Bottom" />
                            </asp:GridView>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                    </tr>
                </table>
                <br />
            </td>
        </tr>
    </table>
</asp:Content>
