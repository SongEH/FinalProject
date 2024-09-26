package first.final_project.vo;

import org.apache.ibatis.type.Alias;

import java.math.BigDecimal;
import java.util.List;

import lombok.Data;

@Data
@Alias("shop")
public class ShopVo {

    private int shop_id;
    private String shop_name;
    private String shop_img;

    private String shop_addr1;
    private String shop_addr2;
    private String shop_addr;

    private String food_category;
    private String shop_call;
    private String shop_content;
    private int shop_min_price;
    private int shop_rate;
    private String shop_open_hour;
    private String shop_close_hour;
    private String shop_close_day;
    private String shop_area;
    private String shop_cdate;
    private String shop_mdate;
    private String shop_status;
    private int owner_id;

    // SQL Cal result
    private int menu_count;
    private int reviews_count;
    private int ceoreview_count;
    private BigDecimal shop_rating;
    private String owner_license;
    private String status;


    List<MenuVo> menu_list;

}