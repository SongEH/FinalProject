package com.githrd.finalproject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.githrd.finalproject.dao.AddrMapper;
import com.githrd.finalproject.dao.MemberMapper;
import com.githrd.finalproject.vo.AddrVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/addr/")
public class AddrController {

    @Autowired
    HttpSession session;

    @Autowired
    HttpServletRequest request;

    @Autowired
    AddrMapper addrMapper;

    @Autowired
    MemberMapper memberMapper;

    @RequestMapping("addr_list.do")
    public String addr_list(int member_id, Model model) {
        List<AddrVo> addr_list = addrMapper.selectList(member_id);

        model.addAttribute("addr_list", addr_list);

        return "addr/addr_list";
    }

    @RequestMapping("addr_insert_form.do")
    public String addr_insert_form() {
        return "addr/addr_insert_form";
    }

    @RequestMapping("addr_insert.do")
    public String addr_insert(AddrVo vo) {
        addrMapper.insert(vo);

        session.setAttribute("vo", vo);

        return "redirect:addr/addr_list";
    }
}
