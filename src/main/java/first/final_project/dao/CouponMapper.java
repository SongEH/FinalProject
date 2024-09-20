package first.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import first.final_project.vo.CouponVo;

@Mapper
public interface CouponMapper {

    void insertCoupon(CouponVo coupon);

    void issueCouponsForAllMembers();

    void issueCouponForMember(@Param("member_id") int member_id);

    // 특정 회원이 발급받은 쿠폰 조회
    @Select("SELECT coupon_code, discount_amount, issued_date, used_date " +
            "FROM coupon WHERE member_id = #{memberId}")
    List<CouponVo> getCouponsByMemberId(@Param("member_id") int member_id);

    @Select("SELECT c.coupon_code, c.discount_amount, c.issued_date, c.used_date, m.member_name " +
            "FROM coupon c JOIN member m ON c.member_id = m.member_id")
    List<CouponVo> getAllIssuedCoupons();
}