package first.final_project.dao;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.ReviewsImgesVo;
import first.final_project.vo.ReviewsVo;



@Mapper
public interface ReviewsMapper {
    
    int insert(ReviewsVo vo);

    int insert_img(ReviewsImgesVo imgVo);

    ReviewsVo selectList();
}
