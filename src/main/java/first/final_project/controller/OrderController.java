package first.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import first.final_project.dao.AddrMapper;
import first.final_project.dao.CartsMapper;
import first.final_project.dao.OrderMapper;
import first.final_project.vo.AddrVo;
import first.final_project.vo.CartsVo;
import first.final_project.vo.MemberVo;
import first.final_project.vo.MenuVo;
import first.final_project.vo.OrderVo;
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
	HttpServletRequest request;

	@Autowired
	HttpSession session;

	@Autowired
	ServletContext application;

	// /menu/list.do
	// /menu/list.do?page=2
	// 주문 내역 확인
	@RequestMapping("list.do")
	public String list(@RequestParam(name = "page", defaultValue = "1") int nowPage,
			Model model) {

		MemberVo user = (MemberVo) session.getAttribute("user");

		List<OrderVo> list = order_mapper.selectList(user.getMember_id());

		// 전체 게시물수
		// int rowTotal = order_mapper.selectRowTotal();

		// System.out.println(rowTotal);
		System.out.println(list);

		// 결과적으로 request binding
		model.addAttribute("list", list);

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
		// 1. 현재 로그인한 사용자의 주소목록을 가져옴
		List<AddrVo> addr_list = addr_mapper.selectList(user.getMember_id());
		model.addAttribute("addr_list", addr_list);

		// 2. 등록된 주소 이외의 추가 주소정보 등록

		return "order/order_pending_list";
	}

	@RequestMapping(value = "order_show.do")
	public String order_show(int orders_id, Model model) {

		// 주문 1건 조회
		OrderVo vo = order_mapper.selectOne(orders_id);

		// 주문ID를 가진 장바구니 목록
		List<CartsVo> list = carts_mapper.selectOrdersById(orders_id);

		System.out.println(list);
		model.addAttribute("vo", vo);
		model.addAttribute("list", list);

		return "order/order_show";

		// VO -> JSON객체 생성
		// JSONObject json = new JSONObject();
		// json.put("p_idx", vo.getP_idx());
		// json.put("p_title", vo.getP_title());
		// json.put("p_content", vo.getP_content());
		// json.put("p_filename", vo.getP_filename());
		// json.put("p_regdate", vo.getP_regdate());
		// json.put("p_ip", vo.getP_ip());
		// json.put("mem_idx", vo.getMem_idx());
		// json.put("mem_name", vo.getMem_name());

		// return json.toString();
	}

	// 주문
	// @RequestMapping("insert.do")
	// public String insert(OrderVo vo) {

	// String orders_drequest = vo.getOrders_drequest().replaceAll("\n", "<br>");
	// vo.setOrders_drequest(orders_drequest);

	// String orders_srequest = vo.getOrders_srequest().replaceAll("\n", "<br>");
	// vo.setOrders_srequest(orders_srequest);

	// // 아래 수동 setting 한건 추후 수정해야됨
	// vo.setOrders_name("주문테스트");
	// vo.setShop_id(1);
	// vo.setOrders_price(100000);
	// vo.setShop_name("맛집1");
	// vo.setAddr_id(99); // 주소 기능 구현완료 되면 추가하기

	// // 현재 로그인한 사용자
	// MemberVo user = (MemberVo) session.getAttribute("user");
	// vo.setMember_id(user.getMember_id());

	// System.out.println(vo);

	// // DB insert
	// int res = order_mapper.insert(vo);

	// return "redirect:list.do";
	// }

}