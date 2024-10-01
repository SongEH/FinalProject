package first.final_project.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("carts")
public class CartsVo {
    private int carts_id;
    private int carts_quantity;
    private int member_id;
    private int shop_id;
    private int orders_id;
    private int menu_id;
    private Date carts_cdate;
    private String shop_name;
    private String menu_name;
    private String menu_img;
    private int menu_price;

    // 판단하기 위한 연산 column
    private String shop_status;
    private int shop_min_price;
}
