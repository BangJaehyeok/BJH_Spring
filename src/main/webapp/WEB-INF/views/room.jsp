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
    <div id="nav">
        <h2>객실목록</h2>
        <select id="reserveRoom2" size="6" style="width: 350px; height: 250px; 
        font-size: 15px; padding-top: 10px; padding-left: 5px;">
        <c:forEach items="${list}" var="room">
	        <option id="listName" value="${room.roomcode}">${room.roomname},${room.typename},${room.howmany},${room.howmuch}</option>
        </c:forEach>
        <!-- forEach문으로 반복하여 나타낸다. -->
        </select>
    </div>
    <h2>객실 정보</h2>
    <table>
        <tr>
            <td>객실명</td>
            <td><input type="text" id="roomName"><input type=hidden id=roomcode></td>
        </tr>
        <tr>
            <td>객실분류</td>
            <td><select  id="selType" size="5" style="width: 175px; height: 120px; font-size:15px;"><br>
            <c:forEach items="${type}" var="room">
	        	<option value='${room.typecode}'>${room.typecode}.${room.name}</option>
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
        	<input type=button value='등록' id="btnAdd">&nbsp;
        	<input type=button value='삭제' id="btnDelete">&nbsp;
        	<input type=button value='Clear' id="btnDelete">
        </td>
        </tr>

    </table>
    <div id="footer">       
    </div>
</body>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script>
$(document)
.on('click','#listName',function(){
    $('#roomName').val($("#reserveRoom2 option:selected").text().split(',')[0]); 
    $('#txtNum').val($("#reserveRoom2 option:selected").text().split(',')[2]);
    $('#roomPrice').val($("#reserveRoom2 option:selected").text().split(',')[3]);
    $('#selType option:eq(0)').prop("selected", true);
	})
</script>
</html>