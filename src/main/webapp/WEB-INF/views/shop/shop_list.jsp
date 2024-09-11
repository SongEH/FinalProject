<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <style>
      /* *{
        border: 1px solid grey
      } */
      .container{
        display: flex;
        justify-content: center;
        align-items: center;
        margin: auto;
        margin-top: 5%;
      }
      body {
        background-color: #f8f9fa;
        font-family: "Arial", sans-serif;
      }
      .menu-section {
        margin-bottom: 40px;
      }
      .menu-item {
        margin-bottom: 20px;
      }
      .menu-item h5 {
        font-weight: bold;
      }
      .menu-item p {
        margin-bottom: 0;
      }
      .price {
        float: right;
        font-weight: bold;
      }
    </style>

    <style>
      body {
        background-color: rgb(92, 161, 218);
      }

      @media (min-width: 768px) {
        body {
          background-color: rgb(235, 221, 203);
        }
      }

      @media (min-width: 992px) {
        body {
          background-color: rgb(221, 162, 162);
        }
      }

      @media (min-width: 1200px) {
        body {
          background-color: rgb(195, 228, 163);
        }
      }

      .menu-item:hover{
        cursor:pointer;
      }
    </style>
    <script>
      function insert_form_shop(){
          
        $.ajax({
          url       :   "/shop/insert_form.do",
          success   :   function(res_data){
              alert("사업자가 확인되었습니다.")
              $("#insert_form_display").html(res_data);
              $("#main").hide();
          },
          error     :   function(err){
              alert(error.responseText)
          }
        })
      }
    </script>
    
    <script>

      function selectOne(shop_id){

        $.ajax({
          url     :     "/shop/select_one.do",
          data    :      {"shop_id": shop_id},
          success :   function(res_data){
                alert("성공")
                $("#select_one_display").html(res_data);
                $("#insert_form_display").hide();
                $("#main").hide();
          },
          error   :   function(err){
            alert(error.responseText);
          }
        });
      }

    </script>
  </head>
  <body>
    <!-- common import -->
    <%@include file="../common.jsp" %>

    <!-- header import -->
    <%@include file="../header.jsp" %>

      <!-- side bar import -->
      <%@include file="../sidebar.jsp" %>

    
    <div class="container">
      <main id="main">
      <div class="menu-section">
          <div class="row">
            <c:forEach var="vo" items="${list}">
            <div class="col-md-6 col-sm-12 menu-item" onclick="selectOne('${vo.shop_id}');">
              <div class="row">
                <div class="row-md2 col-sm-4">
                  <img
                    src="${pageContext.request.contextPath }/resources/images/${vo.shop_img}" alt="Shop Image"
                    style="height: 100px" width="100%"
                  />
                </div>
                <div class="row-md10 col-sm-8">
                  <h2>${vo.shop_name}</h2>
                  <p>${vo.shop_rate} | ${vo.shop_review_count}</p>
                  <p>${vo.shop_min_price}</p>
                </div>
              </div>
            </div>
          </c:forEach>
          </div>
        
      </div>
  </main>
  <div>
    <div id="insert_form_display"></div>
  </div>
  <div>
    <div id="select_one_display"></div>
  </div>

</head>
<body>

</body>
</html>
