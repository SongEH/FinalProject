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
      .container{
        margin: auto;
      }
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
      function shop_modi(f){

        alert("여기?");
        alert(f.shop_id.value);
        f.action="modify_form.do";
        f.submit();
      }

    </script>
  </head>
  <body>
  <div class="container">
  <form method="post">
  <!-- 표현은 하지않고 활용하기 위한 데이터  -->
   <input type="hidden" name="shop_id" value="${shop_vo.shop_id}"/>
   
    <div class="restaurant-info">
        <div class="row">
          <div class="col-md-8 mb-30">
            <div class="shop_name">
              <h5><b>${shop_vo.shop_name}</b>(${shop_vo.shop_review_count})</h5>
            </div>
            <diV class="shop_info">
                <img  src="../resources/images/${shop_vo.shop_img}" alt="Shop Image" style="height: 100px" width="100px" />
                <div class="shop_text">
                  <p>${shop_vo.shop_rate}</p>
                  <p>최소주문금액 ${shop_vo.shop_min_price} </p> 
                  <p>결제 신용카드, 현금, 요기서결제</p> 
                </div>
            </diV>
            <div>${shop_vo.shop_content}</div>     
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
      </div>
      <section class="section">
        <div class="row align-items-top">
            <div class="col-lg-6">
                <c:forEach var="vo" items="${menu_list}">
                    <!-- vo.menu_status가 1인 경우만 표시 -->
                    <c:if test="${vo.menu_status == 1}">
                        <!-- Card with an image on left -->
                        <div class="card mb-3">
                            <div class="row g-0" lass="photo"
                                onclick="show_menu('${vo.menu_id}');">
                                <div class="col-md-4">
                                    <img src="../resources/images/${vo.menu_img}"
                                        class="img-fluid rounded-start" alt="...">
                                </div>
                                <div class="col-md-8">
                                    <div class="card-body">
                                        <h5 class="card-title">
                                            <div style="color:red;">
                                                <c:choose>
                                                    <c:when
                                                        test="${vo.menu_popularity == 1}">
                                                        인기
                                                    </c:when>
                                                    <c:when test="${vo.menu_hidden == 1}">
                                                        숨김
                                                    </c:when>
                                                    <c:when test="${vo.menu_soldout == 1}">
                                                        품절
                                                    </c:when>
                                                    <c:otherwise>
                                                        <!-- 아무 조건에도 해당하지 않으면 빈 문자열 -->
                                                    </c:otherwise>

                                                </c:choose>
                                            </div>
                                            메뉴명 (${vo.menu_id})
                                            ${vo.menu_name}
                                        </h5>
                                        <p class="card-text">설명 ${vo.menu_content}</p>
                                        <p class="card-text">가격 ${vo.menu_price}</p>
                                        <input class="btn btn-info" type="button"
                                            id="btn_popup_update" value="상세보기"
                                            onclick="show_menu('${vo.menu_id}');">
                                        <input class="btn btn-info" type="button"
                                            id="btn_popup_update" value="수정"
                                            onclick="modify_menu('${vo.menu_id}');">
                                        <input class="btn btn-danger" type="button"
                                            id="btn_popup_delete" value="삭제"
                                            onclick="delete_menu('${vo.menu_id}');">
                                    </div>
                                </div>
                                <div id="pop_job" style="text-align: center;">

                                </div>
                            </div><!-- End Card with an image on left -->
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </section>

    <div>

    </div>

      
      <div>
        <input type="button" value="수정하기" onclick="shop_modi(this.form)"/>
        <!-- <input type="button" value="수정하기" onclick="location.href='modify_form.do?shop_id=${shop_vo.shop_id}'"/> -->
        <input type="button" value="삭제하기" onclick="shop_del('${shop_vo.shop_id}')"/>
      </div>
    </form>
  </main>
    <div>
      <div id="menu_list"></div>
    </div>
  </div>
  </body>
</html>