package first.final_project.vo;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("coupon")
public class CouponVo {
    private int coupon_id;
    private int member_id;
    private String coupon_code;
    private int discount_amount;
    private String member_name; // Optional
    private Timestamp issued_date; // If you need to retrieve dates
    private Timestamp used_date; // If you need to retrieve dates
}
