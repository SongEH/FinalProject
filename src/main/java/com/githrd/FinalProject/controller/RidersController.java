package com.githrd.FinalProject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.githrd.FinalProject.dao.RidersMapper;
import com.githrd.FinalProject.vo.RidersVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/riders/")
public class RidersController {

	// 자동연결(요청시 마다 Injection)
	@Autowired
	HttpServletRequest request;

	@Autowired
	HttpSession session;

	@Autowired
	RidersMapper ridersMapper;

	// 회원 조회
	@RequestMapping("list.do")
	public String list(Model model) {
		List<RidersVo> list = ridersMapper.selectList();
		model.addAttribute("list", list);
		return "riders/riders_list";
	}

	// 회원가입 폼
	@RequestMapping("insert_form.do")
	public String insert_form() {
		return "riders/riders_insert_form";
	}

	// 회원가입
	@RequestMapping("insert.do")
	public String insert(RidersVo vo) {
		ridersMapper.insert(vo);

		return "redirect:login_form.do";
	}

	// 로그인 폼
	@RequestMapping("login_form.do")
	public String login_form() {

		return "redirect:list.do";
		// return "riders/riders_insert_form5";
	}

	// 로그인
	@RequestMapping("login.do")
	public String login(String riders_email, String riders_pwd, String url, RedirectAttributes ra) {

		RidersVo user = ridersMapper.selectOneFromEmail(riders_email);

		if (user == null) {
			ra.addAttribute("reason", "fail_id");

			return "redirect:riders/list.do";
		}

		if (user.getRiders_pwd().equals(riders_pwd) == false) {
			ra.addAttribute("reason", "fail_pwd");
			ra.addAttribute("riders_email", riders_email);

			return "redirect:list.do";
		}

		session.setAttribute("user", user);
		session.setAttribute("isLoggedIn", true);

		return "riders/riders_insert_form5";

	}

	// 로그아웃
	@RequestMapping("logout.do")
	public String logout() {

		session.removeAttribute("user");

		return "redirect:list.do";
	}

	@RequestMapping("mypage.do")
	public String showMyPage(RidersVo vo, Model model) {
		RidersVo user = (RidersVo) session.getAttribute("user");
		if (user == null) {

			return "redirect:login_form.do";

		}
		RidersVo riders = ridersMapper.selectOneFromId(user.getRiders_id());
		model.addAttribute("vo", riders);
		// 다른 데이터 모델 추가
		return "riders/riders_mypage";
	}

	// 마이페이지에서 회원 수정폼 띄우기
	@RequestMapping("mypage/modify_form.do")
	public String myPageUpdateForm(int riders_id, Model model) {

		RidersVo vo = ridersMapper.selectOneFromId(riders_id);
		// RidersVo user = (RidersVo) session.getAttribute("user");
		// if (user == null) {
		// return "redirect:login_form.do";
		// }
		// // 로그인한 유저의 정보를 가져옴
		// RidersVo riders = ridersMapper.selectOneFromId(user.getRiders_id());
		model.addAttribute("vo", vo);
		return "riders/riders_mypage_modify"; // 수정 폼 JSP 페이지
	}

	// 회원정보 수정을 처리하는 메소드
	@RequestMapping("mypage/modify.do")
	public String myPageUpdate(RidersVo vo) {
		// 회원 정보 업데이트
		ridersMapper.update(vo);
		RidersVo loginUser = (RidersVo) session.getAttribute("user");

		if (loginUser.getRiders_id() == vo.getRiders_id()) {

			// 로그인상태정보
			RidersVo user = ridersMapper.selectOneFromId(vo.getRiders_id());

			// session.removeAttribute("user");
			// scope내에 저장방식 Map형식: key / value
			// 동일한 key로 저장하면 수정처리된다
			session.setAttribute("user", user);
		}
		return "redirect:../mypage.do"; // 수정 후 마이페이지로 리다이렉트
	}

	// 마이페이지에서 회원 탈퇴
	@RequestMapping("mypage/delete.do")
	public String myPageDelete(@RequestParam("riders_id") int riders_id, RedirectAttributes ra) {
		ridersMapper.delete(riders_id);
		session.invalidate(); // 세션 무호화 -> 사용자가 탈퇴할 때 세션에 저장된 정보가 더이상 유효하지 않기에 세션을
		// 무효화 시켜야 한다
		return "redirect:../list.do";
	}

}
