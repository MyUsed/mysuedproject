<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<table align="center" width="100%" bgcolor="#3B5998">
			<tr><td style="vertical-align:left; padding-left: 30px; padding-right: 80px;">
			<a href="/MyUsed/Admin.nhn">
			<img src="/MyUsed/images/Mlogo2.png" width="170"  height="50">
			</a>
			</td>
			<td style="vertical-align:right; padding-left: 730px;">
			<input type="button" value="包府磊包府" onclick="javascript:window.location='/MyUsed/AdminMember.nhn'"/>  
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<c:if test="${sessionScope.adminId != null }">
					<a href="/MyUsed/MyUsedAdminLogout.nhn" onmouseover="this.style.textDecoration='none'"><font color="#F6F6F6">肺弊酒眶</font></a>
			</c:if>
			</td></tr>
	</table>
	<table align="center" border="1" width="100%" bgcolor="#3B5998">
		<tr align="center"><td><font color="white">雀盔包府</font></td> <td><font color="white">其捞瘤包府</font></td> 
		<td><font color="white">霸矫臂包府</font></td><td><font color="white">硅价包府</font></td>
		<td><font color="white">堡绊包府</font></td><td><font color="white">绊按季磐包府</font></td></tr>
	</table>
</body>
</html>