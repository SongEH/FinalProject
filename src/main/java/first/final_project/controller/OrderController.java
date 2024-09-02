package first.final_project.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import first.final_project.service.OrderService;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class OrderController {

    @Autowired
    OrderService orderService;

    @RequestMapping("order/pay.do")
    public String order() {

        return "order/pay";
    }

    @RequestMapping("order/payment/complete")
    public String order_complete(@RequestParam Map<String, String> paramMap, HttpServletRequest request) {
        try {
            // 1. 클라이언트로부터 전달받은 imp_uid와 merchant_uid를 추출합니다.
            String impUid = paramMap.get("imp_uid");
            String merchantUid = paramMap.get("merchant_uid");

            // 2. 포트원 API를 호출하여 결제 정보를 검증합니다.
            boolean isPaymentValid = orderService.verifyPayment(impUid, merchantUid);

            if (isPaymentValid) {
                // 3. 주문 상태를 업데이트합니다.
                orderService.updateOrderStatus(merchantUid, "PAID");

                // 4. 결제 완료 페이지로 리다이렉트합니다.
                return "redirect:/order/success";
            } else {
                // 결제 검증 실패 시 에러 페이지로 리다이렉트
                return "redirect:/order/fail";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/order/fail";
        }
    }
}
