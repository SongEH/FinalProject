<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="utf-8">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <style>
    #menuImg {
      width: 200px !important;
    }
  </style>
  <script>

    // 메뉴 필터링
    function optionChange() {
      let selectValue = document.getElementById("sortOption").value;
      let shopId = document.getElementById("shop_id").value;

      $.ajax({
        url: "/menu/menu_rank.do",
        data: {
          "selectValue": selectValue,
          "shop_id": shopId
        },
        success: function (res_data) {
          $("#menu_default_list").hide();
          $("#menu_rank_list").html(res_data);
        },
        error: function (err) {
          alert(error.responseText)
        }
      });
    }

    // 사장용 메뉴상세 보기
    function show_menu(menu_id) {

      location.href = "show.do?menu_id=" + menu_id;
    }

    // 사장용 메뉴 삭제
    function delete_menu(menu_id) {

      if (confirm("정말 삭제하시겠습니까?") == false) return;

      location.href = "delete.do?menu_id=" + menu_id;
    }

    // 사장용 메뉴 수정
    function modify_menu(menu_id) {

      location.href = "modify_form.do?menu_id=" + menu_id;

    }
  </script>

</head>

<body>

  <!-- 공통 css import -->
  <%@include file="../common.jsp" %>

  <!-- header import -->
  <%@include file="../header.jsp" %>

  <!-- side bar import -->
  <%@include file="../sidebar.jsp" %>

  <main id="main" class="main">
    <div class="pagetitle">
      <h1>메뉴목록</h1><br>

      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">Home</a></li>
          <li class="breadcrumb-item">메뉴관리</li>
          <li class="breadcrumb-item active">메뉴목록</li>
        </ol>
      </nav>
    </div>
    <!-- End Page Title -->

    <div id="menu_sort" style="margin-bottom: 20px;">
      <select id="sortOption" class="form-control" onchange="optionChange()">
        <option value="rank">모든메뉴</option>
        <option value="rank_normal">기본메뉴</option>
        <option value="rank_popularity">인기메뉴</option>
        <option value="rank_soldout">품절메뉴</option>
        <option value="rank_hidden">숨김메뉴</option>
      </select>
    </div>

    <input type="hidden" id="shop_id" value="${shop_id}">

    <!-- 메뉴목록리스트 -->
    <div id="menu_default_list">
      <c:forEach var="item" items="${menu_list}">
        <!-- item.menu_status가 1인 경우만 표시 -->
        <c:if test="${item.menu_status == 1}">
          <div class="card mb-3">
            <div class="row g-0" lass="photo">
              <div class="col-md-4">
                <img id="menuImg" src="../resources/images/${item.menu_img}" class="img-fluid rounded-start" alt="...">
              </div>
              <div class="col-md-8">
                <div class="card-body">
                  <h5 class="card-title">
                    <div style="color:red;">
                      <c:choose>
                        <c:when test="${item.menu_popularity == 1}">
                          인기
                        </c:when>
                        <c:when test="${item.menu_hidden == 1}">
                          숨김
                        </c:when>
                        <c:when test="${item.menu_soldout == 1}">
                          품절
                        </c:when>
                        <c:otherwise>
                          <!-- 아무 조건에도 해당하지 않으면 빈 문자열 -->
                        </c:otherwise>
                      </c:choose>
                    </div>
                    ${item.menu_name}
                  </h5>
                  <p class="card-text">${item.menu_content}</p>
                  <p class="card-text">${item.menu_price}원</p>

                  <input class="button_style" type="button" id="btn_popup_update" value="상세보기"
                    onclick="show_menu('${item.menu_id}');">
                  <input class="button_style" type="button" id="btn_popup_update" value="수정"
                    onclick="modify_menu('${item.menu_id}');">
                  <input class="button_style" type="button" id="btn_popup_delete" value="삭제"
                    onclick="delete_menu('${item.menu_id}');">
                </div>
              </div>
            </div><!-- End Card with an image on left -->
          </div>
        </c:if>
      </c:forEach>
    </div>

    <!-- 메뉴 필터링된 목록 표시 영역 -->
    <div id="menu_rank_list">
    </div>

  </main><!-- End #main -->

</body>

</html>