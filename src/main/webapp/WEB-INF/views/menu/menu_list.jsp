<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="utf-8">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

  <style>
    .menu-card {
      background-color: white;
      border-radius: 8px;
      padding: 20px 15px;
      /* 상하 2px, 좌우 15px */
      margin-bottom: 20px;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    td {
      padding-bottom: 7px !important;
    }

    .menu-img {
      border-radius: 8px;
      width: 150px;
      height: 150px;
      /* 자동 높이 조정 */
      object-fit: cover;
      /* 비율 유지 */
    }

    .button_style {
      padding: 50px 50px;
      width: 150px;
      margin-bottom: 10px;
      margin-left: 30px;
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
          <li class="breadcrumb-item"><a href="../order/accept.do">Home</a></li>
          <li class="breadcrumb-item">메뉴관리</li>
          <li class="breadcrumb-item active">메뉴목록</li>
        </ol>
      </nav>
    </div>
    <!-- End Page Title -->

    <!-- <div id="menu_sort" style="margin-bottom: 20px;">
      <select id="sortOption" class="form-control" onchange="optionChange()">
        <option value="rank">모든메뉴</option>
        <option value="rank_normal">기본메뉴</option>
        <option value="rank_popularity">인기메뉴</option>
        <option value="rank_soldout">품절메뉴</option>
        <option value="rank_hidden">숨김메뉴</option>
      </select>
    </div> -->

    <input type="hidden" id="shop_id" value="${shop_id}">

    <!-- 메뉴목록리스트 -->
    <div id="menu_default_list">
      <c:forEach var="item" items="${menu_list}">
        <!-- item.menu_status가 1인 경우만 표시 -->
        <c:if test="${item.menu_status == 1}">
          <div class="menu-card" style="width:60%;">
            <table style="border-collapse: collapse;">
              <tr>
                <td style="vertical-align: top;">
                  <img id="menuImg" src="../resources/images/${item.menu_img}" alt="..." class="menu-img">
                </td>
                <td style="padding-left: 15px; width: 450px; vertical-align: top;">
                  <h5>                   
                    ${item.menu_name}
                    <c:choose>
                      <c:when test="${item.menu_popularity == 1}"><span class="badge rounded-pill bg-warning"
                          style="margin-left: 5px;">인기</span></c:when>
                      <c:when test="${item.menu_soldout == 1}"><span class="badge rounded-pill bg-secondary"
                          style="margin-left: 5px;">품절</span></c:when>
                      <c:otherwise></c:otherwise>
                    </c:choose>
                  </h5>
                  <p style="margin: 15px 0;">${item.menu_content}</p>
                  <p style="margin: 15px 0;">
                    <fmt:formatNumber value="${item.menu_price}" pattern="#,###" />원</p>
                </td>
                <td>
                  <input class="button_style" type="button" id="btn_popup_update" value="상세보기"
                    onclick="show_menu('${item.menu_id}');"><br>
                  <input class="button_style" type="button" id="btn_popup_update" value="수정"
                    onclick="modify_menu('${item.menu_id}');"><br>
                  <input class="button_style" type="button" id="btn_popup_delete" value="삭제"
                    onclick="delete_menu('${item.menu_id}');">
                </td>

              </tr>
            </table>
          </div>
        </c:if>
      </c:forEach>
    </div>

    <!-- 메뉴 필터링된 목록 표시 영역 -->
    <!-- <div id="menu_rank_list">
    </div> -->

  </main>

</body>

</html>