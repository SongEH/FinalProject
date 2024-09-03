package first.final_project.vo;

import org.apache.ibatis.type.Alias;

@Alias("owner")
public class OwnerVo {
    int owner_id;
    String owner_name;
    String owner_accountId;
    String owner_pwd;
    String owner_email;
    String owner_phone;
    String owner_license;
    String owner_registration;
    String owner_bankbook;
    String owner_rdate;
    String approval_status;

    public int getOwner_id() {
        return owner_id;
    }

    public void setOwner_id(int owner_id) {
        this.owner_id = owner_id;
    }

    public String getOwner_name() {
        return owner_name;
    }

    public void setOwner_name(String owner_name) {
        this.owner_name = owner_name;
    }

    public String getOwner_accountId() {
        return owner_accountId;
    }

    public void setOwner_accountId(String owner_accountId) {
        this.owner_accountId = owner_accountId;
    }

    public String getOwner_pwd() {
        return owner_pwd;
    }

    public void setOwner_pwd(String owner_pwd) {
        this.owner_pwd = owner_pwd;
    }

    public String getOwner_email() {
        return owner_email;
    }

    public void setOwner_email(String owner_email) {
        this.owner_email = owner_email;
    }

    public String getOwner_phone() {
        return owner_phone;
    }

    public void setOwner_phone(String owner_phone) {
        this.owner_phone = owner_phone;
    }

    public String getOwner_license() {
        return owner_license;
    }

    public void setOwner_license(String owner_license) {
        this.owner_license = owner_license;
    }

    public String getOwner_registration() {
        return owner_registration;
    }

    public void setOwner_registration(String owner_registration) {
        this.owner_registration = owner_registration;
    }

    public String getOwner_bankbook() {
        return owner_bankbook;
    }

    public void setOwner_bankbook(String owner_bankbook) {
        this.owner_bankbook = owner_bankbook;
    }

    public String getOwner_rdate() {
        return owner_rdate;
    }

    public void setOwner_rdate(String owner_rdate) {
        this.owner_rdate = owner_rdate;
    }

    public String getApproval_status() {
        return approval_status;
    }

    public void setApproval_status(String approval_status) {
        this.approval_status = approval_status;
    }

}
