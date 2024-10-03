<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8" />
  <title>Insert title here</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <style>
    body {
      width: 100%;
    }

    .container-custom {
      margin: auto;
      width: 1000px;
      /* justify-content: space-between; */
      /* padding: 20px 0;
        width: 1200px; 
        display: flex;
        margin: 0;
        position: relative; */
    }

    .row {
      margin: 0;
    }

    panel-left,
    .panel-right {
      padding: 10px;
      /* border: 1px solid gray; */
      /* background-color: #f9f9f9; */
    }

    .panel-left {
      width: 70%;
    }

    .panel-right {
      /* width: 330px; */
      position: sticky;
      top: 30px;
    }

    .shop {
      /* width: 1000px; */
      margin: auto;
    }

    /* .shop-info { */
    /* width: 600px; */
    /* } */
    .col-custom {
      width: 66.66667%;
    }

    .shop-info h1 {
      font-size: 20px;
      margin-bottom: 10px;
    }

    .shop-info img {
      width: 60px;
      height: 60px;
      padding-left: 10px;
    }

    .shop-info .rating {
      width: 100%;
      display: flex;
      align-items: center;
    }

    .shop-info .rating span {
      font-size: 16px;
      margin-left: 5px;
    }

    .shop-info .rating img {
      width: 155px;
      height: 155px;
      padding: 0;
    }

    .menu-item img {
      width: 80px;
      height: 80px;
      padding-right: 10px;
      display: flex;
      align-items: center;
    }

    .order_info {
      width: 350px;
      position: sticky;
      top: 0;
    }

    #shop_name {
      font-size: 16px;
      padding: 10px;
      border: 1px solid gray;
    }

    #shop_info {
      padding: 10px;
      border: 1px solid grey;
      border-top: none;
    }

    .shop_content_CSS {
    padding: 10px;
    border: 1px solid grey;
    border-top: none;
    width: 100%;
    display: -webkit-box;
    overflow: hidden;
    text-overflow: ellipsis;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 1;
    line-clamp: 1;
    height: 40px;
}

    .shop_info_list {
      border: 1px solid grey;
    }

    .menu-tab input[type="button"] {
      width: 100%;
      height: 40px;
      background-color: white;
      border: 1px solid gray;
    }

    .menu-section {
      width: 100%;
      margin-top: 20px;
      padding-top: 10px;
    }

    .menu-section .menu-title {
      font-size: 18px;
      margin-bottom: 5px;
    }

    .menu-tab {
      display: flex;
      align-items: center;
    }

    .menu-tab input[type="button"] {
      flex-shrink: 0;
      padding: 0;
    }

    #menuButton:focus {
      outline: none;
    }

    .menu-tab .badge {
      margin-left: 10px;
    }

    .right-panel {
      position: sticky;
      top: 30px;
    }

    .right-panel h2 {
      font-size: 20px;
    }

    .menu-tab input:hover,
    .menu-tab input:focus {
      color: #F0A8D0;
      font-size: 14px;
      font-weight: bold;
      border-bottom: 5px solid #F0A8D0;
      transform: scale(1.05);
      /* Make button slightly larger on hover */
    }
    .star-empty{
      color: white;
      text-shadow: 0px 0px 0.5px black;
    }
    .container .container {
      width: auto; /* Override specific styles */
      max-width: none; /* Reset width restrictions */
      padding-left: 0;
      padding-right: 0;
      margin-left: 0;
      margin-right: 0;
    }
    footer{
      margin: auto;
      padding:0;
      border-top: none;   
    }
  </style>
  <script>
    function get_info(shop_id) {
      $.ajax({
        url: "../shop/select_info.do",
        data: {
          "shop_id": shop_id
        },
        success: function (res_data) {
          $("#shop_info_display").html(res_data).show();
          $("#menu_display").hide();
          $('#reviews_display').hide();

        },
        error: function (err) {
          alert(err.responseText)
        }
      });
    }
  </script>
  <script>
    // menu 호출 
    function get_menu(shop_id,shop_status) {
      $.ajax({
        url: "../menu/listByShopId.do",
        data: {
          "shop_id": shop_id,
          "shop_status" : shop_status,
        },
        success: function (res_data) {
          // alert(res_data);
          $("#menu_display").html(res_data).show();
          $('#reviews_display').hide();
          $("#shop_info_display").hide();
        },
        error: function (err) {
          alert(err.responseText)
        }
      });
    }
  </script>
  <script>
    // 특정 가게 삭제 
    function shop_del(shop_id) {
      alert(shop_id);
      if (confirm("삭제하면 복구되지 않습니다?\n 정말 삭제하시겠습니까? ") == false) return;

      $.ajax({
        url: "/shop/delete.do",
        data: {
          "shop_id": shop_id
        },
        success: function (res_data) {
          alert("삭제 성공");
          location.href = "/shop/list.do";
        },
        error: function (err) {
          alert(error.responseText)
        }
      });
    }
  </script>

  <script>
    // 선택한 가게 수정 
    function shop_modi(f) {
      alert("여기?");
      alert(f.shop_id.value);
      f.action = "modify_form.do";
      f.submit();
    }

    function get_review(shop_id) {
      // alert("도착");
      // alert(shop_id);
      $.ajax({
        url: "../reviews/listByShopId.do",
        method: "POST",
        data: {
          "shop_id": shop_id
        },
        success: function (res_data) {
          // alert(res_data);
          $("#reviews_display").html(res_data).show();
          $("#menu_display").hide();
          $("#shop_info_display").hide();
        },
        error: function (err) {
          alert(err.responseText);
        }
      });
    }
    // location.href="../reviews/listByShopId.do?shop_id=" + shop_id;
    // }

     // 천 단위 콤마 추가하는 함수
    function formatNumber(num) {
      return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    // shop_min_price 값에 콤마 추가
    let shop_min_price = document.getElementById("shop_min_price");
    let price = shop_min_price.innerHTML; // ${vo.shop_min_price} 값 가져오기
    shop_min_price.innerHTML = formatNumber(price);
    </script>

</head>

<body>
  <form method="post">
    <!-- 표현은 하지않고 활용하기 위한 데이터  -->
    <input type="hidden" name="shop_id" value="${vo.shop_id}" />
    <input type="hidden" name="shop_status" value="${shop_status}"/>
    <input type="hidden" name="shop_min_price" id="shop_min_price" value="${shop_min_price}"/>

    <div class="container-custom">
      <div class="shop">
        <div class="row">
          <!-- Left Panel (shop Information) -->
          <div class="col-md-8 col-sm-12 col-custom">
            <div class="shop-info">
              <div id="shop_name">${vo.shop_name}</div>

              <div class="rating" id="shop_info">
                <img src="${pageContext.request.contextPath }/resources/images/${vo.shop_img}" alt="Rating Star">
                <span>
                  <div class="stars" style="margin-bottom: 10px;">
                    <c:if test="${vo.shop_rating != null && vo.shop_rating > 0}">
                      <c:forEach begin="1" end="${vo.shop_rate}">
                        <i class="fa fa-star"></i>
                      </c:forEach>
                      <c:forEach begin="1" end="${5 - vo.shop_rate}">
                        <i class="fa fa-star star-empty"></i>
                      </c:forEach>
                      ${vo.shop_rating}
                    </c:if>
                  </div>
                  <div class="details">
                    <!-- <div><strong>21,000원 이상 주문 시 4,000원 할인</strong></div> -->
                    <div style="margin-bottom: 10px;">최소 주문 금액: <strong id="shop_min_price"> <fmt:formatNumber value="${vo.shop_min_price}" pattern="#,###"/> </strong></div>
                    <div>결제: <strong>신용카드, 현금, 요기서결제</strong></div>
                    <!-- <button class="btn btn-danger">4,000원 할인</button> -->
                  </div>
                </span>
              </div>
              <div class="shop_content_CSS">📢사장님 알림${vo.shop_content.replaceAll('<[^>]*>', '')}</div>
            </div>

            <!-- 메뉴 / 클린리뷰 / 정보  -->
            <div class="row" style="width:100%; margin-top: 30px;">
              <div class="col-sm-4" style="padding:0px">
                <div class="menu-tab border">
                  <input type="button" id="menuButton" value="메뉴 (${vo.menu_count})"
                    onclick="get_menu('${vo.shop_id}', '${shop_status}')">
                </div>
              </div>
              <div class="col-sm-4" style="padding:0px">
                <div class="menu-tab border">
                  <input type="button" id="reviewButton" value="클린리뷰(${vo.reviews_count})"
                    onclick="get_review('${vo.shop_id}');" />
                </div>
              </div>
              <div class="col-sm-4" style="padding:0px">
                <div class="menu-tab border">
                  <input type="button" id="infoButton" value="정보" onclick="get_info('${vo.shop_id}')" />
                </div>
              </div>
            </div>

            <div class="row" style="margin-top:30px;">
              <!--menu_list 출력 공간 -->
              <div style="padding: 0;">
                <div id="menu_display"></div>
              </div>

              <!-- review list 출력 공간 -->
              <div>
                <div id="reviews_display"></div>
              </div>
              <!-- shop_info_list 출력 공간 -->
              <div style="border:1px solid lightgray;">
                <div id="shop_info_display"></div>
              </div>
            </div>
          </div>

          <!-- 장바구니 영역 출력 공간  -->
          <div class="col-md-4 col-sm-12">
            <div class="order_info">
              <!-- <div class="right-panel text-center p-3"> -->
              <div style="background-color:black; color:white; padding: 7px;">
                <h5>장바구니</h5>
              </div>
              <div style="border:1px solid gray; height:auto; min-height: 155px;">
                <!-- 장바구니에 담긴 메뉴가 없습니다. -->

                <!-- 장바구니 목록 출력 -->
                <div id="cart_list"></div>
              </div>                          
            </div>
            <!-- </div> -->
          </div>
        </div>
      </div>
    </div>
    </div>
    </div>
</body>

</html>
