package first.final_project.service;

public interface OrderService {

    boolean verifyPayment(String impUid, String merchantUid);

    void updateOrderStatus(String merchantUid, String status);
}
