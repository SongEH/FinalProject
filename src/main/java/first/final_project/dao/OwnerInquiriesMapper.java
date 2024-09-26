package first.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.OwnerInquiriesVo;

@Mapper
public interface OwnerInquiriesMapper {
    
    List<OwnerInquiriesVo> selectList();

    OwnerInquiriesVo selectFromIdx(int o_inquiries_id);

    int insert(OwnerInquiriesVo vo);

    int update(OwnerInquiriesVo vo);

    int delete(int o_inquiries_id);
    
}
