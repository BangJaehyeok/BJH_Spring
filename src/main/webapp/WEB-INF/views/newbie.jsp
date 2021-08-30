<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<div style="margin-left: auto; margin-right: auto;
 width: 400px; height: 550px; 
border: 1px solid black; margin-top: 5%;">
<p style="text-align: center; font-size:28px; font-weight:1000; padding-top: 20px;">회원가입</p>
<form method=get action="/app/newinfo">
    <table cellpadding="5" cellspacing="0" style="margin-left: 25px;">
      <tr>
        <td>ID :</td>
        <td><input type="text" name="userid">
            <input type="button" value="중복확인">
        </td>
      </tr>
      <tr>
        <td>PW :</td>
        <td><input type="password" name="passcode">
        </td>
      </tr>
      <tr>
        <td>PW확인 :</td>
        <td><input type="password" name="passcode">
        </td>
      </tr>
      <tr>
        <td>이름 :</td>
        <td><input type="text" name="realname">
        </td>
    </tr>
     <tr>
        <td>전화번호 :</td>
        <td><input type="tell" name="mobile">
        </td>
      </tr>
      <tr>
        <td>주소 :</td>
        <td><input type="text" name="address">
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
</html>