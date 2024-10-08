package first.final_project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import first.final_project.dao.RidersMapper;
import first.final_project.service.KakaoMapService;
import first.final_project.service.RidersService;
import first.final_project.vo.AddrVo;
import first.final_project.vo.OrderVo;
import first.final_project.vo.RiderVo;
import first.final_project.vo.ShopVo;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/riders/")
public class RiderController {

    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpSession session;

    @Autowired
    RidersMapper riderMapper;

    @Autowired
    private RidersService riderService;

    @Autowired
    private KakaoMapService kakaoMapService;

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    // ==========
    @RequestMapping("main.do")
    public String main() {

        return "riders/riders_main";
    }

    // 회원 조회
    @RequestMapping("list.do")
    public String list(Model model) {
        List<RiderVo> list = riderMapper.selectList();
        model.addAttribute("list", list);
        return "riders/riders_list";
    }

    // 회원가입 폼
    @RequestMapping("insert_form.do")
    public String insert_form() {
        return "riders/riders_insert_form";
    }

    // 회원가입
    @RequestMapping("insert.do")
    public String insert(RiderVo vo) {
        riderMapper.insert(vo);

        return "redirect:login_form.do";
    }

    // 로그인 폼
    @RequestMapping("login_form.do")
    public String login_form() {

        return "redirect:main.do";
        // return "riders/riders_insert_form5";
    }

    // 로그인
    @RequestMapping("login.do")
    public String login(String riders_email, String riders_pwd, String url, RedirectAttributes ra) {

        RiderVo user = riderMapper.selectOneFromEmail(riders_email);

        if (user == null) {
            ra.addAttribute("reason", "fail_id");

            return "redirect:main.do";
        }

        if (user.getRiders_pwd().equals(riders_pwd) == false) {
            ra.addAttribute("reason", "fail_pwd");
            ra.addAttribute("riders_email", riders_email);

            return "redirect:main.do";
        }

        session.setAttribute("user", user);
        session.setAttribute("isLoggedIn", true);

        return "riders/delivery";

    }

    // 로그아웃
    @RequestMapping("logout.do")
    public String logout() {

        session.removeAttribute("user");

        return "redirect:main.do";
    }

    @RequestMapping("mypage.do")
    public String showMyPage(RiderVo vo, Model model) {
        RiderVo user = (RiderVo) session.getAttribute("user");
        if (user == null) {

            return "redirect:login_form.do";

        }
        RiderVo rider = riderMapper.selectOneFromId(user.getRaiders_id());
        model.addAttribute("vo", rider);
        // 다른 데이터 모델 추가
        return "riders/riders_mypage";
    }

    // 마이페이지에서 회원 수정폼 띄우기
    @RequestMapping("mypage/modify_form.do")
    public String myPageUpdateForm(int raiders_id, Model model) {

        RiderVo vo = riderMapper.selectOneFromId(raiders_id);
        // RiderVo user = (RiderVo) session.getAttribute("user");
        // if (user == null) {
        // return "redirect:login_form.do";
        // }
        // // 로그인한 유저의 정보를 가져옴
        // RiderVo riders = ridersMapper.selectOneFromId(user.getraiders_id());
        model.addAttribute("vo", vo);
        return "riders/riders_mypage_modify"; // 수정 폼 JSP 페이지
    }

    // 회원정보 수정을 처리하는 메소드
    @RequestMapping("mypage/modify.do")
    public String myPageUpdate(RiderVo vo) {
        // 회원 정보 업데이트
        riderMapper.update(vo);
        RiderVo loginUser = (RiderVo) session.getAttribute("user");

        if (loginUser.getRaiders_id() == vo.getRaiders_id()) {

            // 로그인상태정보
            RiderVo user = riderMapper.selectOneFromId(vo.getRaiders_id());

            // session.removeAttribute("user");
            // scope내에 저장방식 Map형식: key / value
            // 동일한 key로 저장하면 수정처리된다
            session.setAttribute("user", user);
        }
        return "redirect:../mypage.do"; // 수정 후 마이페이지로 리다이렉트
    }

    // 마이페이지에서 회원 탈퇴
    @RequestMapping("mypage/delete.do")
    public String myPageDelete(@RequestParam("raiders_id") int raiders_id, RedirectAttributes ra) {
        riderMapper.delete(raiders_id);
        session.invalidate(); // 세션 무호화 -> 사용자가 탈퇴할 때 세션에 저장된 정보가 더이상 유효하지 않기에 세션을
        // 무효화 시켜야 한다
        return "redirect:../main.do";
    }
    // ==========

    // 라이더가 주문을 배차 받기
    @PostMapping("/assign")
    public String assignOrder(
            @RequestParam(value = "orders_id", required = true) String orderIdStr,
            @RequestParam(value = "raiders_id", required = true) String riderIdStr,
            @RequestParam(value = "deliveries_method", required = true) String deliveries_method,
            HttpServletRequest request,
            Model model) {

        Map<String, Object> response = new HashMap<>();

        // 입력 값이 비어있는지 확인
        if (orderIdStr.isEmpty() || riderIdStr.isEmpty()) {
            response.put("error", "Order ID 또는 Rider ID가 없습니다.");
            return "riders/main.do"; // JSP 페이지로 이동
        }

        try {
            // String 값을 int로 변환
            int orders_id = Integer.parseInt(orderIdStr);
            int raiders_id = Integer.parseInt(riderIdStr);
            ;

            // 주문 배차 로직 실행
            boolean result = riderService.assignOrderToRider(orders_id, raiders_id, deliveries_method);
            String resultMessage = result ? "주문을 받으셨습니다." : "주문을 받으실 수 없습니다";
            response.put("resultMessage", resultMessage);
            response.put("success", result);


            // 주문 테이블 업테이트 실행
            if (result) {
                riderService.updateOrderStatus(orders_id, "조리 중");

                // 서버 측: 주문이 들어왔을 때 전송할 메시지
                Map<String, Object> message = new HashMap<>();
                message.put("orderStatus", "주문 정보가 업데이트되었습니다."); // 주문 상태
                message.put("orders_id", orders_id); // 주문 ID

                messagingTemplate.convertAndSend("/topic/orders", message);

                return "redirect:/riders/progress"; // 성공 시 진행 상황 페이지로 리다이렉트
            }

        } catch (NumberFormatException e) {
            response.put("error", "Order ID 또는 Rider ID가 잘못되었습니다.");
        }

        return "redirect:/riders/waiting-orders";
    }

    // 배차 대기 중인 주문 리스트
    @GetMapping("/waiting-orders")
    public String getWaitingOrders(Model model) {
        // 세션에서 라이더 정보를 가져옴
        HttpSession session = request.getSession();

        // 세션에서 저장된 객체를 가져옴
        Object userObj = session.getAttribute("user");

        // 객체가 존재하고, 타입이 RiderVo일 때만 처리
        if (userObj != null) {
            if (userObj instanceof RiderVo) {
                RiderVo user = (RiderVo) userObj;
                int raiders_id = user.getRaiders_id();

                // raiders_id를 세션에 저장
                session.setAttribute("raiders_id", raiders_id);

                // 라이더가 배차 대기 중인 주문 목록를 가져오기
                List<OrderVo> orders = riderService.getOrdersByStatus("배차 대기", raiders_id);

                if (orders == null || orders.isEmpty()) {
                    // 오류가 발생한 경우를 처리하거나 빈 목록을 반환
                    model.addAttribute("error", "현재 배차 대기 중인 주문이 없습니다.");
                    return "riders/waitingOrders";
                }

                model.addAttribute("orders", orders);
                model.addAttribute("raiders_id", raiders_id);
                return "riders/waitingOrders";
            }else{
                // RiderVo를 사용하지 않는 세션"user" 로그아웃 처리
                session.removeAttribute("user");
                return "redirect:/riders/main.do";
            }
        }
    return "redirect:/riders/main.do";
    }

    // 라이더가 진행 중인 주문 리스트를 표시
    @GetMapping("/progress")
    public String getOrderProgress(Model model) {
        HttpSession session = request.getSession();
        RiderVo user = (RiderVo) session.getAttribute("user");

        // 라이더 정보가 없을 경우
        if (user == null) {
            // 로그인 화면으로 리다이렉트
            return "redirect:login_form.do";
        }

        int raiders_id = user.getRaiders_id();
        // 배차가 완료된 리스트 가져오기
        List<OrderVo> orders = riderService.getOrdersByRiderAndStatus(raiders_id, "배차 완료");
        // 배차가 완료된 리스트가 없을시
        if (orders == null || orders.isEmpty()) {
            model.addAttribute("message", "현재 진행 중인 주문이 없습니다.");
        } else {
            model.addAttribute("orders", orders);
        }

        return "riders/orderProgress";
    }

    // 픽업 완료 처리
    @PostMapping("/pickup")
    public String pickupOrder(@RequestParam("orders_id") int orders_id, @RequestParam("raiders_id") int raiders_id) {
        // 주문 상태를 '배달 중'으로 변경
        riderService.updateOrderStatus(orders_id, "배달 중");

        // 배달 이력 상태도 '배달 중'으로 업데이트
        riderService.updateDeliveryHistory(orders_id, "배달 중");

        // 주문이 들어왔을 때 웹 소켓에 전송할 메시지
        Map<String, Object> message = new HashMap<>();
        message.put("orderStatus", "주문 정보가 업데이트되었습니다."); // 주문 상태
        message.put("orders_id", orders_id); // 주문 ID
        message.put("raiders_id", raiders_id); // 라이더 ID

        messagingTemplate.convertAndSend("/topic/orders", message);

        return "redirect:/riders/progress"; // 진행 상황 페이지로 리다이렉트
    }

    // 배달 완료 처리
    @PostMapping("/completeDelivery")
    public String completeDelivery(@RequestParam("orders_id") int orders_id, @RequestParam("raiders_id") int raiders_id) {
        // 주문 상태를 '배달 완료'로 변경
        riderService.updateOrderStatus(orders_id, "배달 완료");

        // 배달 이력 상태도 '배달 완료'로 업데이트
        riderService.updateDeliveryHistory(orders_id, "배달 완료");

        // 서버 측: 주문이 들어왔을 때 전송할 메시지
        Map<String, Object> message = new HashMap<>();
        message.put("orderStatus", "주문 정보가 업데이트되었습니다."); // 주문 상태
        message.put("orders_id", orders_id); // 주문 ID
        message.put("raiders_id", raiders_id); // 라이더 ID

        messagingTemplate.convertAndSend("/topic/orders", message);

        return "redirect:/riders/completed"; // 진행 상황 페이지로 리다이렉트
    }

    // 배달 경로를 표시하는 메서드
    @GetMapping("/route")
    public String showRoute(@RequestParam("orders_id") int orders_id, Model model) {
        // Order 정보를 가져옴
        OrderVo order = riderService.getOrderById(orders_id);

        // Addr 정보를 가져옴 (주소 정보)
        AddrVo addr = riderService.getAddrById(order.getAddr_id());

        // Shop 정보를 가져옴 (가게 정보)
        ShopVo shop = riderService.getShopById(order.getShop_id());

        try {
            // 경로 계산을 위한 주소 정보 가져오기
            String customerAddress = addr.getAddr_line1() + " " + addr.getAddr_line2(); // 고객 주소 1, 2 결합
            String shopAddress = shop.getShop_addr1() + " " + shop.getShop_addr2(); // 가계 주소 1, 2 결합

            double[] shopCoordinates = kakaoMapService.getCoordinates(shopAddress);
            double[] customerCoordinates = kakaoMapService.getCoordinates(customerAddress);

            model.addAttribute("shopAddress", shopAddress);
            model.addAttribute("customerAddress", customerAddress);
            model.addAttribute("shopLat", shopCoordinates[0]);
            model.addAttribute("shopLng", shopCoordinates[1]);
            model.addAttribute("customerLat", customerCoordinates[0]);
            model.addAttribute("customerLng", customerCoordinates[1]);
        } catch (Exception e) {
            model.addAttribute("error", "경로를 찾을 수 없습니다: " + e.getMessage());
        }

        return "route/showRoute";
    }

    // 라이더가 완료한 배달 내역을 표시
    @GetMapping("/completed")
    public String getCompletedDeliveries(Model model) {
        // 라이더 ID를 고정값으로 설정
        HttpSession session = request.getSession();
        RiderVo user = (RiderVo) session.getAttribute("user");

        // 라이더 정보가 없을 경우
        if (user == null) {
            // 로그인 화면으로 리다이렉트
            return "redirect:login_form.do";
        }

        int raiders_id = user.getRaiders_id();

        // 배달 완료된 주문 목록을 가져오기
        List<OrderVo> completedOrders = riderService.getCompletedOrdersByRider(raiders_id);

        // 주문 목록을 모델에 추가하여 JSP에서 사용 가능하게 설정
        model.addAttribute("completedOrders", completedOrders);

        return "riders/deliveryCompleted"; // 배달 완료된 주문을 표시하는 JSP로 이동
    }

    // index에서 delivery.jsp로 이어지도록
    @GetMapping("/delivery")
    public String showDeliveryPage() {
        return "riders/delivery";
    }

    // 라이더가 예상 배달 시간 선택
    @PostMapping("/setDeliveryTime")
    public String setDeliveryTime(@RequestParam("orders_id") int orders_id,
            @RequestParam("delivery_time") int delivery_time) {
        riderService.updateDeliveryTime(orders_id, delivery_time);
        riderService.updateDeliveryHistory(orders_id, "배차 완료");
        return "redirect:/riders/progress";
    }

    // 라이더가 배차를 받았을 때 클라이언트에게 알림 전송
    public void notifyOrderUpdate(int ordersId, String status) {
        messagingTemplate.convertAndSend("/topic/status", status);
    }

}
