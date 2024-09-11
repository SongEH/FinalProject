package first.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("admin")
public class AdminVo {
    int admin_id;
    String admin_accountId;
    String admin_pwd;

   
}
