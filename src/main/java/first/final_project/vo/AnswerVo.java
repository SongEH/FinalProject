package first.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("answer")
public class AnswerVo {
    private int answer_id;
    private String answer_content;
    private String answer_cdate;
    private int inquiries_id;
    private int admin_id;
}
