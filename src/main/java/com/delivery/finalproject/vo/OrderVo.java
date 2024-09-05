package com.delivery.finalproject.vo;

import lombok.Data;
import java.util.Date;

@Data
public class OrderVo {
    private int orders_id;
    private String orders_payment;
    private int orders_price;
    private String orders_srequest;
    private String orders_drequest;
    private Date orders_cdate;
    private String orders_status;
    private int shop_id;
    private int addr_id;
    private String shop_name; // 추가
    private String deliveries_method; // 추가
    private String shop_status; // 추가
    private String shop_addr; // 추가
    private String member_nickname; // 추가
    private String addr_line1; // 추가
    private String addr_line2; // 추가
}
