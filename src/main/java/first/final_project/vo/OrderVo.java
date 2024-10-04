package first.final_project.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("order")
public class OrderVo {
    private int orders_id;
    private String orders_payment;
    private String orders_name;
    private int orders_price;
    private String orders_merchant_uid;
    private String orders_srequest;
    private String orders_drequest;
    private Date orders_cdate;
    private String orders_status;
    private int shop_id;
    private int addr_id;
    private String addr1;
    private String addr2;
    private int member_id;
    private String shop_img;
    private int orders_isdelete;

    private String shop_name; 
    private String deliveries_method; 
    private String shop_status;
    private String shop_addr1; 
    private String shop_addr2;
    private String member_nickname; 
    private String addr_line1;
    private String addr_line2; 
    private String delivery_history_status; 
    private String member_phone; 
    private int delivery_time; 
    private int menu_count;
    
    private int reviews_delete; // 리뷰삭제이력 확인 
    boolean hasReview;

}
