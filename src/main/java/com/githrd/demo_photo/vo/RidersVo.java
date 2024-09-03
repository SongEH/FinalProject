package com.githrd.demo_photo.vo;

import org.apache.ibatis.type.Alias;

@Alias("riders")
public class RidersVo {

	int riders_id;
	String riders_name;
	String riders_pwd;
	String riders_email;
	String riders_phone;
	String riders_region;

	// 기본 생성자 (매개변수 없는 생성자)
	public RidersVo() {
	}

	// 모든 필드를 초기화하는 생성자
	public RidersVo(int riders_id, String riders_name, String riders_pwd, String riders_phone, String riders_email,
			String riders_region) {
		this.riders_id = riders_id;
		this.riders_name = riders_name;
		this.riders_pwd = riders_pwd;
		this.riders_phone = riders_phone;
		this.riders_email = riders_email;

	}

	public RidersVo(String riders_name, String riders_pwd, String riders_phone, String riders_email,
			String riders_region) {

		this.riders_name = riders_name;
		this.riders_pwd = riders_pwd;
		this.riders_phone = riders_phone;
		this.riders_email = riders_email;
		this.riders_region = riders_region;
	}

	public int getRiders_id() {
		return riders_id;
	}

	public void setRiders_id(int riders_id) {
		this.riders_id = riders_id;
	}

	// riders_name의 getter와 setter
	public String getRiders_name() {
		return riders_name;
	}

	public void setRiders_name(String riders_name) {
		this.riders_name = riders_name;
	}

	// riders_pwd의 getter와 setter
	public String getRiders_pwd() {
		return riders_pwd;
	}

	public void setRiders_pwd(String riders_pwd) {
		this.riders_pwd = riders_pwd;
	}

	// riders_phone의 getter와 setter
	public String getRiders_phone() {
		return riders_phone;
	}

	public void setRiders_phone(String riders_phone) {
		this.riders_phone = riders_phone;
	}

	// riders_email의 getter와 setter
	public String getRiders_email() {
		return riders_email;
	}

	public void setRiders_email(String riders_email) {
		this.riders_email = riders_email;
	}

	// riders_region의 getter와 setter
	public String getRiders_region() {
		return riders_region;
	}

	public void setRiders_region(String riders_region) {
		this.riders_region = riders_region;
	}

}
