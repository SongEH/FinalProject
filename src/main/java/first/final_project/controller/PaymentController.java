package first.final_project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.JsonNode;

import first.final_project.dao.CartsMapper;
import first.final_project.service.MemberService;
import first.final_project.service.PaymentService;
import first.final_project.vo.MemberVo;
import first.final_project.vo.PaymentVo;
import jakarta.servlet.http.HttpSession;

@Controller
public class PaymentController {

    @Autowired
    PaymentService paymentService;

    @Autowired
	CartsMapper carts_mapper;

    // 09/10 유정 - MemberService & HttpSession 추가 자동 연결
    @Autowired
    MemberService member_service;

    @Autowired
    HttpSession session;

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
<<<<<<< HEAD
    public void orders_insert(PaymentVo vo, RedirectAttributes ra,int shop_id,int member_id) {

        System.out.println("도착");

=======
    public void orders_insert(PaymentVo vo, RedirectAttributes ra, int shop_id, int member_id) {
        
>>>>>>> parent of b45aac4 (Merge pull request #35 from SongEH/한지혜브랜치2)
        System.out.println(vo);

        System.out.println("DB 인서트 전!!!");
        try {
<<<<<<< HEAD

            int res = paymentService.insert(vo);

            // 현재 로그인한 사용자 정보를 가져옴
            MemberVo user = (MemberVo) session.getAttribute("user");
            if (user != null) {
                // 회원의 주문 수를 업데이트
                member_service.updateMemberOrder(user.getMember_id());
            }
            
            System.out.println("DB 인서트 완료");
        } catch (Exception e) {
=======
            paymentService.insert(vo);      
>>>>>>> parent of b45aac4 (Merge pull request #35 from SongEH/한지혜브랜치2)

            Integer orders_id = vo.getOrders_id();
            System.out.println(orders_id);
            
            // 주문 후에는 장바구니 테이블에 주문 id 부여 (더이상 장바구니에 표시안되도록)
            // carts_mapper.updateOrderId(orders_id, shop_id, member_id);

<<<<<<< HEAD
            // 주문 후에는 장바구니 테이블에 주문 id 부여 
            Map<String, Object> map = new HashMap<>();
            map.put("orders_id", orders_id);
            map.put("shop_id", shop_id);
            map.put("member_id", member_id);

            // update 메서드 호출
            carts_mapper.updateOrderId(map);
        } 
=======
        } catch (Exception e) {
            e.printStackTrace();
        }
>>>>>>> parent of b45aac4 (Merge pull request #35 from SongEH/한지혜브랜치2)
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
