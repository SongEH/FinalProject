package com.githrd.FinalProject.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("deliveries")
public class DeliveriesVo {
    private int deliveries_id;
    private int riders_id;
    private String deliveries_method;
    private int orders_id;
}