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
    function requestPay(f) {

      // 입력값 검증
      let member_phone = f.member_phone.value.trim();
      let member_name = f.member_name.value.trim();
      let member_id = f.member_id.value.trim();

      let orders_drequest = f.orders_drequest.value.trim();
      let orders_srequest = f.orders_srequest.value.trim();

      let shop_id = f.shop_id.value;
      

      // 주소
      let selectElement = document.getElementById('addr_select');
      let selectedOption = selectElement.options[selectElement.selectedIndex];
      let addr_id = selectedOption.value;
      let addr_name = selectedOption.getAttribute('data-addr-name');
      // addr_all 변수에 합쳐서 저장
      const addrLine1 = selectedOption.getAttribute('data-addr-line1');
      const addrLine2 = selectedOption.getAttribute('data-addr-line2');
      const addrAll = addrLine1 + " "  + addrLine2;

      
      // 총 가격
      // total_price의 텍스트 값을 가져와서 orders_price에 저장
      const totalPriceElement = document.getElementById('total_price');
      const orders_price = parseFloat(totalPriceElement.textContent.replace(/[^0-9.-]+/g, ""));

      // Example usage
      // console.log('Selected Address ID:', addr_id);
      // console.log('Selected Address Name:', addr_name);
      // console.log('orders_price : ', orders_price);
      // console.log('Addr All:', addrAll);
      // console.log('shop_id:', shop_id);
      

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

      // -------------------------- 결제 --------------------





      // 가맹점 식별코드
      let IMP = window.IMP;
      IMP.init("imp51327214");
      IMP.request_pay({
          pg: "kakaopay", // PG사명 단일 문자열로 변경
          // pay_method: "card", // 결제 방법
          merchant_uid: "order_" + new Date().getTime(), // 고유한 주문번호 생성
          name: "호박 10kg", // 상품 명                       // 여기 수정
          amount: orders_price, // 금액                                
          buyer_name: member_name, // 회원 이름
          buyer_tel: member_phone, // 회원 번호
          buyer_addr: addrAll, 
          // buyer_postcode: "04024", // 회원 주소 
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
                "orders_payment": "kakaopay",
                "orders_method": rsp.pay_method,
                "orders_imp_uid": rsp.imp_uid,
                "orders_merchant_uid": rsp.merchant_uid,
                "orders_name": rsp.name, //
                "orders_price": orders_price, // 완료
                "member_name": rsp.buyer_name, // 완료
                "member_phone": rsp.buyer_tel, // 완료
                "orders_srequest": orders_srequest, // 완료
                "orders_drequest": orders_drequest, // 완료
                "shop_id": shop_id, // 완료
                "addr_id": addr_id, // 완료
                "member_id": member_id // 완료
              },
              success: function (response) {
                // 서버 결제 API 성공 시 로직
                alert("결제가 성공적으로 완료되었습니다.");

                // 주문내역 확인 화면으로 이동 
                window.location.href = '/main.do';
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

                <!-- 주문시 필요한 정보 히든태그에 저장  -->
                <input type="hidden" name="shop_id" value="${shop_id}">
                <input type="hidden" name="shop_name" value="${shop_name}">
                <input type="hidden" name="member_id" value="${user.getMember_id()}">
                <input type="hidden" name="member_name" value="${user.getMember_name()}">

                <div class="col-md-12">
                  <div class="form-floating">
                    <select id="addr_select" name="addr_id" class="form-select">
                      <c:forEach var="addr" items="${addr_list}">
                        <!-- <input type="text" class="form-control" placeholder="기본주소" name="addr_line1"
                        value="${addr.addr_line1}" readonly>
                      <label>${addr.addr_name}</label> -->
                        <option value="${addr.addr_id}" data-addr-name="${addr.addr_name}" data-addr-line1="${addr.addr_line1}" data-addr-line2="${addr.addr_line2}">
                          ${addr.addr_name} : ${addr.addr_line1} ${addr.addr_line2}
                        </option>
                      </c:forEach>
                    </select>
                    <label>주소</label>
                  </div>
                </div>

                <input type="button" value="주소 등록" onclick="location.href='/addr/addr_insert_form.do'" />

                <!-- <div class="col-md-12">
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
                </div> -->

                <div class="col-md-12">
                  <div class="form-floating">
                    <input type="text" class="form-control" placeholder="연락처" value=${user.getMember_phone()}
                      name="member_phone">
                    <label>연락처</label>
                  </div>
                </div>

                <div class="col-md-12">
                  <div class="form-floating">
                    <textarea class="form-control" placeholder="배달요청사항" name="orders_drequest" id="orders_drequest"
                      style="height: 100px;"></textarea>
                    <label>배달요청사항</label>
                  </div>
                </div>

                <div class="col-md-12">
                  <div class="form-floating">
                    <textarea class="form-control" placeholder="가게요청사항" name="orders_srequest" id="orders_srequest"
                      style="height: 100px;"></textarea>
                    <label>가게요청사항</label>
                  </div>
                </div>

                <div class="col-md-12">
                  <div class="form-floating">
                    <input type="text" class="form-control" placeholder="결제가격" id="menu_price_all" name="orders_price"
                      readonly>
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
                    <tr>
                      <td colspan="5" class="text-right">
                        <strong>주문 항목:</strong> <span id="orders_name"></span>
                      </td>
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

                    <input type="button" id="kakaoPay" onclick="requestPay(this.form);">카카오페이 결제</button>
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