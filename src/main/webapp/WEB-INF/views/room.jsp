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
        <select id="reserveRoom2" size="6" style="width: 250px; height: 250px; 
        font-size: 18px; padding-top: 10px; padding-left: 10px;">
        <c:forEach items="${list}" var="room">
	        <option>${room.roomcode},${room.name},${room.type},${room.howmany},${room.howmuch}</option>
        </c:forEach>
        <!-- forEach문으로 반복하여 나타낸다. -->
        </select>
    </div>
    <h2>객실 정보</h2>
    <table>
        <tr>
            <td>객실이름</td>
            <td><input type="text" id="roomName"></td>
        </tr>
        <tr>
            <td>객실분류</td>
            <td><select size="2" style="width: 175px; height: 120px;"><br>
                    <option id="room1">백두산 SuiteRoom</option>
                    <option id="room2">한라산 FamilyRoom</option>
                    <option id="room3">설악산 DoubleRoom</option>
                    <option id="room4">지리산 SingleRoom</option>
                    <option id="room5">태조산 SingleRoom</option>
                </select></td>
        </tr>
        <tr>
            <td>숙박가능인원</td>
            <td><input type="number"></td>
        </tr>
        <tr>
            <td>1박 요금</td>
            <td><input type="text" id="roomPrice"></td>
        </tr>

    </table>
    <div id="footer">       
    </div>
</body>
</html>