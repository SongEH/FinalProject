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
    <script
      type="text/javascript"
      src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"
    ></script>
    <!-- 인증SDK -->
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <script>
      function requestPay() {
        let IMP = window.IMP;
        IMP.init("imp51327214");
        IMP.request_pay(
          {
            pg: "kakaopay", //KG이니시스 pg파라미터 값
            pay_method: "card", //결제 방법
            merchant_uid: "1234578", //주문번호
            name: "당근 10kg", //상품 명
            amount: 200, //금액
            buyer_email: "gildong@gmail.com",
            buyer_name: "홍길동",
            buyer_tel: "010-4242-4242",
            buyer_addr: "서울특별시 강남구 신사동",
            buyer_postcode: "01181",
          },
          async function (response) {
            if (response.error_code) {
              alert("결제에 실패했습니다. 에러 내용: " + response.error_msg);
              return;
            }
            // 결제가 성공적으로 이루어진 경우 서버에 결제 완료 처리 요청
            try {
              //   const notified = await fetch(`${SERVER_BASE_URL}/payment/complete`,
              const notified = await fetch("order/payment/complete", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                  imp_uid: response.imp_uid,
                  merchant_uid: response.merchant_uid,
                  // 주문 정보 추가...
                }),
              });

              if (notified.ok) {
                alert("결제가 완료되었습니다!");
              } else {
                alert("결제는 완료되었으나 서버에 알림 처리에 실패했습니다.");
              }
            } catch (error) {
              console.error("서버 알림 처리 중 오류가 발생했습니다:", error);
              alert("결제는 완료되었으나 서버 알림 중 오류가 발생했습니다.");
            }
          }
        );
      }

      app.post("/payment/complete", async (req, res) => {
        try {
          const { imp_uid, merchant_uid } = req.body;

          // 1. 포트원 API 엑세스 토큰 발급
          const tokenResponse = await fetch(
            "https://api.iamport.kr/users/getToken",
            {
              method: "POST",
              headers: { "Content-Type": "application/json" },
              body: JSON.stringify({
                imp_key: "5625016054463015",
                imp_secret:
                  "1U0EWkXpNH5tCbQSXhfFtQmQ0ciaNfgG5g5guMt8PiC6Shvn1djKoIeW0rsx9a7yBq9fGdpLrKcPUypQ",
              }),
            }
          );
          if (!tokenResponse.ok) throw new Error("토큰 발급 실패");
          const { access_token } = await tokenResponse.json();

          // 2. 포트원 결제내역 단건조회 API 호출
          const paymentResponse = await fetch(
            `https://api.iamport.kr/payments/${imp_uid}`,
            { headers: { Authorization: access_token } }
          );
          if (!paymentResponse.ok) throw new Error("결제 정보 조회 실패");
          const payment = await paymentResponse.json();

          // 3. 주문 정보와 결제 금액 비교
          const order = await OrderService.findById(merchant_uid);
          if (order.amount === payment.amount) {
            if (payment.status === "ready") {
              // 가상 계좌가 발급된 상태
              // 예: 발급된 가상 계좌 정보를 DB에 저장하거나 고객에게 전송
              await VirtualAccountService.save(payment);
              return res.status(200).send({ message: "가상 계좌 발급 완료" });
            }
          } else {
            throw new Error("결제 금액 불일치");
          }
        } catch (e) {
          return res.status(400).send({ message: e.message });
        }
      });
    </script>

    <meta charset="UTF-8" />
    <title>Sample Payment</title>
  </head>
  <body>
    <button onclick="requestPay()">결제하기</button>
    <!-- 결제하기 버튼 생성 -->
  </body>
</html>
