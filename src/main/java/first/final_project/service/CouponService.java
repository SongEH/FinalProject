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

    @Transactional
    public void issueCouponsForAllMembers3000() {
        // 모든 회원 정보를 조회
        List<MemberVo> members = memberMapper.selectList();

        // 각 회원에게 3000원 할인 쿠폰 발급
        for (MemberVo member : members) {
            CouponVo coupon = new CouponVo();
            coupon.setMember_id(member.getMember_id()); // 회원 ID 설정
            coupon.setDiscount_amount(3000); // 할인 금액 설정
            coupon.setCoupon_code(generateCouponCode()); // 쿠폰 코드 생성

            couponMapper.insertCoupon(coupon); // 쿠폰 DB에 삽입
        }
    }

    @Transactional
    public void issueCouponsForAllMembers5000() {
        // 모든 회원 정보를 조회
        List<MemberVo> members = memberMapper.selectList();

        // 각 회원에게 5000원 할인 쿠폰 발급
        for (MemberVo member : members) {
            CouponVo coupon = new CouponVo();
            coupon.setMember_id(member.getMember_id()); // 회원 ID 설정
            coupon.setDiscount_amount(5000); // 할인 금액 설정
            coupon.setCoupon_code(generateCouponCode()); // 쿠폰 코드 생성

            couponMapper.insertCoupon(coupon); // 쿠폰 DB에 삽입
        }
    }

    // 특정 회원의 쿠폰 목록을 조회하는 메서드
    public List<CouponVo> getCouponsForMember(int member_id) {
        return couponMapper.getCouponsByMemberId(member_id); // 회원 ID에 따라 쿠폰 조회
    }

    // 랜덤한 쿠폰 코드를 생성하는 메서드
    private String generateCouponCode() {
        return UUID.randomUUID().toString().substring(0, 8); // UUID에서 앞 8자리 추출
    }

    // 발급된 모든 쿠폰을 조회하는 메서드
    public List<CouponVo> getAllIssuedCoupons() {
        return couponMapper.getAllIssuedCoupons(); // 발급된 모든 쿠폰 조회
    }

}