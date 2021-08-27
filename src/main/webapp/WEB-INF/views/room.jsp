<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

    <div id="header">
    	
        <h1 style="font-size: 45px;">관리자홈페이지-객실관리</h1><br>
        <h2 style="font-size: 20px;"><a href="booking">예약관리</a>  
        <a href="#"><u>객실관리</u></a></h2>

    </div> 
    <button type="button" style="float:right;" onclick="location.href='home'">  로그아웃  </button>
    
    <div id="nav">
        <h2 style="margin-left: 40px; font-size: 23px;">객실목록</h2>
        <div id="roomlist">
        <h3>백두산 Suite Room 4명</h3>
        <h3>한라산 Family Room 6명</h3>
        <h3>설악산 Double Room 4명</h3>
        <h3>지리산 Single Room 2명</h3>
        <h3>북한산 Single Room 2명</h3>
        <h3>태조산 Single Room 2명</h3>
        <h3>남산 Single Room 2명</h3>
        </div>
    </div>
    <div id="sectionMenu">
        <h2>객실이름</h2><br>
        <h2>객실분류</h2>
        <br><br><br><br><br>
        <h2>숙박가능인원</h2>
        <h2>1박요금</h2>
    </div>
    <div id="section">
        <input type="text"><br><br> <br>   
        <select size="5" style="width: 150px; font-size: 16px;" multiple><br>
            <option>백두산</option>
            <option>한라산</option>
            <option>설악산</option>
            <option>지리산</option>
            <option>북한산</option>
            <option>태조산</option>
            <option>남산</option>
           </select><br><br><br><br>   
        <input type="number"><br><br>        
        <input type="text">원<br><br><br><br><br>
        <input type="button" id="btnRegister" value="  등록  ">
        <input type="button" id="btnDelete" value="  삭제  ">
        <input type="button" id="btnClear" style="height: 24px;"  value="  Clear  ">
    </div>
    <div id="footer">       
    </div>
</body>
</html>