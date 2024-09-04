package first.final_project.vo;

import org.apache.ibatis.type.Alias;
import java.util.List;

import lombok.Data;

@Data
@Alias("shop")
public class ShopVo {

    private int shop_id;
    private String shop_name;
    private String shop_img;
    private String shop_addr;
    private String food_category;
    private String shop_call;
    private String shop_content;
    private int shop_min_price;
    private String shop_rate;
    private int shop_stemp_count;
    private int shop_review_count;
    private String shop_open_time;
    private String shop_close_time;
    private String shop_close_day;
    private String shop_area;
    private String shop_create_day;
    private String shop_modify_day;
    private String shop_status;

    List<MenuVo> menu_list;

}
