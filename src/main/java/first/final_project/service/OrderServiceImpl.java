package first.final_project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import first.final_project.repository.OrderRepository;
import first.final_project.vo.Order;

@Service
public class OrderServiceImpl implements OrderService {

    @Value("${iamport.api.key}")
    private String impkey;

    @Value("${iamport.api.secret}")
    private String impsecret;

    @Autowired
    private final OrderRepository orderRepository;

    @Autowired
    private final RestTemplate restTemplate;

    public OrderServiceImpl(OrderRepository orderRepository, RestTemplate restTemplate) {
        this.orderRepository = orderRepository;
        this.restTemplate = restTemplate;
    }

    @Override
    public void updateOrderStatus(String merchantUid, String status) {
        Order order = orderRepository.findByMerchantUid(merchantUid);
        if (order != null) {
            order.setStatus(status);
            orderRepository.save(order);
        }
    }

    private String extractAccessToken(String tokenResponse) {
        return "extracted_access_token";
    }

    @Override
    public boolean verifyPayment(String impUid, String merchantUid) {
        // Step 1: Get Access Token
        String tokenUrl = "https://api.iamport.kr/users/getToken";
        TokenRequest tokenRequest = new TokenRequest(impkey, impsecret);
        String tokenResponse = restTemplate.postForObject(tokenUrl, tokenRequest, String.class);

        String accessToken = extractAccessToken(tokenResponse);

        // Step 2: Verify Payment
        String paymentUrl = "https://api.iamport.kr/payments/" + impUid;
        PaymentResponse paymentResponse = restTemplate.getForObject(paymentUrl, PaymentResponse.class, accessToken);

        // Step 3: Validate Payment Details
        if (paymentResponse != null && "paid".equals(paymentResponse.getStatus())) {
            Order order = orderRepository.findByMerchantUid(merchantUid);
            return order != null && order.getAmount() == paymentResponse.getAmount();
        }
        return false;
    }

}
