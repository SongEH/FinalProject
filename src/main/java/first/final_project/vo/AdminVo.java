package first.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("admin")
@Data
public class AdminVo {
    int admin_id;
    String admin_accountId;
    String admin_pwd;

}
