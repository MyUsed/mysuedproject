
        
 			// ------------------------------------------ submit 이미지버튼 -------------------------------------- 
 		
              function send(){     
        
                   document.formId.method = "post"     // method 선택, get, post
                   document.formId.action = "mainSubmit.nhn";  // submit 하기 위한 페이지 
                   document.formId.submit();
                   document.formId.image_preview();
                  
              }
              
          
              
        
 			
 			// -------------------------------------------- div 처리 ------------------------------------------
              
              function fncChecked(num)
              {
               if(num == 1)
               {
                div1.style.display = '';
                div2.style.display = 'none';
                div2_categ.style.display = 'none';
               }
               
               else if(num == 2)
               {
                div1.style.display = 'none';
                div2.style.display = '';  
                div2_categ.style.display = '';
               }
      
               else
               {
                div1.style.display = 'none';
                div2.style.display = 'none';
                
               }
              }
              
              
              
 			// ----------------------------------------------- 채팅 -----------------------------------------------
              
              function openChat(){
      			var url = "chat.nhn";
      			window.open(url, "chat", "width=500, height=600, resizable=yes, location=no, status=no, toolbar=no, menubar=no, left=400, top=30");
      			
      		}
              

              
           // ----------------------------------- 상품 카테고리 ----------------------------------
              
                 $(document).ready(function(){		//onload이벤트같은것(시작하자마자 바로 동작)
                   $("#categ0").change(function(){	// 이렇게 안불러와짐........
                       callAjax();
                   });
                 });
                 function callAjax(){
                     $.ajax({
             	        type: "post",
             	        url : "/MyUsed/categindex.nhn",
             	        data: {	// url 페이지도 전달할 파라미터
             	        	categ0 : $('#categ0').val()
             	        },
             	        success: test,	// 페이지요청 성공시 실행 함수
             	        error: whenError	//페이지요청 실패시 실행함수
                  	});
                 }
                 function test(aaa){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
                     $("#div2").html(aaa);
                     console.log(resdata);
                 }
                 function whenError(){
                     alert("Error");
                 }
              
                 // ----------------------------------  삭제여부 확인 ---------------------------------------
                 

                 
               	function deleteCheck(){
               if(confirm("정말로 삭제하시겠습니까?") == true){

               } 	else{
               	event.preventDefault();
             		  }
               }
               	
               	// ---------------------------------- 카테고리 선택 확인 ----------------------------------------
               	
                function alarm(aa){
            		alert(aa);
            	}
                
                
                //------------------------------친구찾기 페이지------------------------------------------------
                function callAjax_friend(mem_num){
                    $.ajax({
            	        type: "post",
            	        url : "/MyUsed/MyUsedFriend.nhn",
            	        data: {	// url 페이지도 전달할 파라미터
            	        	mem_num : mem_num
            	        },
            	        success: test,	// 페이지요청 성공시 실행 함수
            	        error: whenError	//페이지요청 실패시 실행함수
                 	});
                }
                function test(aaa){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
                    $("#contents").html(aaa);
                    console.log(resdata);
                }
                function whenError(){
                    alert("Error");
                }

                
                // ----------------------------------- 알림 스크립트 ------------------------------------------------
                function openMsg() {
                	
                	msgPop.style.display = '';
                	arrow.style.display = '';
                }

                function closeMsg() {
                	msgPop.style.display = 'none';
                	arrow.style.display = 'none';
                }
                
                // ---------------------------------   알림 새창 띄우기 -----------------------------------------------
                
                /* 친구추가 새창 열기 */
                function tradeCheck(){
                	alert("123");
                   // url = "/MyUsed/AddFriend.nhn?mem_num=";
                    
                    open(url, "confirm", 
                	"toolbar=no, location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=400, height=200");
                }

                
      

              
