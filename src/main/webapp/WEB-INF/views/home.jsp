<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hotel Login</title>
</head>
<body style="background-image: url('./resources/img/hotel.jpg');
background-repeat: no-repeat;
background-size: cover;">
<h1 style="margin-left: auto; margin-right: auto; text-align: center; color: pink; border: violet 1px solid; width: 450px; font-size:50px; margin-top: 7%;">HOTEL SYSTEM</h1>
<div style="margin-left: auto; margin-right: auto;
 width: 400px; height: 250px; background-color: white;
border: 1px solid black; margin-top: 5%;">
<p style="text-align: center; font-size:larger; font-weight:1000; padding-top: 20px;">관리자 로그인</p>
	<form method=post action="/app/check_user" id="frmLogin">	
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
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script>
$(document)
.on('submit','#frmLogin',function(){
	let pstr=$.trim($('input[name=userid]').val());
	$('input[name=userid]').val(pstr);
	pstr=$.trim($('input[name=passcode]').val());
	$('input[name=passcode]').val(pstr);
	if($('input[name=userid]').val()==''){
		alert('로그인 아이디를 입력하세요.');
		return false;
	}
	if($('input[name=passcode]').val()=''){
		alert('비밀번호를 입력하시오.');
		return false;
	}
})
</script>
</html>