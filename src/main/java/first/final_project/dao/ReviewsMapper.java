package first.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.ReviewsImagesVo;
import first.final_project.vo.ReviewsVo;



@Mapper
public interface ReviewsMapper {
    
    // insert review --> reviews table
    int insert(ReviewsVo vo);

    // insert reviews_img  --> reviews_images table
    int insert_img(ReviewsImagesVo imageVo);

    int getReviewIdFromOrderId(int orders_id);

    // select reviews + reviews_images 
    List<ReviewsVo> selectList();
}
