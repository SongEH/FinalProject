<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="utf-8">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

  <script type="text/javascript">
    function show_menu(menu_id) {

      location.href = "show.do?menu_id=" + menu_id;
    }

    function delete_menu(menu_id) {

      if (confirm("정말 삭제하시겠습니까?") == false) return;

      location.href = "delete.do?menu_id=" + menu_id;
    }


    function modify_menu(menu_id) {

      location.href = "modify_form.do?menu_id=" + menu_id;

    }


    function menu_modal(menu_id) {

      //alert(p_idx + " 그림정보 조회");

      console.log("Menu ID:", menu_id);

      // Show the modal
      var myModal = new bootstrap.Modal(document.getElementById('menuModal'), {
        backdrop: 'static',
        keyboard: false
      });
      myModal.show();



      // p_idx에 대한 사진정보 가져오기(Ajax이용 JSON형식)
      $.ajax({
        url: "menu_one.do", //PhotoOneAction
        data: {
          "menu_id": menu_id
        }, //parameter => photo_one.do?p_idx=5
        dataType: "json",
        success: function (res_data) {
          // res_data = {"p_idx":5, "p_title":"제목" , "p_content":"내용" , "p_filename":"a.jpg",....}
          console.log(res_data);

          $("#pop_image").prop("src", "../resources/images/" + res_data.menu_img);

          $("#pop_title").html(res_data.menu_name);
          $("#pop_content").html(res_data.menu_content);
          $("#pop_regdate").html(res_data.menu_cdate);
          $("#pop_price").html(res_data.menu_price);

          //버튼 보여지기 유/무

          //버튼숨기기
          $("#btn_popup_download").hide(); //다운
          $("#btn_popup_update").hide(); //수정
          $("#btn_popup_delete").hide(); //삭제

          //로그인된 상태에는 다운로드 가능
          if ("${ not empty user}" == "true") {
            $("#btn_popup_download").show();
          }

          //현재 사진을 올린 유저가 로그인한 유저면(수정/삭제)
          //alert("${ user.mem_idx }" == res_data.mem_idx);
          if ("${ user.mem_idx }" == res_data.mem_idx) {

            $("#btn_popup_update").show(); //수정
            $("#btn_popup_delete").show(); //삭제
          }
        },
        error: function (err) {
          alert(err.responseText);
        }
      });




    }
  </script>
</head>

<body>
  <%@include file="popup.jsp" %>

  <%@include file="../common.jsp" %>

  <!-- header import -->
  <%@include file="../header.jsp" %>

  <!-- side bar import -->
  <%@include file="../sidebar.jsp" %>

  <main id="main" class="main">
    <div class="pagetitle">

      <h1>Form Layouts</h1>

      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">Home</a></li>
          <li class="breadcrumb-item">Forms</li>
          <li class="breadcrumb-item active">Layouts</li>
        </ol>
      </nav>

    </div><!-- End Page Title -->

    <section class="section">
      <div class="row align-items-top">
        <div class="col-lg-6">
          <c:forEach var="vo" items="${list}">
            <!-- vo.menu_status가 1인 경우만 표시 -->
            <c:if test="${vo.menu_status == 1}">



              <!-- Card with an image on left -->
              <div class="card mb-3">
                <div class="row g-0" lass="photo" onclick="menu_modal('${ vo.menu_id }');">
                  <!-- popup:Modal -->

                  <div class="col-md-4">
                    <img src="../resources/images/${vo.menu_img}" class="img-fluid rounded-start" alt="...">
                  </div>
                  <div class="col-md-8">
                    <div class="card-body">
                      <h5 class="card-title">
                        <div style="color:red;">
                          <c:choose>
                            <c:when test="${vo.menu_popularity == 1}">
                              인기
                            </c:when>
                            <c:when test="${vo.menu_hidden == 1}">
                              숨김
                            </c:when>
                            <c:when test="${vo.menu_soldout == 1}">
                              품절
                            </c:when>
                            <c:otherwise>
                              <!-- 아무 조건에도 해당하지 않으면 빈 문자열 -->
                            </c:otherwise>

                          </c:choose>
                        </div>
                        메뉴명 (${vo.menu_id})
                        ${vo.menu_name}
                      </h5>
                      <p class="card-text">설명 ${vo.menu_content}</p>
                      <p class="card-text">가격 ${vo.menu_price}</p>
                      <input class="btn btn-info" type="button" id="btn_popup_update" value="상세보기"
                        onclick="show_menu('${vo.menu_id}');">
                      <input class="btn btn-info" type="button" id="btn_popup_update" value="수정"
                        onclick="modify_menu('${vo.menu_id}');">
                      <input class="btn btn-danger" type="button" id="btn_popup_delete" value="삭제"
                        onclick="delete_menu('${vo.menu_id}');">
                    </div>
                  </div>
                  <div id="pop_job" style="text-align: center;">

                  </div>
                </div><!-- End Card with an image on left -->
              </div>
            </c:if>
          </c:forEach>
        </div>
      </div>
    </section>

  </main><!-- End #main -->

</body>

</html>
