<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<c:if test="${sessionScope.memId == null}">
	<script type="text/javascript">
		alert("로그인 후에 이용하실 수 있습니다.");
		history.go(-1);
	</script>
</c:if>

<c:if test="${sessionScope.memId != null}">
<html>
	<head>
		<meta charset="euc-kr" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
		<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
		<meta name="description" content="Accordion with CSS3" />
		<meta name="keywords" content="accordion, css3, sibling selector, radio buttons, input, pseudo class" />
		<meta name="author" content="Codrops" />
		<link rel="stylesheet" type="text/css" href="accordian/css/style.css" />
		<script type="text/javascript" src="/accordian/js/modernizr.custom.29473.js"></script>
		<script type="text/javascript" src="/accordian/js/accordian.js"></script>	
	</head>

<body>
<h3>공지사항</h3>
	<c:if test="${count == 0}">
    		게시글이 없습니다. <br /><br/>
    	<input type="button" value ="글쓰기" onclick="location.href='/MyUsed/Reportwirte.nhn'"/>
	</c:if>
	<c:if test="${count != 0}">
					<table  width="500">
						<tr border="0">
							<td align="right"><a onclick="location.href='/MyUsed/Notice.nhn'">자세히 보기</a></td>
						</tr>
				     </table>
					<table border="1" width="500" height="20">
				
					<tr bgcolor="#3B5998">
						<th width="20">번호</th>
						<th width="130">제목</th>
					<!-- 	<th width="50">조회수</th> -->
						<th width="50">작성자</th> 
						<th width="50">작성일</th>
					</tr>
				</table>
				<c:forEach var="list" items="${list}" varStatus="i">
					<table border="1" width="500" height="20">
					<tr>
						<td width="20">${i.count}</td>
						<td width="130">
							<c:if test="${fn:length(list.title) > 20}">
								${fn:substring(list.title,0,19)}...
							</c:if>
							
							<c:if test="${fn:length(list.title) < 20}">
								${list.title}
							</c:if>
						</td>
						<%-- <td width="50">${list.readcount}</td> --%>
						<td width="50">관리자</td>
						<td width="50">
							<c:if test="${fn:length(list.reg) > 11}">
								${fn:substring(list.reg,0,10)}
							</c:if>
						 </td>
					</tr>
					</table>
				</c:forEach>
	</c:if>
</body>
</html>
</c:if>