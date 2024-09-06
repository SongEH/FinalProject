<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <!-- iamport  -->
  <script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
  <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
  <!-- 인증SDK -->
  <script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
  <!-- 카카오우편번호찾기 -->
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <meta charset="UTF-8" />

  <script type="text/javascript">
    function requestPay() {

      // 입력값 검증
      let member_phone = f.member_phone.value.trim();
      let orders_drequest = f.orders_drequest.value.trim();
      let orders_srequest = f.orders_srequest.value.trim();


      if (member_phone == '') {
        alert("연락처를 입력하세요!");
        f.member_phone.value = ""; //지우기
        f.member_phone.focus();
        return;
      }

      if (orders_drequest == '') {
        alert("배달 요청사항을 입력하세요!");
        f.orders_drequest.value = ""; //지우기
        f.orders_drequest.focus();
        return;
      }

      if (orders_srequest == '') {
        alert("가게 요청사항을 입력하세요!");
        f.orders_srequest.value = ""; //지우기
        f.orders_srequest.focus();
        return;
      }


      // 가맹점 식별코드
      let IMP = window.IMP;
      IMP.init("imp51327214");
      IMP.request_pay({
          pg: "kakaopay", // PG사명 단일 문자열로 변경
          pay_method: "card", // 결제 방법
          merchant_uid: "order_" + new Date().getTime(), // 고유한 주문번호 생성
          name: "호박 10kg", // 상품 명
          amount: 200, // 금액
          // buyer_email: "gildong@gmail.com",            // 이메일 주소
          buyer_name: "홍길동", // 회원 이름
          buyer_tel: "010-4242-4242", // 회원 번호
          buyer_addr: "서울특별시 강남구 신사동",
          buyer_postcode: "04024", // 회원 주소
        },
        function (rsp) {
          // callback
          if (rsp.success) {
            alert("rsp.success");
            // 결제 성공 시 서버로 데이터 전송
            $.ajax({
              // url: "/api/payment/data/" + rsp.imp_uid, // 서버의 결제 정보를 받는 endpoint
              url: "/payment/insert.do",
              method: "POST",
              // contentType: "application/json",
              data: {
                "orders_payment": rsp.pg,
                "orders_method": rsp.pay_method,
                "orders_imp_uid": rsp.imp_uid,
                "orders_merchant_uid": rsp.merchant_uid,
                "orders_name": rsp.name,
                "orders_price": rsp.amount,
                "member_name": rsp.buyer_name,
                "member_phone": rsp.buyer_tel,
                "addr_line2": rsp.buyer_addr,
                "orders_request": '맛있게',
                "orders_drequest": "배달",
                "Shop_id": "1",
                "addr_id": "1",
                "member_id": "1"
              },
              success: function (response) {
                // 서버 결제 API 성공 시 로직
                alert("결제가 성공적으로 완료되었습니다.");
              },
              error: function (error) {
                // 서버 결제 API 실패 시 로직
                alert("서버와의 통신에 실패했습니다.");
              },
            });
          } else {
            // 결제 실패 시 로직
            alert(`결제에 실패하였습니다. 에러 내용: ${rsp.error_msg}`);
          }
        }
      );
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
      <div class="row">
        <div class="col-lg-10">
          <div class="card">
            <div class="card-body">

              <h5 class="card-title">Floating labels Form</h5>

              <!-- Floating Labels Form -->
              <form class="row g-3" method="POST">

                <!-- 추가 필요할 듯...?  -->
                <!-- <input type="hidden" name="shop_id" value="${shop_id}">
                <input type="hidden" name="shop_name" value="${shop_name}"> -->

                <div class="col-md-12">
                  <div class="form-floating">
                    <input type="text" class="form-control" placeholder="기본주소" name="addr_line1" readonly>
                    <label>기본주소</label>

                  </div>
                </div>

                <div class="col-md-12">
                  <div class="form-floating">
                    <input type="text" class="form-control" placeholder="상세주소" name="addr_line2" readonly>
                    <label>상세주소</label>
                  </div>
                </div>

                <div class="col-md-12">
                  <div class="form-floating">
                    <input type="text" class="form-control" placeholder="연락처" value=${user.getMember_phone()}
                      name="member_phone">
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
                    <input type="text" class="form-control" placeholder="결제가격" id="menu_price_all"
                      name="orders_price1111" readonly>
                    <label>결제가격</label>
                  </div>
                </div>

                <div class="col-md-12">
                  <div class="form-floating">
                    <input type="text" class="form-control" placeholder="결제방식" value="카카오페이" name="orders_payment"
                      readonly>
                    <label>결제방식</label>
                  </div>
                </div>


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

                        <!-- 상점 ID를 헤더로 표시 -->
                        <tr>
                          <th colspan="5" style="background-color: #f8f9fa; text-align: left; padding: 10px;">
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
                        <td class="cart_quantity">${vo.carts_quantity}</td> <!-- 수량을 직접 출력 -->
                        <td class="cart_price">${vo.menu_price}</td>
                        <td class="cart_total_price">
                          ${vo.menu_price * vo.carts_quantity}
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>

                  <tfoot>
                    <tr>
                      <td colspan="2" class="text-right"><strong>총 개수:</strong></td>
                      <td id="total_quantity">0</td>
                      <td colspan="1" class="text-right"><strong>총 가격:</strong></td>
                      <td id="total_price">0</td>
                    </tr>
                  </tfoot>

                  <script>
                    document.addEventListener('DOMContentLoaded', function () {
                      const currencyFormatter = new Intl.NumberFormat('ko-KR', {
                        style: 'currency',
                        currency: 'KRW',
                        minimumFractionDigits: 0
                      });

                      function updateTotals() {
                        let totalQuantity = 0;
                        let totalPrice = 0;

                        // 각 행을 순회하며 총 개수와 총 가격 계산
                        document.querySelectorAll('#cartItems tr').forEach(row => {
                          const quantityElement = row.querySelector('.cart_quantity');
                          const priceElement = row.querySelector('.cart_price');
                          const totalPriceElement = row.querySelector('.cart_total_price');

                          if (quantityElement && priceElement && totalPriceElement) {
                            const quantity = parseInt(quantityElement.textContent) || 0;
                            const price = parseFloat(priceElement.textContent) || 0;
                            const total = quantity * price;

                            totalQuantity += quantity;
                            totalPrice += total;

                            totalPriceElement.textContent = currencyFormatter.format(total);
                          }
                        });

                        // 총 개수와 총 가격 업데이트
                        document.getElementById('total_quantity').textContent = totalQuantity;
                        document.getElementById('total_price').textContent = currencyFormatter.format(totalPrice);

                        // 결제 가격 입력 필드에 총 가격 값을 설정
                        document.getElementById('menu_price_all').value = currencyFormatter.format(totalPrice);

                      }

                      updateTotals();
                    });
                  </script>

                  <div class="text-center">
                    <!-- <button type="submit" class="btn btn-primary">Submit</button>
                          <button type="reset" class="btn btn-secondary">Reset</button> -->
                    <input class="btn btn-success" type="button" value="메인화면" onclick="location.href='list.do'">

                    <!-- <input class="btn btn-primary" type="button" value="결제" onclick="send(this.form);"> -->

                    <button id="kakaoPay" onclick="requestPay();">카카오페이 결제</button>
                    <!-- 결제하기 버튼 생성 -->
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