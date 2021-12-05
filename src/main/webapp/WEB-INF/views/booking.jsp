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
    <div id="header" style="background-image: url('./resources/img/hotel2.jpg');
background-repeat: no-repeat;
background-size: cover;">
        <h1 style="font-size: 45px;">관리자홈페이지-예약관리</h1><br>
        <h2>
        <input type="button" id="btngobook" onclick="location.href='booking'" value=" 예약관리  ">
		<input type="button" id="btngoroom" onclick="location.href='room'" value=" 객실관리  ">
        </h2>
    </div>    
    
    <div id="nav2">        
        <span id="findRoom">
     <p style="font-size: 24px;">객실예약조회</p><br>   
        숙박기간&nbsp;&nbsp;
        <input type="date" id="date1" min='2021-10-01'>~
        <input type="date" id="date2" min=today>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;        
        객실종류&nbsp;&nbsp;
        <select id="roomTypeMenu">
        <option value='all'>전체</option>
           <c:forEach items="${type}" var="roomtype">
             <option value='${roomtype.name}'>${roomtype.name}</option>
   		   </c:forEach>                 
         </select> 
           <input type="button" id="btnroomlist" value="  예약조회   ">
           </span>            
        </div>
        <div id="binnav">
		</div>
        <div id="reserveRoom">
        <h2 style="text-align: center;">예약가능한 객실</h2>
        <select id="reserveRoom2" size="8"><br>         
        </select>   
        </div>
    </div>
    
    <div id="sectionMenu2">
    <table id="roomTable" cellpadding="5" cellspacing="5">
    	<tr>
    		<td style="width:120px;">객실이름</td>
    		<td><input type="text" id="roomname" readonly>
    		<input type=hidden id="roomcode"></td>
    	</tr>
    	<tr>
    		<td>객실종류</td>
    		<td><select id="roomtypelist" style="width:177px;">
    		<c:forEach items="${type}" var="roomtype">
    			<option value='${roomtype.typecode}'>${roomtype.name}</option>
    		</c:forEach>
    		</select>
    		</td>
    	</tr>    	
    	<tr>
    		<td>예약인원</td>
    		<td><input type="number" id="bookpeople" min=1></td>
    	</tr>
    	<tr>
    		<td>최대인원</td>
    		<td><input type="number" id="roompeople" readonly></td>
    	</tr>
    	<tr>
    		<td>예약기간</td>
    		<td><input type="date" id="date3" readonly>&nbsp;~&nbsp;
        <input type="date" id="date4" readonly></td>
    	</tr>
    	<tr>
    		<td>숙박비총액</td>
    		<td><input type="text" id="roompriceall" readonly>&nbsp;원</td>
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
        <br>
        <p style="text-align:center;">
        <input type="button" id="btnRegister2" value="  예약완료  ">
        <input type="button" id="btnClear2" value="   비우기   ">
        <input type="button" id="btnUpdate" value="  예약수정  ">
        <input type="button" id="btnDelete2" value="   예약취소   ">
    	</p>
    </div>
    
    <div id="section2">
        <h2 style="font-size: 22px;">예약된 객실</h2>
        <select id="comroom" size="6"></select>
    </div>
    <div id="footer">
    </div>    
</body>

<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script>
document.getElementById('date1').valueAsDate = new Date();
$(document)
.on('click','#btnroomlist',function(){//ajax호출
	let roompeople=$('#roompeople').val();
	let roompriceall=$('#roompriceall').val();
	let bookpeople=$('#bookpeople').val();
	let bookName=$('#bookName').val();	
	let bookdate1=$('#date1').val();
	let bookdate2=$('#date2').val();
	let roomtype=$('#roomTypeMenu').val();
	if(bookdate1==''||bookdate2=='') return false;
	if(roomtype!="all"){
		$.post("http://localhost:8080/app/getBookList",
			{day1:bookdate1,day2:bookdate2,roomtype:roomtype},
			function(result){
		console.log(result);
		bookdate1=new Date(bookdate1);
		bookdate2=new Date(bookdate2);
		if(bookdate1>bookdate2){
			alert('체크인날짜가 체크아웃보다 나중일 수 없습니다.');
			return false;
		}
		$('#reserveRoom2').empty();
		$.each(result,function(ndx,value){
			str='<option value="'+value['roomcode']+'">'+value['roomname']+','
			+value['typename']+','+value['howmany']+','+value['howmuch']+'</option>';
			$('#reserveRoom2').append(str);
		});
	},'json');
	} else {
		$.post("http://localhost:8080/app/getBookListAll",
				{day1:bookdate1,day2:bookdate2},
				function(result){
			console.log(result);
			bookdate1=new Date(bookdate1);
			bookdate2=new Date(bookdate2);
			if(bookdate1>bookdate2){
				alert('체크인날짜가 체크아웃보다 나중일 수 없습니다.');
				return false;
			}
			$('#reserveRoom2').empty();
			$.each(result,function(ndx,value){
				str='<option value="'+value['roomcode']+'">'+value['roomname']+','
				+value['typename']+','+value['howmany']+','+value['howmuch']+'</option>';
				$('#reserveRoom2').append(str);
			});
		},'json');
	}
	 	
	bookdate1=$('#date1').val();
	bookdate2=$('#date2').val();
	$.post("http://localhost:8080/app/getBooked",
			{day1:bookdate1,day2:bookdate2},
			function(result){
		console.log(result);
		$('#comroom').empty();
		$.each(result,function(ndx,value){
			str='<option value="'+value['roomcode']+'">'+value['roomname']+','+value['typename']+','+
			value['bookingname']+','+value['mobile']+','+
			value['bookingpeople']+','+value['roompeople']+','
			+value['bookdate1']+'~'+value['bookdate2']+','+value['roomprice']+'</option>'
			  console.log(str);
			  $('#comroom').append(str);
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
	$('#date3').val($('#date1').val());
	$('#date4').val($('#date2').val());
	let code=$(this).val();
	console.log(code);
	console.log($('#roomcode').val(code));
	$('#roomcode').val(code);//DB호출을 위한 KEY값 저장, 나중에 삭제할때 써먹으려고 씀.
	
	return false;
})
.on('click','#comroom option',function(){
	let a=$(this).text();
	let ar=a.split(',');
	$('#roomname').val(ar[0]);
	$('#roomtypelist option:contains("'+ar[1]+'")').prop('selected','selected');
	$('#bookName').val(ar[2]);
	$('#telNum').val(ar[3]);
	$('#bookpeople').val(ar[4]);
	$('#roompeople').val(ar[5]);
	$('#roompriceall').val(ar[7]);
	$('#date3').val($('#date1').val());
	$('#date4').val($('#date2').val());
	let code=$(this).val();
	console.log(code);
	console.log($('#comroom').val(code));	
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
	$('#roomname,#roomtypelist,#roompeople,#date1,#date2,#date3,#date4,#bookpeople,#roompriceall,#telNum,#bookName').val('');
	$('#reserveRoom2').children('option').remove();
	$('#comroom').children('option').remove();
	return false;
	
})

.on('click','#btnRegister2',function(){	
	let roomcode=$('#roomcode').val();
	let bookdate1=$('#date3').val();
	let bookdate2=$('#date4').val();
	let bookdate=String(bookdate1)+'~'+String(bookdate2);
	let roomname=$('#roomname').val();
	let roomtypelist=$('#roomtypelist option:selected').text();
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
	if($('#roomcode').val()!=''){//insert
		$.post('http://localhost:8080/app/addBookRoom',
	  {roomcode:$('#roomcode').val(),roompriceall:roompriceall,bookpeople:bookpeople,bookName:bookName,bookdate1:bookdate1,bookdate2:bookdate2,mobile:mobile},
	  function(result){
		  if(result=='ok'){
			  str='<option>'+roomname+' '+roomtypelist+' '+'예약자명:'+bookName+' '+'전화번호:'+mobile+' '+bookpeople+'명'+'/'+roompeople+'명'+' '+bookdate1+'~'+bookdate2+' '+roompriceall+'원'+'</option>'
			  console.log(str);
			  $('#comroom').append(str);
			  $('#roomname,#roomtypelist,#roompriceall,#roompeople,#date1,#date2,#date3,#date4,#bookpeople,#roomPrice,#telNum,#bookName').val('');
			  $('#reserveRoom2').children('option').remove();
		  return false;
			}
		},'text');
	}
})
.on('click','#btnDelete2',function(){
	$.post('http://localhost:8080/app/deleteBookRoom',
			{roomcode:$('#roomcode').val()},
			function(result){
		if(result=="ok"){
			$('#comroom option:selected').remove();
			return false;
		} else{
			alert("삭제가 완료되지 않았습니다.");
		}
	},'text');
})
.on('click','#btnUpdate',function(){
	let roomcode=$('#roomcode').val();
	let roomname=$('#roomname').val();
	let bookpeople=$('#bookpeople').val();
	let bookname=$('#bookName').val();
	let mobile=$('#telNum').val();
	let roomtypelist=$('#roomtypelist option:selected').text();
	let roompeople=$('#roompeople').val();
	let roompriceall=$('#roompriceall').val();		
	let bookdate1=$('#date1').val();
	let bookdate2=$('#date2').val();	
	$.post('http://localhost:8080/app/updateBook',
		{roomcode:roomcode,bookingpeople:bookpeople,
		bookingname:bookname,mobile:mobile},
		function(result){
			if(result=='ok'){
				console.log(result);
				alert("예약수정이 완료되었습니다.");
				str='<option>'+roomname+','+roomtypelist+','+
				bookname+','+mobile+','+bookpeople+','+roompeople+','
				+bookdate1+'~'+bookdate2+','+roompriceall+'</option>'
				$("#comroom option:selected").html(str);
			}
		}, 'text');
	return false;
})

</script>

</html>