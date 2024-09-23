<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    display: flex;
    flex-wrap: wrap;                 /* This allows the stores to wrap to the next line if needed*/
    justify-content: space-between;  /*Distribute space evenly between stores */
    gap: 20px;                       /*   Adds space between items */
  
}

/* Each store block */
.store {
  width: calc(50% - 10px); /* Each store takes 50% of the container's width, minus spacing */
  background-color: #f9f9f9;
  border: 1px solid #ddd;
  padding: 15px;
  box-sizing: border-box;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

/* Flex properties for the store info */
.store-left {
    display: flex;
    flex-direction: row;
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

/* .store-list {
  max-width: 1200px;
  margin: 20px auto;
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 20px;
}
.store {
  border: 1px solid #eee;
  padding: 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-radius: 5px;
}
.store-left {
  display: flex;
}
.store-logo {
  margin-right: 20px;
}
.store-logo img {
  width: 60px;
  height: 60px;
}
.store-info {
  font-size: 14px;
}
.store-info strong {
  font-size: 16px;
  display: block;
  margin-bottom: 5px;
}
.store-info .rating {
  color: orange;
  margin-right: 10px;
}
.coupon {
  background-color: #fff4f4;
  color: red;
  padding: 5px 10px;
  border-radius: 5px;
  font-size: 14px;
} */
.delivery-time {
  color: gray;
  font-size: 12px;
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
        alert(shop_id);
        $.ajax({
          url     :     "/shop/select_one.do",
          data    :      {"shop_id": shop_id},
          success :   function(res_data){
                alert("select_one.do 성공")
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
        alert(food_category);
        alert(order_addr);
        alert(selectValue);
        $.ajax({
        url     :     "../shop/food_list.do",
        data  : {"selectValue": selectValue,
              "food_category": food_category,
              "order_addr": order_addr,
              "searchValue": searchValue},
        success :   function(res_data){
                    alert("성공");
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
        <c:forEach var="vo" items="${list}">
          <div class="store" onclick="selectOne('${vo.shop_id}');">
              <div class="store-left">
                  <div class="store-logo">
                    <img src="${pageContext.request.contextPath }/resources/images/${vo.shop_img}" alt="Store 1 Logo">
                  </div>
                  <div class="store-info">
                      <strong>${vo.shop_name}</strong>
                      <div>
                          <span class="rating">★ ${vo.shop_rating}</span>
                          | 리뷰${vo.reviews_count} | 사장님댓글 ${vo.ceoreview_count}
                      </div>
                      <div>${vo.shop_min_price} 11,000원 이상 배달</div>
                      <div class="delivery-time">47~62분</div>
                  </div>
              </div>
          </div>
        </c:forEach>
      </div>
    </div>
  </div>
 
  <div id="store_list_display">
    <input type="hidden" id="order_addr" value="${order_addr}"/>
    <input type="hidden" id="food_category" value="${food_category}"/>
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

</main>
</body>
</html>
