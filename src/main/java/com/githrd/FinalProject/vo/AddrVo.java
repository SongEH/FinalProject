package com.githrd.FinalProject.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;
//import lombok.NoArgsConstructor;
//import lombok.AllArgsConstructor;
//import lombok.Builder;

@Data
@Alias("addr")
// @NoArgsConstructor
// @AllArgsConstructor
// @Builder
public class AddrVo {
    private int addr_id;
    private String addr_zipcode;
    private String addr_line1;
    private String addr_line2;
    private String addr_name;
    private int member_id;
}