<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body style="background-image: url('./resources/img/hotel.jpg');
background-repeat: no-repeat;
background-size: cover;">
<div style="margin-left: auto; margin-right: auto;
 width: 400px; height: 550px; background-color:white;
border: 1px solid black; margin-top: 10%;">
<p style="text-align: center; font-size:28px; font-weight:1000; padding-top: 20px;">회원가입</p>
<form method=post action="/app/join" id="frmjoin">
    <table cellpadding="5" cellspacing="0" style="margin-left: 25px;">
    <tr>
        <td>이름 :</td>
        <td><input type="text" name="realname">
        </td>
    </tr>
      <tr>
        <td>ID :</td>
        <td><input type="text" name="loginid">
        </td>
      </tr>
      <tr>
        <td>PW :</td>
        <td><input type="password" name="passcode1">
        </td>
      </tr>
      <tr>
        <td>PW확인 :</td>
        <td><input type="password" name="passcode2">
        </td>
      </tr>
      
    </table>    
	<br>
	<p style="text-align: center;"><input type=submit value=' 회원가입 '>&nbsp;
	<button type="button" onclick="location.href='home'"> 돌아가기 </button>
</p>	
</form>
</div>
</body>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script>
$(document)
.on('submit','#frmjoin',function(){
	if($('input[name=realname]').val()==''){
		alert('이름을 입력하시오');
		return false;
	}
	if($('input[name=loginid]').val()==''){
		alert('아이디를 입력하시오');
		return false;
	}
	if($('input[name=passcode1]').val()==''){
		alert('비밀번호를 입력하시오');
		return false;
	}
	if($('input[name=passcode1]').val()!=$('input[name=passcode2]').val()){
		alert('비밀번호가 일치하지 않습니다');
		return false;
	}
	alert('회원가입이 완료되었습니다.');
	return true;
})
</script>
</html>