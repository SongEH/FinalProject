package first.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("rider")
public class RiderVo {
    private int raiders_id;
    private String rider_name;
    private String riders_phone;
    private String riders_email;
    private String riders_pwd;
    private String riders_region;
}
