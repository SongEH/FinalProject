package first.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.MemberInquiriesVo;

@Mapper
public interface MemberInquiriesMapper {

    List<MemberInquiriesVo> selectListByType(String m_inquiries_type);

    MemberInquiriesVo selectFromIdx(int m_inquiries_id);

    int insert(MemberInquiriesVo vo);

    int update(MemberInquiriesVo vo);

    int delete(int m_inquiries_id);

}
