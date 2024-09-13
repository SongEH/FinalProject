package first.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("DeliveryHistory")
public class DeliveryHistoryVo {
    private int delivery_history_id;
    private String delivery_history_status;
    private int deliveries_id;
}
