<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<link rel="stylesheet" type="text/css" href="/MyUsed/main/main.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="/MyUsed/main/script.js"></script>
<script src="/MyUsed/main/animate.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>


<title>MyUsed</title>

<script type="text/javascript">
//----------------- 친구 목록 실시간 --------------------------------------------------------
$(document).ready(function(){
	window.setInterval('myfriendlist()', 10000); //5초마다한번씩 함수를 실행한다..!! 
});
function myfriendlist(){
	 $.ajax({
	        type: "post",
	        url : "/MyUsed/FriendList.nhn",
	        success: list,	// 페이지요청 성공시 실행 함수
	        error: whenError	//페이지요청 실패시 실행함수
  	});
}
function list(aaa){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
    $("#sidebannerR").html(aaa);
}
function whenError(){
    alert("FriendListError");
} 




// ----------------------------------좋아요 이번트 처리---------------------------------
var count;
function likeAjax(num,c){
	
	
	count = c;
	
	 $.ajax({
	        type: "post",
	        url : "likeup.nhn",
	      	data: {	// url 페이지도 전달할 파라미터
        	num : num //페이지 넘버
        },
	        success: test,	// 페이지요청 성공시 실행 함수
	        error: whenError	//페이지요청 실패시 실행함수
  	});
}
function test(aaa){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
	
	$("#likewow"+count).html(aaa);	//id가 ajaxReturn인 부분에 넣어라
    
}
function whenError(){
    alert("Error");
}


var count;
function likedownAjax(num,c){
	
	
	count = c;
	
	 $.ajax({
	        type: "post",
	        url : "likedown.nhn",
	      	data: {	// url 페이지도 전달할 파라미터
        	num : num //페이지 넘버
        },
	        success: test,	// 페이지요청 성공시 실행 함수
	        error: whenError	//페이지요청 실패시 실행함수
  	});
}
function test(aaa){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
	
	$("#likewow"+count).html(aaa);	//id가 ajaxReturn인 부분에 넣어라
    
}
function whenError(){
    alert("Error");
}


// 태그 알람 확인 
function NoticeUpdateTeg(mynum,memnum){
	
	  $.ajax({
	        type: "post",
	        url : "/MyUsed/NoticeUpdateTeg.nhn",
	        data: {	// url 페이지도 전달할 파라미터
	        	mynum : mynum,
	        	memnum : memnum
	      	},
	      
   	});
	
}

// 배송 알람 확인
function NoticeUpdatePost(mynum,pro_num){
	
	  $.ajax({
	        type: "post",
	        url : "/MyUsed/NoticeUpdatPost.nhn",
	        data: {	// url 페이지도 전달할 파라미터
	        	mynum : mynum,
	        	pro_num : pro_num
	      	},
	      
   	});
	
}

//수정 알람 확인 (승인)
function NoticeUpdateModifyR(mynum){
	
	
	  $.ajax({
	        type: "post",
	        url : "/MyUsed/NoticeUpdatModifyR.nhn",
	        data: {	// url 페이지도 전달할 파라미터
	        	mynum : mynum
	        	
	      	},
	      
   	});
	
}

//수정 알람 확인 (승인)
function NoticeUpdateModifyP(mynum){
	
	
	  $.ajax({
	        type: "post",
	        url : "/MyUsed/NoticeUpdatModifyP.nhn",
	        data: {	// url 페이지도 전달할 파라미터
	        	mynum : mynum
	        	
	      	},
	      
   	});
	
}


// ----------------------------------- 친구 알림 스크립트 ------------------------------------------------
function fri_openMsg() {
	$("#fri_msgPop").attr('style','display:block;');
	$("#fri_arrow").attr('style','display:block;');
}

function fri_closeMsg() {
	$("#fri_msgPop").attr('style','display:none;');
	$("#fri_arrow").attr('style','display:none;');
}




</script>


</head>
<body>



<div id="layer_fixed"><jsp:include page="layer_fixed.jsp"/></div> <!-- 상단 검색 Top -->
<div id="sidebannerR"><jsp:include page="/mypage/friendList.jsp"/></div> <!-- 사이드배너 Right  -->
<div id="advertise" ><jsp:include page="advertise.jsp"/></div>  <!-- 광고 페이지  -->
<div id="sidebannerL"><jsp:include page="sidebannerL.jsp"/></div> <!-- 사이드배너 Left -->




<!-- 친구 아이콘 누르면 나오는 알람 -->
<div id="friendNotice" style="position:absolute; z-index:9999;">
<jsp:include page="friendNotice.jsp"/></div>


<div id="contents">   <!-------------------------------- 메인 내용 ------------------------------------------>


	
	
	
	
	
<!------------------------------------------------------- 알림 메시지 --------------------------------------------------->
<div id="arrow" style='display:none;'>
	<img src="/MyUsed/images/arrow.png" width="0" height="0"> 
</div>
<div id="msgPop" style='display:none;'>
    <br/>
	<div id="closemsg">
		<label for="close4" style="cursor:pointer;">
			<img src="/MyUsed/images/close.png" width="15" height="15">
		</label>
    </div>
    
   	<input type="button" id="close4" OnClick="javascript:closeMsg()" style='display: none;'>
   	<br />
   	<div id="msgtitle">
   		<font size="3"><b>알림 확인</b></font>
   	</div>
   	
   	<div id="msgtext">
   	
   	
   		<c:forEach var="noticelist" items="${noticelist}">
   			
   			(<strong> <a href="MyUsedMyPage.nhn?mem_num=${noticelist.call_memnum}">${noticelist.call_name}</a> </strong>) 
   			
   			<a Onclick="javascript:tradeCheck(${noticelist.call_memnum},${noticelist.pro_num})" style="cursor:pointer;">
   			<c:if test="${noticelist.categ == 'product'}">	
   			<b>님이 거래요청 하였습니다.</b> 
   			</c:if>
   			</a>
   			<a href="paperMain.nhn?mynum=${noticelist.board_num}" onclick="javascript:NoticeUpdate(${noticelist.board_num},${noticelist.call_memnum})">
   			<c:if test="${noticelist.categ == 'msg'}">
   			<b>님이 메세지를 보내셨습니다.</b>
   			</c:if>
   			</a>
   			<a href="MyUsedMyPage.nhn?mem_num=${noticelist.board_num}" onclick="javascript:NoticeUpdateFriend(${noticelist.board_num},${noticelist.call_memnum})" >
   			<c:if test="${noticelist.categ == 'friend'}">
   			<b>님이 친구요청을 하였습니다.</b>
   			</c:if>
   			</a>
   			<a href="MypageModal.nhn?num=${noticelist.board_num}" onclick="javascript:NoticeUpdateTeg(${noticelist.board_num},${noticelist.call_memnum})" >
   			<c:if test="${noticelist.categ == 'board'}">
   			<b>님이 게시물에 태그 하였습니다.</b>
   			</c:if>
   			</a>
   			<a href="tradeState.nhn" onclick="javascript:NoticeUpdatePost(${noticelist.board_num},${noticelist.pro_num})"  >
   			<c:if test="${noticelist.categ == 'post'}">
   			<b>님이 상품을 배송 하였습니다.</b>
   			</c:if>
   			</a>
   			<a href="MyUsed.nhn" onclick="javascript:NoticeUpdateModifyR(${noticelist.call_memnum})"  >
   			<c:if test="${noticelist.categ == 'modify_reject'}">
   			<b>님의 프로필 수정요청이 거절되었습니다.</b>
   			</c:if>
   			</a>
   			<a href="MyUsed.nhn" onclick="javascript:NoticeUpdateModifyP(${noticelist.call_memnum})"  >
   			<c:if test="${noticelist.categ == 'modify_permit'}">
   			<b>님의 프로필 수정요청이 승인되었습니다.</b>
   			</c:if>
   			</a>
   			<br /> &nbsp;
   			<font size="2" color="#9A9DA4">
  			<fmt:formatDate value="${noticelist.reg}" type="both" /> 
 			</font>
   			<hr width="90%" />
   		</c:forEach>
   	
   		
   	
   	
   	
   	
 	</div>
   	
</div>
	
	
	
	
	
	
<!-- --------------------------------------------------------------------------------------------------------------- -->	
	<br /><br /><br />
	
	
	 <form name="formId" enctype="multipart/form-data" action="mainSubmit.nhn" method="post" >
	 
	 
	 <table align="center"  width="550" height="30">
	 <tr bgcolor="#FFFFFF">
	 <td align="center" colspan="8">
	 <input type="radio" name="deposit" value="update" onclick='javascript:fncChecked(1);' ${checked}><font size="3" color="#3B5998" face="Comic Sans MS"><b>SNS</b></font>
     <input type="radio" name="deposit" value="product" onclick='javascript:fncChecked(2);'${checked1}><font size="3" color="#3B5998"  face="Comic Sans MS"><b>Trade</b></font>
	 </td>
	 </tr>
	 </table>

	
	<!--  --------------------------------------------- 일반 ---------------------------------------------------- -->
	 
	
<div id='div1' style='display:${view};'>
	 <table align="center"  width="550" height="200">
	<tr bgcolor="#FFFFFF">
	<td align="center" colspan="8">
	<font size="2" color="#3B5998" >상태 업데이트</font> 
		  <hr width="80%"  > 
	</td>
	</tr>
	<tr bgcolor="#FFFFFF">
	<td align="center" colspan="8">
	
		
		<textarea rows="5" cols="73" name="content" placeholder="무슨 생각을 하고계신가요 ?"></textarea>
	
		<br/> 
		
		
		<hr width="80%"  > 
		
	
	</td>
	
	</tr>
	<tr bgcolor="#FFFFFF">
	

	
	
	
		<c:forEach var="i" begin="1" end="8">
    <td align="center"  >
<!-- 이미지 미리보기  -->


  
 
<c:if test="${i==1}">
<img src="/MyUsed/images/mainPic.PNG" width="15" height="15" title="메인사진"/>
</c:if>
        <label for="image${i}">
        <img src="/MyUsed/images/cameraUp.PNG" width="25" height="25" style='cursor:pointer;' title="사진"/>
        </label>
   		
        <input type="file" name="image${i}" id="image${i}" style='display: none;'>
	
   
    <div id="image${i}_preview" style='display: none;'>
        <img src="/MyUsed/images/option.png" width="70" height="70"/>
        <a href="#">Remove</a>
    </div>


    <script type="text/javascript">
 
    
    $('#image${i}').on('change', function() {
        
        ext = $(this).val().split('.').pop().toLowerCase(); //확장자
        
        //배열에 추출한 확장자가 존재하는지 체크
        if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
            resetFormElement($(this)); //폼 초기화
            window.alert('이미지 파일이 아닙니다! (gif, png, jpg, jpeg 만 업로드 가능)');
        } else {
            file = $('#image${i}').prop("files")[0];
            blobURL = window.URL.createObjectURL(file);
            $('#image${i}_preview img').attr('src', blobURL);
            $('#image${i}_preview').slideDown(); //업로드한 이미지 미리보기 
            $(this).slideUp(); //파일 양식 감춤
        }
    });
    $('#image${i}_preview a').bind('click', function() {
        resetFormElement($('#image${i}')); //전달한 양식 초기화
        $('#image${i}').slideDown(); //파일 양식 보여줌
        $(this).parent().slideUp(); //미리 보기 영역 감춤
        return false; //기본 이벤트 막음
    });	
  
    function resetFormElement(e) {
        e.wrap('<form>').closest('form').get(0).reset(); 
        //리셋하려는 폼양식 요소를 폼(<form>) 으로 감싸고 (wrap()) , 
        //요소를 감싸고 있는 가장 가까운 폼( closest('form')) 에서 Dom요소를 반환받고 ( get(0) ),
        //DOM에서 제공하는 초기화 메서드 reset()을 호출
        e.unwrap(); //감싼 <form> 태그를 제거
    }
    
    
    
    
	
    
    
    </script>
  
</td>
</c:forEach>
<!-- 이미지 미리보기  -->


</tr>
	<tr bgcolor="#FFFFFF" align="center"	>
		<td colspan="8">
	 	<img src="/MyUsed/images/submit.PNG" style='cursor:pointer;' onclick="javascript_:send();" title="등록하기" />
	 	</td>
	</tr> 	
	
	
	</table>
	
	<br /> <br />
	
</form>

<!--  상품 보기 페이지  -->	



<c:forEach var="list" items="${list}"  varStatus="i">	
<form name="reple" action="reple.nhn" method="post" >

	
 	<table align="center"  width="550" height="180">
		<tr	bgcolor="#FFFFFF">
		<td>
		<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${list.mem_num}"><font face="Comic Sans MS">( ${list.name} )</font></a>
		<font face="Comic Sans MS" size="2" color="#A6A6A6" > 님이 글을 게시하였습니다</font>  
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<c:if test="${list.mem_num == memDTO.num}">
		<a href="delete.nhn?num=${list.num}"><img src="/MyUsed/images/deleteIcon.PNG" style="margin-right: 1em;" width="20" height="20" align="right" title="게시글 삭제"/></a>
		</c:if>
		<hr width="100%" > 
		</td>
		</tr>
		
		<tr  bgcolor="#FFFFFF">
		<td align="center">
		<c:if test="${list.mem_pic != null}">
		<a href="MypageModal.nhn?num=${list.num}">	
		<img src="/MyUsed/images/${list.mem_pic}" width="470" height="300"/>
		</a>
		 <br/> <br />
		</c:if>
		<!-- 일반 게시글 해시태그 -->	
	<!-- 일반 게시글 해시태그 -->	
	<script type="text/javascript">
	$(document).ready(function(){
		var content = document.getElementById('listcontent_${list.num}').innerHTML;
		var splitedArray = content.split(' ');	// 공백을 기준으로 자름
		var resultArray = [];	//최종 결과를 담을 배열을 미리 선언함
		
		// 공백을 기준으로 잘린 배열의 요소들을 검색함
		for(var i = 0; i < splitedArray.length ; i++){
			// 그 중 <br>이 포함되어있는 배열의 요소가 있다면
			if(splitedArray[i].indexOf('<br>') > -1){
				
				// <br> 기준으로 잘라 임시 배열인 array에 넣는다 -> 이때 array의 길이는 2개 일 수 밖에 없음
				var array = splitedArray[i].split('<br>');
				// 이때 <br>이 #이 붙은 단어의 앞에 있을 수 도있고 뒤에 있을 수도 있기 때문에 indexOf를 이용해 위치를 판단한다.
				if(splitedArray[i].indexOf('<br>') < splitedArray[i].indexOf('#')){	//br이 앞에 있을경우
					resultArray[i] = array[0]+'<br>';	// array의 첫번째 요소에 <br>을 붙여준다
					resultArray[i+1] = array[1];
					i++;	//resultArray의 크기가 1 늘어났음으로 i를 ++해줌
				}else{	//br이 뒤에 있을경우
					resultArray[i] = array[0];
					resultArray[i+1] = '<br>'+array[1];	// array의 두번째 요소에 <br>을 붙여준다
					i++;	//resultArray의 크기가 1 늘어났음으로 i를 ++해줌
				}
			// <br>이 포함되지않은 요소들은 그냥 resultArray에 넣어준다.
			}else{
				resultArray[i] = splitedArray[i];
			}
		}
		var linkedContent = '';
		for(var word in resultArray)
		{
		  word = resultArray[word];
		   if(word.indexOf('#') == 0)
		   {
				var url = '"'+'/MyUsed/tegSearch.nhn?word='+word.split('#')+'"';
			    word = '<a href='+url+'>'+word+'</a>';
		   }
		   linkedContent += word+' ';
		}
		document.getElementById('listcontent_${list.num}').innerHTML = linkedContent; 
	});
	</script>
		
		
		<div id="listcontent_${list.num}">${list.content}</div>
		</td>
		</tr>
		
		<tr bgcolor="#FFFFFF">
		<td>
		<hr width="100%"  > 
		
		<script type="text/javascript">
			/****** 리플열기 ******/
			function mianopenreple${list.num}() {
				if(main_reple_${list.num}.style.display == 'block'){
				    $('#main_reple_${list.num}').slideUp();
				    $('#main_reple_${list.num}').attr('style', 'display:none;');				
				}else{
				    $.ajax({
				        type: "post",
				        url : "/MyUsed/reple.nhn",
				        data: {	// url 페이지도 전달할 파라미터
				        	num : '${list.num}',
				        	page: 0
				        },
				        success: reple${list.num},	// 페이지요청 성공시 실행 함수
				        error: whenError_reple	//페이지요청 실패시 실행함수
				 	});
					
				}
			}
			function reple${list.num}(relist){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다.
			    $('#main_reple_${list.num}').attr('style', 'background:#FFFFFF;  display:block;');
			    $('#main_reple_${list.num}').slideDown();	// 댓글 폼열기
			    $('#main_reple_${list.num}').html(relist);
			    console.log(resdata);
			}
			function whenError_reple(){
			    alert("리플 에러");
			}
		</script>
		
	 <div id="likewow${i.count}"></div>
	 <a onclick="likeAjax('${list.num}','${i.count}')">
	 <c:if test="${list.likes == 0}">
	 <img id="love" src="/MyUsed/images/likeDown.png"  style='cursor:pointer;' />
	 </c:if>
	 </a>
	 <a onclick="likedownAjax('${list.num}','${i.count}')">
	 <c:if test="${list.likes != 0}">
	 <img id="love" src="/MyUsed/images/likeUp.png"  style='cursor:pointer;' />
	 </c:if>
	 </a>
	 <a onclick="javascript:mianopenreple${list.num}()" style="cursor:pointer;"><img src="/MyUsed/images/reple.PNG" width="23" height="17"/><font size="2" color="#9A9DA4">댓글 ${list.reples}개</font></a>
		</td>
		</tr>
				
		<tr bgcolor="#FFFFFF">
		<td>
		
		
		
		</td>
		</tr>
		
		<tr>
		<td>
		
		<!-- 리플 영역 -->
		<div id="main_reple_${list.num}" style=" border:2px solid #000000; display:none;"></div>
	
		</td>
		</tr>
		

	</table>



 	<br />	

		

<!--  상품 보기 페이지  -->	

</form>	 
</c:forEach>



</div>
	

	 
<div id='div2_categ' style='display:${view2};' > 
	 <!--  일반상품 등록  -->
	 	
<table align="center"  width="550" height="30">
<tr bgcolor="#FFFFFF">
	<td align="left">
	<center><font size="2" color="#3B5998">상품 등록</font> </center>
		  <hr width="80%"  > 
	<select name="categ0" id="categ0">
		<option>--------1차--------</option>
		<c:forEach var="categ" items="${categList}">
			<option>${categ.categ}</option>
		</c:forEach>
	</select>
	<input id="button" type="image" src="/MyUsed/images/agree.PNG" width="15" height="" value="확인" onClick="callAjax()">
	<br />
	</td>
</tr>
</table>
	 
</div>
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 <!--  --------------------------------------------- 상품 ---------------------------------------------------- -->
	 
	 
<div id='div2'  style='display:${view2};'  >
	
	<table align="center"  width="550" height="200">
	<tr bgcolor="#FFFFFF">
	<td align="center" colspan="8">
	<br/>
	
		<textarea rows = "5" cols = "73" name="contents" placeholder="상품에 대한 설명을 써주세요" onkeyup="alarm('카테고리를 선택하고 작성하세요!')"></textarea> <br/> 
		<font size ="2" color="#3B5998">
		* 배송료
		포함(선불) <input type="radio" name="sendPay" value="yes" />
		미포함(착불) <input type="radio" name="sendPay" value="no"  />
		</font>
		<br />
		<input type="text" name="price" size="7" value="0000" placeholder="상품가격"/>
		<hr width="80%"  > 	
	
	</td>
	
	</tr>
	<tr bgcolor="#FFFFFF">

	
		<c:forEach var="i" begin="1" end="8">
    <td align="center"  >
<!-- 이미지 미리보기  -->

  
 
<c:if test="${i==1}">
<img src="/MyUsed/images/mainPic.PNG" width="15" height="15" title="메인사진"/>
</c:if>

        <label for="pimage${i}">
		<img src="/MyUsed/images/box.PNG" width="25" height="25" style='cursor:pointer;' title="상품사진"/>
		</label>
   
        <input type="file" name="pimage${i}" id="pimage${i}" style='display: none;'>
	
   
    <div id="pimage${i}_preview" style='display: none;'>
        <img src="/MyUsed/images/option.png" width="70" height="70"/>
        <a href="#">Remove</a>
    </div>


    <script type="text/javascript">
 
    
    $('#pimage${i}').on('change', function() {
        
        ext = $(this).val().split('.').pop().toLowerCase(); //확장자
        
        //배열에 추출한 확장자가 존재하는지 체크
        if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
            resetFormElement($(this)); //폼 초기화
            window.alert('이미지 파일이 아닙니다! (gif, png, jpg, jpeg 만 업로드 가능)');
        } else {
            file = $('#pimage${i}').prop("files")[0];
            blobURL = window.URL.createObjectURL(file);
            $('#pimage${i}_preview img').attr('src', blobURL);
            $('#pimage${i}_preview').slideDown(); //업로드한 이미지 미리보기 
            $(this).slideUp(); //파일 양식 감춤
        }
    });
    $('#pimage${i}_preview a').bind('click', function() {
        resetFormElement($('#pimage${i}')); //전달한 양식 초기화
        $('#pimage${i}').slideDown(); //파일 양식 보여줌
        $(this).parent().slideUp(); //미리 보기 영역 감춤
        return false; //기본 이벤트 막음
    });	
  
    function resetFormElement(e) {
        e.wrap('<form>').closest('form').get(0).reset(); 
        //리셋하려는 폼양식 요소를 폼(<form>) 으로 감싸고 (wrap()) , 
        //요소를 감싸고 있는 가장 가까운 폼( closest('form')) 에서 Dom요소를 반환받고 ( get(0) ),
        //DOM에서 제공하는 초기화 메서드 reset()을 호출
        e.unwrap(); //감싼 <form> 태그를 제거
    }
    </script>
    
<script type="text/javascript">
/* 찜하기 ajax */
    function choiceAjax(coun){
        $.ajax({
	        type: "post",
	        url : "choiceInsert.nhn",
	        data: {	// url 페이지도 전달할 파라미터
	        	num : $('#num'+coun).val(),
       			mem_num : $('#mem_num'+coun).val(),
       			mem_name : $('#mem_name'+coun).val(),
       			price : $('#price'+coun).val(),
       			pro_pic : $('#pro_pic'+coun).val(),
       			content : $('#content'+coun).val(),
	        },
	        success: choice,	// 페이지요청 성공시 실행 함수
	        error: whenError	//페이지요청 실패시 실행함수
     	});
    }
    function choice(choice){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
    	if(confirm("이 게시물을 찜하시겠습니까?") == true){
        	$("#ajaxChoice").html(choice);
        	console.log(resdata);
    	}
        else{
			return false;
		}
    }
    function whenError(){
        alert("Error");
    }
</script>
    
</td>
</c:forEach>
<!-- 이미지 미리보기  -->


</tr>
	<tr bgcolor="#FFFFFF" align="center"	>
		<td colspan="8">
	 	<img src="/MyUsed/images/submit.PNG" style='cursor:pointer;' title="등록하기" onclick="javascript_:send();" />
	 	</td>
	</tr> 	
	</table>

	 
	 <br /> <br />

<c:forEach var="prolist" items="${prolist}" varStatus="i">
	
 	<table align="center"  width="550" height="180">
		<tr	bgcolor="#FFFFFF">
		<td>
		<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${prolist.mem_num}"><font face="Comic Sans MS" >( ${prolist.name} )</font></a>
		<font face="Comic Sans MS" size="2" color="#A6A6A6" > 님이 상품을 게시하였습니다  </font>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		
		<c:if test="${prolist.mem_num == memDTO.num}">
		<a href="prodelete.nhn?num=${prolist.num}"><img src="/MyUsed/images/deleteIcon.PNG" style="margin-right: 1em;" width="20" height="20" align="right" title="게시글 삭제"/></a>
		</c:if>
		
		<hr width="100%" > 
		</td>
		</tr>
		
		<tr  bgcolor="#FFFFFF">
		<td align="center">
		
		<c:if test="${prolist.pro_pic != null}"> 
		<a href="ProductDetailView.nhn?num=${prolist.num}">
		<img src="/MyUsed/images/${prolist.pro_pic}" width="370" height="350" /> 
		</a>
		<br/>
		</c:if>
		
		<c:if test="${prolist.sendpay != null}"> 
		<font size="2" color="#8C8C8C">* 배송료${prolist.sendpay}</font> <br/>
		<font size="3" color="#1F51B7" ><b><fmt:formatNumber value="${prolist.price}" type="number" />원</b></font> <br /><br />
		</c:if>
		<c:if test="${prolist.sendpay == null}"> 
		 <br/>
		<font size="3" color="#4374D9" > <b>거래중입니다</b> </font> <br /><br />
		</c:if>
		<font size="3" color="#D7D2FF" >
		──────────────<font size="3" color="#A6A6A6" face="Comic Sans MS"> Detail </font>──────────────
		</font>
		<!-- 상품 게시글 해시태그 -->	
		<script type="text/javascript">
	$(document).ready(function(){
		var content = document.getElementById('procontent_${prolist.num}').innerHTML;
		var splitedArray = content.split(' ');	// 공백을 기준으로 자름
		var resultArray = [];	//최종 결과를 담을 배열을 미리 선언함
		
		// 공백을 기준으로 잘린 배열의 요소들을 검색함
		for(var i = 0; i < splitedArray.length ; i++){			
			// 그 중 <br>이 포함되어있는 배열의 요소가 있다면
			if(splitedArray[i].indexOf('<br>') > -1){
				
				// <br> 기준으로 잘라 임시 배열인 array에 넣는다 -> 이때 array의 길이는 2개 일 수 밖에 없음
				var array = splitedArray[i].split('<br>');
				// 이때 <br>이 #이 붙은 단어의 앞에 있을 수 도있고 뒤에 있을 수도 있기 때문에 indexOf를 이용해 위치를 판단한다.
				if(splitedArray[i].indexOf('<br>') < splitedArray[i].indexOf('#')){	//br이 앞에 있을경우
					resultArray[i] = array[0]+'<br>';	// array의 첫번째 요소에 <br>을 붙여준다
					resultArray[i+1] = array[1];
					i++;	//resultArray의 크기가 1 늘어났음으로 i를 ++해줌
				}else{	//br이 뒤에 있을경우
					resultArray[i] = array[0];
					resultArray[i+1] = '<br>'+array[1];	// array의 두번째 요소에 <br>을 붙여준다
					i++;	//resultArray의 크기가 1 늘어났음으로 i를 ++해줌
				}
			// <br>이 포함되지않은 요소들은 그냥 resultArray에 넣어준다.
			}else{
				resultArray[i] = splitedArray[i];
			}
		}
		var linkedContent = '';
		for(var word in resultArray)
		{
		  word = resultArray[word];
		   if(word.indexOf('#') == 0)
		   {
				var url = '"'+'/MyUsed/protegSearch.nhn?word='+word.split('#')+'"';
			    word = '<a href='+url+'>'+word+'</a>';
		   }
		   linkedContent += word+' ';
		}
		document.getElementById('procontent_${prolist.num}').innerHTML = linkedContent; 
	});
	</script>
	
		 <br/>
		 <div id="procontent_${prolist.num}">${prolist.content}</div>
		
		</td>
		</tr>
		
		<tr bgcolor="#FFFFFF">
		<td>
		<hr width="100%"> 

		<img id="love" src="/MyUsed/images/likeDown.png"  style='cursor:pointer;' />
		<input type="hidden" name="num" id="num${i.count}" value="${prolist.num}" />
		<input type="hidden" name="mem_num" id="mem_num${i.count}" value="${prolist.mem_num}" />
		<input type="hidden" name="mem_name" id="mem_name${i.count}" value="${prolist.name}" />
		<input type="hidden" name="price" id="price${i.count}" value="${prolist.price}" />
		<input type="hidden" name="pro_pic" id="pro_pic${i.count}" value="${prolist.pro_pic}" />
		<input type="hidden" name="content" id="content${i.count}" value="${prolist.content}" /> 
		
		 <a href="ProductDetailView.nhn?num=${prolist.num}"><img src="/MyUsed/images/reple.PNG"/><font size="2" color="#9A9DA4">댓글 ${prolist.reples}개</font></a>
		
			<c:if test="${prolist.sendpay != null}"> 
			<a id="choiceB${i.count}" onclick="choiceAjax('${i.count}')"><img src="/MyUsed/images/choIcon.png" title="찜하기" width="25" height="25" style='cursor:pointer;'/><font size="2" color="#9A9DA4" style='cursor:pointer;'>찜하기</font></a>
			</c:if>
			
			<a href="ProductDetailView.nhn?num=${prolist.num}"><img align="right" style="padding:2px" src="/MyUsed/images/buyIcon.PNG" width="55" height="45" title="구매하기"/></a>
			
			<div id="ajaxChoice"></div>
			
		</td>
		
		</tr>

	</table>
 	<br />	
 	

<!--  상품 보기 페이지  -->	
	 
</c:forEach>


	
</div>





</body>
</html>

