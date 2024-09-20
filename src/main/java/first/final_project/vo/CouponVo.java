package first.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("coupon")
public class CouponVo {
    int coupon_id;
    int member_id;
    String coupon_code;
    int discount_admount;
    String member_name;

    public void setMemberId(int member_id) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'setMemberId'");
    }

    public void setDiscountAmount(int grade_discount) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'setDiscountAmount'");
    }

    public void setCouponCode(String couponCode) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'setCouponCode'");
    }

}
