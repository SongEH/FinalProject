<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="utf-8">
  <script type="text/javascript">
    function send(f) {

      //입력값 검증
      let menu_name = f.menu_name.value.trim();
      let menu_content = f.menu_content.value.trim();
      let menu_category = f.menu_category.value.trim();
      let menu_price = f.menu_price.value.trim();
      let photo = f.photo.value;

      if (menu_name == '') {
        alert("메뉴명을 입력하세요!");
        f.menu_name.value = ""; //지우기
        f.menu_name.focus();
        return;
      }

      if (menu_content == '') {
        alert("메뉴설명을 입력하세요!");
        f.menu_content.value = ""; //지우기
        f.menu_content.focus();
        return;
      }

      if (menu_category == '') {
        alert("카테고리를 입력하세요!");
        f.menu_category.value = ""; //지우기
        f.menu_category.focus();
        return;
      }
      if (menu_price == '') {
        alert("가격을 입력하세요!");
        f.menu_price.value = ""; //지우기
        f.menu_price.focus();
        return;
      }

      if (photo == '') {
        alert("사진을 선택하세요!");
        return;
      }


      //f.method = "POST";
      f.action = "insert.do"; //전송대상(PhotoInsertAction)
      f.submit(); //전송
    }
  </script>
</head>

<body>
  <%@include file="../common.jsp" %>

  <!-- header import -->
  <%@include file="../header.jsp" %>

  <!-- side bar import -->
  <%@include file="../sidebar.jsp" %>


  <main id="main" class="main">
    <div class="pagetitle">

      <h1>주문하기</h1>

      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">Home</a></li>
          <li class="breadcrumb-item">Forms</li>
          <li class="breadcrumb-item active">Layouts</li>
        </ol>
      </nav>

    </div><!-- End Page Title -->



    <section class="section">
      <div class="row align-items-top">
        <div class="col-lg-10">
          <div class="card">
            <div class="card-body">

              <!-- Card with an image on left -->
              <!-- 장바구니 항목 테이블 -->
              <table class="table table-bordered">
                <thead>
                  <tr>
                    <th>이미지</th>
                    <th>메뉴명</th>
                    <th>메뉴개수</th>
                    <th>메뉴가격</th>
                    <th>총 가격</th>
                    <th></th>
                  </tr>
                </thead>


                <tbody id="cartItems">
                  <!-- 현재 상점 ID를 저장할 변수 초기화 -->
                  <c:set var="currentShopId" value="" />

                  <!-- 항목 리스트를 반복 처리 -->
                  <c:forEach var="vo" items="${list}">
                    <!-- 상점 ID가 변경되었는지 확인 -->
                    <c:if test="${currentShopId != vo.shop_id}">
                      <!-- 새로운 상점 ID가 발견되면 현재 상점 ID를 업데이트 -->
                      <c:set var="currentShopId" value="${vo.shop_id}" />

                      <!-- 상점 ID를 헤더로 표시 (여기서는 상점 ID를 사용하고 있습니다) -->
                      <tr>
                        <th colspan="7" style="background-color: #f8f9fa; text-align: left; padding: 10px;">
                          가게명 : ${vo.shop_name}

                        </th>
                      </tr>
                    </c:if>

                    <!-- 상점 항목 정보를 출력 -->
                    <tr>
                      <td class="cart_menuimg">
                        <div>
                          <img src="../resources/images/${vo.menu_img}" class="img-fluid rounded" alt="..."
                            width="150px">
                        </div>
                      </td>
                      <td class="cart_menuname">${vo.menu_name}</td>

                      <td class="cart_quantity">
                        <input type="number" class="form-control quantity-input" id="quantity_${vo.carts_id}"
                          value="${vo.carts_quantity}" min="1" max="50" disabled>
                      </td>

                      <td class="cart_price">${vo.menu_price}</td>
                      <td class="cart_total_price">
                        ${vo.menu_price * vo.carts_quantity}
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>



                <tfoot>
                  <tr>
                    <td colspan="3" class="text-right"><strong>총 개수:</strong></td>
                    <td id="total_quantity">0</td>
                    <td colspan="2" class="text-right"><strong>총 가격:</strong></td>
                    <td id="total_price">0</td>
                  </tr>
                </tfoot>



                <h5 class="card-title">Floating labels Form</h5>

                <!-- Floating Labels Form -->
                <form class="row g-3" method="POST" enctype="multipart/form-data">

                  <div class="col-md-12">
                    <div class="form-floating">
                      <input type="text" class="form-control" placeholder="기본주소" name="addr_line1">
                      <label>기본주소</label>
                    </div>
                  </div>

                  <div class="col-md-12">
                    <div class="form-floating">
                      <input type="text" class="form-control" placeholder="상세주소" name="addr_line2">
                      <label>상세주소</label>
                    </div>
                  </div>

                  <div class="col-md-12">
                    <div class="form-floating">
                      <input type="text" class="form-control" placeholder="연락처" name="member_phone">
                      <label>연락처</label>
                    </div>
                  </div>

                  <div class="col-md-12">
                    <div class="form-floating">
                      <textarea class="form-control" placeholder="배달요청사항" name="orders_drequest"
                        style="height: 100px;"></textarea>
                      <label>배달요청사항</label>
                    </div>
                  </div>

                  <div class="col-md-12">
                    <div class="form-floating">
                      <textarea class="form-control" placeholder="가게요청사항" name="orders_srequest"
                        style="height: 100px;"></textarea>
                      <label>가게요청사항</label>
                    </div>
                  </div>

                  <div class="col-md-12">
                    <div class="form-floating">
                      <input type="text" class="form-control" placeholder="결제가격" name="menu_price_all">
                      <label>결제가격</label>
                    </div>
                  </div>

                  <div class="col-md-12">
                    <div class="form-floating">
                      <input type="text" class="form-control" placeholder="결제방식" name="orders_payment">
                      <label>결제방식</label>
                    </div>
                  </div>


                  <div class="text-center">
                    <!-- <button type="submit" class="btn btn-primary">Submit</button>
                          <button type="reset" class="btn btn-secondary">Reset</button> -->
                    <input class="btn btn-success" type="button" value="메인화면" onclick="location.href='list.do'">

                    <input class="btn btn-primary" type="button" value="결제" onclick="send(this.form);">
                  </div>
                </form><!-- End floating Labels Form -->
            </div>
          </div>
          </table>
        </div>
      </div>
    </section>


  </main><!-- End #main -->

</body>

</html>