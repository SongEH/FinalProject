<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>


    <style>
      .container {
        margin-top: 10%;
      }
    </style>

    <!-- <script>
      function send(f) {
        alert("도착 ");

        let shop_name = f.shop_name.value;
        let shop_addr = f.shop_addr.value;
        let shop_phone= f.shop_call.value;
        let shop_content = f.shop_content.value;
        let food_category = f.food_category.value;
        let shop_min_price = f.shop_min_price.value;
        let shop_delivery_time = f.shop_delivery_time.value;
        let shop_open_time = f.shop_open_time.value;
        let shop_close_time = f.shop_close_time.value;
        let shop_close_day = f.shop_close_day.value;
        let shop_area = f.shop_area.value;
        let shop_status = f.shop_status.value;
        alert(shop_status)

        f.action = "insert.do";
        f.submit();
      }
    </script> -->
  </head>
  <body>

    <head> </head>
    <nav></nav>
    <main>
        <form method="post" action="insert.do" enctype="multipart/form-data">
          <section class="section">
            <div class="row">
              <div class="col-lg-10">
                <div class="card">
                  <div class="card-body">
                    <h5 class="card-title">Floating labels Form</h5>

                    <!-- Floating Labels Form -->
                    <form class="row g-3" method="POST" enctype="multipart/form-data">
                      <div class="col-md-12">
                        <div class="form-floating">
                          <input type="text" class="form-control" placeholder="상호명" name="shop_name">
                          <label>상호명</label>
                        </div>
                      </div>

                      <div class="col-md-12">
                        <div class="form-floating">
                          <textarea class="form-control" placeholder="소개글" name="shop_content"
                            tyle="height: 100px;"></textarea>
                          <label>가게소개글 </label>
                        </div>
                      </div>

                      <div class="col-md-12">
                        <div class="form-floating">
                          <input type="text" class="form-control" placeholder="가게주소" name="shop_addr">
                          <label>가게주소</label>
                        </div>
                      </div>

                      <div class="col-md-12">
                        <div class="form-floating">
                          <input type="text" class="form-control" placeholder="가게 전화번호" name="shop_call">
                          <label>가게전화번호</label>
                        </div>
                      </div>

                      <div class="col-md-12">
                        <div class="form-floating">
                          <input type="text" class="form-control" placeholder="최소주문금액" name="shop_min_price">
                          <label>최소주문금액</label>
                        </div>
                      </div>

                      <div class="col-md-12">
                        <div class="form-floating">
                          <input type="text" class="form-control" placeholder="영업시작시간" name="shop_open_time">
                          <label>영업시작시간</label>
                        </div>
                      </div>

                      <div class="col-md-12">
                        <div class="form-floating">
                          <input type="text" class="form-control" placeholder="영업마감시간" name="shop_close_time">
                          <label>영업마감시간</label>
                        </div>
                      </div>

                      <div class="col-md-12">
                        <div class="form-floating">
                          <input type="text" class="form-control" placeholder="휴무일" name="shop_close_day">
                          <label>휴무일</label>
                        </div>
                      </div>

                      <div class="col-md-12">
                        <div class="form-floating">
                          <input type="text" class="form-control" placeholder="배달지역" name="shop_area">
                          <label>배달지역</label>
                        </div>
                      </div>

                      <div class="col-md-12">
                        <div class="form-floating">
                          <select class="form-control" placeholder="음식카테고리" name="food_category">
                            <option class="form-control" value="pork_trotters">족발·보쌈</option>
                            <option class="form-control" value="pizza">피자</option>
                            <option class="form-control" value="chicken">치킨</option>
                            <option class="form-control" value="japanese_food">돈까스·회·일식</option>
                            <option class="form-control" value="korea_food">한식</option>
                            <option value="chinese_food">중식</option>
                            <option value="asian_food">아시안</option>
                            <option value="porridge_noodle">백반·죽·국수</option>
                            <option value="snack_food">분식</option>
                            <option value="desserts">카페·디저트</option>
                            <option value="fast_food">패스트푸드</option>
                          </select>
                        </div>
                      </div>

                      <div class="col-md-12">
                        <div class="form-floating form-control">
                          <input type="radio" name="shop_status" value="영업전" checked="checked">영업전</input>
                          <input type="radio" name="shop_status" value="영업중">영업중</input>
                          <input type="radio" name="shop_status" value="휴무일">휴무일</input>
                        </div>
                      </div>

                      <div class="col-md-12">
                        <div class="form-floating">
                          <input class="form-control" type="file" name="photo">
                          <label>사진</label>
                        </div>
                      </div>

                      <div class="text-center">
                        <!-- <button type="submit" class="btn btn-primary">Submit</button>
                      <button type="reset" class="btn btn-secondary">Reset</button> -->
                        <input class="btn btn-success" type="button" value="메인화면" onclick="location.href='list.do'">

                        <input class="btn btn-primary" type="button"  value="가게등록" onclick="send(this.form);">
                      </div>
                    </form><!-- End floating Labels Form -->

                  </div>
                </div>
              </div>
            </div>
          </section>
        </form>
    </main>
  </body>
</html>
