package first.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("grade")
@Data
public class GradeVo {

    int grade_id;
    String grade_name;
    double grade_discount;

}
