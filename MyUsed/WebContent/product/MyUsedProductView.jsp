
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/MyUsed/product/ProductView.css" />
<title>상품</title>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript">

   function callAjax(aa){
	   //alert(aa);
	   var num = document.getElementById("num"+aa);
	   //alert(num.value);
       $.ajax({
	        type: "post",
	        url : "/MyUsed/ProductDetailView.nhn",
	        data: {	// url 페이지도 전달할 파라미터
	        	num : num.value,
	        },
	        success: successRequest,	// 페이지요청 성공시 실행 함수
	        error: whenError	//페이지요청 실패시 실행함수
    	});
   }
   function successRequest(aaa){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
       $("#body").html(aaa);
       console.log(resdata);
   }
   function whenError(){
       alert("Error");
   }
   
   
   /** 전체 상품 카테고리 보기 */
   function callTotalCateg(){
       $.ajax({
	        type: "post",
	        url : "/MyUsed/TotalCateg.nhn",
	        success: callCateg,	// 페이지요청 성공시 실행 함수
	        error: Error	//페이지요청 실패시 실행함수
    	});
   }
   function callCateg(aaa){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
       $("#sidebannerL").html(aaa);
       console.log(resdata);
   }
   function Error(){
       alert("Error");
   }
   
   
</script>

</head>
<body>

<div id="layer_fixed">
<form action="/MyUsed/MyUsedSearchMember.nhn" method="post">
	<table cellspacing="0" cellpadding="0" style="width:100%; height:100%;">
		<tr>
			<td style="vertical-align:left; padding-left: 30px; padding-right: 80px;">
			<a href="/MyUsed/MyUsed.nhn">
			<img src="/MyUsed/images/Mlogo2.png" width="170"  height="50">
			</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
			<!-- 친구찾기 -->
				<input type="text" size="70" name="member"/>
				<button type="submit"><img src="/MyUsed/images/Search.png" width="20"  height="20"></button>
			
			
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				<img src="/MyUsed/images/profile/${sessionproDTO.profile_pic}" width="15"  height="15">
				<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${memDTO.num}">${memDTO.name}</a> | 
				<a href="/MyUsed/MyUsed.nhn">홈</a> | 
				<a href="/MyUsed/MyUsed.nhn">친구찾기</a>
				
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/mainFriend.png" width="45"  height="40"></a>
				<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/mainMessage.png" width="40"  height="35"></a>
				<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/mainView.png" width="40"  height="35"></a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<!-- 추후 이미지로 바꾸기(페이스북처럼 드롭다운메뉴로) -->
				<c:if test="${sessionScope.memId != null }">
					<a href="/MyUsed/MyUsedLogout.nhn">로그아웃</a>
				</c:if>
			</td>
			
		</tr>
	</table>
	</form>
</div>

<div id="body">
</div>

<div id="contents">
<center>
	<br /><br />
	
	<div id="subject">
	<table border="0" align="center" width="670">
		<tr>
			<td align="left">
				<c:if test="${categ2 == null}">
				${categ}
				</c:if>
				<c:if test="${categ2 != null}">
				${categ2}
				</c:if>
				
			</td>
			<td align="right">
				<font size="2">
				<select>
					<option>최신등록</option>
					<option>낮은가격</option>
					<option>높은가격</option>
				</select>
				</font>
			</td>
		</tr>
	</table>
	</div>

	<br /><br />
	<c:if test="${totalCount == 0}">
	<br /><br />
		<font size="4">등록된 상품이 없습니다</font>
	</c:if>
	
	<c:if test="${totalCount != 0}">
	<table border="0" align="center">
		<tr height="310">
		<c:forEach begin="0" step="1" end="2" var="proList" items="${proList}" varStatus="i">
			<td width="250" valign="top" align="center">
			<div id="proview">
			<form id="pro_detile" name="pro_detile">
				<div id="proview_img">
					<img src="/MyUsed/images/${proList.pro_pic}" onclick="callAjax('${i.count}')" style="width:200px; height:200px; border-top-left-radius:7px; border-top-right-radius:7px;">
				</div>
				<div id="proview_sub">
					<font size="5" color="#3B5998">
						<font size="3" color="#1F51B7" ><b><fmt:formatNumber value="${proList.price}" type="number" />원</b></font>
					</font>
				</div>
				<input type="hidden" name="num" id="num${i.count}" value="${proList.num}">
				<input type="button" id="detail" style='display: none;' >
			</form>
			</div>
   	
			</td>
		</c:forEach>
		</tr>
		
		<tr height="310">
		<c:forEach begin="3" step="1" end="5" var="proList" items="${proList}" varStatus="i">
			<td width="250" valign="top" align="center">
			<div id="proview">
			<form id="pro_detile">
				<div id="proview_img">
					<img src="/MyUsed/images/${proList.pro_pic}" onclick="callAjax('${i.count+3}')" style="width:200px; height:200px; border-top-left-radius:7px; border-top-right-radius:7px;">
				</div>
				<div id="proview_sub">
					<font size="5" color="#3B5998">
						<fmt:formatNumber value="${proList.price}" type="number" />원
					</font>
				</div>
				<input type="hidden" name="num" id="num${i.count+3}" value="${proList.num}">
				<input type="button" id="detail" style='display: none;'>
			</form>
			</div>
			</td>
		</c:forEach>
		</tr>
	
		<tr height="310">
		<c:forEach begin="6" step="1" end="8" var="proList" items="${proList}" varStatus="i">
			<td width="250" valign="top" align="center">
			<div id="proview">
			<form id="pro_detile">
				<div id="proview_img">
					<img src="/MyUsed/images/${proList.pro_pic}" onclick="callAjax('${i.count+6}')" style="width:200px; height:200px; border-top-left-radius:7px; border-top-right-radius:7px;">
				</div>
				<div id="proview_sub">
					<font size="5" color="#3B5998">
						<fmt:formatNumber value="${proList.price}" type="number" />원
					</font>
				</div>
				<input type="hidden" name="num" id="num${i.count+6}" value="${proList.num}">
				<input type="button" id="detail" style='display: none;'>
			</form>
			</div>
			</td>
		</c:forEach>
		</tr>
		<tr height="50">
			<td colspan="3" align="center">
				${pagingHtml}
			</td>
		</tr>
	</table>
	</c:if>
<br /><br /><br />
</center>	
</div>

<div id="sidebannerL">
	<br />
	<font size="2" color="#000000"><b>
	<a onclick="callTotalCateg()" style="cursor:pointer;">전체</a>	
	<a href="/MyUsed/MyUsedProductView.nhn?categ=${categ}&currentPage=1">>${categ}</a>
	<c:if test="${categ2 != null}">
		<a href="/MyUsed/MyUsedProductView2.nhn?categ=${categ}&categ2=${categ2}&currentPage=1">>${categ2}</a>
	</c:if>
	</b></font>
	
	<br /><br />
	
	<c:forEach var="categList" items="${categList}">
	<a href="/MyUsed/MyUsedProductView2.nhn?categ=${categ}&categ2=${categList.categ}&currentPage=1">
		${categList.categ} <br /></a>
	</c:forEach>
</div>


<div id="sidebannerR"><jsp:include page="/mypage/friendList.jsp"/>
 	
 	
 	
</div>


<div id="advertise">
<br /> 
<center>
	
	
</center>
</div>


</body>
</html>

