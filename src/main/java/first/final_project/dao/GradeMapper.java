package first.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import first.final_project.vo.GradeVo;

@Mapper
public interface GradeMapper {
    List<GradeVo> selectList();

    GradeVo selectOne(String grade_name);

    // 쿠폰 발행을위한 grade_iD선택
    @Select("SELECT * FROM grade WHERE grade_id = #{grade_id}")
    GradeVo getGradeById(int grade_id);

}