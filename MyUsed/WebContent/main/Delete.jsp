<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
	alert("게시글이 삭제되었습니다.");
	
	if('${page}' == 0){
		window.location="MyUsed.nhn"; 
	}else{
		window.location="MyUsedMyPage.nhn?mem_num=${mem_num}"; 
	}
</script>