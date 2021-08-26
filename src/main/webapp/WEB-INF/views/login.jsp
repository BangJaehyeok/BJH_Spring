<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
<p>로그인</p>	
	<form method=get action="/app/viewinfo">	
	아이디 : <input type=text name=userid><br>
	PW : <input type=password name=passcode><br><br>
	<input type=submit value='로그인'>&nbsp;
	<button type="button" onclick="location.href='home'">돌아가기</button>	
</form>
</body>
</html>