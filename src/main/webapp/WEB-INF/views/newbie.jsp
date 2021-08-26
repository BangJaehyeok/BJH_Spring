<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<form method=get action="/app/newinfo">
	이름 : <input type=text name=realname><br>
	아이디 : <input type=text name=userid><br>
	PW : <input type=password name=passcode><br>
	PW 확인 : <input type=password name=passcode><br>
	Mobile : <input type="tel" name=mobile><br><br>
	<input type=submit value='회원가입'>&nbsp;
	<button type="button" onclick="location.href='home'">돌아가기</button>		
</form>
</body>
</html>