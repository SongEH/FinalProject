<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link
  href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
  rel="stylesheet"
/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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

      .header {
        background-color: #f0a8d0;
        color: black;
        padding: 20px;
        text-align: center;
      }

      .header h1 {
        margin: 0;
      }

      .search-bar {
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
      }

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
      }

      .card img {
        width: 80%;
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
  </head>
  <body>
    <div class="header">
      <h1>요기요</h1>
      <h2>"어디로 배달해 드릴까요?"</h2>
    </div>

    <div class="search-bar">
      <input type="text" placeholder="서울특별시 관악구 봉천동 1690-41 골든" />
      <button>검색</button>
    </div>

    <div class="container">
      <div class="row">
        <div class="col-md-3 card" onclick="location.href='/shop/list.do'">
          <img src="/resources/images/전체보기.png" alt="전체보기" />
          <p>전체보기</p>
        </div>
        <div
          class="col-md-3 card"
          onclick="location.href='/shop/list.do?food_category=pork_trotters'"
        >
          <img src="/resources/images/보쌈.png" alt="족발·보쌈" />
          <p>족발·보쌈</p>
        </div>
        <div
          class="col-md-3 card"
          onclick="location.href='/shop/list.do?food_category=pizza'"
        >
          <img src="/resources/images/피자.png" alt="피자" />
          <p>피자</p>
        </div>
        <div
          class="col-md-3 card"
          onclick="location.href='/shop/list.do?food_category=chicken'"
        >
          <img src="/resources/images/치킨.png" alt="치킨" />
          <p>치킨</p>
        </div>
      </div>
      <div class="row">
        <div
          class="col-md-3 card"
          onclick="location.href='/shop/list.do?food_category=japanese_food'"
        >
          <img src="/resources/images/일식.png" alt="돈까스·회·일식" />
          <p>돈까스·회·일식</p>
        </div>
        <div
          class="col-md-3 card"
          onclick="location.href='/shop/list.do?food_category=korea_food'"
        >
          <img src="/resources/images/한식.png" alt="한식" />
          <p>한식</p>
        </div>
        <div
          class="col-md-3 card"
          onclick="location.href='/shop/list.do?food_category=chinese_food'"
        >
          <img src="/resources/images/중식.png" alt="중식" />
          <p>중식</p>
        </div>
        <div
          class="col-md-3 card"
          onclick="location.href='/shop/list.do?food_category=asian_food'"
        >
          <img src="/resources/images/아시안.png" alt="아시안" />
          <p>아시안</p>
        </div>
      </div>
      <div class="row">
        <div
          class="col-md-3 card"
          onclick="location.href='/shop/list.do?food_category=porridge_noodle'"
        >
          <img src="/resources/images/백반.png" alt="백반·죽·국수" />
          <p>백반·죽·국수</p>
        </div>
        <div
          class="col-md-3 card"
          onclick="location.href='/shop/list.do?food_category=snack_food'"
        >
          <img src="/resources/images/분식.png" alt="분식" />
          <p>분식</p>
        </div>
        <div
          class="col-md-3 card"
          onclick="location.href='/shop/list.do?food_category=desserts'"
        >
          <img src="/resources/images/디저트.png" alt="카페/디저트" />
          <p>카페·디저트</p>
        </div>
        <div
          class="col-md-3 card"
          onclick="location.href='/shop/list.do?food_category=fast_foods'"
        >
          <img src="/resources/images/패스트푸드.png" alt="패스트푸드" />
          <p>패스트푸드</p>
        </div>
      </div>
    </div>

    <div class="footer">
      <p>© 2024 Food Delivery Service</p>
    </div>
  </body>
</html>
