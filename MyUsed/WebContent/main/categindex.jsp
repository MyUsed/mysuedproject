<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<html lang="ko">
<head>

 		<script type="text/javascript">
        
              function send(){     
        
                   document.formId2.method = "post"     // method 선택, get, post
                   document.formId2.action = "mainSubmit.nhn";  // submit 하기 위한 페이지 
                   document.formId2.submit();
                   document.formId2.image_preview();
                  
              }
              
              function fncChecked(num)
              {
               if(num == 1)
               {
                div1.style.display = '';
                div2.style.display = 'none';
               }
               else if(num == 2)
               {
                div1.style.display = 'none';
                div2.style.display = '';  
               }
               else
               {
                div1.style.display = 'none';
                div2.style.display = 'none';
               }
              }
              
   
              
             
         </script>




	
	<title>MyUsed</title>
	<style type="text/css">
		#layer_fixed
		{
			height:50px;
			width:120%;
			color: #242424;
			font-size:12px;
			position:fixed;
			z-index:999;
			top:0px;
			left:0px;
			-webkit-box-shadow: 0 1px 2px 0 #777;
			box-shadow: 0 1px 2px 0 #777;
			background-color:#3B5998;
		}
		
		input[type=text] {
 		padding: 5px;
 		text-align: center;
 		margin: 0px;
		}
		
		
	</style>
</head>
 	
 	
<form name="formId2" enctype="multipart/form-data" action="mainSubmit.nhn" method="post" >
	 
	 

	 <!--  일반상품 등록  -->
	 
<div id='div2' >
	
	<table align="center"  width="550" height="200">
	<tr bgcolor="#FFFFFF">
	<td align="center" colspan="8">

	<select name="categ1" id="categ1">
		<option>--------2차--------</option>
		<c:forEach var="categ" items="${categList}">
			<option>${categ.categ}</option>
		</c:forEach>
	</select>
	
	<input type="hidden" name="categ0" value="${categ0}"/>
	<input type="hidden" name="deposit" value="product"/>
	
	<br /><br />


		<textarea rows = "5" cols = "73" name="content" placeholder="상품에 대한 설명을 써주세요"></textarea> <br/> 
		<font size ="2" color="#3B5998">
		* 배송료
		포함(선불) <input type="radio" name="sendPay" value="yes" />
		미포함(착불) <input type="radio" name="sendPay" value="no"  />
		</font>
		<br />
		<input type="text" name="price" size="7" placeholder="상품가격"/>
		<hr width="80%"  > 
		
	
	</td>
	
	</tr>
	<tr bgcolor="#FFFFFF">
	

	
	
	
		<c:forEach var="i" begin="1" end="8">
    <td align="center"  >
<!-- 이미지 미리보기  -->

<style>
  body {
    margin: 20px;
    font-family: "맑은 고딕";
}
  #image_preview {
    display:none;
}
  </style>
  
  <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>


        <label for="pimage${i}">Image${i}</label>
   
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
</td>
</c:forEach>
<!-- 이미지 미리보기  -->


</tr>
	<tr bgcolor="#FFFFFF" align="center"	>
		<td colspan="8">
	 	<img src="/MyUsed/images/submit.PNG" onclick="javascript_:send();" />
	 	</td>
	</tr> 	
	
	
	</table>
	
</div>
</form>


<br /> <br />
<c:forEach var="prolist" items="${prolist}">
	
 	<table align="center"  width="550" height="180">
		<tr	bgcolor="#FFFFFF">
		<td>
		<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${prolist.mem_num}">( ${prolist.name} )</a> 님이 글을 게시하였습니다  
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<c:if test="${prolist.mem_num == memDTO.num}">
		<a href="prodelete.nhn?num=${prolist.num}">게시글삭제</a>
		</c:if>
		
		<hr width="100%" > 
		</td>
		</tr>
		
		<tr  bgcolor="#FFFFFF">
		<td align="center">
		
		<c:if test="${prolist.pro_pic != null}"> 
		<img src="/MyUsed/images/${prolist.pro_pic}" width="370" height="350"/> <br/>
		</c:if>
		
		
		 <font size="5" color="#1F51B7" >[${prolist.price}\] </font> <br /><br />
		
		<font size="3" color="#0042ED" >
		-------------------------------- * 상세설명 * -------------------------------- 
		</font>
		 <br/>
		${prolist.content}
		
		</td>
		</tr>
		
		<tr bgcolor="#FFFFFF">
		<td>
		<hr width="100%"  > 
		좋아요 / 댓글달기 / 공유하기 / 구매하기
		</td>
		</tr>

	</table>
 	<br />	
 	

<!--  상품 보기 페이지  -->	
	 
</c:forEach>

	 
	 
<br /> <br />
</html>




