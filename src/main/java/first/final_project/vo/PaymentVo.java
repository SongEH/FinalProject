package first.final_project.vo;

import lombok.Data;

@Data
public class PaymentVo {

    private String imp_uid;
    private String merchant_uid;

    public void setMerchant_uid(String merchant_uid) {
        this.merchant_uid = merchant_uid;
    }
}
