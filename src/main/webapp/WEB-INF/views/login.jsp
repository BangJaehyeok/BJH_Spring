<!-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
<div style="margin-left: auto; margin-right: auto;
 width: 400px; height: 250px; 
border: 1px solid black; margin-top: 10%;">
<p style="text-align: center; font-size:larger; padding-top: 20px;">관리자 로그인</p>
	<form method=post action="/app/check_user">	
	<p style="text-align: center;">ID : <input type=text name=userid></p1><br>
	<p style="text-align: center;">PW : <input type=password name=passcode></p1><br><br>
	<input type=submit value='로그인'>&nbsp;
	<button type="button" onclick="location.href='home'">돌아가기</button>	
</form>
</div>
</body>
</html>