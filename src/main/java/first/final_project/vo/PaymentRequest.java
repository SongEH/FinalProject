package first.final_project.vo;

public class PaymentRequest {

    private String imp_uid;
    private String merchant_uid;

    // Getters and Setters
    public String getImp_uid() {
        return imp_uid;
    }

    public void setImp_uid(String imp_uid) {
        this.imp_uid = imp_uid;
    }

    public String getMerchant_uid() {
        return merchant_uid;
    }

    public void setMerchant_uid(String merchant_uid) {
        this.merchant_uid = merchant_uid;
    }
}
