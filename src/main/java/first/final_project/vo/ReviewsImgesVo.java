package first.final_project.vo;

import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("reviewsImges")
public class ReviewsImgesVo {
    private int reviews_images_id;
    private String reviews_img;
    // 외래키 
    private int reviews_id; 
}
