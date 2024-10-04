package first.final_project.vo;

import lombok.Data;

@Data
public class CountVo { // 문의사항 답변 VO
    
    private int null_answer_count;
    private int owner_null_answer_count;
    
    public CountVo(int null_answer_count, int owner_null_answer_count) {
        this.null_answer_count = null_answer_count;
        this.owner_null_answer_count = owner_null_answer_count;
    }

    
}
