package first.final_project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import first.final_project.dao.CartsMapper;
import first.final_project.util.MyCommon;
import first.final_project.util.Paging;
import first.final_project.vo.CartsVo;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/order/")
public class OrderController {

	@Autowired
	CartsMapper carts_mapper;

	@Autowired
	HttpServletRequest request;

	@Autowired
	HttpSession session;

	@Autowired
	ServletContext application;

	// /menu/list.do
	// /menu/list.do?page=2
	// @RequestMapping("list.do")
	// public String list(@RequestParam(name = "page", defaultValue = "1") int
	// nowPage,
	// Model model) {

	// List<CartsVo> list = carts_mapper.selectList();

	// // 전체 게시물수
	// int rowTotal = carts_mapper.selectRowTotal();

	// System.out.println(rowTotal);
	// System.out.println(list);

	// // 결과적으로 request binding
	// model.addAttribute("list", list);

	// return "carts/carts_list";
	// }

	// 주문대기 (주문 전)
	@RequestMapping("pending_order.do")
	public String insert(
			@RequestParam("shop_id") int shop_id,  Model model) {

		int member_id = 98;

		// 장바구니 테이블에서 => 가게ID와 + 현재 사용자ID와 + orderID가 없는 것을 조회

		// 리스트로 반환
		List<CartsVo> list = carts_mapper.findPendingOrders(member_id, shop_id);

		System.out.println(list);

		// request binding
		model.addAttribute("list", list);

		return "order/order_pending_list";
	}

	// // 수정
	// // /carts/modify.do?carts_id=9&carts_quantity=5
	// @PostMapping("modify.do")
	// public String modify(int carts_id, int carts_quantity, RedirectAttributes ra)
	// {

	// System.out.println("수정!!!!" + carts_id + " " + carts_quantity);

	// int res = carts_mapper.update(carts_id, carts_quantity);

	// // ra.addAttribute("page", page);

	// return "redirect:list.do";
	// }

	// // 삭제
	// // /carts/delete.do?carts_id=5
	// // /carts/delete.do?carts_id=5&page=2
	// @RequestMapping("delete.do")
	// public String delete(int carts_id, RedirectAttributes ra) {

	// // CartsVo 정보 얻어온다
	// CartsVo vo = carts_mapper.selectOne(carts_id);

	// // DB delete
	// int res = carts_mapper.delete(carts_id);

	// // ra.addAttribute("page", page);

	// return "redirect:list.do";

	// }
}
