package com.githrd.FinalProject.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("riders")
@Data
public class RidersVo {

	int riders_id;
	String riders_name;
	String riders_pwd;
	String riders_email;
	String riders_phone;
	String riders_region;

}
