package com.githrd.FinalProject.vo;

import lombok.Data;
import java.util.Date;

import org.apache.ibatis.type.Alias;

@Data
@Alias("shopvo")
public class ShopVo {
    private int shop_id;
    private String shop_name;
    private String shop_img;
    private String shop_addr;
    private String food_category;
    private String shop_call;
    private String shop_content;
    private int shop_min_price;
    private String shop_delivery_time;
    private double shop_rate;
    private int shop_stemp_count;
    private int shop_review_count;
    private String shop_open_time;
    private Date shop_close_day;
    private String shop_area;
    private Date shop_cdate;
    private Date shop_mdate;
    private String shop_status;
    private int owner_id;
}