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

    // reviews delete
    int deleteReviews(int reviews_id);

    // use Orders_id for get Reviews_id 
    int getReviewIdFromOrderId(int orders_id);

    // Calling reviews written by customers 
    List<ReviewsVo> selectList(int member_id);
    
    List<ReviewsVo> selectListByShopId(int shop_id);

    List<String> getImageForReviews(int reviews_id);

    Boolean checkReviewExists(int orders_id);

    Boolean checkCeoReviewExists(int reviews_id);
}
