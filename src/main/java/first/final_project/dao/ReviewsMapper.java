package first.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.ReviewsImgesVo;
import first.final_project.vo.ReviewsVo;



@Mapper
public interface ReviewsMapper {
    
    int insert(ReviewsVo vo);

    int insert_img(ReviewsImgesVo imgVo);

    List<ReviewsVo> selectList();
}
