<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html>

  <head>
    <meta charset="UTF-8">
    <title>Insert title here</title>

    <style type="text/css">
      .mycommon {

        /* text-align: center; */
        width: 300px;
        margin: auto;
        border: 1px solid gray;
        margin-bottom: 10px;
        padding: 5px;

        box-shadow: 1px 1px 1px black;
      }

      #pop_image {
        width: 300px;
        height: 300px;
        border: 2px solid gray;
        outline: 2px solid black;
      }

      #pop_content {
        min-height: 80px;
      }
    </style>


    <script type="text/javascript">

      //전역변수
      var g_menu_img; //hoisting
      var g_menu_id;


      function delete_photo() {

        if (confirm("정말 삭제하시겠습니까?") == false) return;

        location.href = "delete.do?menu_id=" + g_menu_id;// PhotoDeleteAction
      }//end:delete_photo()

      function modify_photo() {

        location.href = "modify_form.do?menu_id=" + g_menu_id;// PhotoModifyFormAction

      }//end:modify_form()
    </script>
  </head>

  <body>
    <!-- 이미지 팝업  -->
    <!-- Modal -->
    <div class="modal fade" id="photoModal" tabindex="-1" role="dialog" aria-labelledby="photoModalLabel"
      aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">

        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">×</button>
            <!-- <h4 class="modal-title" id="pop_mem_name">올린이: 홍길동</h4> -->
          </div>

          <!-- 본문 -->
          <div class="modal-body">
            <div style="text-align: center; height: 310px;">
              <img id="pop_image">
            </div>
            메뉴명<div class="mycommon" id="pop_title">메뉴명</div>
            메뉴설명<div class="mycommon" id="pop_content">메뉴설명</div>
            가격<div class="mycommon" id="pop_price">가격</div>
            카테고리<div class="mycommon" id="pop_category">카테고리</div>
            인기여부<div class="mycommon" id="pop_popularity">인기여부</div>
            등록날짜<div class="mycommon" id="pop_regdate">등록날짜</div>

            <div id="pop_job" style="text-align: center;">
              <input style="display: none;" class="btn btn-info" type="button" id="btn_popup_update" value="수정"
                onclick="modify_photo();">
              <input style="display: none;" class="btn btn-danger" type="button" id="btn_popup_delete" value="삭제"
                onclick="delete_photo();">

              <button class="btn btn-primary" type="button" data-dismiss="modal">닫기</button>
            </div>


          </div>
          <!--   
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div> -->
        </div>
      </div>
    </div>
  </body>

  </html>