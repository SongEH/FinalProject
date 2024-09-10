<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="utf-8">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

</head>

<body>

  <%@include file="../common.jsp" %>

  <%@include file="../header.jsp" %>

  <%@include file="../sidebar.jsp" %>

  <main id="main" class="main">
    <div class="pagetitle">

      <h1>주문내역</h1>

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

            <!-- Card with an image on left -->
            <div class="card mb-3">
              <div class="row g-0" lass="photo">
                <!-- popup:Modal -->

                <div class="col-md-4">
                  dd
                </div>
                <div class="col-md-8">
                  <div class="card-body">
                    <h5 class="card-title">
                      <div style="color:red;">

                        <p class="card-text">이름 ${vo.orders_name}</p>

                        <input class="btn btn-info" type="button" id="btn_popup_update" value="세부내역보기"
                          onclick="show_menu('${vo.orders_id}');">
                      </div>
                  </div>

                </div><!-- End Card with an image on left -->
              </div>

          </c:forEach>
        </div>
      </div>
    </section>

  </main><!-- End #main -->

</body>

</html>