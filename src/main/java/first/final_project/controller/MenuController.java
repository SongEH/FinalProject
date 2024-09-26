package first.final_project.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import first.final_project.dao.MenuMapper;
import first.final_project.dao.ShopMapper;
import first.final_project.service.ShopService;
import first.final_project.vo.MemberVo;
import first.final_project.vo.MenuVo;
import first.final_project.vo.OwnerVo;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/menu/")
public class MenuController {

	@Autowired
	MenuMapper menu_mapper;

	@Autowired
	ShopMapper shop_mapper;

	@Autowired
	HttpServletRequest request;

	@Autowired
	HttpSession session;

	@Autowired
	ServletContext application;

	@Autowired
	ShopService shop_service;

	// 메뉴 목록
	@RequestMapping("list.do")
	public String list(Model model) {

		// Menu Vo에 가게 ID 부여 (현재 로그인된 사장의 가게ID 가져와서 등록)
		OwnerVo user = (OwnerVo) session.getAttribute("user");
		int owner_id = user.getOwner_id();
		int shop_id = shop_service.select_one_shop_id(owner_id);

		List<MenuVo> menu_list = menu_mapper.selectList(shop_id);

		// 결과적으로 request binding
		model.addAttribute("menu_list", menu_list);
		model.addAttribute("shop_id", shop_id);

		return "menu/menu_list";
	}


	// shop_id로 메뉴 목록 조회 
	@RequestMapping("listByShopId.do")
	public String listByShopId(int shop_id,
	@RequestParam(name="status", required = false)String status, Model model) {
		System.out.println("listbyShopid 도착");
		List<MenuVo> list = menu_mapper.selectList(shop_id);

		MemberVo user = (MemberVo) session.getAttribute("user");
		if(user!=null){
			session.setAttribute("userType", "MEMBER");
		}
		// model.addAttribute("list", list);
		// return "menu/menu_listByShopId";
		model.addAttribute("status", status);
		model.addAttribute("menu_list", list);
		return "menu/menu_list_display";

	}

	// 가게 메뉴목록 필터링(숨김, 품절, 인기) 
	@RequestMapping("menu_rank.do")
	public String menu_rank(int shop_id, Model model, String selectValue) {
		
		System.out.println("menu_rank 도착");

		// List<MenuVo> list = menu_mapper.selectList(shop_id);

		Map<String, Object> selectMap = new HashMap<String, Object>();
        selectMap.put("shop_id", shop_id);      
        selectMap.put("selectValue", selectValue); 

		List<MenuVo> menu_list = menu_mapper.selectListValue(selectMap);

		model.addAttribute("menu_list", menu_list);
		System.out.println("menu_list : \n" + menu_list);

		return "menu/menu_list_display";

	}

	// 메뉴 등록 폼 띄우기
	@RequestMapping("insert_form.do")
	public String insert_form() {

		return "menu/menu_insert_form";
	}
	
	// 메뉴 등록 
	@RequestMapping("insert.do")
	public String insert(MenuVo vo,
			@RequestParam(name = "photo") MultipartFile photo,
			RedirectAttributes ra) throws Exception, IOException {

		// 세션에서 가져옴
		OwnerVo user = (OwnerVo) session.getAttribute("user");

		// session timeout
		if (user == null) {
			// response.sendRedirect("../member/login_form.do?reason=session_timeout");
			ra.addAttribute("reason", "session_timeout");
			return "redirect:../member/login.do";
		}
		// owner_id 가져오기
		int owner_id = user.getOwner_id();
		System.out.println(owner_id);
		// owner_id로 shop_id 구하기
		int shop_id = shop_service.select_one_shop_id(owner_id);
		// 파일업로드
		String absPath = application.getRealPath("/resources/images/");

		String menu_img = "no_file";
		if (!photo.isEmpty()) {

			// 업로드 화일이름 얻어오기
			menu_img = photo.getOriginalFilename();

			File f = new File(absPath, menu_img);

			if (f.exists()) {
				// 저장경로에 동일한 화일이 존재하면=>다른이름을 화일명 변경
				// 변경화일명 = 시간_원래화일명
				long tm = System.currentTimeMillis();
				menu_img = String.format("%d_%s", tm, menu_img);

				f = new File(absPath, menu_img);
			}

			// 임시화일=>내가 지정한 위치로 복사
			photo.transferTo(f);

		}
		// 업로드된 화일이름
		vo.setMenu_img(menu_img);

		String menu_content = vo.getMenu_content().replaceAll("\n", "<br>");
		vo.setMenu_content(menu_content);

		// Menu Vo에 가게 ID 부여 (현재 로그인된 사장의 가게ID 가져와서 등록)
		// vo.setShop_id(user.getShop_id()); // 로그인된 계정이 사장계정이어야하고, 사장VO안에 ShopID가 있어야
		// 한다.
		System.out.println(shop_id);
		vo.setShop_id(shop_id);

		// DB insert
		int res = menu_mapper.insert(vo);

		return "redirect:list.do";
	}

	// 메뉴 하나 조회
	@RequestMapping(value = "menu_one.do")
	@ResponseBody // 반환 값을 응답데이터로 이용
	public MenuVo menu_one(int menu_id) {

		MenuVo vo = menu_mapper.selectOne(menu_id);

		return vo;

		// VO를 -> JSON 객체로 생성해서 반환
		// JSONObject json = new JSONObject();
		// json.put("menu_id", vo.getMenu_id());
		// ... 
		// return json.toString();
	}

	// 상세보기폼 띄우기
	@RequestMapping("show.do")
	public String show(int menu_id, Model model) {

		MenuVo vo = menu_mapper.selectOne(menu_id);

		// <br> -> "\n"
		String menu_content = vo.getMenu_content().replaceAll("<br>", "\n");
		vo.setMenu_content(menu_content);

		// model통한 request binding
		model.addAttribute("vo", vo);

		return "menu/menu_show";
	}

	// 수정폼 띄우기
	@RequestMapping("modify_form.do")
	public String modify_form(int menu_id, Model model) {

		MenuVo vo = menu_mapper.selectOne(menu_id);
		// <br> -> "\n"
		String menu_content = vo.getMenu_content().replaceAll("<br>", "\n");
		vo.setMenu_content(menu_content);

		// model통한 request binding
		model.addAttribute("vo", vo);

		return "menu/menu_modify_form";
	}

	// Ajax를 이용한 이미지 수정
	@RequestMapping(value = "photo_upload.do")
	@ResponseBody
	public Map<String, String> photo_upload(int menu_id,
			@RequestParam MultipartFile photo) throws Exception, IOException {

		String absPath = application.getRealPath("/resources/images/");
		String p_filename = "";
		if (!photo.isEmpty()) {

			// 업로드 화일이름 얻어오기
			p_filename = photo.getOriginalFilename();

			File f = new File(absPath, p_filename);

			if (f.exists()) {
				// 저장경로에 동일한 화일이 존재하면=>다른이름을 화일명 변경
				// 변경화일명 = 시간_원래화일명
				long tm = System.currentTimeMillis();
				p_filename = String.format("%d_%s", tm, p_filename);

				f = new File(absPath, p_filename);
			}
			// 임시화일=>내가 지정한 위치로 복사
			photo.transferTo(f);
		}

		// 이전화일 삭제
		MenuVo vo = menu_mapper.selectOne(menu_id);
		File delFile = new File(absPath, vo.getMenu_img());
		delFile.delete();

		// update된 화일이름 수정
		vo.setMenu_img(p_filename);
		int res = menu_mapper.updateFilename(vo);

		Map<String, String> map = new HashMap<String, String>();
		map.put("p_filename", p_filename);

		return map;

		// 변경화일명 JSON형식으로 반환
		// {"p_filename":"a.jpg"}
		// JSONObject json = new JSONObject();
		// json.put("p_filename", p_filename);
		// return json.toString();
	}

	// 수정
	@RequestMapping("modify.do")
	public String modify(MenuVo vo, RedirectAttributes ra) {

		String menu_content = vo.getMenu_content().replaceAll("\n", "<br>");
		vo.setMenu_content(menu_content);

		int res = menu_mapper.update(vo);

		return "redirect:list.do";
	}

	// 삭제
	@RequestMapping("delete.do")
	public String delete(int menu_id, RedirectAttributes ra) {

		// 현재 menu_id가 사용하고 있는 화일도 삭제
		MenuVo vo = menu_mapper.selectOne(menu_id);
		// /images/의 절대경로
		String absPath = application.getRealPath("/resources/images/");
		// 절대경로 (삭제)파일명
		File delFile = new File(absPath, vo.getMenu_img());

		delFile.delete();

		// DB delete
		int res = menu_mapper.delete(menu_id);

		return "redirect:list.do";
	}
}
