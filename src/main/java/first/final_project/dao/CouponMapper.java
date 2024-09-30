package first.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import first.final_project.vo.CouponVo;

@Mapper
public interface CouponMapper {

        void insertCoupon(CouponVo coupon); // Insert coupon

        List<CouponVo> getCouponsByMemberId(@Param("member_id") int member_id); // Retrieve coupons by member ID

        List<CouponVo> getAllIssuedCoupons(); // Retrieve all issued coupons
}