package com.githrd.finalproject.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.githrd.finalproject.dao.MemberMapper;
import com.githrd.finalproject.vo.MemberVo;

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

    @Autowired
    MemberMapper memberMapper;

    // 회원 조회
    @RequestMapping("list.do")
    public String list(Model model) {
        List<MemberVo> list = memberMapper.selectList();
        model.addAttribute("list", list);
        return "member/member_list";
    }

    // 회원가입 폼
    @RequestMapping("insert_form.do")
    public String insert_form() {
        return "member/member_insert_form";
    }

    // 회원가입
    @RequestMapping("insert.do")
    public String insert(MemberVo vo) {
        memberMapper.insert(vo);

        session.setAttribute("vo", vo);

        return "redirect:login_form.do";
    }

    // 아이디 중복 체크
    @RequestMapping("check_id.do")
    @ResponseBody
    public Map<String, Boolean> check_id(@RequestParam("member_accountId") String member_accountId) {
        MemberVo vo = memberMapper.selectOneFromId(member_accountId);
        boolean bResult = (vo == null);
        Map<String, Boolean> map = new HashMap<>();
        map.put("result", bResult);
        return map;
    }

    // 닉네임 중복 체크
    @RequestMapping("check_nickname.do")
    @ResponseBody
    public Map<String, Boolean> check_nickname(@RequestParam("member_nickname") String member_nickname) {
        MemberVo vo = memberMapper.selectOneFromNickname(member_nickname);
        boolean bResult = (vo == null);
        Map<String, Boolean> map = new HashMap<>();
        map.put("result", bResult);
        return map;
    }

    // 로그인 폼
    @RequestMapping("login_form.do")
    public String login_form() {
        return "member/member_login_form";
    }

    // 로그인
    @RequestMapping("login.do")
    public String login(String member_accountId, String member_pwd, String url, RedirectAttributes ra) {

        MemberVo user = memberMapper.selectOneFromId(member_accountId);

        if (user == null) {
            ra.addAttribute("reason", "fail_id");

            return "redirect:login_form.do";
        }

        if (user.getMember_pwd().equals(member_pwd) == false) {
            ra.addAttribute("reason", "fail_pwd");
            ra.addAttribute("member_accountId", member_accountId);

            return "redirect:login_form.do";
        }

        session.setAttribute("user", user);
        session.setAttribute("isLoggedIn", true);

        if (url == null || url.isEmpty())
            return "redirect:../main.do";
        else
            return "redirect:" + url;
    }

    // 로그아웃
    @RequestMapping("logout.do")
    public String logout() {

        session.removeAttribute("user");

        return "redirect:../main.do";
    }

    // 마이페이지
    @RequestMapping("mypage.do")
    public String showMyPage(MemberVo vo, Model model) {
        MemberVo user = (MemberVo) session.getAttribute("user");
        if (user == null) {
            return "redirect:login_form.do";
        }
        MemberVo member = memberMapper.selectOneFromIdx(user.getMember_id());
        model.addAttribute("member", member);
        // 다른 데이터 모델 추가
        return "member/member_mypage";
    }

    // 마이페이지에서 회원 수정폼 띄우기
    @RequestMapping(value = "mypage/modify_form.do", method = RequestMethod.GET)
    public String myPageEditForm(Model model) {
        MemberVo user = (MemberVo) session.getAttribute("user");
        if (user == null) {
            return "redirect:login_form.do";
        }
        // 로그인한 유저의 정보를 가져옴
        MemberVo member = memberMapper.selectOneFromIdx(user.getMember_id());
        model.addAttribute("member", member);
        return "member/mypage_modify"; // 수정 폼 JSP 페이지
    }

    // 회원정보 수정을 처리하는 메소드
    @RequestMapping(value = "mypage/modify.do", method = RequestMethod.POST)
    public String myPageEdit(MemberVo vo) {
        // 회원 정보 업데이트
        memberMapper.update(vo);

        // 세션의 사용자 정보도 업데이트
        session.setAttribute("user", vo);

        return "redirect:mypage.do"; // 수정 후 마이페이지로 리다이렉트
    }

    // 마이페이지에서 회원 탈퇴
    @RequestMapping(value = "mypage/delete.do", method = RequestMethod.POST)
    public String myPageDelete(@RequestParam int member_id) {
        memberMapper.delete(member_id);
        session.invalidate(); // 세션 무호화 -> 사용자가 탈퇴할 때 세션에 저장된 정보가 더이상 유효하지 않기에 세션을 무효화 시켜야 한다
        return "redirect:../main.do";
    }

}
