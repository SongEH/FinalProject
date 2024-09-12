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
    private String reviews_img;
    private String reviews_cdate;



    // foreign key 
    private int member_id;
    private int menu_id;
    private int shop_id;

    List<ReviewsImageVo> reviews_img_list = new ArrayList<>();
}
