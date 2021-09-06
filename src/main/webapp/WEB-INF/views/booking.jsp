<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%
	String loginid=(String)session.getAttribute("loginid");
	String passcode=(String)session.getAttribute("passcode");
	if(!loginid.equals("admin")||!(passcode.equals("123"))){		
		response.sendRedirect("http://localhost:8080/app/selected?path=login");
	}
%> --%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예약관리</title>
    <link href="${path}/resources/css/style.css" rel="stylesheet" type="text/css">
     <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  </head>
<body>
    <button type="button" style="float:right;" onclick="location.href='home'">  로그아웃  </button>
    <div id="header">
        <h1 style="font-size: 45px;">관리자홈페이지-예약관리</h1><br>
        <h2 style="font-size: 20px;"><a href="booking">예약관리</a>  
        <a href="room"><u>객실관리</u></a></h2>
    </div>    
    
    <div id="nav2">        
        <div id="findRoom">
        <h2>숙박기간</h2>
        <input type="date" id="date1" min="2021-08-31">~
        <input type="date" id="date2" min="2021-08-31">
        <h2>객실종류</h2>
        <select style="width: 150px; font-size: 16px;"><br>
            <option>SuiteRoom</option>
            <option>FamilyRoom</option>
            <option>DoubleRoom</option>
            <option>SingleRoom</option>                  
           </select> 
           <input type="button" id="btnroomlist" value=" 조회 "> 
        </div>
        <div id="reserveRoom">
        <h2>예약가능한 객실</h2>
        <select id="reserveRoom2" size="8" style="width: 260px; height: 280px; font-size: 16px;"><br>
         
        </select>   
        </div>
    </div>
    <div id="sectionMenu2" style="border: 1px solid black; margin-top: 63px; height:600px;">
    <table cellpadding="5" cellspacing="0" style="margin-left: auto; margin-right: auto;">
    	<tr>
    		<td style="width:100px;">객실이름</td>
    		<td><input type="text" id="roomname">
    		<input type=hidden id="roomcode"></td>
    	</tr>
    	<tr>
    		<td>객실종류</td>
    		<td><select id="roomtypelist" style="width:120px;">
    		<c:forEach items="${type}" var="roomtype">
    			<option value='${roomtype.typecode}'>${roomtype.name}</option>
    		</c:forEach>
    		</select>
    		</td>
    	</tr>    	
    	<tr>
    		<td>예약인원</td>
    		<td><input type="number" id="bookpeople"></td>
    	</tr>
    	<tr>
    		<td>최대인원</td>
    		<td><input type="number" id="roompeople"></td>
    	</tr>
    	<tr>
    		<td>예약기간</td>
    		<td><input type="date" id="date3" min="2021-08-30">~
        <input type="date" id="date4" min="2021-08-30"></td>
    	</tr>
    	<tr>
    		<td>숙박비총액</td>
    		<td><input type="text" id="roompriceall">원</td>
    	</tr>
    	<tr>
    		<td>예약자명</td>
    		<td><input type="text" id="bookName"></td>
    	</tr>
    	<tr>
    		<td>모바일</td>
    		<td><input type="text" id="telNum"></td>
    	</tr>
    </table>
        <br><br>
        <input type="button" id="btnRegister2" value="  예약완료  ">
        <input type="button" id="btnClear2" value="  비우기  ">
        <input type="button" id="btnDelete2" style="height: 24px;"  value="  예약취소  ">
    </div>
    <div id="section2">
        <h2 style="font-size: 22px;">예약된 객실</h2>
        <select id="comroom" size="6" style="width: 400px; height: 600px; text-align: left;float: left;    
        margin-left: 0px; border: 1px black solid;">        
        </select>
    </div>    
</body>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script>
$(document)
.on('click','#btnroomlist',function(){//ajax호출
	$.post("http://localhost:8080/app/getBookRoomList",{},function(result){
		console.log(result);
		$('#reserveRoom2').empty();
		$.each(result,function(ndx,value){
			str='<option value="'+value['roomcode']+'">'+value['roomname']+','+
			value['typename']+','+value['howmany']+','+value['howmuch']+'</option>';
			$('#reserveRoom2').append(str);
		});
	},'json');
	return false;
})
.on('click','#reserveRoom2 option',function(){
	let a=$(this).text();
	let ar=a.split(',');
	$('#roomname').val(ar[0]);
	$('#roomtypelist option:contains("'+ar[1]+'")').prop('selected','selected');
	$('#roompeople').val(ar[2]);
	let code=$(this).val();
	$('#roomcode').val(code);//DB호출을 위한 KEY값 저장, 나중에 삭제할때 써먹으려고 씀.	
	return false;
})
.on('click','#roompriceall',function(){
	let bookdate1=$('#date3').val();
	let bookdate2=$('#date4').val();
	let bookdate=String(bookdate1)+'~'+String(bookdate2);
	let startdate = new Date(bookdate1.substr(0,4),bookdate1.substr(5,2),bookdate1.substr(8,2));
	let enddate = new Date(bookdate2.substr(0,4),bookdate2.substr(5,2),bookdate2.substr(8,2));
	let diffTime= Math.abs(enddate-startdate);
	let cntDays= Math.ceil(diffTime/(1000*60*60*24));
	menuPrice=parseInt($('#reserveRoom2 option:selected').text().split(',')[3]);
	totalPrice=menuPrice*cntDays;
	if(totalPrice>0){
		$('#roompriceall').val(totalPrice);
		return false;
	}
})
.on('click','#btnClear2',function(){
	$('#roomname,#roomtypelist,#roompeople,#date3,#date4,#bookpeople,#roompriceall,#telNum,#bookName').val('');
	return false;
})

.on('click','#btnRegister2',function(){	
	let roomcode=$('#roomcode').val();
	let bookdate1=$('#date3').val();
	let bookdate2=$('#date4').val();
	let bookdate=String(bookdate1)+'~'+String(bookdate2);
	let roomname=$('#roomname').val();
	let roomtypelist=$('#roomtypelist').val();
	let roompeople=$('#roompeople').val();
	let roompriceall=$('#roompriceall').val();
	let bookpeople=$('#bookpeople').val();
	let bookName=$('#bookName').val();
	let mobile=$('#telNum').val();
	
	if(roomname==''||roomtypelist==''||roompeople==''||roompriceall==''||bookpeople==''||bookName==''||mobile==''){
		alert("누락된 값이 있습니다.");
		return false;
	}
	if(bookpeople>roompeople){
		alert("예약인원이 최대인원을 초과했습니다.");
		return false;
	}
	if($('#roomname').val()!=''){//insert
		$.post('http://localhost:8080/app/addBookRoom',
	  {roompriceall:roompriceall,bookpeople:bookpeople,bookdate:bookdate,bookName:bookName,mobile:mobile},
	  function(result){
		  if(result=='ok'){
			  str='<option>'+roomname+' '+roomtypelist+' '+bookName+' '+mobile+' '+bookpeople+'/'+roompeople+' '+bookdate+' '+roompriceall+'</option>'
			  console.log(str);
			  $('#comroom').append(str);
			  $('#roomname,#roomtypelist,#roompeople,#date3,#date4,#bookpeople,#roomPrice,#telNum,#bookName').val('');
		  return false;
			}
		},'text');
	}
})
.on('click','#btnDelete2',function(){
	$.post('http://localhost:8080/app/deleteBookRoom',
			{roomcode:roomcode},
			function(result){
		if(result=="ok"){
			$('#comroom option:selected').remove();
		}
	},'text');
})

</script>

</html>