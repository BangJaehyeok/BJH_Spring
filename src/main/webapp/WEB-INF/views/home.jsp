<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선택</title>
</head>
<body>
<h1 style="text-align: center; font-size:40px; margin-top: 5%;">HOME</h1>
<div style="margin-left: auto; margin-right: auto;
 width: 400px; height: 250px; 
border: 1px solid black; margin-top: 5%;">
<p style="text-align: center; font-size:larger; font-weight:1000; padding-top: 20px;">관리자 로그인</p>
	<form method=post action="/app/check_user">	
	<p style="text-align: center;">ID : <input type=text name=userid><br>
	<p style="text-align: center;">PW : <input type=password name=passcode><br><br>
	<input type=submit value='로그인'>&nbsp;
	<button type="button" onclick="location.href='selected?path=newbie'">  회원가입  </button>	
	</p>
</form>
</div>
</body>
</html>