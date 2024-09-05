package first.final_project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.JsonNode;

import first.final_project.service.PaymentService;

@Controller
@RequestMapping("/api/payment")
public class PaymentController {
    @Autowired
    private final PaymentService paymentService;

    public PaymentController(PaymentService paymentService) {
        this.paymentService = paymentService;
    }

    @RequestMapping("/jsp")
    public String home() {
        return "order/pay";
    }

    @GetMapping("/token")
    public String getAccessToken() {
        try {
            return paymentService.getAccessToken();
        } catch (Exception e) {
            return "Error fetching access token: " + e.getMessage();
        }
    }

    @GetMapping("/data/{impUid}")
    @ResponseBody
    public String getPaymentData(@PathVariable String impUid) {
        System.out.println("도착");
        System.out.println(impUid);

        try {
            // accessToken 발급 받기
            String accessToken = paymentService.getAccessToken();
            System.out.println("AccessToken: " + accessToken);
            if (accessToken == null || accessToken.isEmpty()) {
                System.out.println("AccessToken이 유효하지 않습니다.");
                return "error/error_page";
            }

            // 결제 데이터 가져오기
            JsonNode paymentData = paymentService.getPaymentData(impUid, accessToken);
            System.out.println("PaymentData: " + paymentData);
            if (paymentData == null) {
                System.out.println("결제 데이터가 없습니다.");
                return "error/error_page";
            }

            return paymentData.toString();
        } catch (Exception e) {
            e.printStackTrace(); // 예외의 스택 트레이스를 콘솔에 출력
            return "error/error_page";
        }
    }
}
