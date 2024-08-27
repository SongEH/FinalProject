package com.githrd.finalproject.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.githrd.finalproject.dao.OwnerMapper;
import com.githrd.finalproject.vo.OwnerVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/owner/")
public class OwnerController {
    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpSession session;

    @Autowired
    OwnerMapper ownerMapper;

    // 사장 조회
    // @RequestMapping("list.do")
    // public String list(Model model) {
    // List<OwnerVo> list = ownerMapper.selectList();
    // model.addAttribute("list", list);
    // return "owner/owner_list";
    // }

    // 사장 회원가입
    @RequestMapping("insert_form.do")
    public String insert_form() {
        return "owner/owner_insert_form";
    }

    // 사장 회원가입
    @RequestMapping("insert.do")
    public String insert(OwnerVo vo) {
        ownerMapper.insert(vo);
        return "redirect:login_form.do";
    }

    // 아이디 중복 체크
    @RequestMapping("check_id.do")
    @ResponseBody
    public Map<String, Boolean> check_id(@RequestParam("owner_accountId") String owner_accountId) {
        OwnerVo vo = ownerMapper.selectOneFromId(owner_accountId);
        boolean bResult = (vo == null);
        Map<String, Boolean> map = new HashMap<>();
        map.put("result", bResult);
        return map;
    }

    // 로그인 폼
    @RequestMapping("login_form.do")
    public String login_form() {
        return "owner/owner_login_form";
    }

    // 로그인
    @RequestMapping("login.do")
    public String login(String owner_accountId, String owner_pwd, RedirectAttributes ra) {

        OwnerVo user = ownerMapper.selectOneFromId(owner_accountId);

        if (user == null) {
            ra.addAttribute("reason", "fail_id");

            return "redirect:login_form.do";
        }

        if (user.getOwner_pwd().equals(owner_pwd) == false) {
            ra.addAttribute("reason", "fail_pwd");
            ra.addAttribute("owner_accountId", owner_accountId);

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
}
