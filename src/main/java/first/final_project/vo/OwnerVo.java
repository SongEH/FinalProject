package first.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;
@Data
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

    String member_name;

   
}
