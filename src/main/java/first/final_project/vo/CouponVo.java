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
    private int coupon_value;
    private int discount_amount;
    private String member_name;
    private Timestamp start_date;
    private Timestamp used_date;
    private Timestamp end_date;
    private int grade_id;

}
