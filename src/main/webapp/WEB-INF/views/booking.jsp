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
        <h2>객실분류</h2>
        <select size="4" style="width: 150px; font-size: 16px;" multiple><br>
            <option>백두산</option>
            <option>한라산</option>
            <option>설악산</option>
            <option>지리산</option>
            <option>태조산</option>                        
           </select> 
           <input type="button" value="찾기">          

        </div>
        <div id="reserveRoom">
        <h2>예약가능한 객실</h2>
        <select id="reserveRoom2" size="6" style="width: 250px; height: 250px; font-size: 18px;"><br>
            <option id="room1">백두산 SuiteRoom</option>
            <option id="room2">한라산 FamilyRoom</option>
            <option id="room3">설악산 DoubleRoom</option>
            <option id="room4">지리산 SingleRoom</option>
            <option id="room5">태조산 SingleRoom</option>
        </select>   
        </div>
    </div>
    <div id="sectionMenu2">
        <h2>객실이름</h2>
        <input type="text" id="roomname" value="">
        <h2>숙박기간</h2>
        <input type="date" id="date3" min="2021-08-30">~
        <input type="date" id="date4" min="2021-08-30">
        <h2>숙박인원</h2>
        <input id="roompeople" type="number">
        <h2>1박요금</h2>
        <input type="text" id="roomPrice">원
        <h2>총 숙박비</h2>
        <input type="text" id="roomSum">원
        <h2>예약자 모바일</h2>
        <input type="text" id="telNum"><br><br><br>
        <input type="button" id="btnRegister2" value="  등록  ">
        <input type="button" id="btnDelete2" value="  삭제  ">
        <input type="button" id="btnClear2" style="height: 24px;"  value="  Clear  ">
    </div>
    <div id="section2">
        <h2 style="font-size: 22px;">예약된 객실</h2>
        <div id="comroom" style="width: 100%; height: 600px; text-align: left;float: left;    
        margin-left: 0px; border: 1px black solid;">
    </div>    
</body>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>

<script>
$(function(){
	$("#datepicker").datepicker();
});
$(document)

.on('dblclick','#room1',function(){
    $('#roomname').val('백두산');    
    $('#roomPrice').val('500,000');       
    return false;
})
.on('dblclick','#room2',function(){
    $('#roomname').val('한라산');    
    $('#roomPrice').val('450,000');
    return false;
})
.on('dblclick','#room3',function(){
    $('#roomname').val('설악산');
    $('#roomPrice').val('300,000');
    return false;
})
.on('dblclick','#room4',function(){
    $('#roomname').val('지리산');
    $('#roomPrice').val('150,000');
    return false;
})
.on('dblclick','#room5',function(){
    $('#roomname').val('태조산');    
    $('#roomPrice').val('125,000');
    return false;
})
.on('click','#btnRegister2',function(){
    if($('#roomname').val()!=""){
         $('#comroom').append($('#roomname').val()+' '+$('#roompeople').val()+'명'+'<br>'
        +'숙박기간 : '+$('#date3').val()+'~'+$('#date4').val()+'<br>'+' 전화번호 : '+$('#telNum').val()
        +'<br>')        
    }
    $('#roomname').val('');
    $('#date3').val('');
    $('#date4').val('');
    $('#roompeople').val('');
    $('#roomPrice').val('');  
    $('#telNum').val('');  
})
</script>

</html>