<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <style>
      .container{
        margin:auto;
        justify-content: center;
        padding: 0px;
        width: 100%; 
      }
      .row{
        margin: 0;
      }
      
      .store-info h1 {
          font-size: 20px;
          margin-bottom: 10px;
      }
      .store-info img{
        width: 60px;
        height: 60px;
        padding-left: 10px;
      }
      .store-info .rating {
        width: 100%;
          display: flex;
          align-items: center;
      }
      .store-info .rating span {
          font-size: 16px;
          margin-left: 5px;
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
      .menu-section {
          width: 100%;
          margin-top: 20px;
          padding-top: 10px;
      }
      .menu-section .menu-title {
          font-size: 18px;
          margin-bottom: 5px;
      }
      .right-panel h2 {
          font-size: 20px;
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
  <form method="post">
  <!-- 표현은 하지않고 활용하기 위한 데이터  -->
   <input type="hidden" name="shop_id" value="${shop_vo.shop_id}"/>
   

   <div class="container my-2">
    <div class="row">
        <!-- Left Panel (Store Information) -->
        <div class="col-lg-8 col-md-8 col-sm-12">
            <div class="store-info  p-3 ">
                <div id="shop_name">${shop_vo.shop_name}</div>
                
                <div class="rating" id="shop_info">
                    <img src="${pageContext.request.contextPath }/resources/images/${shop_vo.shop_img}" alt="Rating Star" width="20"> 
                    <span>${shop_vo.shop_stemp_count}
                      <div class="details">
                        <div><strong>21,000원 이상 주문 시 4,000원 할인</strong></div>
                        <div>최소 주문 금액: <strong>${shop_vo.shop_min_price}</strong></div>
                        <div>결제: <strong>신용카드, 현금, 요기서결제</strong></div>
                        <button class="btn btn-danger">4,000원 할인</button>
                      </div>
                    </span>
                </div>
                <div id="shop_content">${shop_vo.shop_content}</div>
            </div>
        </div>
        <div class="col-lg-4 col-md-4 ">
          <div class="right-panel text-center p-3">
            <div style="background-color:black; color:white; padding: 7px;">
              <h2>주문표</h2>
            </div>
              <div style="border:1px solid gray; height:auto; min-height: 155px;">
                <div>주문표에 담긴 메뉴가 없습니다.</div>
              <div style="border:1px solid gray; height:45px;">배달요금 <strong>2,000원</strong> 별도</div>
              <button class="btn btn-secondary" disabled>주문하기</button>
            </div>
        </div>
        <div class="row border mt-10" style="width:66%;">
          <div class="col-lg-4 col-md-4">
            <div class="menu-tab border">
                <input type="button" value="메뉴"><span class="badge bg-secondary">83</span>
            </div>
        </div>
        <div class="col-lg-4 col-md-4">
            <div class="menu-tab border">
                <input type="button" value="클린리뷰"/><span class="badge bg-secondary">10039</span>
            </div>
        </div>
        <div class="col-lg-4 col-md-4">
            <div class="menu-tab border">
                <input type="button" value="정보"/>
            </div>
        </div>
        </div>
    </div>
  </div>

  <!-- Sample Menu List -->
  <div class="container mt-3">
      <div class="row">
              <div class="menu-item">
                  <img src="image_url" alt="menu_image" class="img-fluid">
                  <p>(New)맵단짠 칩</p>
                  <p><strong>19,900원</strong></p>
              </div>
          <!-- Add more menu items in a similar fashion -->
      </div>
  </div>
    <div>
      <div id="menu_list"></div>
    </div>
  </div>
  </body>
</html>
