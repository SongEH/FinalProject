package first.final_project.controller;

import java.util.List;

import org.apache.http.HttpStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import first.final_project.dao.CartsMapper;
import first.final_project.vo.CartsVo;
import first.final_project.vo.MemberVo;
import first.final_project.vo.ShopVo;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/carts/")
public class CartsController {

	@Autowired
	CartsMapper carts_mapper;

	@Autowired
	HttpServletRequest request;

	@Autowired
	HttpSession session;

	@Autowired
	ServletContext application;

	// 장바구니 목록
	@RequestMapping("list.do")
	public String list(@RequestParam(name = "page", defaultValue = "1") int nowPage,
			Model model) {

		MemberVo user = (MemberVo) session.getAttribute("user");
		int member_id = user.getMember_id();

		List<CartsVo> list = carts_mapper.selectList(member_id);
		System.out.println(list);

		// request binding
		model.addAttribute("list", list);

		return "carts/carts_list";
	}

	// 회원용 shop_listOne.jsp 에서 보여질 장바구니 목록
	@RequestMapping("list2.do")
	public String list2(@RequestParam(name = "page", defaultValue = "1") int nowPage,
	@RequestParam(name="status", required = false) String status,	
	Model model) {

		MemberVo user = (MemberVo) session.getAttribute("user");

		int member_id = user.getMember_id();

		List<CartsVo> list = carts_mapper.selectList(member_id);
		System.out.println("장바구니목록\n" + list);

		// request binding
		model.addAttribute("list", list);

		return "carts/carts_display"; // 반환할 뷰 이름

	}

	// 장바구니에 메뉴 추가
	// 요청 Parameter이름과 받는 변수명이 동일하면 @RequestParam(name="")의 name속성은 생략가능
	@RequestMapping("insert.do")
	public String insert(
			@RequestParam("menu_id") int menu_id,
			@RequestParam("shop_id") int shop_id,
			@RequestParam("carts_quantity") int carts_quantity) {

		MemberVo user = (MemberVo) session.getAttribute("user");
		int member_id = user.getMember_id();

		CartsVo existingItem = carts_mapper.findByMenuId(member_id, shop_id, menu_id);

		if (existingItem != null) {

			// 동일 메뉴면 수량만 업데이트
			existingItem.setCarts_quantity(existingItem.getCarts_quantity() + carts_quantity);

			carts_mapper.update(existingItem.getCarts_id(), existingItem.getCarts_quantity());

		} else {
			CartsVo vo = new CartsVo();
			vo.setCarts_quantity(carts_quantity);
			vo.setMember_id(member_id);
			vo.setMenu_id(menu_id);
			vo.setShop_id(shop_id);
			carts_mapper.insert(vo);
		}

		return "redirect:list.do";
	}

	// 수정
	@PostMapping("modify.do")
	public String modify(int carts_id, int carts_quantity, RedirectAttributes ra) {
		carts_mapper.update(carts_id, carts_quantity);

		return "redirect:list.do";
	}

	// 삭제
	@RequestMapping("delete.do")
	public String delete(int carts_id, RedirectAttributes ra) {

		// CartsVo 정보 얻어온다
		CartsVo vo = carts_mapper.selectOne(carts_id);

		carts_mapper.delete(carts_id);

		return "redirect:list.do";

	}

	// carts_display.jsp에서 호출
	// @RequestMapping("delete2.do")
	// public void delete2(@RequestParam("carts_id") int carts_id,
	// RedirectAttributes ra) {
	// System.out.println("delete2.do 호출\n\n");

	// // CartsVo 정보 얻어온다
	// CartsVo vo = carts_mapper.selectOne(carts_id);

	// if (vo != null) {
	// carts_mapper.delete(carts_id);
	// System.out.println("삭제완\n\n");
	// ra.addFlashAttribute("message", "장바구니 항목이 삭제되었습니다.");
	// } else {
	// ra.addFlashAttribute("error", "해당 항목을 찾을 수 없습니다.");
	// }

	// // return "redirect:/main/display.do"; // 적절한 리디렉션 URL

	// // String referer = request.getHeader("Referer");
	// // return "redirect:" + referer;
	// }

	@GetMapping("delete2.do")
	@ResponseBody // JSON 응답을 반환
	public ResponseEntity<String> deleteCartItem(@RequestParam("carts_id") int cartsId) {
		CartsVo vo = carts_mapper.selectOne(cartsId);

		if (vo != null) {
			carts_mapper.delete(cartsId);
			return ResponseEntity.ok("삭제되었습니다.");
		} else {
			return ResponseEntity.status(HttpStatus.SC_NOT_FOUND).body("해당 항목을 찾을 수 없습니다.");
		}
		
	}
	
}
