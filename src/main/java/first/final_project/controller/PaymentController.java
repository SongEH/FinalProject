package first.final_project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.JsonNode;

import first.final_project.service.PaymentService;
import first.final_project.vo.PaymentVo;

@Controller
public class PaymentController {

    @Autowired
    PaymentService paymentService;

    // public PaymentController(PaymentService paymentService) {
    // this.paymentService = paymentService;
    // }

    @RequestMapping("/payment/jsp")
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

    // order tabel에 insert
    @RequestMapping(value = "/payment/insert.do")
    @ResponseBody
    public void orders_insert(PaymentVo vo, RedirectAttributes ra) {

        System.out.println("도착");

        System.out.println(vo);

        System.out.println("DB 인서트 전!!!");
        try {
            int res = paymentService.insert(vo);
            System.out.println("DB 인서트 완료");
        } catch (Exception e) {

            e.printStackTrace();
        }

    }

    @GetMapping("/api/payment/data/{impUid}")
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
