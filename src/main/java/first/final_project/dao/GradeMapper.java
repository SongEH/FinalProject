package first.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.GradeVo;

@Mapper
public interface GradeMapper {
    List<GradeVo> selectList();

    GradeVo selectOne(String grade_name);
<<<<<<< HEAD
}
=======
}
>>>>>>> main
