package first.final_project.vo;

import org.apache.ibatis.type.Alias;

@Alias("addr")
public class AddrVo {

    int addr_id;
    int member_id;
    String addr_zipcode;
    String adrr_line1;
    String addr_line2;
    String addr_name;

    public int getAddr_id() {
        return addr_id;
    }

    public void setAddr_id(int addr_id) {
        this.addr_id = addr_id;
    }

    public int getMember_id() {
        return member_id;
    }

    public void setMember_id(int member_id) {
        this.member_id = member_id;
    }

    public String getAddr_zipcode() {
        return addr_zipcode;
    }

    public void setAddr_zipcode(String addr_zipcode) {
        this.addr_zipcode = addr_zipcode;
    }

    public String getAdrr_line1() {
        return adrr_line1;
    }

    public void setAdrr_line1(String adrr_line1) {
        this.adrr_line1 = adrr_line1;
    }

    public String getAddr_line2() {
        return addr_line2;
    }

    public void setAddr_line2(String addr_line2) {
        this.addr_line2 = addr_line2;
    }

    public String getAddr_name() {
        return addr_name;
    }

    public void setAddr_name(String addr_name) {
        this.addr_name = addr_name;
    }

}
