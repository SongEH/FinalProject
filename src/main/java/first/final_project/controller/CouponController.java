package first.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import first.final_project.service.CouponService;
import first.final_project.vo.CouponVo;
import first.final_project.vo.MemberVo;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/coupon/")
public class CouponController {

    @Autowired
    private CouponService couponService;

    @Autowired
    HttpSession httpSession;

    @RequestMapping("main.do")
    public String list() {
        return "coupon/coupon_main";
    }

    @RequestMapping("issue3000.do")
    public String issueCouponsForMembers3000() {
        couponService.issueCouponsForAllMembers3000();
        return "redirect:/coupon/success";
    }

    @RequestMapping("issue5000.do")
    public String issueCouponsForMembers5000() {
        couponService.issueCouponsForAllMembers5000();
        return "redirect:/coupon/success";
    }

    @RequestMapping("success")
    public String successPage() {
        return "coupon/success";
    }

    @RequestMapping("listMember.do")
    public String listCouponsForMember(Model model, HttpSession session) {
        MemberVo member = (MemberVo) session.getAttribute("member");
        if (member != null) {
            List<CouponVo> coupon = couponService.getCouponsForMember(member.getMember_id());
            model.addAttribute("coupon", coupon);
        }
        return "coupon/coupon_list";
    }

    @RequestMapping("list.do")
    public String listCoupons(Model model) {
        List<CouponVo> coupon = couponService.getAllIssuedCoupons();
        model.addAttribute("coupon", coupon);
        return "coupon/coupon_list";
    }

}