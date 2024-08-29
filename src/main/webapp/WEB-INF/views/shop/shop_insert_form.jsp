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
      <div class="container">
        <form method="post" action="insert.do" enctype="multipart/form-data">
          <table class="table">
            <tr>
              <th>가게사진</th>
              <td><input name="photo" type="file" /></td>
            </tr>
            <tr>
              <th>가게이름</th>
              <td><input name="shop_name" type="text" /></td>
            </tr>
            <tr>
              <th>가게주소</th>
              <td><input name="shop_addr" type="text" /></td>
            </tr>
            <tr>
              <th>가게전화번호</th>
              <td><input name="shop_call" type="text" /></td>
            </tr>
            <tr>
              <th>가게소개글</th>
              <td><input name="shop_content" type="text" /></td>
            </tr>
            <tr>
              <th>음식카테고리</th>
              <td>
                <select name="food_category">
                  <option value="pork_trotters">족발 보쌈</option>
                  <option value="Steam_food">찜 탕 찌개</option>
                  <option value="japanese_food">돈까스 회 일식</option>
                  <option value="pizza">피자</option>
                  <option value="meat">고기 구이</option>
                  <option value="west_food">양식</option>
                  <option value="chicken">치킨</option>
                  <option value="chinese_food">중식</option>
                  <option value="asian_food">아시안</option>
                  <option value="porridge_noodle">백반 죽 국수</option>
                  <option value="lunch_box">도시락</option>
                  <option value="snack_food">분식</option>
                  <option value="desserts">디저트</option>
                  <option value="fast_food">패스트푸드</option>
                </select>
              </td>
            </tr>
            <tr>
              <th>최소주문금액</th>
              <td><input name="shop_min_price" type="text" /></td>
            </tr>
            <tr>
              <th>배달예상시간</th>
              <td><input name="shop_delivery_time" type="text" /></td>
            </tr>
            <tr>
              <th>영업시작시간</th>
              <td><input name="shop_open_time" type="text" /></td>
            </tr>
            <tr>
              <th>영업마감시간</th>
              <td><input name="shop_close_time" type="text" /></td>
            </tr>
            <tr>
              <th>휴무일</th>
              <td><input name="shop_close_day" type="text" /></td>
            </tr>
            <tr>
              <th>배달지역</th>
              <td><input name="shop_area" type="text" /></td>
            </tr>
            <tr>
              <th>상태</th>
              <td>
                <input type="radio" name="shop_status" value="영업전" checked="checked">영업전</input>
                <input type="radio" name="shop_status" value="영업중">영업중</input>
                <input type="radio" name="shop_status" value="휴무일">휴무일</input>
              </td>
            </tr>
          </table>
          <input type="submit" value="가게 등록" />
        </form>
      </div>
    </main>
  </body>
</html>
