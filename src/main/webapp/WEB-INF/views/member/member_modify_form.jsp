<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
    
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!--  Bootstrap  3.x  -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
  #box{
     width: 800px;
     margin: auto;
     margin-top: 100px;
  
  }
  
  th{
     vertical-align: middle !important;
     text-align: right; 
     font-size: 18px;
  }
  
  #id_msg{
     display: inline-block;
     width: 300px;
     height: 20px;
     margin-left: 10px;
    /*  border : 1px solid red; */
  }

</style>

<!-- 주소검색 API  -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">

  
   
   function find_addr(){
	   
	   var themeObj = {
			   bgColor: "#B51D1D" //바탕 배경색
	   };
	   
	   new daum.Postcode({
		    theme: themeObj,
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
	            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
	            $("#mem_zipcode").val(data.zonecode); //우편번호 넣기
	            $("#mem_addr").val(data.address);     //주소넣기
	            
	        }
	    }).open();

   }//end:find_addr()
   
   
   function send(f){
	   
	   let mem_name 	= f.mem_name.value.trim();
	   let mem_pwd  	= f.mem_pwd.value.trim();
	   let mem_zipcode 	= f.mem_zipcode.value.trim();
	   let mem_addr 	= f.mem_addr.value.trim();
	   
	   if(mem_name==''){
		   alert("이름을 입력하세요");
		   f.mem_name.value="";
		   f.mem_name.focus();
		   return;
	   }
	   
	   if(mem_pwd==''){
		   alert("비밀번호를 입력하세요");
		   f.mem_pwd.value="";
		   f.mem_pwd.focus();
		   return;
	   }
	   
	   if(mem_zipcode==''){
		   alert("우편번호를 입력하세요");
		   f.mem_zipcode.value="";
		   f.mem_zipcode.focus();
		   return;
	   }
	   
	   if(mem_addr==''){
		   alert("주소를 입력하세요");
		   f.mem_addr.value="";
		   f.mem_addr.focus();
		   return;
	   }
	   
	   
	   f.action = "modify.do";  //MemberModifyAction
	   f.submit(); //전송
	   
	   
	   
	   
   }//end:send()
</script>


<script type="text/javascript">
  
  $(document).ready(function(){
	  // element + attribute selector
	  $("select[name='mem_grade']").val("${ vo.mem_grade }");
	  
  });

</script>


</head>
<body>

<form class="form-inline">
   <input type="hidden"  name="mem_idx"  value="${ vo.mem_idx }">
   <div id="box">
		<div class="panel panel-primary">
			<div class="panel-heading"><h4>::::회원수정::::</h4></div>
			<div class="panel-body">
			   <table class="table">
			      <tr>
			         <th>이름</th>
			         <td><input style="width:50%;" class="form-control" name="mem_name"  value="${ vo.mem_name }"></td>
			      </tr>
			      
			      <tr>
			         <th>아이디</th>
			         <td>
			             <input style="width:50%;"  class="form-control" name="mem_id"  
			                    value="${ vo.mem_id }"  readonly="readonly">
			         </td>
			      </tr>
			      
			      <tr>
			         <th>비밀번호</th>
			         <td><input style="width:50%;" class="form-control"  type="password" name="mem_pwd" value="${ vo.mem_pwd }"></td>
			      </tr>
			      
			      <tr>
			         <th>우편번호</th>
			         <td>
			            <input style="width:50%;" class="form-control" name="mem_zipcode" id="mem_zipcode"
			                   value="${ vo.mem_zipcode }">
			            <input class="btn  btn-info"  type="button"  value="주소검색"  onclick="find_addr();">
			         </td>
			      </tr>
			      
			      <tr>
			         <th>주소</th>
			         <td><input style="width:100%;"  class="form-control" name="mem_addr" id="mem_addr" value="${ vo.mem_addr }"></td>
			      </tr>
			      
			      
			      <tr>
			         <th>회원등급</th>
			         <td>
			             <!-- 로그인유저가 관리자면 회원등급 수정 가능 -->
			             <c:if test="${ user.mem_grade eq '관리자' }">
				             <select style="width:50%;" name="mem_grade" class="form-control">
				                <option value="일반">일반</option>
				                <option value="관리자">관리자</option>
				             </select>     
			             </c:if> 
			             
			             <!-- 로그인유저가 일반이면 회원등급 수정 불가 -->
			             <c:if test="${ user.mem_grade eq '일반' }">
			                  <input style="width:50%;"  class="form-control" name="mem_grade"  
			                    value="${ vo.mem_grade }"  readonly="readonly">
			             </c:if> 
			                    
			         </td>
			      </tr>
			      
			      
			      <tr>
			         <td colspan="2" align="center">
			              <input class="btn btn-success" type="button"  value="목록보기"
			                     onclick="location.href='list.do'" >
			              <input class="btn btn-primary" type="button"  value="수정하기" 
			                     onclick="send(this.form);" >
			         </td>
			      </tr>
			      
			   </table>   
			</div>
		</div>
	</div>
</form>   
   
</body>
</html>