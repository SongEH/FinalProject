package first.final_project.vo;

import lombok.Data;
import java.util.Date;

import org.apache.ibatis.type.Alias;

@Data
@Alias("order")
public class OrderVo {
    private int orders_id;
    private String orders_payment;
    private String orders_name;
    private int orders_price;
    private String orders_srequest;
    private String orders_drequest;
    private Date orders_cdate;
    private String orders_status;
    private int shop_id;
    private int addr_id;
<<<<<<< HEAD
    private String shop_name;
    private String deliveries_method;
    private String shop_status;
    private String shop_addr;
    private int member_id;
    private String member_nickname;
=======
    private String shop_name; // 추가
    private String deliveries_method; // 추가
    private String shop_status; // 추가
    private String shop_addr; // 추가
    private String member_nickname; // 추가
    private String addr_line1; // 추가
    private String addr_line2; // 추가
>>>>>>> riders-branch
}
