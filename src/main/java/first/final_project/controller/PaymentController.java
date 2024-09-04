package first.final_project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.JsonNode;

import first.final_project.service.PaymentService;
import first.final_project.vo.PaymentRequest;

@RestController
@RequestMapping("/payments")
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    @RequestMapping("/pay")
    public String pay() {

        return "pay";
    }

    public PaymentController(PaymentService paymentService) {
        this.paymentService = paymentService;
    }

    @PostMapping("/complete")
    public ResponseEntity<JsonNode> completePayment(@RequestBody PaymentRequest paymentRequest) {
        try {
            // 액세스 토큰 발급 받기
            String accessToken = paymentService.getAccessToken();

            // imp_uid로 포트원 서버에서 결제 정보 조회
            JsonNode paymentData = paymentService.getPaymentData(paymentRequest.getImp_uid(), accessToken);

            // 추가 처리 로직
            // 예: 결제 금액 확인, 주문 상태 업데이트 등

            return ResponseEntity.ok(paymentData);
        } catch (Exception e) {
            return ResponseEntity.status(400).body(null);
        }
    }

}
