package first.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.InquiriesVo;

@Mapper
public interface InquiriesMapper {
    
    List<InquiriesVo> selectListByType(String inquiries_type);

    InquiriesVo selectFromIdx(int inquiries_id);

    int insert(InquiriesVo vo);

    int update(InquiriesVo vo);

    int delete(int inquiries_id);

}
