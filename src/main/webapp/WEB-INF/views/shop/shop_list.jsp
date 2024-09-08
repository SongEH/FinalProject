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
body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
}
.container {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
      }
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
/* .menu {
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
  background-color: gray;
} */
/* .menu div {
    background-color: #f1f1f1;
    padding: 15px 25px;
    border-radius: 10px;
    margin: 0 10px;
    font-size: 16px;
    cursor: pointer;
    text-align: center;
    border: 1px solid #ddd;
    transition: background-color 0.3s, box-shadow 0.3s;
}

.menu div:hover {
    background-color: #ff3366;
    color: white;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
}

.menu div:active {
    background-color: #e62e5d;
} */
.navbar {
            display: flex;
            justify-content: center;
            background-color: #ff3366;
            padding: 10px 0;
        }

        /* Box style for navbar items */
        .navbar div {
            background-color: #fff;
            padding: 15px 25px;
            border-radius: 5px;
            margin: 0 10px;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
            transition: background-color 0.3s, box-shadow 0.3s;
            color: #333;
            border: 1px solid #ddd;
        }

        .navbar div:hover {
            background-color: #ff6699;
            color: white;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        .navbar div:active {
            background-color: #e62e5d;
        }

        .navbar div a {
            text-decoration: none;
            color: inherit;
        }
.store-list {
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
}
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
    <header>
      <div class="logo">오기요</div>
      <a href="#" class="login">로그인</a>
  </header>
  
  <div class="search-bar">
      <input type="text" placeholder="서울특별시 관악구 봉천동 1601-6 족발이세계...">
      <button>검색</button>
  </div>

  <nav class="container-fulid">
    <!-- <div class="menu">
        <a href="#">전체보기</a>
        <a href="#">1인분 주문</a>
        <a href="#">프랜차이즈</a>
        <a href="#">치킨</a>
        <a href="#">피자/양식</a>
        <a href="#">중국집</a>
        <a href="#">한식</a>
        <a href="#">일식/돈까스</a>
        <a href="#">족발/보쌈</a>
        <a href="#">야식</a>
    </div> -->
    
  </nav>

  <div class="container">
  <div class="store-list">
      <div class="store">
          <div class="store-left">
              <div class="store-logo">
                  <img src="store1-logo.png" alt="Store 1 Logo">
              </div>
              <div class="store-info">
                  <strong>고돼지-관악본점</strong>
                  <div>
                      <span class="rating">★ 4.8</span>
                      리뷰 4142 · 사장님댓글 1352
                  </div>
                  <div>11,000원 이상 배달</div>
                  <div class="delivery-time">47~62분</div>
              </div>
          </div>
          <div class="coupon">2,000원 할인</div>
      </div>
  
      <div class="store">
          <div class="store-left">
              <div class="store-logo">
                  <img src="store2-logo.png" alt="Store 2 Logo">
              </div>
              <div class="store-info">
                  <strong>청년피자-사당방배점</strong>
                  <div>
                      <span class="rating">★ 4.9</span>
                      리뷰 7562 · 사장님댓글 706
                  </div>
                  <div>17,900원 이상 배달</div>
                  <div class="delivery-time">37~52분</div>
              </div>
          </div>
          <div class="coupon">4,000원 할인</div>
      </div>
  
      <div class="store">
          <div class="store-left">
              <div class="store-logo">
                  <img src="store3-logo.png" alt="Store 3 Logo">
              </div>
              <div class="store-info">
                  <strong>또래오래-봉천2호점</strong>
                  <div>
                      <span class="rating">★ 4.7</span>
                      리뷰 4543 · 사장님댓글 305
                  </div>
                  <div>19,000원 이상 배달</div>
                  <div class="delivery-time">52~67분</div>
              </div>
          </div>
          <div class="coupon">4,000원 할인</div>
      </div>
  
      <div class="store">
          <div class="store-left">
              <div class="store-logo">
                  <img src="store4-logo.png" alt="Store 4 Logo">
              </div>
              <div class="store-info">
                  <strong>치킨플러스-서울대역점</strong>
                  <div>
                      <span class="rating">★ 4.6</span>
                      리뷰 162 · 사장님댓글 26
                  </div>
                  <div>15,900원 이상 배달</div>
                  <div class="delivery-time">38~53분</div>
              </div>
          </div>
          <div class="coupon">3,000원 할인</div>
      </div>
    </div>
  </div>
      <!-- Add more stores similarly -->
<!--   
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
  <div> -->
    <div id="insert_form_display"></div>
  </div>
  <div>
    <div id="select_one_display"></div>
  </div>

</head>
<body>

</body>
</html>
