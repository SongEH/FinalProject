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
            pay_method: "card", // 결제 방법
            merchant_uid: "order_" + new Date().getTime(), // 고유한 주문번호 생성
            name: "당근 10kg", // 상품 명
            amount: 200, // 금액
            buyer_email: "gildong@gmail.com",
            buyer_name: "홍길동",
            buyer_tel: "010-4242-4242",
            buyer_addr: "서울특별시 강남구 신사동",
            buyer_postcode: "01181",
          },
          function (rsp) {
            if (rsp.success) {
              // alert("결제 성공");
              var msg = "결제가 완료되었습니다.";
              msg += "고유ID : " + rsp.imp_uid;
              msg += "상점 거래ID : " + rsp.merchant_uid;
              msg += "결제 금액 : " + rsp.paid_amount;
              msg += "카드 승인번호 : " + rsp.apply_num;
            } else {
              // alert("결제 실패: " + rsp.error_msg);
              msg += "에러내용 : " + rsp.error_msg;
            }
            alert(msg);
          }
        );
      }
    </script>

    <title>Sample Payment</title>
  </head>
  <body>
    <button onclick="requestPay()">결제하기</button>
    <button onclick="findAddress()">우편번호찾기</button>
    <!-- 결제하기 버튼 생성 -->
  </body>
</html>
