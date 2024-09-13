package com.delivery.finalproject.vo;

import lombok.Data;
import java.util.Date;

import org.apache.ibatis.type.Alias;

@Data
@Alias("owner")
public class OwnerVo {
    private int owner_id;
    private String owner_name;
    private String owner_account_id;
    private String owner_pwd;
    private String owner_email;
    private String owner_phone;
    private String owner_license;
    private String owner_registration;
    private String owner_bankbook;
    private Date owner_cdate;
}
