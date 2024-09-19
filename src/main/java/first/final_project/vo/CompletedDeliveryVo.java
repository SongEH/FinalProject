package first.final_project.vo;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("completeddeliveryvo")
public class CompletedDeliveryVo {
    private int deliveries_id;
    private String rider_name;
    private int orders_id;
    private double orders_price;
    private String orders_status;
    private Date orders_cdate;
    private String shop_name;
    private String addr_line1;
    private String addr_line2;
    private String delivery_history_status;
    private double commission;

}
