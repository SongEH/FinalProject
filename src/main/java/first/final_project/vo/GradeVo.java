package first.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("grade")
@Data
public class GradeVo {

    int grade_id; // 등급 ID
    String grade_name; // 등급명
    int grade_discount; // 할인금액

}
