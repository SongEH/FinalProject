package first.final_project.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.JsonNode;

import first.final_project.dao.CartsMapper;
import first.final_project.service.PaymentService;
import first.final_project.vo.PaymentVo;

@Controller
public class PaymentController {

    @Autowired
    PaymentService paymentService;

    @Autowired
    CartsMapper carts_mapper;

    @Autowired
    SimpMessagingTemplate messagingTemplate;

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
    public void orders_insert(PaymentVo vo, RedirectAttributes ra, int shop_id, int member_id) {

        System.out.println(vo);

        try {
            paymentService.insert(vo);

            Integer orders_id = vo.getOrders_id();
            System.out.println("orders_id : " + orders_id);

            // 주문 후에는 장바구니 테이블에 주문 id 부여 
            Map<String, Object> map = new HashMap<>();
            map.put("orders_id", orders_id);
            map.put("shop_id", shop_id);
            map.put("member_id", member_id);

            // update 메서드 호출
            carts_mapper.updateOrderId(map);

            // WebSocket을 통해 가계에 메시지 전송
		    messagingTemplate.convertAndSend("/topic/orders", "주문이 들어왔습니다.");
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
