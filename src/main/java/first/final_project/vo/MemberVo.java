package first.final_project.vo;

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
    int member_monthOrder;
    String member_cdate;

    // If you intend to store the grade name
    String grade_name; // derived from joining with the Grade table

    // This refers to the ID of the grade
    int grade_id;

    // Fields from the Address table (if these are inner joins)
    String addr_line1;
    String addr_line2;

    String owner_name;
}
