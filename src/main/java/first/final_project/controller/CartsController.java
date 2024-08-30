package first.final_project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import first.final_project.dao.MenuMapper;
import first.final_project.vo.CartsVo;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/carts/")
public class CartsController {

	@Autowired
	MenuMapper menu_mapper;

	@Autowired
	HttpServletRequest request;

	@Autowired
	HttpSession session;

	@Autowired
	ServletContext application;

	// /menu/list.do
	// /menu/list.do?page=2

	// @RequestMapping("list.do")
	// public String list(@RequestParam(name = "page", defaultValue = "1") int nowPage,
	// 		Model model) {

	// 	// // 게시물의 범위 계산(start/end)
	// 	// int start = (nowPage - 1) * MyCommon.Menu.BLOCK_LIST + 1;
	// 	// int end = start + MyCommon.Menu.BLOCK_LIST - 1;

	// 	// Map<String, Object> map = new HashMap<String, Object>();
	// 	// map.put("start", start);
	// 	// map.put("end", end);

	// 	// // 페이징된 리스트를 가져온다
	// 	// List<MenuVo> list = menu_mapper.selectPageList(map);

	// 	// // 전체 게시물수
	// 	// int rowTotal = menu_mapper.selectRowTotal();

	// 	// // pageMenu만들기
	// 	// String pageMenu = Paging.getPaging("list.do", // pageURL
	// 	// 		nowPage, // 현재페이지
	// 	// 		rowTotal, // 전체게시물수
	// 	// 		MyCommon.Menu.BLOCK_LIST, // 한화면에 보여질 게시물수
	// 	// 		MyCommon.Menu.BLOCK_PAGE); // 한화면에 보여질 페이지수

	// 	// // 결과적으로 request binding
	// 	// model.addAttribute("list", list);
	// 	// model.addAttribute("pageMenu", pageMenu);

	// 	// return "menu/menu_list";
	// }


	// 장바구니에 메뉴 추가 
	// 요청 Parameter이름과 받는 변수명이 동일하면 @RequestParam(name="")의 name속성은 생략가능
	
	@RequestMapping("insert.do")
    public void insert(
		@RequestParam("menu_id") int menuId,
        @RequestParam("shop_id") int shopId,
        @RequestParam("quantity") int quantity) {

        CartsVo vo = new CartsVo();
		vo.setCartsQuantity(quantity);
		vo.setMemberId(98);
		vo.setMenuId(menuId);
		vo.setShopId(shopId);
 
		System.out.println("Menu ID: " + vo.getMenuId());
        System.out.println("Shop ID: " + vo.getShopId());
        System.out.println("Quantity: " + vo.getCartsQuantity());

		}
	// 	// cats 매퍼 만들고 DAO 만들기 
	// 	int res = carts_mapper.insert(vo);

	// 	return "redirect:list.do";
	// }



	// // 수정
	// // /photo/modify.do?p_idx=9&p_title=노트북&p_content=복사본
	// @RequestMapping("modify.do")
	// public String modify(MenuVo vo, RedirectAttributes ra) {

	// 	String menu_content = vo.getMenu_content().replaceAll("\n", "<br>");
	// 	vo.setMenu_content(menu_content);

	// 	int res = menu_mapper.update(vo);

	// 	// ra.addAttribute("page", page);

	// 	return "redirect:list.do";
	// }

	// // 삭제
	// // /photo/delete.do?p_idx=5&page=2
	// @RequestMapping("delete.do")
	// public String delete(int menu_id, RedirectAttributes ra) {

	// 	// 현재 p_idx가 사용하고 있는 화일도 삭제
	// 	// 2.PhotoVo정보 얻어온다
	// 	MenuVo vo = menu_mapper.selectOne(menu_id);
	// 	// /images/의 절대경로
	// 	String absPath = application.getRealPath("/resources/images/");
	// 	// 절대경로 (삭제)파일명
	// 	File delFile = new File(absPath, vo.getMenu_img());

	// 	delFile.delete();

	// 	// DB delete
	// 	int res = menu_mapper.delete(menu_id);

	// 	// ra.addAttribute("page", page);

	// 	return "redirect:list.do";
	// }
}
