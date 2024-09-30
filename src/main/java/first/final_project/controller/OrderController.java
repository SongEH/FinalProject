package first.final_project.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.JsonNode;

import first.final_project.dao.AddrMapper;
import first.final_project.dao.CartsMapper;
import first.final_project.dao.OrderMapper;
import first.final_project.dao.ReviewsMapper;
import first.final_project.service.OrderService;
import first.final_project.service.PaymentService;
import first.final_project.service.ShopService;
import first.final_project.vo.AddrVo;
import first.final_project.vo.CartsVo;
import first.final_project.vo.MemberVo;
import first.final_project.vo.MenuVo;
import first.final_project.vo.OrderVo;
import first.final_project.vo.ReviewsVo;
import first.final_project.vo.OwnerVo;
import first.final_project.vo.PaymentVo;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/order/")
public class OrderController {

	@Autowired
	OrderMapper order_mapper;

	@Autowired
	CartsMapper carts_mapper;

	@Autowired
	AddrMapper addr_mapper;

	@Autowired
	ReviewsMapper reviews_mapper;

	@Autowired
	HttpServletRequest request;

	@Autowired
	HttpSession session;

	@Autowired
	ServletContext application;

	@Autowired
	OrderService orderService;

	@Autowired
	SimpMessagingTemplate messagingTemplate;

	@Autowired
	PaymentService paymentService;

	@Autowired
	ShopService shop_Service;

	// 페이징 처리 전
	// 주문 내역 확인
	// @RequestMapping("list.do")
	// public String list(@RequestParam(name = "page", defaultValue = "1") int
	// nowPage,
	// Model model) {

	// MemberVo user = (MemberVo) session.getAttribute("user");

	// List<OrderVo> list = order_mapper.selectList(user.getMember_id());

	// // 전체 게시물수
	// // int rowTotal = order_mapper.selectRowTotal();

	// for (OrderVo vo : list) {
	// Boolean result = reviews_mapper.checkReviewExists(vo.getOrders_id());
	// boolean hasReview = (result != null) ? result : false;
	// vo.setHasReview(hasReview);
	// }
	// // System.out.println(rowTotal);
	// System.out.println(list);
	// // 결과적으로 request binding
	// model.addAttribute("list", list);

	// return "order/order_list";
	// }

	@RequestMapping("list.do")
	public String list(@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "startDate", required = false) String startDate, // 요청 파라미터로 시작 날짜 필터를 받음. 필수 값이 아니기
																					// 때문에 null일 수 있음
			@RequestParam(name = "endDate", required = false) String endDate, // 요청 파라미터로 종료 날짜 필터를 받음. 필수 값이 아니기 때문에
																				// null일 수 있음
			Model model) {

		// DATETIME 형식으로 비교하기 위해서 시:분:초 추가
		if (startDate != null && !startDate.isEmpty()) {
			startDate += " 00:00:00"; // 시작 날짜에 시간 추가
		}
		if (endDate != null && !endDate.isEmpty()) {
			endDate += " 23:59:59"; // 종료 날짜에 시간 추가
		}

		// OrderService에서 결과를 담을 Map 객체
		Map<String, Object> resultMap;

		// 로그인한 member_id
		MemberVo user = (MemberVo) session.getAttribute("user");
		int member_id = user.getMember_id();

		// 필터가 없는 경우(날짜 필터 값이 null이거나 빈 값일 경우) 전체 목록을 가져옴
		if ((startDate == null || startDate.isEmpty()) && (endDate == null || endDate.isEmpty())) {
			resultMap = orderService.getPagedOrder(member_id, page); // 전체 배달 목록
		} else {
			// 필터가 있는 경우 해당 날짜 범위에 맞는 목록을 가져옴
			resultMap = orderService.getPagedOrder(member_id, page, startDate, endDate); // 필터 적용된 목록
		}

		List<OrderVo> order_list = (List<OrderVo>) resultMap.get("order_list");

		for (OrderVo vo : order_list) {
			if (vo.getReviews_delete() == 1) {
				vo.setHasReview(true);
			} else {
				Boolean result = reviews_mapper.checkReviewExists(vo.getOrders_id());
				boolean hasReview = (result != null) ? result : false;
				vo.setHasReview(hasReview);
			}
		}

		// 결과적으로 request binding
		model.addAttribute("list", order_list);
		System.out.println("order_list : " + order_list);
		System.out.println("order_list count : " + order_list.size());

		// 페이지 메뉴 데이터를 모델에 추가하여 JSP에 전달 (페이징 처리된 페이지 번호)
		model.addAttribute("pageMenu", resultMap.get("pageMenu"));

		// 현재 페이지 번호를 모델에 추가하여 JSP에 전달
		model.addAttribute("currentPage", page);

		// 필터 값을 모델에 추가하여 JSP에서 필터를 유지할 수 있게 함
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);

		return "order/order_list";
	}

	@RequestMapping("order_list.do")
	@ResponseBody
	public List<OrderVo> getOrders(@RequestParam String type, HttpSession session) {
		List<OrderVo> order_list = new ArrayList<>();
		int id;

		// 세션에서 사용자 정보 가져오기
		Object userObject = session.getAttribute("user");

		if (userObject == null) {
			throw new RuntimeException("사용자가 로그인하지 않았습니다."); // 또는 적절한 예외 처리
		}

		if ("owner".equals(type)) {
			OwnerVo user = (OwnerVo) userObject;
			id = user.getOwner_id();
			order_list = orderService.getAcceptOrderList(id, "주문 대기");

		} else if ("member".equals(type)) {
			MemberVo user = (MemberVo) userObject;
			id = user.getMember_id();
			order_list = order_mapper.selectList(id);
		}

		System.out.println("주문리스트\n" + order_list);

		return order_list;
	}

	// 회원 주문대기 (주문 전)
	@RequestMapping("pending_order.do")
	public String insert(int shop_id, String shop_name, String order_addr, String order_addr_zipcode, Model model) { 

		// 현재 로그인한 사용자
		MemberVo user = (MemberVo) session.getAttribute("user");

		// 장바구니 테이블에서 => 가게ID와 + 현재 사용자ID와 + orderID가 없는 것을 조회한 결과
		List<CartsVo> list = carts_mapper.findPendingOrders(user.getMember_id(), shop_id);

		// request binding
		model.addAttribute("list", list);
		model.addAttribute("user", user);
		model.addAttribute("shop_id", shop_id);
		model.addAttribute("shop_name", shop_name);
		model.addAttribute("order_addr", order_addr);
		model.addAttribute("order_addr_zipcode", order_addr_zipcode);

		// 주소 처리
		List<AddrVo> addr_list = addr_mapper.selectList(user.getMember_id());
		model.addAttribute("addr_list", addr_list);

		return "order/order_pending_list";
	}

	// 회원 주문 상세보기
	@RequestMapping(value = "order_show.do")
	public String order_show(int orders_id, Model model) {

		// 주문 1건 조회
		OrderVo vo = order_mapper.selectOne(orders_id);

		// 주문ID를 가진 장바구니 목록
		List<CartsVo> list = carts_mapper.selectCartListByOrdersId(orders_id);

		System.out.println(list);
		model.addAttribute("vo", vo);
		model.addAttribute("list", list);

		return "order/order_show";
	}

	// 회원 주문 삭제 (소프트삭제)
	@RequestMapping(value = "delete.do")
	public String delete(int orders_id) {

		orderService.softDelete(orders_id);

		return "redirect:list.do";
	}

	// ------------------------------ 가맹점 측 -----------------------------
	// 가맹점 주문 내역
	@GetMapping("accept.do")
	public String getAcceptOrderList(Model model) {
		// 세션에서 가계 정보를 가져옴
		HttpSession session = request.getSession();
		OwnerVo user = (OwnerVo) session.getAttribute("user");

		// 가계 정보가 없는 경우
		if (user == null) {
			return "redirect:/login_form.do";
		}

		int owner_id = user.getOwner_id();

		// session에 shop_id 삽입
		int shop_id = shop_Service.select_one_shop_id(owner_id);
		session.setAttribute("shop_id", shop_id);

		// 주문 대기 상태의 주문 정보를 가져옴
		List<OrderVo> orders = orderService.getAcceptOrderList(owner_id, "주문 대기");

		if (orders == null || orders.isEmpty()) {
			model.addAttribute("message", "현재 진행 중인 주문이 없습니다.");
		} else {
			model.addAttribute("orders", orders);
		}

		// owner와 shop 은 1:1 매칭 확인 및 버튼 비활성화
		System.out.println("user.getOwner_id() : " + user.getOwner_id());
		Boolean result = shop_Service.hasShop(user.getOwner_id());
		System.out.println(result);
		Boolean hasShop = (result != null) ? result : false;
		if (hasShop != null & hasShop) {
			if (hasShop == false) {
				return "redirect:../shop/insert_form.do";
			}
		}
		model.addAttribute("hasShop", hasShop);
		return "order/order_accept_list";
	}

	// 주문 접수
	@GetMapping("accept")
	public String acceptOrderList(@RequestParam("orders_id") int orders_id) {
		
		// 주문 상태를 '배차 대기'로 변경
		orderService.updateOrderStatus(orders_id, "배차 대기");

		// 서버 측: 주문이 들어왔을 때 전송할 메시지
        Map<String, Object> message = new HashMap<>();
        message.put("orderStatus", "주문 정보가 업데이트되었습니다."); // 주문 상태
        message.put("orders_id", orders_id); // 주문 ID

        messagingTemplate.convertAndSend("/topic/orders", message);

		return "redirect:/order/accept.do";
	}

	// 픽업대기 (조리완료시)
	@GetMapping("endCooking")
	public String endCooking(@RequestParam("orders_id") int orders_id) {

		// 주문 상태를 '픽업 대기'로 변경
		orderService.updateOrderStatus(orders_id, "픽업 대기");

        // 서버 측: 주문이 들어왔을 때 전송할 메시지
        Map<String, Object> message = new HashMap<>();
        message.put("orderStatus", "주문 정보가 업데이트되었습니다."); // 주문 상태
        message.put("orders_id", orders_id); // 주문 ID

        messagingTemplate.convertAndSend("/topic/orders", message);	

		return "redirect:/order/accept.do";
	}

	// 주문 거절
	@GetMapping("cancel")
	public String deleteOrder(@RequestParam("orders_id") int orders_id) {
		// // 주문 정보 조회
		// PaymentVo payment = paymentService.getPaymentByOrderId(orders_id);

		// try {
		// // 결제 취소 처리 (아임포트 결제 취소 API 호출)
		// JsonNode cancelResponse =
		// paymentService.cancelPaymentByOrder(payment.getOrders_imp_uid(),
		// payment.getOrders_price());

		// // API 응답 전체를 출력해서 확인
		// System.out.println("Cancel Response: " + cancelResponse.toString());

		// // 응답의 "response" 노드 확인
		// JsonNode responseNode = cancelResponse.get("response");

		// // 결제 취소 결과 확인
		// if (responseNode != null &&
		// responseNode.get("status").asText().equals("cancelled")) {
		// // 결제 취소 성공 시 주문 삭제 처리
		// orderService.deleteOrder(orders_id);
		// return "redirect:/order/accept.do?success=OrderAndPaymentCancelled";
		// } else {
		// // 결제 취소 실패 시 처리
		// return "redirect:/order/accept.do?error=PaymentCancelFailed";
		// }
		// } catch (IOException e) {
		// e.printStackTrace();
		// return "redirect:/order/accept.do?error=PaymentCancelError";
		// }
		// 결제 취소 성공 시 주문 삭제 처리
		orderService.deleteOrder(orders_id);
		return "redirect:/order/accept.do";
	}

	// 완료한 주문 내역
	@GetMapping("complete.do")
	public String getCompleteOrderList(Model model) {
		// 세션에서 가게 정보를 가져옴
		HttpSession session = request.getSession();
		OwnerVo user = (OwnerVo) session.getAttribute("user");

		// 가계 정보가 없는 경우
		if (user == null) {
			return "redirect:/login_form.do";
		}

		int owner_id = user.getOwner_id();

		List<OrderVo> orders = orderService.getCompleteOrderList(owner_id, "주문 대기");

		if (orders == null || orders.isEmpty()) {
			model.addAttribute("message", "완료된 주문이 없습니다.");
		} else {
			model.addAttribute("orders", orders);
		}

		return "order/order_complete_list";
	}

}
