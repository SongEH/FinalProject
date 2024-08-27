package com.githrd.finalproject.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.security.SecurityProperties.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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

    // member/insert_form.do?member_accountId=&member_name=&member_nickname=&member_accountId=&member_pwd=&member_pwd_confirm=&member_phone=
    // 회원가입 폼
    @RequestMapping("insert_form.do")
    public String insert_form() {
        return "member/member_insert_form";
    }

    // 회원가입
    @RequestMapping("insert.do")
    public String insert(MemberVo vo) {
        memberMapper.insert(vo);

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
    public String login(String member_accountId, String member_pwd, RedirectAttributes ra) {

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

        return "redirect:../main.do";
    }

    // 로그아웃
    @RequestMapping("logout.do")
    public String logout() {

        session.removeAttribute("user");

        return "redirect:../main.do";
    }

    // 마이페이지
    @GetMapping("mypage.do")
    public String showMyPage(Model model, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        model.addAttribute("user", user);
        // 다른 데이터 모델 추가
        return "member/member_page";
    }

    // 수정폼
    @RequestMapping("modify_form.do")
    public String modify_form(int member_id, Model model) {
        MemberVo vo = memberMapper.selectOneFromIdx(member_id);

        model.addAttribute("vo", vo);

        return "member/member_modify_form";
    }

    // 수정하기
    @RequestMapping("modify.do")
    public String modify(MemberVo vo) {

        memberMapper.update(vo);

        MemberVo loginUser = (MemberVo) session.getAttribute("user");

        if (loginUser.getMember_id() == vo.getMember_id()) {
            MemberVo user = memberMapper.selectOneFromIdx(vo.getMember_id());
            session.setAttribute("user", user);
        }

        return "redirect: ../main.do";
    }
}
