package com.githrd.finalproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.githrd.finalproject.dao.AdminMapper;
import com.githrd.finalproject.dao.OwnerMapper;
import com.githrd.finalproject.vo.AdminVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin/")
public class AdminController {
    // 자동연결(요청시 마다 Injection)
    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpSession session;

    @Autowired
    AdminMapper adminMapper;

    @Autowired
    OwnerMapper ownerMapper;

    // 로그인 폼
    @RequestMapping("login_form.do")
    public String login_form() {

        return "admin/admin_login_form";
    }

    // 로그인
    @RequestMapping("login.do")
    public String login(String admin_accountId, String admin_pwd, RedirectAttributes ra) {

        AdminVo user = adminMapper.selectOneFromId(admin_accountId);

        if (user == null) {
            ra.addAttribute("reason", "fail_id");

            return "redirect:login_form.do";
        }

        if (user.getAdmin_pwd().equals(admin_pwd) == false) {
            ra.addAttribute("reason", "fail_pwd");
            ra.addAttribute("admin_accountId", admin_accountId);

            return "redirect:login_form.do";
        }

        session.setAttribute("user", user);

        return "redirect:../main.do";
    }
}
