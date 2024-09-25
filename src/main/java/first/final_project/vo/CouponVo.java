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
    private String member_name; // Optional
    private Timestamp start_date; // If you need to retrieve dates
    private Timestamp used_date; // If you need to retrieve dates
    private Timestamp end_date; // If you need to retrieve dates
    private int grade_id;

    // coupon_id INT PRIMARY KEY AUTO_INCREMENT,
    // coupon_code VARCHAR(50) NOT NULL UNIQUE,
    // coupon_value INT NULL,
    // discount_amount INT,
    // start_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    // end_date TIMESTAMP NULL, -- 명시적으로 NULL 허용 설정
    // used_date DATETIME DEFAULT NULL,
    // member_id INT,
    // grade_id INT NOT NULL, -- 회원 등급을 명시하는 필드
}
