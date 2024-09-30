package first.final_project.service;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import first.final_project.dao.CouponMapper;
import first.final_project.dao.MemberMapper;
import first.final_project.vo.CouponVo;
import first.final_project.vo.MemberVo;

@Service
public class CouponService {

    @Autowired
    private MemberMapper memberMapper;

    @Autowired
    private CouponMapper couponMapper;

    // 모든 회원에게 등급에 맞는 쿠폰 발행
    @Transactional
    public void issueCouponsForAllMembers3000() {
        List<MemberVo> members = memberMapper.selectList();
        for (MemberVo member : members) {
            CouponVo coupon = new CouponVo();
            coupon.setMember_id(member.getMember_id());
            coupon.setDiscount_amount(3000);
            coupon.setCoupon_code(generateCouponCode());

            couponMapper.insertCoupon(coupon);
        }

    }

    @Transactional
    public void issueCouponsForAllMembers5000() {
        List<MemberVo> members = memberMapper.selectList();
        for (MemberVo member : members) {
            CouponVo coupon = new CouponVo();
            coupon.setMember_id(member.getMember_id());
            coupon.setDiscount_amount(5000);
            coupon.setCoupon_code(generateCouponCode());

            couponMapper.insertCoupon(coupon);
        }

    }

    public List<CouponVo> getCouponsForMember(int member_id) {
        return couponMapper.getCouponsByMemberId(member_id);
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