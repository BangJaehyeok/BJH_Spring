<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String loginid=(String)session.getAttribute("loginid");
	String passcode=(String)session.getAttribute("passcode");
	out.println(loginid);
	if(!loginid.equals("admin")||!(passcode.equals("1234"))){		
		response.sendRedirect("http://localhost:8080/app/selected?path=login");
	}
%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예약관리</title>
    <link href="${path}/resources/css/style.css" rel="stylesheet" type="text/css">
    <style>
        .menu a{cursor:pointer;}
        .menu .hide{display:none;}
    </style>
</head>
<body>
    <div id="header">
        <h1 style="font-size: 45px;">관리자홈페이지-예약관리</h1><br>
        <h2 style="font-size: 20px;"><a href="#">예약관리</a>  
        <a href="room"><u>객실관리</u></a></h2>
    </div>    
    <button type="button" style="float:right;" onclick="location.href='home'">  로그아웃  </button>
    <div id="nav2">        
        <div id="findRoom">
        <h2>숙박기간</h2>
        <input type="date">~<input type="date">
        <h2>객실분류</h2>
        <select size="3" style="width: 100px; font-size: 15px;" multiple><br>
            <option>백두산</option>
            <option>한라산</option>
            <option>설악산</option>
            <option>지리산</option>
            <option>북한산</option>
            <option>태조산</option>
            <option>남산</option>            
           </select> 
           <input type="button" value="찾기">          

        </div>
        <div id="reserveRoom">
        <h2>예약가능한 객실</h2>
            <h3>백두산 Suite Room 4명</h3>
        <h3>한라산 Family Room 6명</h3>
        <h3>설악산 Double Room 4명</h3>
        <h3>지리산 Single Room 2명</h3>
        <h3>북한산 Single Room 2명</h3>
        <h3>태조산 Single Room 2명</h3>
        <h3>남산 Single Room 2명</h3>
        </div>
    </div>
    <div id="sectionMenu2">
        <h2>객실이름</h2>
        <input type="text" value="">
        <h2>숙박기간</h2>
        <input type="date">~<input type="date">
        <h2>숙박인원</h2>
        <input type="number">
        <h2>1박요금</h2>
        <input type="text" id="roomPrice">원
        <h2>총 숙박비</h2>
        <input type="text" id="roomSum">원
        <h2>예약자 모바일</h2>
        <input type="tel" id="telNum"><br><br><br>
        <input type="button" id="btnRegister2" value="  등록  ">
        <input type="button" id="btnDelete2" value="  삭제  ">
        <input type="button" id="btnClear2" style="height: 24px;"  value="  Clear  ">
    </div>
    <div id="section2">
        <h2 style="font-size: 22px;">예약된 객실</h2>
        <select size="8" style="width: 200px; font-size: 20px;" multiple><br>
            <option>백두산</option>
            <option>한라산</option>
            <option>설악산</option>
            <option>지리산</option>
            <option>북한산</option>
            <option>태조산</option>
            <option>남산</option>
           </select>
    </div>
    <div id="footer2">       
    </div>
</body>

</html>