package first.final_project.vo;

import lombok.Data;

@Data
public class PaymentOutVo {

    private String status;
    private String merchantUid;
    private int amount;
    private String payMethod;
}
