package com.delivery.finalproject.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.delivery.finalproject.mapper.RiderMapper;
import com.delivery.finalproject.service.KakaoMapService;
import com.delivery.finalproject.service.RiderService;
import com.delivery.finalproject.vo.AddrVo;
import com.delivery.finalproject.vo.OrderVo;
import com.delivery.finalproject.vo.RiderVo;
import com.delivery.finalproject.vo.ShopVo;

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
    RiderMapper riderMapper;

    @Autowired
    private RiderService riderService;

    @Autowired
    private KakaoMapService kakaoMapService;

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
            return "index"; // JSP 페이지로 이동
        }

        try {
            // String 값을 int로 변환
            int orders_id = Integer.parseInt(orderIdStr);
            int raiders_id = Integer.parseInt(riderIdStr);

            // System.out.println("Parsed orders_id: " + orders_id + ", raiders_id: " +
            // raiders_id);

            // 주문 배차 로직 실행
            boolean result = riderService.assignOrderToRider(orders_id, raiders_id, deliveries_method);
            String resultMessage = result ? "주문을 받으셨습니다." : "주문을 받으실 수 없습니다";
            response.put("resultMessage", resultMessage);
            response.put("success", result);

            // System.out.println("Order assignment result: " + result);

            // 주문 테이블 업테이트 실행
            if (result) {
                riderService.updateOrderStatus(orders_id, "배차 완료");

                return "redirect:/riders/progress"; // 성공 시 진행 상황 페이지로 리다이렉트
                // System.out.println("Order status updated to '배차 완료'");
            }

        } catch (NumberFormatException e) {
            response.put("error", "Order ID 또는 Rider ID가 잘못되었습니다.");
            // System.out.println("NumberFormatException occurred: " + e.getMessage());
        }

        return "riders/waitingOrders";
    }

    // 라이더가 진행 중인 주문 리스트를 표시
    @GetMapping("/progress")
    public String getOrderProgress(Model model) {
        // int raiders_id = 1; // 예시로 라이더 ID를 1로 설정 (실제로는 로그인된 라이더의 ID를 가져와야 함)
        List<OrderVo> orders = riderService.getOrdersByRiderAndStatus(1, "배차 완료");
        if (orders == null || orders.isEmpty()) {
            model.addAttribute("message", "현재 진행 중인 주문이 없습니다.");
        } else {
            model.addAttribute("orders", orders);
        }
        return "riders/orderProgress";
    }

    // 라이더가 주문을 픽업 완료
    @PostMapping("/pickup")
    public String pickupOrder(@RequestParam("orders_id") int orders_id, @RequestParam("raiders_id") int raiders_id) {
        // 주문 상태를 '픽업 완료'로 변경
        riderService.updateOrderStatus(orders_id, "픽업 완료");
        return "redirect:/riders/progress"; // 진행 상황 페이지로 리다이렉트
    }

    // 라이더가 배달을 완료로 설정
    @PostMapping("/completeDelivery")
    public String completeDelivery(@RequestParam("orders_id") int orders_id,
            @RequestParam("riders_id") int raiders_id) {
        // 주문 상태를 '배송 완료'로 변경
        riderService.updateOrderStatus(orders_id, "배송 완료");
        return "redirect:/riders/progress"; // 진행 상황 페이지로 리다이렉트
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
            String customerAddress = addr.getAddr_line1() + " " + addr.getAddr_line2(); // 주소 1, 2 결합
            String shopAddress = shop.getShop_addr();
            double[] shopCoordinates = kakaoMapService.getCoordinates(shop.getShop_addr());
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
        // 라이더 ID를 고정값으로 설정 (로그인 시스템이 있다면 해당 라이더의 ID를 사용)
        int raiders_id = 1; // 예시로 1번 라이더로 설정

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

    // 배차 대기 중인 주문 리스트
    @GetMapping("/waiting-orders")
    public String getWaitingOrders(Model model) {
        List<OrderVo> orders = riderService.getOrdersByStatus("배차 대기");

        if (orders == null || orders.isEmpty()) {
            // 오류가 발생한 경우를 처리하거나 빈 목록을 반환
            model.addAttribute("error", "현재 배차 대기 중인 주문이 없습니다.");
            return "riders/waitingOrders";
        }

        model.addAttribute("orders", orders);
        model.addAttribute("raiders_id", 1); // 예시로 라이더 ID를 1로 설정 (실제로는 로그인된 라이더의 ID가 필요)
        return "riders/waitingOrders";
    }

}
