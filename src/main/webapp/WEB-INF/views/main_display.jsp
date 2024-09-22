<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<link
  href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
  rel="stylesheet"
/>
<script src="https://cdn.jsdelivr.net/npm/alpinejs@2.8.2" defer></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>

    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f7f7f7;
      }
      /* .search-bar {
        display: flex;
        justify-content: center;
        margin: 20px 0;
      }
      .search-bar input {
        width: 300px;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
      }
      .search-bar button {
        background-color: #ff3366;
        color: white;
        border: none;
        padding: 10px 20px;
        margin-left: 10px;
        border-radius: 5px;
        cursor: pointer;
      } */
      .container {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
      }
      .card {
        background-color: white;
        margin: 10px;
        border-radius: 10px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        text-align: center;
        width: 200px;
        height: 200px;
        float: left;
      }

      .card img {
        width: 50%;
        padding-top: 10px;
        border-top-left-radius: 20px;
        border-top-right-radius: 20px;
        margin: auto;
      }

      .card p {
        padding: 10px;
        font-size: 16px;
      }
      .card:hover {
        cursor: pointer;
      }

      .footer {
        text-align: center;
        margin: 20px 0;
      }
    </style>
    <script>
    function shopListAll(element){
      var food_category = element.getAttribute('food_category');
      alert(food_category);
      let order_addr = $("#order_addr").val().trim();
      alert(order_addr);
      if(order_addr==null || order_addr==""){
        alert("주소를 입력하시거나 로그인 후 이용할 수 있습니다.")
        return;
      }

      $.ajax({
        url  : "../shop/list.do",
        data : {
              "food_category": food_category,
              "order_addr": order_addr
              },
      success :   function(res_data){
              alert("성공");
              $("#shop_list_display").html(res_data).show();
              $("#main_display").hide();
              $(".nav-link").removeClass("active");
              $("#" + food_category).addClass("active");
      },
      error   :   function(err){
      alert(error.responseText)
      }
      });
      }
    </script>

    <script>
      // findAddr() 함수 정의
      function findAddr() {
        new daum.Postcode({
              oncomplete: function(data) {
                  // 사용자 주소를 받아올 변수를 정의한다.
                    // let addr = '';
                    
                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우(R)
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }
                    
                    // 부모창의 주소칸에 받아온 주소를 넣는다.
                    $("#order_addr").val(addr);
              }
          }).open();
      }

</script>
</head>
<body>
  <%@ include file="header.jsp" %>
  <%@ include file="searchbar.jsp" %>
  <div id="main_display">
  <form id="myForm" method="POST">
    <div class="container">
      <div class="row">
        <div class="col-xxl-3 col-md-4 card" food_category="all" onclick="shopListAll(this)">
          <img src="/resources/images/전체보기.png" alt="전체보기" />
          <p>전체보기</p>
        </div>
        <div class="col-xxl-3 col-md-4 card" food_category="pork_trotters" onclick="shopListAll(this)">
          <img src="/resources/images/보쌈.png" alt="족발·보쌈" />
          <p>족발·보쌈</p>
        </div>
        <div class="col-xxl-3 col-md-4 card" food_category="pizza" onclick="shopListAll(this)">
          <img src="/resources/images/피자.png" alt="피자" />
          <p>피자</p>
        </div>
        <div class="col-xxl-3 col-md-4 card" food_category="chicken" onclick="shopListAll(this)">
          <img src="/resources/images/치킨.png" alt="치킨" />
          <p>치킨</p>
        </div>
      
        <div class="col-xxl-3 col-md-4 card" food_category="japanese_food" onclick="shopListAll(this)">
          <img src="/resources/images/일식.png" alt="돈까스·회·일식" />
          <p>돈까스·회·일식</p>
        </div>
        <div class="col-xxl-3 col-md-4 card" food_category="korea_food" onclick="shopListAll(this)">
          <img src="/resources/images/한식.png" alt="한식" />
          <p>한식</p>
        </div>
        <div class="col-xxl-3 col-md-4 card" food_category="chinese_food" onclick="shopListAll(this)">
          <img src="/resources/images/중식.png" alt="중식" />
          <p>중식</p>
        </div>
        <div class="col-xxl-3 col-md-4 card" food_category="asian_food" onclick="shopListAll(this)">
          <img src="/resources/images/아시안.png" alt="아시안" />
          <p>아시안</p>
        </div>
        <div class="col-xxl-3 col-md-4 card" food_category="porridge_noodle" onclick="shopListAll(this)">
          <img src="/resources/images/백반.png" alt="백반·죽·국수" />
          <p>백반·죽·국수</p>
        </div>
        <div class="col-xxl-3 col-md-4 card" food_category="snack_food" onclick="shopListAll(this)">
          <img src="/resources/images/분식.png" alt="분식" />
          <p>분식</p>
        </div>
        <div class="col-xxl-3 col-md-4 card" food_category="desserts" onclick="shopListAll(this)">
          <img src="/resources/images/디저트.png" alt="카페/디저트" />
          <p>카페·디저트</p>
        </div>
        <div class="col-xxl-3 col-md-4 card" food_category="fast_food" onclick="shopListAll(this)">
          <img src="/resources/images/패스트푸드.png" alt="패스트푸드" />
          <p>패스트푸드</p>
        </div>
      </div>
    </div>
  </form>
</div>
  <div>
    <div id="shop_list_display"></div>
  </div>
  <div style="margin-top: 50px;">
    <%@ include file="footer.jsp" %>
  </div>
</body>
</html>
