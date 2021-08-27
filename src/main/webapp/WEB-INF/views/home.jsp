<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선택</title>
</head>
<body>
<h1>HOME</h1>
<p>로그인</p>	
	<form method=post action="/app/check_user">	
	ID : <input type=text name=userid><br>
	PW : <input type=password name=passcode><br><br>
	<input type=submit value='로그인'>&nbsp;
	<button type="button" onclick="location.href='selected?path=newbie'">  회원가입  </button>	
</form>
</body>
</html>