package com.delivery.finalproject.vo;

import lombok.Data;
import java.util.Date;

import org.apache.ibatis.type.Alias;

@Data
@Alias("member")
public class MemberVo {
    private int member_id;
    private String member_name;
    private String member_nickname;
    private String member_account_id;
    private String member_pwd;
    private String member_email;
    private String member_phone;
    private int member_month_order;
    private Date member_cdate;
    private String member_grade;
}
