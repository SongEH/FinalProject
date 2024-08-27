<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

   function check_id(){
	   
	    
	   //회원가입 버튼은 비활성화
	   // <input id="btn_register" type="button" ...  disabled="disabled">
	   $("#btn_register").prop("disabled", true) ;
	   
	   
	   //           document.getElementById("mem_id").value
	   	let mem_id = $("#mem_id").val();
	    
	   	if(mem_id.length==0){
	   		
	   		$("#id_msg").html("");
	   		return;
	   	}
	   	
	   	
	    if(mem_id.length<3){
	    	
	    	$("#id_msg").html("id는 3자리 이상 입력하세요").css("color","red");
	    	return;
	    }
	    
	    //서버에 현재 입력된 ID를 체크요청(jQuery Ajax이용)
	    $.ajax({
	    	url		:	"check_id.do",     //MemberCheckIdAction
	    	data	:	{"mem_id":mem_id}, //parameter   => check_id.do?mem_id=one
	    	dataType:	"json",
	    	success	:	function(res_data){
	    		// res_data = {"result": true}  or {"result": false}
	    		if(res_data.result){
	    			
	    			$("#id_msg").html("사용가능한 아이디 입니다").css("color","blue");
	    			
	    			//가입버튼 활성화
	    			$("#btn_register").prop("disabled", false) ;
	    			
	    		}else{
	    			
	    			$("#id_msg").html("이미 사용중인 아이디 입니다").css("color","red");
	    			
	    		}
	    	},
	    	error	:	function(err){
	    		alert(err.responseText);
	    	}
	    });
   }//end:check_id()
   
   
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
	   
	   
	   f.action = "insert.do";  //MemberInsertAction
	   f.submit(); //전송
	   
	   
	   
	   
   }//end:send()


</script>

</head>
<body>

<form class="form-inline">
   <div id="box">
		<div class="panel panel-primary">
			<div class="panel-heading"><h4>::::회원가입::::</h4></div>
			<div class="panel-body">
			   <table class="table">
			      <tr>
			         <th>이름</th>
			         <td><input style="width:50%;" class="form-control" name="mem_name"></td>
			      </tr>
			      
			      <tr>
			         <th>아이디</th>
			         <td>
			             <input style="width:50%;"  class="form-control" name="mem_id"  id="mem_id" 
			                    onkeyup="check_id();">
			             <span  id="id_msg"></span>
			         </td>
			      </tr>
			      
			      <tr>
			         <th>비밀번호</th>
			         <td><input style="width:50%;" class="form-control"  type="password" name="mem_pwd"></td>
			      </tr>
			      
			      <tr>
			         <th>우편번호</th>
			         <td>
			            <input style="width:50%;" class="form-control" name="mem_zipcode" id="mem_zipcode">
			            <input class="btn  btn-info"  type="button"  value="주소검색"  onclick="find_addr();">
			         </td>
			      </tr>
			      
			      <tr>
			         <th>주소</th>
			         <td><input style="width:100%;"  class="form-control" name="mem_addr" id="mem_addr"></td>
			      </tr>
			      
			      <tr>
			         <td colspan="2" align="center">
			              <input class="btn btn-success" type="button"  value="메인화면"
			                     onclick="location.href='../photo/list.do'" >
			              <input id="btn_register"  class="btn btn-primary" type="button"  value="가입하기" disabled="disabled"
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