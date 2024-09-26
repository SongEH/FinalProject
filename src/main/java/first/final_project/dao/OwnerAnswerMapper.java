package first.final_project.dao;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.OwnerAnswerVo;

@Mapper
public interface OwnerAnswerMapper {

    OwnerAnswerVo selectOne(int o_answer_id);

    OwnerAnswerVo selectOneFromIdx(int o_inquiries_id);

    int insert(OwnerAnswerVo vo);

    int update(OwnerAnswerVo vo);

    int delete(int o_answer_id);
}
