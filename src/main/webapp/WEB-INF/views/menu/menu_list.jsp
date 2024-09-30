<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <style>
      #menuImg {
        width: 200px !important;
      }
    </style>
    <script>
      function optionChange() {
        let selectValue = document.getElementById("sortOption").value;
        let shopId = document.getElementById("shop_id").value;

        alert(shopId);

        $.ajax({
          url: "/menu/menu_rank.do",
          data: {
            selectValue: selectValue,
            shop_id: shopId,
          },
          success: function (res_data) {
            $("#menu_default_list").hide();
            $("#menu_rank_list").html(res_data);
          },
          error: function (err) {
            alert(error.responseText);
          },
        });
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
        <h1>메뉴목록</h1>

        <nav>
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.html">Home</a></li>
            <li class="breadcrumb-item">메뉴관리</li>
            <li class="breadcrumb-item active">메뉴목록</li>
          </ol>
        </nav>
      </div>
      <!-- End Page Title -->

      <div id="menu_sort" style="margin-bottom: 20px">
        <select id="sortOption" class="form-control" onchange="optionChange()">
          <option value="rank">기본 정렬순</option>
          <option value="rank_popularity">인기메뉴</option>
          <option value="rank_soldout">품절메뉴</option>
          <option value="rank_hidden">숨김메뉴</option>
        </select>
      </div>

      <input type="hidden" id="shop_id" value="${shop_id}" />

      <!-- 메뉴목록리스트 -->
      <div id="menu_default_list">
        <%@include file="menu_list_display.jsp" %>
      </div>

      <div id="menu_rank_list"></div>
    </main>
    <!-- End #main -->
  </body>
</html>
