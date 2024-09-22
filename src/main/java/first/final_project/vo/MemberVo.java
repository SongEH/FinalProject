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
    String member_grade;
    int grade_id;
    
    // inner join from addr 
    String addr_line1;
    String addr_line2;

    String owner_name;

    
}
