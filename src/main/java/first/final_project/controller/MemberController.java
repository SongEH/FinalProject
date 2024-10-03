package first.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import first.final_project.dao.MemberMapper;
import first.final_project.service.MemberService;
import first.final_project.vo.CouponVo;
import first.final_project.vo.MemberVo;
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
    MemberMapper member_mapper;

    @Autowired
    MemberService memberService;

    @RequestMapping("mypage.do")
    public String showMyPage(MemberVo vo, Model model) {
        MemberVo user = (MemberVo) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login_form.do";
        }
        MemberVo member = member_mapper.selectOneFromIdx(user.getMember_id());
        model.addAttribute("member", member);

        return "member/member_mypage";
    }


    @RequestMapping(value = "mypage/modify_form.do", method = RequestMethod.GET)
    public String myPageEditForm(Model model) {
        MemberVo user = (MemberVo) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login_form.do";
        }

        MemberVo member = member_mapper.selectOneFromIdx(user.getMember_id());
        model.addAttribute("member", member);
        return "member/mypage_modify"; 
    }


    @RequestMapping(value = "mypage/modify.do", method = RequestMethod.POST)
    public String myPageEdit(MemberVo vo) {

        member_mapper.update(vo);

        session.setAttribute("user", vo);

        return "redirect:/member/mypage.do";
    }

    @RequestMapping(value = "mypage/delete.do", method = RequestMethod.GET)
    public String myPageDelete(@RequestParam int member_id) {
        member_mapper.delete(member_id);
        session.invalidate(); 
        return "redirect:/main/display.do";
    }

    @RequestMapping("selectcoupon.do")
    public String getMemberCoupons(Model model) {
        MemberVo user = (MemberVo) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login_form.do";
        }
        List<CouponVo> member = memberService.getMemberWithCoupons(user.getMember_id());
        model.addAttribute("member", member);
        return "member/member_Mycoupon";
    }

}