package com.githrd.demo_photo.vo;

import org.apache.ibatis.type.Alias;

@Alias("photo")
public class PhotoVo {

	int    no;
	int    p_idx;
	String p_title;
	String p_content;
	String p_filename;
	String p_ip;
	String p_regdate;
	int    mem_idx;
	String mem_name;
	
	public PhotoVo() {
		
	}
	
	public PhotoVo(String p_title, String p_content, String p_filename, String p_ip, int mem_idx, String mem_name) {
		super();
		this.p_title = p_title;
		this.p_content = p_content;
		this.p_filename = p_filename;
		this.p_ip = p_ip;
		this.mem_idx = mem_idx;
		this.mem_name = mem_name;
	}
	
	
	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getP_idx() {
		return p_idx;
	}
	public void setP_idx(int p_idx) {
		this.p_idx = p_idx;
	}
	public String getP_title() {
		return p_title;
	}
	public void setP_title(String p_title) {
		this.p_title = p_title;
	}
	public String getP_content() {
		return p_content;
	}
	public void setP_content(String p_content) {
		this.p_content = p_content;
	}
	public String getP_filename() {
		return p_filename;
	}
	public void setP_filename(String p_filename) {
		this.p_filename = p_filename;
	}
	public String getP_ip() {
		return p_ip;
	}
	public void setP_ip(String p_ip) {
		this.p_ip = p_ip;
	}
	public String getP_regdate() {
		return p_regdate;
	}
	public void setP_regdate(String p_regdate) {
		this.p_regdate = p_regdate;
	}
	public int getMem_idx() {
		return mem_idx;
	}
	public void setMem_idx(int mem_idx) {
		this.mem_idx = mem_idx;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	
	
	
}
