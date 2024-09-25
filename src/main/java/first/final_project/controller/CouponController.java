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

    // 쿠폰 메인 페이지
    @RequestMapping("main.do")
    public String list() {
        return "coupon/coupon_main";
    }

    // 쿠폰 발행 버튼을 클릭했을 때 호출
    @RequestMapping("issue.do")
    public String issueCouponsForMembers() {
        couponService.issueCouponsForAllMembers();
        return "redirect:/coupon/success"; // 성공 페이지로 리디렉션
    }

    // Success page after issuing coupons
    @RequestMapping("success")
    public String successPage() {
        return "coupon/success"; // Show success message
    }

    // 특정 회원의 쿠폰 리스트 조회
    @RequestMapping("listMember.do")
    public String listCouponsForMember(Model model, HttpSession session) {
        MemberVo member = (MemberVo) session.getAttribute("member"); // 세션에서 로그인된 회원 정보 가져오기
        if (member != null) {
            List<CouponVo> coupons = couponService.getCouponsForMember(member.getMember_id());
            model.addAttribute("coupons", coupons); // 쿠폰 리스트를 모델에 추가
        }
        return "coupon/coupon_list"; // 쿠폰 리스트를 보여주는 페이지로 이동
    }

    // 관리자가 모든 발급된 쿠폰을 조회하는 메서드
    // View issued coupons
    @RequestMapping("list.do")
    public String listCoupons(Model model) {
        List<CouponVo> coupons = couponService.getAllIssuedCoupons();
        model.addAttribute("coupons", coupons); // Add coupon data to the model
        return "coupon/coupon_list"; // Render coupon list JSP page
    }

}