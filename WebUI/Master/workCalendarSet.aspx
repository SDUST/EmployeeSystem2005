<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="workCalendarSet.aspx.cs" Inherits="Master_workCalendarSet" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script language="javascript">
		   function gotoNextPage(selDate){
				var selDataList;
				if(selDate.substring(selDate.length-1,selDate.length)== ",") {
					selDataList = selDate.substring(0,selDate.length-1)
			    }
				window.open('workDayRemark.aspx?selDay=" & selDate & "','','dialogWidth:400px;dialogHeight:240px;status: No;help: No; scroll:NO')
		   }
		   function chColor(td){
				if(event.srcElement.tagName == "A"){
					return ;
				}
				var cl = document.all.dayColorList.value;
				//默认都为0，改变颜色后，根据颜色分别写成1，2，3
				var ocl = document.all.chaList.value;				
				var intDay = td.id;
				var headNum ;
				var chaNum ;
				var endNum ;
				var headOnlyCha;
				var endOnlyCha;
				headNum = cl.substring(0,2*(intDay-1))
				endNum = cl.substring(2*intDay-1,cl.length)
				//只记录改变的
				headOnlyCha = ocl.substring(0,2*(intDay-1))
				endOnlyCha = ocl.substring(2*intDay-1,ocl.length)			
				if(document.all("click_type").value==1){
					document.all("click_type").value=0;
					return;
				}
				if(td.bgColor==""){
					td.bgColor='#ffff00';
					document.all.dayColorList.value = headNum + "1" + endNum
					document.all.chaList.value = headOnlyCha + "1" + endOnlyCha
					return;
				}
				if(td.bgColor=='#ffff00'){
					td.bgColor='#ff0000';
					document.all.dayColorList.value = headNum + "2" + endNum
					document.all.chaList.value = headOnlyCha + "2" + endOnlyCha
					return;
				}
				if(td.bgColor=='#ff0000'){
					td.bgColor="";
					document.all.dayColorList.value = headNum + "0" + endNum
					document.all.chaList.value = headOnlyCha + "3" + endOnlyCha
					return;
				}
				
			}
			function refresh(){
			   this.location = this.location;
			}

			function setColor(){
				var list = document.all.chaList.value
				if(list.substring(list.length-1,list.length)== ",") {
					list = document.all.chaList.value.substring(0,document.all.chaList.value.length-1)
			    }
				var eachCha = list.split(",");
				for (i=0;i<eachCha.length;i++){
					if(eachCha[i]==1){
						document.getElementById(i+1).bgColor='#ffff00'
					}else if(eachCha[i]==2){
						document.getElementById(i+1).bgColor='#ff0000'
					}else if(eachCha[i]==3){
						document.getElementById(i+1).bgColor=""
					}
				}
			}
			function open_form(newPage){
			alert(newPage);
				var win = window.open(newPage,"","toolbar=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=250,height=25,top=250,left=300");
				Form1.submit();
			}

    </script>

    <table align="center" border="0" cellpadding="0" cellspacing="1" class="border" width="600">
        <tr class="topbg">
            <td align="left" colspan="8" style="height: 22px">
                工作日历设置</td>
        </tr>
        <tr>
            <td height="22" style="width: 130px; text-align: center;">
                年度&nbsp;
                <asp:DropDownList ID="selYear" runat="server">
                    <asp:ListItem Value="2005">2005</asp:ListItem>
                    <asp:ListItem Value="2006">2006</asp:ListItem>
                    <asp:ListItem Value="2007">2007</asp:ListItem>
                    <asp:ListItem Value="2008">2008</asp:ListItem>
                    <asp:ListItem Value="2009">2009</asp:ListItem>
                    <asp:ListItem Value="2010">2010</asp:ListItem>
                    <asp:ListItem Value="2011">2011</asp:ListItem>
                    <asp:ListItem Value="2012">2012</asp:ListItem>
                    <asp:ListItem Value="2013">2013</asp:ListItem>
                    <asp:ListItem Value="2014">2014</asp:ListItem>
                    <asp:ListItem Value="2015">2015</asp:ListItem>
                    <asp:ListItem Value="2016">2016</asp:ListItem>
                    <asp:ListItem Value="2017">2017</asp:ListItem>
                    <asp:ListItem Value="2018">2018</asp:ListItem>
                    <asp:ListItem Value="2019">2019</asp:ListItem>
                    <asp:ListItem Value="2020">2020</asp:ListItem>
                    <asp:ListItem Value="2021">2021</asp:ListItem>
                    <asp:ListItem Value="2022">2022</asp:ListItem>
                    <asp:ListItem Value="2023">2023</asp:ListItem>
                    <asp:ListItem Value="2024">2024</asp:ListItem>
                    <asp:ListItem Value="2025">2025</asp:ListItem>
                </asp:DropDownList></td>
            <td style="width: 130px; text-align: center;">
                月份&nbsp;
                <asp:DropDownList ID="selMonth" runat="server">
                    <asp:ListItem Value="1">1月</asp:ListItem>
                    <asp:ListItem Value="2">2月</asp:ListItem>
                    <asp:ListItem Value="3">3月</asp:ListItem>
                    <asp:ListItem Value="4">4月</asp:ListItem>
                    <asp:ListItem Value="5">5月</asp:ListItem>
                    <asp:ListItem Value="6">6月</asp:ListItem>
                    <asp:ListItem Value="7">7月</asp:ListItem>
                    <asp:ListItem Value="8">8月</asp:ListItem>
                    <asp:ListItem Value="9">9月</asp:ListItem>
                    <asp:ListItem Value="10">10月</asp:ListItem>
                    <asp:ListItem Value="11">11月</asp:ListItem>
                    <asp:ListItem Value="12">12月</asp:ListItem>
                </asp:DropDownList></td>
            <td style="text-align: center" colspan="2">
                <font face="宋体"></font>
                <asp:Button ID="btnQuery" runat="server" BackColor="#D7E8DF" BorderColor="#658B84"
                    BorderStyle="Solid" BorderWidth="1px" Height="17px" OnClick="btnQuery_Click"
                    Text="查 询" Width="58px" /><font face="宋体"> </font>
                </td>
        </tr>
    </table>
    <table align="center" style="width: 600px; height: 312px">
        <tr>
            <td align="center" style="width: 603px; height: 329px">
                <asp:Calendar ID="Calendar1" runat="server" BackColor="Transparent" BorderColor="RoyalBlue"
                    CellPadding="1" CellSpacing="1" DayNameFormat="Full" EnableViewState="False"
                    FirstDayOfWeek="Sunday" Height="312px" OnDayRender="Calendar1_DayRender" ShowTitle="False"
                    TabIndex="1" Width="600px" OnSelectionChanged="Calendar1_SelectionChanged" Font-Bold="True"
                    Font-Names="Arial Black" Font-Size="Large">
                    <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                    <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                    <DayStyle Font-Bold="True" Font-Size="Large" ForeColor="Blue" HorizontalAlign="Center"
                        Height="25px" />
                    <NextPrevStyle Font-Size="8pt" ForeColor="#8080FF" />
                    <DayHeaderStyle BackColor="#39867B" Font-Bold="True" ForeColor="#336666" Height="12px" />
                    <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True"
                        Font-Size="10pt" ForeColor="Transparent" Height="25px" />
                    <WeekendDayStyle BackColor="Yellow" ForeColor="Red" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                </asp:Calendar>
            </td>
        </tr>
    </table>
    <br />
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="600">
        <tr>
            <td bgcolor="#ffff00" height="30" width="60">
                &nbsp;</td>
            <td style="width: 81px" width="80">
                公休日</td>
            <td bgcolor="#99cccc" height="30" width="60">
                &nbsp;</td>
            <td style="width: 85px" width="80">
                当日</td>
            <td align="center" height="30" style="font-weight: bold; font-size: larger; color: gray"
                width="60">
                30</td>
            <td style="width: 161px" width="160">
                此日期有备注信息</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td height="20">
                &nbsp;</td>
            <td height="20" style="width: 81px">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td bgcolor="#ff0000" height="30">
                &nbsp;</td>
            <td style="width: 80px">
                法定节假日</td>
            <td align="center" height="30" style="font-weight: bold; font-size: larger; color: blue"
                width="60">
                30</td>
            <td style="width: 85px" width="80">
                平日</td>
            <td align="center" height="30" style="font-weight: bold; font-size: larger; color: purple"
                width="60">
                30</td>
            <td style="width: 161px" width="160">
                此日期为法定假日且周末</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
    <asp:HiddenField ID="chaList" runat="server" />
</asp:Content>
