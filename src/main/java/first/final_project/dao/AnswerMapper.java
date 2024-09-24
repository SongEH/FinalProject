package first.final_project.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.AnswerVo;

@Mapper
public interface AnswerMapper {
    
    List<AnswerVo> selectList();
}
