// package com.githrd.finalproject.controller;

// import java.util.List;

// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.stereotype.Controller;
// import org.springframework.ui.Model;
// import org.springframework.web.bind.annotation.RequestMapping;

// import com.githrd.finalproject.dao.X_MemberMapper;
// import com.githrd.finalproject.vo.X_MemberVo;

// import jakarta.servlet.http.HttpServletRequest;
// import jakarta.servlet.http.HttpSession;

// @Controller
// @RequestMapping("/member/")
// public class X_final_MemberController {
// // 자동연결(요청시 마다 Injection)
// @Autowired
// HttpServletRequest request;

// @Autowired
// HttpSession session;

// // 처음에 1회연결
// @Autowired
// X_MemberMapper member_mapper;

// // 회원전체목록
// @RequestMapping("list.do")
// public String list(Model model) {

// List<X_MemberVo> list = member_mapper.selectList();

// model.addAttribute("list", list);

// return "member/member_list";
// }

// // 회원가입폼
// @RequestMapping("insert_form.do")
// public String insert_form() {

// return "member/member_insert_form";
// }

// }
