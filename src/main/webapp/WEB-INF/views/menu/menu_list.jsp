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
    function optionChange() {
      let selectValue = document.getElementById("sortOption").value;
      
      alert(selectValue);

      // $.ajax({
      //   url: "/menu/menu_rank.do",
      //   data: {
      //     "selectValue": selectValue
      //   },
      //   success: function (res_data) {
      //     $("#store_list").hide();
      //     $("#store_list_display").html(res_data);
      //   },
      //   error: function (err) {
      //     alert(error.responseText)
      //   }
      // });
    }
  </script>

</head>

<body>


  <%@include file="../common.jsp" %>

  <%@include file="../header.jsp" %>

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

    <div id="menu_sort" style="margin-bottom: 20px;">
      <select id="sortOption" class="form-control" onchange="optionChange()">
        <option value="rank">기본 정렬순</option>
        <option value="rank_popularity">인기메뉴</option>
        <option value="rank_soldout">품절메뉴</option>
        <option value="rank_hidden">숨김메뉴</option>
      </select>
    </div>
    <!-- 메뉴목록리스트 -->
    <%@include file="menu_list_display.jsp" %>

  </main><!-- End #main -->

</body>

</html>