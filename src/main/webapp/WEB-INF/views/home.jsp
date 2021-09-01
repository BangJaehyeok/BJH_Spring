<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hotel Login</title>
</head>
<body>
<h1 style="text-align: center; font-size:50px; margin-top: 7%;">HOTEL SYSTEM</h1>
<div style="margin-left: auto; margin-right: auto;
 width: 400px; height: 250px; 
border: 1px solid black; margin-top: 5%;">
<p style="text-align: center; font-size:larger; font-weight:1000; padding-top: 20px;">관리자 로그인</p>
	<form method=post action="/app/check_user">	
	<table cellpadding="5" cellspacing="0" style="margin-left: auto; margin-right: auto;">
		<tr>
			<td>ID :</td>
			<td><input type=text name=userid></td>	
		</tr>
		<tr>
			<td>PW :</td>
			<td><input type=password name=passcode></td>	
		</tr>
	</table><br>	
	<p style="text-align: center;"><input type=submit value='로그인'>&nbsp;
	<button type="button" onclick="location.href='selected?path=newbie'">  회원가입  </button>	
	</p>
</form>
</div>
</body>
</html>