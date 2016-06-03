<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="/MyUsed/main/main.css" />
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="/MyUsed/main/script.js"></script>

<div id="layer_fixed"><jsp:include page="/main/layer_fixed.jsp"/></div> <!-- 상단 검색 Top -->
<div id="sidebannerR"><jsp:include page="/main/sidebannerR.jsp"/></div> <!-- 사이드배너 Right  -->
<div id="advertise" ><jsp:include page="/main/advertise.jsp"/></div>  <!-- 광고 페이지  -->
<div id="sidebannerL"><jsp:include page="/main/sidebannerL.jsp" /></div> <!-- 사이드배너 Left -->

<div id="contents">
<br/><br/><br/><br/><br/>

<form action="paperchatSend.nhn" method="post">
	<center>
			<table border="0">
			    <tr>
			    	<c:if test="${name == null}">
			    		<td>받는사람 <input type="text" name="r_name" size="35"/>
			    	</c:if>
			    	
			    	<c:if test="${name != null}">
			    		<td>받는사람 <input type="text" name="r_name" size="35" value="${name}"/>
			    	</c:if>
			    </tr>
			    
			  	<tr>
			  		<td><textarea rows="15" cols="57" name="r_content"></textarea></td>
			  	</tr>
			  	<tr>
			  		<input type="hidden" name="mynum" value="${mynum}">
			  		<td align="right">
			  			<input type="submit" value="보내기"/>
			  		</td>
			  	</tr>
			</table>
	</center>
</form>

</div>