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

	// /menu/list.do
	// /menu/list.do?page=2
	@RequestMapping("list.do")
	public String list(@RequestParam(name = "page", defaultValue = "1") int nowPage,
			Model model) {

		// 게시물의 범위 계산(start/end)
		// int start = (nowPage - 1) * MyCommon.Menu.BLOCK_LIST + 1;
		// int end = start + MyCommon.Menu.BLOCK_LIST - 1;

		// Map<String, Object> map = new HashMap<String, Object>();
		// map.put("start", start);
		// map.put("end", end);

		// // 페이징된 리스트를 가져온다
		// List<CartsVo> list = carts_mapper.selectPageList(map);

		List<CartsVo> list = carts_mapper.selectList();

		// 전체 게시물수
		int rowTotal = carts_mapper.selectRowTotal();

		System.out.println(rowTotal);
		System.out.println(list);

		// pageMenu만들기
		// String pageMenu = Paging.getPaging("list.do", // pageURL
		// nowPage, // 현재페이지
		// rowTotal, // 전체게시물수
		// MyCommon.Menu.BLOCK_LIST, // 한화면에 보여질 게시물수
		// MyCommon.Menu.BLOCK_PAGE); // 한화면에 보여질 페이지수

		// 결과적으로 request binding
		model.addAttribute("list", list);
		// model.addAttribute("pageMenu", pageMenu);

		return "carts/carts_list";
	}

	// 장바구니에 메뉴 추가
	// 요청 Parameter이름과 받는 변수명이 동일하면 @RequestParam(name="")의 name속성은 생략가능

	@RequestMapping("insert.do")
	public String insert(
			@RequestParam("menu_id") int menuId,
			@RequestParam("shop_id") int shopId,
			@RequestParam("carts_quantity") int quantity) {

		CartsVo vo = new CartsVo();
		vo.setCarts_quantity(quantity);
		vo.setMember_id(98); // 현재 로그인한 사용자 id 가져오기
		vo.setMenu_id(menuId);
		vo.setShop_id(shopId); // 현재 선택한 가게 id 가져오기

		System.out.println("Menu ID: " + vo.getMenu_id());
		System.out.println("Shop ID: " + vo.getShop_id());
		System.out.println("Quantity: " + vo.getCarts_quantity());

		carts_mapper.insert(vo);

		return "redirect:list.do";
	}

	// 수정
	// /carts/modify.do?carts_id=9&carts_quantity=5
	@PostMapping("modify.do")
	public String modify(int carts_id, int carts_quantity, RedirectAttributes ra) {

		System.out.println("수정!!!!" + carts_id + " " + carts_quantity);
		
		int res = carts_mapper.update(carts_id, carts_quantity);

		// ra.addAttribute("page", page);

		return "redirect:list.do";
	}

	// 삭제
	// /carts/delete.do?carts_id=5
	// /carts/delete.do?carts_id=5&page=2
	@RequestMapping("delete.do")
	public String delete(int carts_id, RedirectAttributes ra) {

		// CartsVo 정보 얻어온다
		CartsVo vo = carts_mapper.selectOne(carts_id);

		// DB delete
		int res = carts_mapper.delete(carts_id);

		// ra.addAttribute("page", page);

		return "redirect:list.do";

	}
}
