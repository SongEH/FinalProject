package first.final_project.vo;

import java.time.LocalDateTime;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("coupon")
public class CouponVo {
    private int coupon_id;
    private int member_id;
    private String coupon_code;
    private int discount_amount;
    private String member_name;
    private LocalDateTime start_date;
    private LocalDateTime used_date;
    private LocalDateTime end_date;

}
