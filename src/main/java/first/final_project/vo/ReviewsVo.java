package first.final_project.vo;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("reviews")
@Data
public class ReviewsVo {
    
    // review column 
    private int reviews_id;
    private int reviews_rating;
    private String reviews_content;
    private String reviews_cdate;

    // foreign key 
    private int orders_id;

    // 이미지 저장 
    List<ReviewsImagesVo> reviews_img_list = new ArrayList<>();
}
