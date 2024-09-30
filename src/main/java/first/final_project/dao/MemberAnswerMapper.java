package first.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.MemberAnswerVo;

@Mapper
public interface MemberAnswerMapper {

    MemberAnswerVo selectOne(int m_answer_id);

    List<MemberAnswerVo> selectListFromIdx(int m_inquiries_id);

    int insert(MemberAnswerVo vo);

    int update(MemberAnswerVo vo);

    int delete(int m_answer_id);
}
