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

import com.delivery.finalproject.service.KakaoMapService;
import com.delivery.finalproject.service.RiderService;
import com.delivery.finalproject.vo.AddrVo;
import com.delivery.finalproject.vo.OrderVo;
import com.delivery.finalproject.vo.ShopVo;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/riders")
public class RiderController {

    @Autowired
    private RiderService riderService;

    @Autowired
    private KakaoMapService kakaoMapService;

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
