package com.delivery.finalproject.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("deliveries")
public class DeliveriesVo {
    private int deliveries_id;
    private int raiders_id;
    private String deliveries_method;
    private int orders_id;
}
