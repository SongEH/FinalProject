package first.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("reviewsImage")
public class ReviewsImageVo {
    private int reviews_images_id;
    private String reviews_img;
    private int reviews_id; 
}
