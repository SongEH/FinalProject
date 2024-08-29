<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>

    <style>
      /* *{
        border : 1px  solid rgb(126, 125, 125);
      } */
      .restaurant-info img{
        width: 100px;
        height: 100px;
        margin-bottom: 30px;
      }
      .shop_info{
        display: flex;
        align-items: center;
      }
      .shop_info img{
        margin-right: 10px;
      }
      .shop_text{
        display: flex;
        flex-direction: column;
      }
      .main-content{
        margin-top: 30px;
      }
      .menu-nav{
      display: flex;
      justify-content: space-between; /* Space out menus evenly */
      padding: 2px;
      }
      .menu-tab {
      flex: 0 1 30%; /* Ensures each menu takes up equal space */
      text-align: center; /* Centers text inside the menu */
      padding: 10px;
      border: 1px solid #ccc; /* Optional: Adds a border around each menu */
      margin: 0 10px; /* Optional: Adds margin between the menus */
      }
      .menu-tab:hover{
      background-color: rgb(196, 196, 196);
      }
    </style>

    <script>

      function shop_del(shop_id){
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

  </head>
</form method="post">
  <!-- 표현은 하지않고 활용하기 위한 데이터  -->
   <input type="hidden" name="shop_id" value="${vo.shop_id}"/>
   <body class="container">
    <div class="restaurant-info">
        <div class="row">
          <div class="col-md-8 mb-30">
            <div class="shop_name">
              <h5><b>${vo.shop_name}</b>(${vo.shop_review_count})</h5>
            </div>
            <diV class="shop_info">
                <img  src="../resources/images/${vo.shop_img}" alt="Shop Image" style="height: 100px" width="100px" />
                <div class="shop_text">
                  <p>${vo.shop_rate}</p>
                  <p>최소주문금액 ${vo.shop_min_price} </p> 
                  <p>결제 신용카드, 현금, 요기서결제</p> 
                </div>
            </diV>
            <div>${vo.shop_content}</div>     
          </div>
          <div class="col-md-4">
            <aside class="order-summary">
              <h2>주문표</h2>
              <p>주문표에 담긴 메뉴가 없습니다.</p>
              <p>배달요금 2,500원 별도</p>
              <button class="order-button" disabled>주문하기</button>
          </aside>
          </div>
        </div>
    </div>
    

  <main class="main-content col-md-8">
      <div class="menu-section">
          <nav class="menu-nav">
              <button class="menu-tab" onclick="">메뉴</button>
              <button class="menu-tab" onclick="">클린리뷰</button>
              <button class="menu-tab" onclick="">정보</button>
          </nav>

          <div class="menu-items">
              <!-- Individual Menu Items -->
              <div class="menu-item">
                  <img src="burger-image.jpg" alt="Burger">
                  <p class="menu-item-name">콰트로치즈 비프라구 버거</p>
                  <p class="menu-item-price">9,900원</p>
              </div>
              <!-- Add more menu items similarly -->
          </div>

          <section class="popular-menu">
              <h2>인기메뉴</h2>
              <div class="popular-menu-item">
                  <p class="menu-item-name">콰트로치즈 비프라구 와퍼 세트</p>
                  <p class="menu-item-price">12,400원</p>
              </div>
              <!-- Add more popular menu items similarly -->
          </section>
      </div>

      
      <div>
        <input type="button" value="수정하기" onclick=""/>
        <input type="button" value="삭제하기" onclick="shop_del('${vo.shop_id}')"/>
      </div>
      <form>
  </main>
  </body>
</html>
