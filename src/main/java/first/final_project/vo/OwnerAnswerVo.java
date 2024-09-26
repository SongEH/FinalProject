package first.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("owner_answer")
public class OwnerAnswerVo {
    
    private int o_answer_id;
    private String o_answer_content;
    private String o_answer_cdate;
    private int admin_id;
    private int o_inquiries_id;
    private String admin_accountId;
}
