package first.final_project.vo;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("member")
public class MemberVo {
    int member_id;
    String member_name;
    String member_nickname;
    String member_accountId;
    String member_pwd;
    String member_email;
    String member_phone;
    String member_cdate;

    // inner join from addr
    String addr_line1;
    String addr_line2;

    String owner_name;
    List<CouponVo> coupon;
}
