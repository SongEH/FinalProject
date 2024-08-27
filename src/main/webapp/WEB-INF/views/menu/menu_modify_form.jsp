<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- bootstrap 3 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- SweetAlert2사용설정  -->
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style type="text/css">
  #box{
      width: 600px;
      margin: auto;
      margin-top: 50px;  
  }

  textarea {
	  width: 100%;
	  resize: none;
  }
  
  input[type='button']{
      width: 100px;
  }
  
  img{
      width: 200px;
  }

</style>


<script type="text/javascript">
   
   function send(f){
	   
		//입력값 검증
		let menu_name = f.menu_name.value.trim();
		let menu_content = f.menu_content.value.trim();
		let menu_category = f.menu_category.value.trim();
		let menu_price = f.menu_price.value.trim();

		if (menu_name == '') {
			alert("메뉴명을 입력하세요!");
			f.menu_name.value = ""; //지우기
			f.menu_name.focus();
			return;
		}

		if (menu_content == '') {
			alert("내용을 입력하세요!");
			f.menu_content.value = ""; //지우기
			f.menu_content.focus();
			return;
		}

		if (menu_category == '') {
			alert("카테고리를 입력하세요!");
			f.menu_category.value = ""; //지우기
			f.menu_category.focus();
			return;
		}
		if (menu_price == '') {
			alert("가격을 입력하세요!");
			f.menu_price.value = ""; //지우기
			f.menu_price.focus();
			return;
		}
		
	   
	   f.action = "modify.do"; //PhotoModifyAction
	   f.submit();
	   
   }
 
   
//------ Ajax이용한 이미지 수정----------------------------------------------   
   
   function ajaxFileUpload() {
       // 업로드 버튼이 클릭되면 파일 찾기 창을 띄운다.
       $("#ajaxFile").click();
   }

   function ajaxFileChange() {
       // 파일이 선택되면 업로드를 진행한다.
       photo_upload();
   }


   // 사진 수정은 추후에@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//    function photo_upload() {

// 	   //파일선택->취소시
// 	   if( $("#ajaxFile")[0].files[0]==undefined)return;
	   
	   	   
// 	   var form = $("#ajaxForm")[0];
	   
//        var formData = new FormData(form);
//        formData.append("menu_id", '${ vo.menu_id }');            //p_idx=5
//        formData.append("photo", $("#ajaxFile")[0].files[0]); //photo=bmi.png

//        $.ajax({
//              url : "photo_upload.do", //PhotoUploadAction
//              type : "POST",
//              data : formData,
//              processData : false,
//              contentType : false,
             
//              dataType : 'json',
//              success:function(res_data) {
//             	 //res_data = {"p_filename":"aaa.jpb"}
                 
//             	 //location.href=''; //자신의 페이지를 리로드(refresh)
            	 
//             	 $("#my_img").attr("src","../resources/images/" + res_data.p_filename);
//             	 //$("#my_img").prop("src","../images/" + res_data.p_filename);
            	 
//              },
//              error : function(err){
//             	 alert(err.responseText);
//              }
//        });

//    }
</script>



</head>
<body>

<!--화일업로드용 폼  -->
<form enctype="multipart/form-data" id="ajaxForm" method="post">
    <input id="ajaxFile" type="file"  style="display:none;"  onChange="ajaxFileChange();" >
</form>


  
  
  
<form>

  <input type="hidden"  name="menu_id"  value="${ vo.menu_id }"> 
  <!-- <input type="hidden"  name="page"   value="${ param.page }">  -->

  <div id="box">
        <div class="panel panel-primary">
	      <div class="panel-heading"><h4>메뉴수정화면</h4></div>
	      <div class="panel-body">
	          <table class="table  table-striped">
	               <tr>
	                   <td colspan="2" align="center">
	                       <img src="../resources/images/${ vo.menu_img }" id="my_img">
	                       <br>
	                       <input  class="btn  btn-info" type="button"  value="이미지편집"  onclick="ajaxFileUpload();">
	                   </td>
	               </tr>
	          
	               <tr>
	                  <th>메뉴명</th>
	                  <td><input name="menu_name"  value="${ vo.menu_name }"></td>
	               </tr>
	               
	               <tr>
	                  <th>메뉴설명</th>
	                  <td>
	                      <textarea  name="menu_content"  rows="5" cols="">${ vo.menu_content }</textarea>
	                  </td>
	               </tr>

				   <tr>
						<th>카테고리</th>
						<td><input name="menu_category"  value="${ vo.menu_category }"></td>
				   </tr>

					<tr>
						<th>가격</th>
						<td><input name="menu_price"  value="${ vo.menu_price }"></td>
					</tr>


					<!-- 인기여부 -->
					<tr>
						<th>인기여부</th>
						<td>
							<!-- 체크박스의 기본값 설정 -->
							<input type="checkbox" id="menu_popularity" name="menu_popularity" value="1"
								${vo.menu_popularity == 1 ? 'checked' : ''}>
							<label for="menu_popularity">인기</label>
							<!-- 체크되지 않은 경우의 값을 전송하는 숨겨진 필드 -->
							<input type="hidden" name="menu_popularity" value="0">
						</td>
					</tr>

					<!-- 숨김여부 -->
					<tr>
						<th>숨김여부</th>
						<td>
							<!-- 체크박스의 기본값 설정 -->
							<input type="checkbox" id="menu_hidden" name="menu_hidden" value="1"
								${vo.menu_hidden == 1 ? 'checked' : ''}>
							<label for="menu_hidden">숨김</label>
							<!-- 체크되지 않은 경우의 값을 전송하는 숨겨진 필드 -->
							<input type="hidden" name="menu_hidden" value="0">
						</td>
					</tr>

					<!-- 품절여부 -->
					<tr>
						<th>품절여부</th>
						<td>
							<!-- 체크박스의 기본값 설정 -->
							<input type="checkbox" id="menu_soldout" name="menu_soldout" value="1"
								${vo.menu_soldout == 1 ? 'checked' : ''}>
							<label for="menu_soldout">품절</label>
							<!-- 체크되지 않은 경우의 값을 전송하는 숨겨진 필드 -->
							<input type="hidden" name="menu_soldout" value="0">
						</td>
					</tr>
	               
	               <tr>
	                   <td colspan="2" align="center">
	                       <input class="btn  btn-primary" type="button"  value="수정하기" 
	                              onclick="send(this.form);">
	                       <input class="btn  btn-success" type="button"  value="메인으로" 
	                              onclick="location.href='list.do'">
	                   </td>
	               </tr>
	               
	          </table>
	      </div>
	    </div>
  </div>
</form>


</body>
</html>