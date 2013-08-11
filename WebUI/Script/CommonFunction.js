//显示年，月，日
function fPopUpCalendarDlg(ctrlobj)
{
	showx = event.screenX - event.offsetX - 4 - 210 + 100  ; // + deltaX;
	showy = event.screenY - event.offsetY + 18; // + deltaY;
	newWINwidth = 210 + 4 + 18;
    
//    alert(ctrlobj);
//    return;
    retval = window.showModalDialog("../WebCtrl/calendar.htm", "", "dialogWidth:197px; dialogHeight:240px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:no; directories:yes;scrollbars:no;Resizable=no; "  );
	if( retval != null ){
		ctrlobj.value = retval;
	}else{
		//alert("canceled");
	}
}
//弹出自定义大小的窗口
function fPopUpPage1(page,width,heigh)
{
    window.showModalDialog(page, "", "dialogWidth:"+width+"px; dialogHeight:"+heigh+"px; status:no; directories:yes;scrollbars:no;Resizable=no; "  );
}
//添加职务以后，从子页向父页传递一个值到文本框里
 function fPopUpDuty(ctrolbj,id,mode,name)
{
    retval = window.showModalDialog("dutyChangeLog.aspx?emp_cd_duty="+id+"&mode="+mode+"&name="+name, "", "dialogWidth:430px; dialogHeight:400px;  status:no; directories:yes;scrollbars:no;Resizable=no; "  );
	if( retval != null )
		ctrolbj.value = retval;
		
}
//关闭当前窗口
 function CloseWin()
    {
         
         window.close();
    }
    
//以固定大小弹出一个窗口
function fPopUpPage(page)
{
    window.showModalDialog(page, "", "dialogWidth:800px; dialogHeight:600px; status:no; directories:yes;scrollbars:no;Resizable=no; "  );
}
//查看合同履历
function fPopPage_Con(page)
{
    window.showModalDialog(page, "", "dialogWidth:494px; dialogHeight:230px; status:no; directories:yes;scrollbars:no;Resizable=no; "  );
}
//弹出员工详细
function fPopPage_Emp(page)
{
    window.showModalDialog(page, "", "dialogWidth:760px; dialogHeight:400px; status:no; directories:yes;scrollbars:no;Resizable=no; "  );
}
//弹出离职详细
function fPopPage_Det(page)
{
    window.showModalDialog(page, "", "dialogWidth:488px; dialogHeight:490px; status:no; directories:yes;scrollbars:no;Resizable=no; "  );
}
//弹出合同续签窗口
function fPopPage_ConCon(page)
{
    window.showModalDialog(page, "", "dialogWidth:495px; dialogHeight:350px; status:no; directories:yes;scrollbars:no;Resizable=no; "  );
}
//弹出雇员详细信息窗口
function fPopUpEmpDetail(id,mode)
{
    window.showModalDialog("empDetailInfo.aspx?emp_cd="+id+"&mode="+mode,"","dialogWidth:755px; dialogHeight:400px;status:no; directories:no;scroll:0;Resizable=no;");
    return false;
}
//弹出公司评价窗口
function fPopUpCE(id,name)
{
   
    window.showModalDialog("companyEvaluateAdd.aspx?emp_cd="+id+"&name="+name,"comy_e","dialogWidth:447px; dialogHeight:378px;status:no; directories:no;scroll:0;Resizable=no;");
    return false;
}
//弹出工程评价窗口
function fPopUpPj_E(id)
{
   
    window.showModalDialog("engineerEvaluateAdd.aspx?emp_cd="+id,"","dialogWidth:610px; dialogHeight:430px;status:no; directories:no;scroll:0;Resizable=no;");
    return false;
}

//点击关闭时，alertmessage(return confirm('确定要关闭吗？')).
 function alertMessage(sr)
{
  if( sr==true)
  {
    window.close();
  }
}

//去空格

function Trim(s){
	return s.replace( /^\s*/, "" ).replace( /\s*$/, "" ).replace(/^[\s　\t]+|[\s　\t]+$/,"");
}


function fncSetFocus( strFormname,strElementbefore,strElementafter ){
	if ((document.forms[strFormname].elements[strElementbefore]) && (document.forms[strFormname].elements[strElementbefore].type == 'text')){
		document.forms[strFormname].elements[strElementbefore].value = document.forms[strFormname].elements[strElementbefore].value;
	}
	if (document.forms[strFormname].elements[strElementafter]){
		document.forms[strFormname].elements[strElementafter].focus();
		
		if (document.forms[strFormname].elements[strElementafter].type == 'select-one'){
	// 未処理


		} else if (document.forms[strFormname].elements[strElementafter].type == 'select-multiple'){
	// 未処理


		} else if (document.forms[strFormname].elements[strElementafter].type == 'button'){
	// 未処理

		} else {
			document.forms[strFormname].elements[strElementafter].select();
		}
	}
}
/*校验
 *name: 控件ID
 *flag: 0.非空校验 1.长度校验 2.输入规则校验
 *num : 长度
 *mark: 0.年校验 1.年/月校验 2.数字校验 3.时间 4.浮点数 
 *		5.数字,字母,下划线 6.非单引号的所有字符 7.身份证
 *msg1: 错误消息1
 *msg2: 错误消息2
 */
function verify(name,flag,num,mark,msg1,msg2){

	var str="";
  var arrFocus=new Array();
  
  switch(flag){
    case 0:
     	//非空
     	if(trim(document.all(name).value) == ""){
 				str+=getMsg(msg1,msg2)+"\r\n";
 				arrFocus[arrFocus.length]=name;
 			}	
 			break;
    case 1:
     	//长度
     	if(trim(document.all(name).value).length > num){
 				str+=getMsg(msg1,msg2)+"\r\n";
 				arrFocus[arrFocus.length]=name;
 			}	
 			break;
    case 2:
     	var strMark = "";
     	switch(mark){
     		case 0:
     			//年
     			strMark = "^((1[8-9]\\d{2})|(2\\d{3}))$";
     			break;
     		case 1:
     			//年/月
	     		strMark = "^((1[8-9]\\d{2})|(2\\d{3}))\\/((0?[1-9])|(1[0-2]))$";
	     		break;
     		case 2:
     			//数字
	     		strMark = "^\\d*$";
	     		break;
	     	case 3:
     			//时间
	     		strMark = "^(((0?|1)\\d|(2[0-3]))\\:[0-5]\\d)$";
	     		break;
	     	case 4:
     			//浮点数
	     		strMark = "^(\\d*|(\\d+\\.\\d+)?)$";
	     		break;
	     	case 5:
     			//数字,字母,下划线
	     		strMark = "^\\w*$";
	     		break;
	     	case 6:
     			//非单引号的所有字符
	     		strMark = "^([^\\'])*$";
	     		break;
	     	case 7:
     			//身份证
	     		strMark = "^((\\d{15}|(\\d{14}x))|(\\d{18}|(\\d{17}x)))?$";
	     		break;
     	}
     	// 正则表达式对象
     	var re = new RegExp(strMark, "");
			// 查找
			var mresult = re.exec(trim(document.all(name).value));
			if( mresult == null ){
				str+=getMsg(msg1,msg2)+"\r\n";
 				arrFocus[arrFocus.length]=name;
			}
			break;
  }
	if(str==""){
		return true; 
	}else{
		alert(str);
		//fncSetFocus('frmMain','',arrFocus[0]);
		return false;
	} 	 
}
function trim(value){
	var re1 = new RegExp("^\\s*", "");
	value = value.replace(re1,"");
	var re2 = new RegExp("\\s*$", "");
	value = value.replace(re2,"");
	return value;
}

/*日期校验
 *开始日期、结束日期不允许为空，且开始日期不能大于结束日期
 *datefrom: 开始日期
 *dateto :结束日期
 *要求：日期需中间以- / 或 空格 为分隔符
 */
function dateCheck(dateFrom,dateTo){
    if((dateFrom==null)||(dateFrom=="")){
      //alert(getMsg(0,4));
      return true;
    }else if(dateTo==null||dateTo==""){
      //alert(getMsg(0,5));
      return true;
    }else {
		// 对字符串进行处理
		// 以 - / 或 空格 为分隔符, 将日期字符串分割为数组
    	var date1 = dateFrom.split(/-|\/|\s/);
		var date2 = dateTo.split(/-|\/|\s/);
		// 创建 Date 对象
		var myDateFrom = new Date(date1[0],date1[1],date1[2]);
		var myDateTo = new Date(date2[0],date2[1],date2[2]);
		// 对日起进行比较
		if(myDateFrom>myDateTo){
			alert(getMsg(0,6));
			return false;
		}
    }
    return true;
}




function workTimeCheck(onDuty,offDuty) 
{
    var on=onDuty;
    var off=offDuty;
    //定义工作时间的正则表达式
    var strMark="(^((0?|1)\\d|(2[0-3]))\\:[0-5]\\d)$";
    //定义RegExp方法，来验证时间
    var re = new RegExp(strMark, "");
    var mresult = re.exec(on);
    var ons=onDuty.split(":");
    var offs=offDuty.split(":");
    
    //通过IF语句判断错误
    if(mresult==null)
    {
       alert("请检查上班时间格式和是否包含空格");
       return false;
    }
    else if(re.exec(off)==null)
    {
       alert("请检查下班时间格式和是否包含空格");
       return false;
    }
    else if(ons[0]>offs[0])
    {
       alert("上班时间必须小于下班时间");
       return false;
    }   
    else if(ons[0]==offs[0])
    {
       if(ons[1]>=offs[1])
       {
          alert("上班时间必须小于下班时间");
          return false;
       }
    }
    else
    {
       alert("时间修改成功");
       return true;
    }
       return true;
}