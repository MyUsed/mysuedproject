<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="facebookstyle.css" />
<link rel="stylesheet" type="text/css" href="/MyUsed/mypage/MyPage.css" />

<script src="/MyUsed/member/jquery-1.11.3.js"></script>
<script src="/MyUsed/member/animate.js"></script>

<!-- 자기 페이지는 아니고  친구 리스트도 없을 때.??(수정하기)-->
<%-- <c:if test="${(mem_num != mynum) || (knewFriendList == null)}">
	<style>
		#knewpeople { position:absolute; height:110px;}
		#picture{ position:absolute; margin-top:125px;}
		#writeform {  position:absolute; margin-top:125px;}				
		/* #article {  position:absolute;  }				 */
	</style>
</c:if>
 --%>
<script type="text/javascript">
	$(document).ready(function(){
		// 해당 페이지가 나의 페이지가 아닐 때(글쓰기폼 감추고, 글 리스트를 위로 당긴다.)
		if('${mem_num}' != '${mynum}'){
	    	$('#writeform').attr('style', 'display:none;');
	    	$('#list').attr('style','margin-top:517px;');
	    	$('#prolist').attr('style','display:none; margin-top:517px;'); 	//처음 로드될땐 prolist는 감춘다
	    	$('#friView').attr('style','display:block; margin-top:473px;');
			
			// 해당 페이지가 친구의 페이지 일 때(알 수 도있는 친구 감추기/사진 당기기/글쓰기폼 감추기/글리스트 당기기)
			if('${friendCheck}' == 1){
				$('#knewpeople').attr('style', 'display:none;');
		    	$('#picture').attr('style','margin-top:0px;');
		    	$('#writeform').attr('style', 'display:none;');
		    	$('#list').attr('style','margin-top:323px;');
		    	$('#prolist').attr('style', 'display:none;'); 	//처음 로드될땐 prolist는 감춘다
		    	$('#friView').attr('style','display:block; margin-top:279px;');
			}
		}
		
	});

	/* 로그인한 사용자의 페이지가 아닐 때 리스트만 보이기 */
	function viewstate(){
		if('${mem_num}' != '${mynum}'){
		    $('#list').attr('style', "display:block;margin-top:517px;");		// 일반글 리스트
		    $('#prolist').attr('style', "display:none;");	// 상품글 리스트
			
			if('${friendCheck}' == 1){
			    $('#list').attr('style', "display:block;margin-top:323px;");		// 일반글 리스트
			    $('#prolist').attr('style', "display:none;");	// 상품글 리스트
				
			}
		}
	}

	function viewproduct(){
		if('${mem_num}' != '${mynum}'){
		    $('#list').attr('style', "display:none;");
		    $('#prolist').attr('style', "display:block;margin-top:517px;");
			
			if('${friendCheck}' == 1){
			    $('#list').attr('style', "display:none;");
			    $('#prolist').attr('style', "display:block;margin-top:323px;");
				
			}
		}
	}

</script>

<body>

<!-- 타임라인 -->



	<!-- 세션아이디의 num과(mynum) 해당페이지의 mem_num과 같은 사람일때만 보임 -->
	<c:if test="${mem_num == mynum}">
	<div id="knewpeople">
		<div id="knewpeopletitle">
			알 수 도 있는 친구
			<div id="line">
				<hr>
			</div>
		</div>
		
		<div id="knewpeopleindex">
		<table>
		<c:if test="${knewFriendList != null}">
			<tr height="115" align="center">
				<c:forEach var="knewFriendList_image" items="${knewFriendList_image}" begin="0" end="5" >
				<td width="130">
					<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${knewFriendList_image.mem_num}">
					<img src="/MyUsed/images/profile/${knewFriendList_image.profile_pic}" width="110" height="110">
					</a>
				</td>
				</c:forEach>
			</tr>
			<tr height="22" align="center">
			<c:forEach var="knewFriend" items="${knewFriendList}" begin="0" end="5" >
				<td width="130">
				<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${knewFriend.mem_num}">
					${knewFriend.name}
				</a>
				<img src="/MyUsed/images/AddFriend.png" onclick="addFriend('${knewFriend.mem_num}')" style="width:20px; height:20px; margin-top:-4px; cursor:pointer;">
				</td>
			</c:forEach>
			</tr>
		</c:if>
		
		<c:if test="${knewFriendList == null}">
			<tr>
				<td valign="middle">
					<font style="font-size:110%; font-weight:bold;">
						알 수 도 있는 친구를 검색해보세요!
					</font>
				</td>
			</tr>
		</c:if>
		
		</table>
		</div>
	</div>
	</c:if>
	
	<c:if test="${mem_num != mynum}">
	<div id="knewpeople">
		<div id="knewpeopletitle">
			${name}님을 아세요?
			<div id="line"><hr></div>
		</div>
		<div id="knewpeopleindex">
			<br />
			<font style="font-size:110%; font-weight:bold;">
				다른 친구들과 공유한 내용을 보려면 
				<a onclick="addFriend('${mem_num}')" style="cursor:pointer;">
				친구요청</a>을 전송하세요!
			</font>
			<div style="margin-left:70%;">
			</div>
		</div>
	</div>
	</c:if>
	
	
	<div id="picture">
		&nbsp;&nbsp;
		<a onclick="movePictureMenu('${mem_num}')" onmouseover="this.style.textDecoration='none'" style="cursor:pointer;">
			<font style="font-weight:bold;" color="#212121">
			사진</font>
		</a>
		<table border="0" width="98%" align="center">
			<tr height="112">
				<c:forEach var="picList" items="${picList}" begin="0" end="1">
					<td width="112">
						<img src="/MyUsed/images/profile/${picList.pic}" width="111" height="111">
					</td>
				</c:forEach>
			</tr>
			<tr height="112">
				<c:forEach var="picList" items="${picList}" begin="2" end="3">
					<td width="112">
						<img src="/MyUsed/images/profile/${picList.pic}" width="111" height="111">
					</td>
				</c:forEach>
			</tr>
		</table>
	</div>
	
	<div id="writeform">
		
		<div id="form1" style="display:block;">
			<div style="padding-top:10px;">
				<center>
				<a onclick="javascript:writestate()" onmouseover="this.style.textDecoration='none'" style="cursor:pointer;"> 
					<font size="2" color="#3B5998">상태업데이트</font></a> | 
				<a onclick="javascript:writeproduct()" onmouseover="this.style.textDecoration='none'" style="cursor:pointer;"> 
					<font size="2" color="#3B5998">상품업데이트</font></a>
				</center>
				<hr width="100%" > 
			</div>
		
			<jsp:include page="writeForm.jsp"/>
		</div>
		
		<div id="form2" style="display:none; border:1px solid red;">
			<div style="padding-top:10px;">
				<center>
				<a onclick="javascript:writestate()" onmouseover="this.style.textDecoration='none'" style="cursor:pointer;"> 
					<font size="2" color="#3B5998">상태업데이트</font></a> | 
				<a onclick="javascript:writeproduct()" onmouseover="this.style.textDecoration='none'" style="cursor:pointer;"> 
					<font size="2" color="#3B5998">상품업데이트</font></a>
				</center>
				<hr width="100%" > 
			</div>
			<div style="background-color:#FFFFFF;">
				<!-- 기본으로 보이는 것은 일반 글쓰기 폼 -->
				<jsp:include page="prowriteForm.jsp"/>
			</div>
		</div>
		
	</div>
	
	<c:if test="${mem_num != mynum}">
	<div id="friView">
		<center>
		<a onclick="javascript:viewstate()" onmouseover="this.style.textDecoration='none'" style="cursor:pointer;"> 
			<font size="2" color="#3B5998">상태업데이트</font></a> | 
		<a onclick="javascript:viewproduct()" onmouseover="this.style.textDecoration='none'" style="cursor:pointer;"> 
			<font size="2" color="#3B5998">상품업데이트</font></a>
		</center>
	</div>
	</c:if>
	
	<div id="list">
		<jsp:include page="list.jsp"/>
	</div>
	<div id="prolist"  style="display:none;">
		<jsp:include page="list_pro.jsp"/>
	</div>

</body>
</html>