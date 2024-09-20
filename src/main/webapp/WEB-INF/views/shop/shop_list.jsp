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
  flex-wrap: wrap;
  justify-content: center;
  box-sizing: border-box;
}
/* .container::after{
  content:"";
  display:block;
  clear:both;
} */
header {
  background-color: #ff3366;
  color: white;
  padding: 15px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
header .logo {
  font-size: 24px;
  font-weight: bold;
}
header .login {
  background-color: orange;
  padding: 8px 15px;
  border-radius: 5px;
  color: white;
  text-decoration: none;
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
                $("#select_one_display").html(res_data);
                $("#insert_form_display").hide();
                // $("#reviews_display").hide();
                $("#store-list").hide();
                // $('#menu_display').hide();
                $('#menuButton').click();
                $('#menuButton').focus();
          },
          error   :   function(err){
            alert(error.responseText);
          }
        });
      }
    </script>
</head>
<body>
    <header>
      <div class="logo">오기요</div>
      <a href="#" class="login">로그인</a>
    </header>
  
  <nav class="navbar navbar-expand-lg navbar-light bg-light mb-10" id="nav">
    <div class="container">
     <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon">?</span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="list.do?food_category=all">전체보기</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="list.do?food_category=pork_trotters">족발·보쌈</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="list.do?food_category=pizza">피자</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="list.do?food_category=chicken">치킨</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="list.do?food_category=japanese_food">돈까스·회·일식</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="list.do?food_category=korea_food">한식</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="list.do?food_category=chinese_food">중식</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="list.do?food_category=asian_food">아시안</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="list.do?food_category=porridge_noodle">백반·죽·국수</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="list.do?food_category=snack_food">분식</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="list.do?food_category=desserts">카페·디저트</a> 
          </li>
          <li class="nav-item"></li>
            <a class="nav-link" href="list.do?food_category=fast_food">패스트푸드</a>
          </li>
        </ul>
        <form class="d-flex">
          <input class="form-control" type="search" placeholder="Search" aria-label="Search">
          <button class="btn btn-outline-success" type="submit">Search</button>
        </form>
      </div>
    </div>
  </nav>

<main style="margin-top: 30px;">
  <div class="container">
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
            <!-- <div class="coupon">2,000원 할인</div> -->
        </div>
      </c:forEach>
    </div>
  </div>
      <!-- Add more stores similarly -->
    <div id="insert_form_display"></div>
  </div>
  <div>
    <div id="select_one_display"></div>
  </div>
<div style="margin-top: 50px;">
  <%@ include file="../footer.jsp" %>
</div>
</main>
</body>
</html>
