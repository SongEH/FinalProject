package first.final_project.dao;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.CeoReviewVo;

@Mapper
public interface CeoReviewMapper {
    
    int insert(CeoReviewVo vo);

    CeoReviewVo selectOne(int reviews_id);

    int delete(int ceoreviews_id);    
}
