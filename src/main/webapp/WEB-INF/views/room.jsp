<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>객실관리</title>   
    <link href="${path}/resources/css/style.css" rel="stylesheet" type="text/css">
    
</head>
<body>
<button type="button" style="float:right;" onclick="location.href='home'">  로그아웃  </button>
    <div id="header">
        <h1 style="font-size: 45px;">관리자홈페이지-객실관리</h1><br>
        <h2 style="font-size: 20px;"><a href="booking">예약관리</a>  
        <a href="#"><u>객실관리</u></a></h2>
    </div>
    <div id="leftnav">
    </div>
    <div id="nav">
        <h2 style="text-align:center;">객실목록</h2>        
        <select id="reserveRoom2" size="6" style="width: 260px; height: 300px; 
        font-size: 15px; padding-top: 10px;  padding-left: 5px;">
       <%--  <c:forEach items="${list}" var="room">
	        <option value="${room.roomcode}">${room.roomname},${room.typename},${room.howmany},${room.howmuch}</option>
        </c:forEach> --%>
        <!-- forEach문으로 반복하여 나타낸다. -->
        </select>        
    </div>
    <div id="nav1">
    <h2 style="text-align:center;">객실 정보</h2>
    <table>
        <tr>
            <td>객실명</td>
            <td><input type="text" id="roomName">
            <input type=hidden id="roomcode"></td>
        </tr>
        <tr>
            <td>객실분류</td>
            <td><select id="selType" size="5" style="width: 175px; height: 120px; font-size:15px;"><br>
            <c:forEach items="${type}" var="roomtype">
	        	<option value='${roomtype.typecode}'>${roomtype.typecode}.${roomtype.name}</option>
        	</c:forEach>
                </select></td>
        </tr>
        <tr>
            <td>최대숙박인원</td>
            <td><input type="number" id="txtNum"></td>
        </tr>
        <tr>
            <td>1박 요금</td>
            <td><input type="text" id="roomPrice"></td>
        </tr>
        <tr>
        <td colspan=2 align=center>
        <br>
        	<input type=button value='등록/수정' id="btnAdd">&nbsp;
        	<input type=button value='삭제' id="btnDelete">&nbsp;
        	<input type=button value='Clear' id="btnClear">
        </td>
        </tr>
    </table>
  </div>   
</body>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script>
$(document)
.ready(function(){//ajax호출
	$.post("http://localhost:8080/app/getRoomList",{},function(result){
		console.log(result);
		$.each(result,function(ndx,value){
			str='<option value="'+value['roomcode']+'">'+value['roomname']+','+
			value['typename']+','+value['howmany']+','+value['howmuch']+'</option>';
			$('#reserveRoom2').append(str);
		});
	},'json');
})
.on('click','#reserveRoom2 option',function(){
	let a=$(this).text();
	let ar=a.split(',');
	$('#roomName').val(ar[0]);
	$('#selType option:contains("'+ar[1]+'")').prop('selected','selected');
	$('#txtNum').val(ar[2]);
	$('#roomPrice').val(ar[3]);
	let code=$(this).val();
	$('#roomcode').val(code);//DB호출을 위한 KEY값 저장, 나중에 삭제할때 써먹으려고 씀.
	return false;
	
	})
.on('click','#btnClear',function(){
	$('#roomName,#txtNum,#roomPrice,#selType,#roomcode').val('');
	return false;
})
.on('click','#btnDelete',function(){
	$.post('http://localhost:8080/app/deleteRoom',
			{roomcode:$('#roomcode').val()},
			function(result){
		if(result=="ok"){
			$('#btnClear').trigger('click');//Clear버튼 클릭 작동.
			$('#reserveRoom2 option:selected').remove(); //roomlist에서 제거
			return false;
		}
	},'text');
})
.on('click','#btnAdd',function(){
	let roomcode=$('#roomcode').val();
	let roomname=$('#roomName').val();
	let roomtype=$('#selType').val();
	let howmany=$('#txtNum').val();
	let howmuch=$('#roomPrice').val();	
	//validation(유효성 검사)
	if(roomname==''||roomtype==''||howmany==''||howmuch==''){
		alert("누락된 값이 있습니다.");
		return false;
	}
	if($('#roomcode').val()==''){//insert
		$.post('http://localhost:8080/app/addRoom',
	  {roomname:roomname,roomtype:roomtype,howmany:howmany,howmuch:howmuch},
	  function(result){
		  if(result=='ok'){
			  console.log(result);
			  location.reload();
		  }
	  },'text');
	} else {//update
		$.post('http://localhost:8080/app/updateRoom',
		{roomcode:roomcode,roomname:roomname,roomtype:roomtype,
			howmany:howmany,howmuch:howmuch},
		function(result){
			if(result=='ok'){
				console.log(result);
				location.reload();
			}
		}, 'text');
	}
	return false;
})
</script>
</html>