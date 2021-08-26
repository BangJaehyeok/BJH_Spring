<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<form method=get action="/app">
	이름 : <input type=text name=realname><br>
	아이디 : <input type=text name=userid><br>
	PW : <input type=password name=passcode1><br>
	PW 확인 : <input type=password name=passcode2><br>
	Mobile : <input type="tel" name=mobile><br><br>
	<input type=submit value='회원가입'>&nbsp;
	<input type="button" value='cancle'>
	
</form>
</body>
</html>