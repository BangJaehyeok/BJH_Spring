<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입정보</title>
</head>
<body>
회원가입에 성공하셨습니다.
<p><회원가입정보></p>
ID : ${userid }<br>
PW : ${ passcode}<br>
이름 : ${realname }<br>
번호 : ${mobile }<br><br>
<button type="button" onclick="location.href='home'">돌아가기</button>&nbsp;&nbsp;
<button type="button" onclick="location.href='selected?path=login'">로그인</button>	
</body>
</html>