<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


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
body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
}
.container {
  display: flex;
  flex-direction: column;
  flex-wrap: nowrap;
  justify-content: center;
  box-sizing: border-box;
}
.menu_sort{
  align-items: end;
  display: block;
}
#sort_display{
  float: right;
  margin-left: auto;
}
.search-bar {
  display: flex;
  justify-content: center;
  padding: 20px 0;
  background-color: #fff4f4;
}
.search-bar input[type="text"] {
  width: 400px;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
  margin-right: 10px;
  font-size: 16px;
}
.search-bar button {
  padding: 10px 20px;
  background-color: orange;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  font-size: 16px;
}
.menu {
  display: flex;
  justify-content: center;
  background-color: white;
  padding: 10px 0;
  border-bottom: 1px solid #eee;
}
.menu a {
  text-decoration: none;
  color: black;
  font-size: 16px;
  margin: 0 15px;
}
.menu a:hover{
  cursor: pointer;
  color: #ff3366;
}

.store-list {
    width: 100%;
    display: flex;
    flex-wrap: wrap;                 /* This allows the stores to wrap to the next line if needed*/
    justify-content: space-between;  /*Distribute space evenly between stores */
    gap: 20px;                       /*   Adds space between items */
  
}

/* Each store block */
.store {
  position: relative;
  width: 48%;
  background-color: #f9f9f9;
  border: 1px solid #ddd;
  padding: 15px;
  box-sizing: border-box;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.store-list:only-child{
  width:100%;
  justify-content: center;
}

/* Flex properties for the store info */
.store-left {
    display: flex;
    flex-direction: row;
}
#store_list{
  width:100%;
}
.store-logo img {
    width: 90px;
    height: 90px;
    object-fit: cover;
    margin-right: 15px;
}

.store-info {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

.store .coupon {
    background-color: #ff5f5f;
    color: white;
    padding: 5px 10px;
    border-radius: 5px;
}
#menu_sort {
  float: right;
  margin-left: auto;
}

.form-control {
  width: 200px;
}
.delivery-time {
  color: gray;
  font-size: 12px;
}
.image-z1 {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover; /* 이미지 비율을 유지하며 div에 맞게 조정 */
    z-index: 1; /* z-index를 설정하여 이미지가 맨 위에 오도록 */
}
.text-over-image {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%); /* 중앙 정렬 */
  color: white; /* 글씨 색 */
  font-size: 24px; /* 글씨 크기 */
  font-weight: bold;
  z-index: 2; /* 이미지 위로 텍스트가 오도록 설정 */
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
      function selectOne(shop_id, shop_status){
        $.ajax({
          url     :     "/shop/select_one.do",
          data    :      {"shop_id": shop_id,
                          "shop_status": shop_status},
          success :   function(res_data){
                // alert("select_one.do 성공");
                $("#select_one_display").html(res_data).show();
                $("#insert_form_display").hide();
                $("#reviews_display").hide();
                $("#store-list").hide();
                $("#store_list_display").hide();
                $("#sort_display").hide();
                $('#select_list_category_display').hide();
                $('#menuButton').click();
                $('#menuButton').focus();

          },
          error   :   function(err){
            alert(error.responseText);
          }
        });
      }
    </script>
    <script>
      function optionChange(){
        let selectValue = document.getElementById("sortOption").value;
        let food_category = document.getElementById("food_category").value;
        let order_addr = document.getElementById("order_addr").value;
        let searchValue = document.getElementById("searchInput").value;
        // alert(food_category);
        // alert(order_addr);
        // alert(selectValue);
        $.ajax({
        url     :     "../shop/food_list.do",
        data  : {"selectValue": selectValue,
              "food_category": food_category,
              "order_addr": order_addr,
              "searchValue": searchValue},
        success :   function(res_data){
                    // alert("성공");
                    $("#store_list").hide();
                    $("#store_list_display").html("");        
                    $("#store_list_display").html(res_data);

        },
          error   :   function(err){
          alert(error.responseText)
        }
      });
    }
    </script>
</head>
<body>

  <!-- <%@ include file="../header.jsp" %>
  <%@ include file="../searchbar.jsp"%> -->
  <%@ include file="../navbar.jsp" %>
<main style="margin-top: 30px;">

  <div class="container">

    <div id="sort_display" style="align-items: end !important;">
      <div id="menu_sort" style="margin-bottom: 20px;">
        <select id="sortOption" class="form-control" onchange="optionChange()">
          <option value="rank" >기본 정렬순</option>
          <option value="shop_rating">별점순</option>
          <option value="reviews_count">리뷰 많은순</option>
          <option value="shop_min_price">최소 주문 금액순</option>
        </select>
      </div>
    </div>

    <div id="store_list">
      <div class="store-list mt-10" id="store-list" >
        <!-- 영업중인 가게  -->
        <c:forEach var="vo" items="${list}">
          <c:if test="${vo.shop_status =='영업중'}">
            <!-- ${vo.shop_status} -->
            <div class="store" onclick="selectOne('${vo.shop_id}', '${vo.shop_status}');">
              <div class="store-left">
                <div class="store-logo">
                  <div class="image-container">
                    <!-- 가게 로고 이미지 -->
                    <img class="image-z2" src="${pageContext.request.contextPath}/resources/images/${vo.shop_img}" alt="Store 1 Logo">
                    <!-- 이미지 위에 표시할 텍스트 -->
                    <div class="overlay-text"></div>
                  </div>
                </div>
                <div class="store-info">
                  <strong>${vo.shop_name}</strong>
                  <div>
                    <span class="rating">★ ${vo.shop_rating}</span> 
                    | 리뷰 ${vo.reviews_count} | 사장님 댓글 ${vo.ceoreview_count}
                  </div>
                  <div><fmt:formatNumber value="${vo.shop_min_price}" pattern="#,###"/>원 이상 배달</div>
                  <div class="delivery-time"></div>
                </div>
              </div>
            </div>
          </c:if>
        </c:forEach>
        <div>

        </div>
        <!-- 영업중이 아닌 가게 -->
        <c:forEach var="vo" items="${list}">
          <c:if test="${vo.shop_status == '영업전' || vo.shop_status=='휴무일'}">
            <!-- ${vo.shop_status} -->
            <div class="store" onclick="selectOne('${vo.shop_id}', '${vo.shop_status}');">
              <img class="image-z1" src="${pageContext.request.contextPath}/resources/images/back_black.png">
            <c:if test="${vo.shop_status == '영업전'}">
              <div class="text-over-image">가게 오픈 시간  ${fn:substring(vo.shop_open_hour, 0, 5)}</div>
            </c:if>
            <c:if test="${vo.shop_status == '휴무일'}">
              <div class="text-over-image">금일은 휴무일입니다.</div>
            </c:if>
              <div class="store-left">
                <div class="store-logo">
                  <div class="image-container">
                    <!-- 가게 로고 이미지 -->
                    <img class="image-z2" src="${pageContext.request.contextPath}/resources/images/${vo.shop_img}" alt="Store 1 Logo">
                    <!-- 이미지 위에 표시할 텍스트 -->
                    <div class="overlay-text">Closed</div>
                  </div>
                </div>
                <div class="store-info">
                  <strong>${vo.shop_name}</strong>
                  <div>
                    <span class="rating">★ ${vo.shop_rating}</span> 
                    | 리뷰 ${vo.reviews_count} | 사장님 댓글 ${vo.ceoreview_count}
                  </div>
                  <div><fmt:formatNumber value="${vo.shop_min_price}" pattern="#,###"/>원 이상 배달</div>
                  <div class="delivery-time"></div>
                </div>
              </div>
            </div>
          </c:if>
        </c:forEach>
      </div>
    </div>
  </div>

  <div>
    <!-- Add more stores similarly -->
  <div id="insert_form_display"></div>
  </div>
  <div>
    <div id="select_list_category_display"></div>
  </div>
  <div>
    <div id="select_one_display"></div>
  </div>

  <div id="store_list_display">
    <input type="hidden" id="order_addr" value="${order_addr}"/>
    <input type="hidden" id="food_category" value="${food_category}"/>
  </div>

 

</main>
</body>
</html>