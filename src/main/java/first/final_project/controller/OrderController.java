package first.final_project.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import first.final_project.dao.AddrMapper;
import first.final_project.dao.CartsMapper;
import first.final_project.dao.OrderMapper;
import first.final_project.dao.ReviewsMapper;
import first.final_project.service.OrderService;
import first.final_project.vo.AddrVo;
import first.final_project.vo.CartsVo;
import first.final_project.vo.MemberVo;
import first.final_project.vo.MenuVo;
import first.final_project.vo.OrderVo;
import first.final_project.vo.ReviewsVo;
import first.final_project.vo.OwnerVo;
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

	// 페이징 처리 전
	// /menu/list.do
	// /menu/list.do?page=2
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
			Boolean result = reviews_mapper.checkReviewExists(vo.getOrders_id());
			boolean hasReview = (result != null) ? result : false;
			vo.setHasReview(hasReview);
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

	// 주문대기 (주문 전)
	@RequestMapping("pending_order.do")
	public String insert(int shop_id, String shop_name, Model model) {

		// 현재 로그인한 사용자
		MemberVo user = (MemberVo) session.getAttribute("user");

		// 장바구니 테이블에서 => 가게ID와 + 현재 사용자ID와 + orderID가 없는 것을 조회한 결과
		List<CartsVo> list = carts_mapper.findPendingOrders(user.getMember_id(), shop_id);

		// request binding
		model.addAttribute("list", list);
		model.addAttribute("user", user);
		model.addAttribute("shop_id", shop_id);
		model.addAttribute("shop_name", shop_name);

		// 주소 처리
		List<AddrVo> addr_list = addr_mapper.selectList(user.getMember_id());
		model.addAttribute("addr_list", addr_list);

		return "order/order_pending_list";
	}

	// 주문 상세보기
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

	// 주문 삭제 (소프트삭제)
	@RequestMapping(value = "delete.do")
	public String delete(int orders_id) {

		orderService.softDelete(orders_id);

		return "redirect:list.do";
	}

	// 은호님 추가
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

		List<OrderVo> orders = orderService.getAcceptOrderList(owner_id, "주문 대기");

		if (orders == null || orders.isEmpty()) {
			model.addAttribute("message", "현재 진행 중인 주문이 없습니다.");
		} else {
			model.addAttribute("orders", orders);
		}

		return "order/order_accept_list";
	}

	@GetMapping("accept")
	public String acceptOrderList(@RequestParam("orders_id") int orders_id) {
		// 주문 상태를 '배차 대기'로 변경
		orderService.updateOrderStatus(orders_id, "배차 대기");
		// WebSocket을 통해 라이더에게 메시지 전송
		messagingTemplate.convertAndSend("/topic/orders", "주문 정보가 업데이트되었습니다.");
		return "redirect:/order/accept.do";
	}

	@GetMapping("startCooking")
	public String startCooking(@RequestParam("orders_id") int orders_id) {
		// 주문 상태를 '조리 중'로 변경
		orderService.updateOrderStatus(orders_id, "조리 중");
		// WebSocket을 통해 라이더에게 메시지 전송
		messagingTemplate.convertAndSend("/topic/orders", "주문 정보가 업데이트되었습니다.");
		return "redirect:/order/accept.do";
	}

	@GetMapping("endCooking")
	public String endCooking(@RequestParam("orders_id") int orders_id) {
		// 주문 상태를 '픽업 대기'로 변경
		orderService.updateOrderStatus(orders_id, "픽업 대기");
		// WebSocket을 통해 라이더에게 메시지 전송
		messagingTemplate.convertAndSend("/topic/orders", "주문 정보가 업데이트되었습니다.");
		return "redirect:/order/accept.do";
	}

	@GetMapping("cancel")
	public String deleteOrder(@RequestParam("orders_id") int orders_id) {
		// 주문 삭제하기
		orderService.deleteOrder(orders_id);
		return "redirect:/order/accept.do";
	}

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
