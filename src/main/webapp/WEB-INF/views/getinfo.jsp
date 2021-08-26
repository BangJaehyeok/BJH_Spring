<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Get Info</title>
</head>
<style>
td{
	width:50px;
	height:30px;
}
</style>
<body>
<table border=1>

<%! int k=1; %> 
<%
	int k=1;
	for(int i=0;i<5;i++){
		out.println("<tr>");
		for(int j=0;j<4;j++){
			out.println("<td align=center>"+k+"</td>");
			k++;
		}
		out.println("</tr>");
	}
%>
<%
	for(int i=0;i<5;i++){
%>
<tr>
<%
	for(int j=0;j<4;j++){
%>
<td align=center><%=k %></td>
<%
	k++;
	}
	out.println("</tr>");
	}
%>
</table>
</body>
</html>