package first.final_project.vo;

import org.apache.ibatis.type.Alias;

@Alias("grade")
public class GradeVo {

    int grade_id;
    String grade_name;
    double grade_discount;

    public int getGrade_id() {
        return grade_id;
    }

    public void setGrade_id(int grade_id) {
        this.grade_id = grade_id;
    }

    public String getGrade_name() {
        return grade_name;
    }

    public void setGrade_name(String grade_name) {
        this.grade_name = grade_name;
    }

    public double getGrade_discount() {
        return grade_discount;
    }

    public void setGrade_discount(double grade_discount) {
        this.grade_discount = grade_discount;
    }
<<<<<<< HEAD
}
=======
}
>>>>>>> main
