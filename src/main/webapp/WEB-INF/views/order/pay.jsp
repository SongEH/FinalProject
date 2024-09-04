<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <!-- Bootstrap CSS -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
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

    <script>
      function requestPay() {
        // 가맹점 식별코드
        let IMP = window.IMP;
        IMP.init("imp51327214");

        IMP.request_pay(
          {
            pg: "kakaopay", // PG사명 단일 문자열로 변경
            orders_payment: "card", // 결제 방법
            merchant_uid: "order_" + new Date().getTime(), // 고유한 주문번호 생성
            order_name: "당근 10kg", // 상품 명
            orders_price: 200, // 금액
            // buyer_email: "gildong@gmail.com",            // 이메일 주소
            member_name: "홍길동", // 회원 이름
            member_phone: "010-4242-4242", // 회원 번호
            addr_line1: "서울특별시 강남구 신사동", // 회원 주소
            addr_line2: "신사로 14길 8로", // 회원 상세 주소
            orders_srequest: "맛있게해주세요", //가게 요청 사항
            orders_drequest: "문 앞에 두고 초인종", //배달 요청 사항
            // buyer_postcode: "01181",
            orders_id: "1",
          },
          function (rsp) {
            // callback
            if (rsp.success) {
              // 결제 성공 시 서버로 데이터 전송
              $.ajax({
                url: "/payments/complete", // 서버의 결제 정보를 받는 endpoint
                method: "POST",
                contentType: "application/json",
                data: JSON.stringify({
                  imp_uid: rsp.imp_uid,
                  merchant_uid: rsp.merchant_uid,
                }),
                success: function (response) {
                  // 서버 결제 API 성공 시 로직
                  console.log(response);
                  alert("결제가 성공적으로 완료되었습니다.");
                },
                error: function (error) {
                  // 서버 결제 API 실패 시 로직
                  console.error(error);
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

    <title>Sample Payment</title>
  </head>
  <body>
    <button id="kakaoPay" onclick="handlePayment('kakaopay', 'card')">
      카카오페이 결제
    </button>
    <!-- 결제하기 버튼 생성 -->
  </body>
</html>
