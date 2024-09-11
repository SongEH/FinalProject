package first.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("member")
@Data
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
    boolean member_active;

}
