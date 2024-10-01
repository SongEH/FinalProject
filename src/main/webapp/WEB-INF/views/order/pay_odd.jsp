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
            console.log(rsp);
            //결제 성공시
            if (rsp.success) {
              let msg = "결제가 완료되었습니다.";
              let result = {
                pay_merchant_uid: rsp.merchant_uid, //결제 번호
                pay_status: "paid", //결제(paid),대기(ready)
                orders_id: rsp.orders_id,
                orders_payment: rsp.orders_payment, //결제 방법
                pay_pg: rsp.pg, //결제 사이트
                pay_name: rsp.order_name, //구매 상품
                orders_price: rsp.orders_price, //결제 금액
                pay_rdate: new Date().toISOString().slice(0, 10), //결제일
                member_name: rsp.member_name, //회원 이름
                member_phone: rsp.member_phone, //회원 번호
                addr_line1: rsp.addr_line1, //회원 주소
                addr_line2: rsp.addr_line2, //회원 상세주소
              };
              console.log(result);
              //  서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
              $.ajax({
                url: "/payment/complete",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(result),
                success: function (res_data) {
                  alert(res_data);
                  location.href = res;
                },
                error: function (err) {
                  alert(err.responseText);
                },
              }); //ajax end
            } else {
              let msg = "결제가 실패되었습니다.";
              // msg += "\n에러내용" + rsp.error_msg;
            }
            alert(msg);
          }
        );
      }

      // function (rsp) {
      //   if (rsp.success) {
      //     // alert("결제 성공");
      //     var msg = "결제가 완료되었습니다.";
      //     msg += "고유ID : " + rsp.imp_uid;
      //     msg += "상점 거래ID : " + rsp.merchant_uid;
      //     msg += "결제 금액 : " + rsp.paid_amount;
      //     msg += "카드 승인번호 : " + rsp.apply_num;
      //   } else {
      //     // alert("결제 실패: " + rsp.error_msg);
      //     msg += "에러내용 : " + rsp.error_msg;
      //   }
      //   alert(msg);
      // }
      // );
      // }
    </script>

    <title>Sample Payment</title>
  </head>
  <body>
    <button onclick="requestPay()">결제하기</button>
    <button onclick="findAddress()">우편번호찾기</button>
    <!-- 결제하기 버튼 생성 -->
  </body>
</html>
