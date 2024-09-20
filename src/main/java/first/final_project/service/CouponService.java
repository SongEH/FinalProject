package first.final_project.service;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import first.final_project.dao.CouponMapper;
import first.final_project.dao.GradeMapper;
import first.final_project.dao.MemberMapper;
import first.final_project.vo.CouponVo;
import first.final_project.vo.GradeVo;
import first.final_project.vo.MemberVo;

@Service
public class CouponService {

    @Autowired
    private MemberMapper memberMapper;

    @Autowired
    private CouponMapper couponMapper;

    @Autowired
    private GradeMapper gradeMapper;

    // 모든 회원에게 등급에 맞는 쿠폰 발행
    public void issueCouponsForAllMembers() {
        List<MemberVo> members = memberMapper.selectList(); // 모든 회원 조회

        for (MemberVo member : members) {
            GradeVo grade = gradeMapper.getGradeById(member.getGrade_id()); // 회원의 등급 조회

            if (grade != null) {
                CouponVo coupon = new CouponVo();
                coupon.setMemberId(member.getMember_id());
                coupon.setDiscountAmount(grade.getGrade_discount()); // 등급에 맞는 할인 금액 설정
                coupon.setCouponCode(generateCouponCode());

                couponMapper.insertCoupon(coupon); // 쿠폰 발행
            }
        }

    }

    public List<CouponVo> getCouponsForMember(int memberId) {
        return couponMapper.getCouponsByMemberId(memberId);
    }

    // 고유 쿠폰 코드 생성
    private String generateCouponCode() {
        return UUID.randomUUID().toString().substring(0, 8); // 랜덤 8자리 쿠폰 코드 생성
    }

    // 모든 발급된 쿠폰을 조회하는 서비스 로직
    public List<CouponVo> getAllIssuedCoupons() {
        return couponMapper.getAllIssuedCoupons();
    }
}