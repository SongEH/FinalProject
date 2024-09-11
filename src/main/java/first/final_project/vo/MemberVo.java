package first.final_project.vo;

import org.apache.ibatis.type.Alias;

@Alias("member")
public class MemberVo {

    int member_id;
    String member_name;
    String member_nickname;
    String member_accountId;
    String member_pwd;
    String member_email;
    String member_phone;
    int member_monthOrder;
    String member_cdate;
    String member_grade;
    boolean member_active;

    public MemberVo() {
    }

    public int getMember_id() {
        return member_id;
    }

    public void setMember_id(int member_id) {
        this.member_id = member_id;
    }

    public String getMember_name() {
        return member_name;
    }

    public void setMember_name(String member_name) {
        this.member_name = member_name;
    }

    public String getMember_nickname() {
        return member_nickname;
    }

    public void setMember_nickname(String member_nickname) {
        this.member_nickname = member_nickname;
    }

    public String getMember_accountId() {
        return member_accountId;
    }

    public void setMember_accountId(String member_accountId) {
        this.member_accountId = member_accountId;
    }

    public String getMember_pwd() {
        return member_pwd;
    }

    public void setMember_pwd(String member_pwd) {
        this.member_pwd = member_pwd;
    }

    public String getMember_email() {
        return member_email;
    }

    public void setMember_email(String member_email) {
        this.member_email = member_email;
    }

    public String getMember_phone() {
        return member_phone;
    }

    public void setMember_phone(String member_phone) {
        this.member_phone = member_phone;
    }

    public int getMember_monthOrder() {
        return member_monthOrder;
    }

    public void setMember_monthOrder(int member_monthOrder) {
        this.member_monthOrder = member_monthOrder;
    }

    public String getMember_cdate() {
        return member_cdate;
    }

    public void setMember_cdate(String member_cdate) {
        this.member_cdate = member_cdate;
    }

    public String getMember_grade() {
        return member_grade;
    }

    public void setMember_grade(String member_grade) {
        this.member_grade = member_grade;
    }

    public boolean isMember_active() {
        return member_active;
    }

    public void setMember_active(boolean member_active) {
        this.member_active = member_active;
    }

}
