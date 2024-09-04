package first.final_project.vo;

import org.apache.ibatis.type.Alias;

@Alias("admin")
public class AdminVo {
    int admin_id;
    String admin_accountId;
    String admin_pwd;

    public int getAdmin_id() {
        return admin_id;
    }

    public void setAdmin_id(int admin_id) {
        this.admin_id = admin_id;
    }

    public String getAdmin_accountId() {
        return admin_accountId;
    }

    public void setAdmin_accountId(String admin_accountId) {
        this.admin_accountId = admin_accountId;
    }

    public String getAdmin_pwd() {
        return admin_pwd;
    }

    public void setAdmin_pwd(String admin_pwd) {
        this.admin_pwd = admin_pwd;
    }

}
