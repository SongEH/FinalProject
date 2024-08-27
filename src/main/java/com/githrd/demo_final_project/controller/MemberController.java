package com.githrd.demo_final_project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.githrd.demo_final_project.dao.MemberMapper;
import com.githrd.demo_final_project.vo.MemberVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member/")
public class MemberController {

	// 자동연결(요청시 마다 Injection)
	@Autowired
	HttpServletRequest request;

	@Autowired
	HttpSession session;

	// 처음에 1회연결
	@Autowired
	MemberMapper member_mapper;

	public MemberController() {
		System.out.println("--MemberController()--");
	}

	// 회원전체목록
	@RequestMapping("list.do")
	public String list(Model model) {

		List<MemberVo> list = member_mapper.selectList();

		model.addAttribute("list", list);

		return "member/member_list";
	}

	// 회원가입폼
	@RequestMapping("insert_form.do")
	public String insert_form() {

		return "member/member_insert_form";
	}

	// /member/check_id.do?mem_id=one
	// 아이디 중복체크
	@RequestMapping(value = "check_id.do")
	@ResponseBody
	public Map<String, Boolean> check_id(String mem_id) {

		MemberVo vo = member_mapper.selectOneFromId(mem_id);

		boolean bResult = (vo == null);

		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("result", bResult); // {"result" : true}

		return map;
	}

	// /member/insert.do?mem_name=홍길동&mem_id=hong&mem_pwd=1234&mem_zipcode=08768&mem_addr=서울+관악구+남부순환로+1357
	// 회원가입
	@RequestMapping("insert.do")
	public String insert(MemberVo vo) {

		String mem_ip = request.getRemoteAddr();
		vo.setMem_ip(mem_ip);

		int res = member_mapper.insert(vo);

		return "redirect:login_form.do";
	}

	// class RequestMapping + method RequestMapping => /member/login_form.do
	@RequestMapping("login_form.do")
	public String login_form() {

		return "member/member_login_form";
	}

	// /member/login.do?mem_id=one&mem_pwd=1234
	@RequestMapping("login.do")
	public String login(String mem_id, String mem_pwd, RedirectAttributes ra) {

		MemberVo user = member_mapper.selectOneFromId(mem_id);

		if (user == null) {

			// RedirectAttributes=> redirect시 parameter로 이용된다
			ra.addAttribute("reason", "fail_id");

			return "redirect:login_form.do";
		}

		// 비밀번호가 틀린경우
		if (user.getMem_pwd().equals(mem_pwd) == false) {

			// response.sendRedirect("login_form.do?reason=fail_pwd&mem_id=" + mem_id);
			// RedirectAttributes=> redirect시 parameter로 이용된다
			ra.addAttribute("reason", "fail_pwd");
			ra.addAttribute("mem_id", mem_id);

			return "redirect:login_form.do";
		}

		// 로그인처리: 현재 로그인된 객체(user)정보를 session저장
		session.setAttribute("user", user);

		return "redirect:../menu/list.do";
	}

	// 로그아웃
	@RequestMapping("logout.do")
	public String logout() {

		session.removeAttribute("user");

		return "redirect:../menu/list.do";
	}

	// 회원삭제
	// /member/delete.do?mem_idx=3
	@RequestMapping("delete.do")
	public String delete(int mem_idx, RedirectAttributes ra) {

		MemberVo user = (MemberVo) session.getAttribute("user");

		// 로그인 유저가 일반유저면 로그인정보 삭제
		if (user.getMem_grade().equals("일반")) {
			session.removeAttribute("user");
		}

		if (user.getMem_grade().equals("관리자") && user.getMem_idx() == mem_idx) {

			// response.sendRedirect("list.do?reason=not_admin_delete");
			ra.addAttribute("reason", "not_admin_delete");
			return "redirect:list.do";
		}

		// 3.DB delete : delete from member where mem_idx=?

		int res = member_mapper.delete(mem_idx);

		return "redirect:list.do";
	}

	// 수정폼 띄우기
	@RequestMapping("modify_form.do")
	public String modify_form(int mem_idx, Model model) {

		MemberVo vo = member_mapper.selectOneFromIdx(mem_idx);

		model.addAttribute("vo", vo);

		return "member/member_modify_form";
	}

	// 수정하기
	@RequestMapping("modify.do")
	public String modify(MemberVo vo) {

		String mem_ip = request.getRemoteAddr();
		vo.setMem_ip(mem_ip);

		int res = member_mapper.update(vo);

		MemberVo loginUser = (MemberVo) session.getAttribute("user");

		// 현재수정정보가 로그인한 유저 본인인경우
		if (loginUser.getMem_idx() == vo.getMem_idx()) {

			// 로그인상태정보
			MemberVo user = member_mapper.selectOneFromIdx(vo.getMem_idx());

			// session.removeAttribute("user");
			// scope내에 저장방식 Map형식: key / value
			// 동일한 key로 저장하면 수정처리된다
			session.setAttribute("user", user);
		}

		return "redirect:../photo/list.do";
	}

}
