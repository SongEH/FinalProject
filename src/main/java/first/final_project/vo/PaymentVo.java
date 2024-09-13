package first.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("payment")
public class PaymentVo {

    private int orders_id;
    private String orders_payment;
    private String orders_method;
    private String orders_imp_uid;
    private String orders_merchant_uid;
    private String orders_name;
    private int orders_price;
    private String orders_srequest;
    private String orders_drequest;
    private String orders_cdate;
    private String orders_status;
    private int shop_id;
    private int addr_id;
    private int member_id;

}