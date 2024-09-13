<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <style>
      body{
        width: 100%;
      }
      .container-custom{
        margin:auto;
        width: 1000px;
        /* justify-content: space-between; */
        /* padding: 20px 0;
        width: 1200px; 
        display: flex;
        margin: 0;
        position: relative; */
      }
      .row{
        margin: 0;
      }
      panel-left, .panel-right {
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
       .shop{
        /* width: 1000px; */
        margin: auto;
      }
      
      /* .shop-info { */
        /* width: 600px; */
      /* } */
      .col-custom{
        width:66.66667%;
      }
      .shop-info h1 {
          font-size: 20px;
          margin-bottom: 10px;
      }
      .shop-info img{
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
      .menu-item img{
        width: 80px;
        height: 80px;
        padding-right: 10px;
        display: flex;
        align-items: center;
      }
      .order_info{
        width: 300px;
      }
      #shop_name{
        font-size: 16px;
        padding: 10px;
        border: 1px solid gray;
      }
      #shop_info{
        padding: 10px;
        border:1px solid grey;
        border-top: none;
      }
      #shop_content{
        padding: 10px;
        border:1px solid grey;
        border-top: none;
        width: 100%;
        text-overflow: ellipsis;
        white-space: nowrap;
        overflow: hidden; 
      }
      .shop_info_list{
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
        padding:0;
      }
      #menuButton:focus {
        outline: none;
      }
      .menu-tab .badge {
        margin-left: 10px;
      }
      .right-panel{
        position: sticky;
        top: 30px;
      }
      .right-panel h2 {
          font-size: 20px;
      }
      .menu-tab input:hover,
      .menu-tab input:focus {
        color : #F0A8D0;
        font-size: 14px;
        font-weight: bold;
        border-bottom: 5px solid #F0A8D0;
        transform: scale(1.05); /* Make button slightly larger on hover */
      }
  </style>
  <script>
    function get_menu(shop_id){
      $('#menu_display').html();
      $('#reviews_display').hide();

    }
  </script>
  <script>
    // 특정 가게 삭제 
    function shop_del(shop_id){
      alert(shop_id);
      if(confirm("삭제하면 복구되지 않습니다?\n 정말 삭제하시겠습니까? ")==false) return;

      $.ajax({
      url     :     "/shop/delete.do",
      data    :      {"shop_id": shop_id},
      success :   function(res_data){
                alert("삭제 성공")
                location.href="/shop/list.do";
        },
      error   :   function(err){
      alert(error.responseText)
        }
      });
    }
  </script>

  <script>
    // 선택한 가게 수정 
    function shop_modi(f){
      alert("여기?");
      alert(f.shop_id.value);
      f.action="modify_form.do";
      f.submit();
    }

    function reviews_list(shop_id){
      alert("도착");
      $.ajax({
        url     :   "../reviews/list.do",
        method  :   "POST",
        data    :   {"shop_id": shop_id},
        success :   function(res_data){
          alert("성공");
          $("#reviews_display").html(res_data);
          $("#menu_display").hide();
        },
        error   :   function(err){
          alert(error.responseText);
        }
      });
    }
  </script>
</head>
<body>
  <form method="post">
  <!-- 표현은 하지않고 활용하기 위한 데이터  -->
   <input type="hidden" name="shop_id" value="${vo.shop_id}"/>
   
<div class="container-custom">
  <div class="shop">
    <div class="row">
        <!-- Left Panel (shop Information) -->
        <div class="col-md-8 col-sm-12 col-custom">
            <div class="shop-info">
                <div id="shop_name">${vo.shop_name}</div>
                
                <div class="rating" id="shop_info">
                    <img src="${pageContext.request.contextPath }/resources/images/${vo.shop_img}" alt="Rating Star" width="20"> 
                    <span>${vo.shop_stemp_count}
                      <div class="details">
                        <div><strong>21,000원 이상 주문 시 4,000원 할인</strong></div>
                        <div>최소 주문 금액: <strong>${vo.shop_min_price}</strong></div>
                        <div>결제: <strong>신용카드, 현금, 요기서결제</strong></div>
                        <button class="btn btn-danger">4,000원 할인</button>
                      </div>
                    </span>
                </div>
                <div id="shop_content">${vo.shop_content}</div>
            </div>

            <!-- menu_list 공간 -->
            

            <!-- 메뉴 / 클린리뷰 / 정보  -->
          <div class="row" style="width:100%; margin-top: 30px;">
            <div class="col-sm-4" style="padding:0px">
              <div class="menu-tab border">
                <input type="button" id="menuButton" value="메뉴 ${vo.shop_stemp_count}"
                onclick="get_menu('${vo.shop_id}')">
              </div>
            </div>
            <div class="col-sm-4" style="padding:0px">
              <div class="menu-tab border">
                <input type="button" id="reviewButton" value="클린리뷰(리뷰갯수카운트값)" onclick="reviews_list('${vo.shop_id}');"/>
              </div>
            </div>
            <div class="col-sm-4" style="padding:0px">
              <div class="menu-tab border">
                <input type="button" id="infoButton" value="정보"/>
              </div>
            </div>
          </div>

          
          <div class="row" style="margin-top:30px;">
            <!--menu_list 출력 공간 -->
            <div id="menu_display" style="padding: 0;">
              <c:forEach var="item" items="${menu_list}">
                <div class="menu-item" style="border: 1px solid gray; height: 120px; display: flex; align-items: center; padding: 10px;">
                  <div>
                    <div>${item.menu_name}</div>
                    <div>${item.menu_content}</div>
                    <div><strong>${item.menu_price}</strong></div>
                  </div>
                  <img src="${pageContext.request.contextPath }/resources/images/${item.menu_img}" alt="menu_image" style="margin-left:auto;">
                </div>
              </c:forEach>
            </div>

            <!-- review list 출력 공간 -->
            <div>
              <div id="reviews_display"></div>
            </div>
            
            <!-- shop_info_list 출력 공간 -->
            <div id="shop_info_display">

            </div>
          </div>
        </div>

        <!-- 주문 영역 출력 공간  -->
        <div class="col-md-4 col-sm-12">
          <div class="order_info">
          <!-- <div class="right-panel text-center p-3"> -->
            <div style="background-color:black; color:white; padding: 7px;">
              <h5>주문표</h5>
            </div>
              <div style="border:1px solid gray; height:auto; min-height: 155px;">
                주문표에 담긴 메뉴가 없습니다.
              </div>
              <div style="border:1px solid gray; height:45px;">배달요금 <strong>2,000원</strong> 별도</div>
              <button class="btn btn-secondary" disabled>주문하기</button>
            </div>
          <!-- </div> -->
          </div>
        </div>
    </div>
  </div>

  <!-- Sample Menu List -->
  <!-- <div class="container" id="menu_list" style="margin:auto; padding:0;">
    <c:forEach var="item" items="${menu_list}">
      <div class="row col-md-8 col-sm-12 col-custom">
        <div class="menu-item" style="border: 1px solid gray; width:75%;">
          <img src="${pageContext.request.contextPath }/resources/images/${item.menu_img}" alt="menu_image" style="float:right">
          <div>${item.menu_name}</div>
          <div>${item.menu_content}</div>
          <div><strong>${item.menu_price}</strong></div>
        </div>
      </div>
    </c:forEach>
  </div> -->
  <!-- <div>
    <div id="menu_list"></div>
  </div> -->
</div>
</body>
</html>
