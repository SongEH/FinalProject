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
import first.final_project.util.MyCommon;
import first.final_project.util.Paging;
import first.final_project.vo.MenuVo;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/menu/")
public class MenuController {

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
	@RequestMapping("list.do")
	public String list(@RequestParam(name = "page", defaultValue = "1") int nowPage,
			Model model) {

		// 게시물의 범위 계산(start/end)
		int start = (nowPage - 1) * MyCommon.Menu.BLOCK_LIST + 1;
		int end = start + MyCommon.Menu.BLOCK_LIST - 1;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);

		// 페이징된 리스트를 가져온다
		List<MenuVo> list = menu_mapper.selectPageList(map);

		// 전체 게시물수
		int rowTotal = menu_mapper.selectRowTotal();

		// pageMenu만들기
		String pageMenu = Paging.getPaging("list.do", // pageURL
				nowPage, // 현재페이지
				rowTotal, // 전체게시물수
				MyCommon.Menu.BLOCK_LIST, // 한화면에 보여질 게시물수
				MyCommon.Menu.BLOCK_PAGE); // 한화면에 보여질 페이지수

		// 결과적으로 request binding
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);

		return "menu/menu_list";
	}

	// 메뉴 등록 폼 띄우기
	@RequestMapping("insert_form.do")
	public String insert_form() {

		return "menu/menu_insert_form";
	}

	// 메뉴등록
	// 요청 Parameter이름과 받는 변수명이 동일하면 @RequestParam(name="")의 name속성은 생략가능
	@RequestMapping("insert.do")
	public String insert(MenuVo vo,
			@RequestParam(name = "photo") MultipartFile photo,
			RedirectAttributes ra) throws Exception, IOException {

		// 세션에서 가져오기....
		// MemberVo user = (MemberVo) session.getAttribute("user");

		// session timeout
		// if (user == null) {

		// // response.sendRedirect("../member/login_form.do?reason=session_timeout");
		// ra.addAttribute("reason", "session_timeout");
		// return "redirect:../member/login_form.do";
		// }

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
		vo.setShop_id(99);

		// DB insert
		int res = menu_mapper.insert(vo);

		return "redirect:list.do";
	}

	// /photo/photo_one.do?p_idx=5
	@RequestMapping(value = "menu_one.do")
	@ResponseBody // 현재 반환값을 응답데이터를 이용해라
	public MenuVo menu_one(int menu_id) {

		MenuVo vo = menu_mapper.selectOne(menu_id);

		return vo;
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
	// /photo/photo_upload.do?p_idx=5&photo=aaa.jpg
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

		// p_idx에 저장된 이전화일 삭제
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
	// /photo/modify.do?p_idx=9&p_title=노트북&p_content=복사본
	@RequestMapping("modify.do")
	public String modify(MenuVo vo, RedirectAttributes ra) {

		String menu_content = vo.getMenu_content().replaceAll("\n", "<br>");
		vo.setMenu_content(menu_content);

		int res = menu_mapper.update(vo);

		// ra.addAttribute("page", page);

		return "redirect:list.do";
	}

	// 삭제
	// /photo/delete.do?p_idx=5&page=2
	@RequestMapping("delete.do")
	public String delete(int menu_id, RedirectAttributes ra) {

		// 현재 p_idx가 사용하고 있는 화일도 삭제
		// 2.PhotoVo정보 얻어온다
		MenuVo vo = menu_mapper.selectOne(menu_id);
		// /images/의 절대경로
		String absPath = application.getRealPath("/resources/images/");
		// 절대경로 (삭제)파일명
		File delFile = new File(absPath, vo.getMenu_img());

		delFile.delete();

		// DB delete
		int res = menu_mapper.delete(menu_id);

		// ra.addAttribute("page", page);

		return "redirect:list.do";
	}
}
