package first.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("member_answer")
public class MemberAnswerVo {

    private int m_answer_id;
    private String m_answer_content;
    private String m_answer_cdate;
    private int admin_id;
    private int m_inquiries_id;
    private String admin_accountId;
}
