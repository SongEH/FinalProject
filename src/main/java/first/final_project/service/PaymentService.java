package first.final_project.service;

import java.io.IOException;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import first.final_project.dao.PaymentMapper;
import first.final_project.vo.PaymentVo;
import jakarta.annotation.PostConstruct;

@Service
public class PaymentService {

    @Autowired
    PaymentMapper paymentMapper;

    @Value("${imp.api.key}")
    private String apiKey;

    @Value("${imp.api.secretkey}")
    private String secretKey;

    private String IMP_KEY;
    private String IMP_SECRET;

    @PostConstruct
    public void init() {
        if (apiKey == null || secretKey == null) {
            throw new IllegalStateException("API KEY and secret key must be set");
        }
        this.IMP_KEY = apiKey;
        this.IMP_SECRET = secretKey;
    }

    // Access Token 가져오는 메서드
    public String getAccessToken() throws IOException {
        // HTTP 클라이언트 생성
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            // HTTP POST 요청 생성
            HttpPost httpPost = new HttpPost("https://api.iamport.kr/users/getToken");
            // HTTP POST 요청시 content type 설정 (JSON으로 받기)
            httpPost.setHeader("Content-Type", "application/json");
            // 데이터 형식은 json
            System.out.println(IMP_KEY);
            System.out.println(IMP_SECRET);
            String json = "{\"imp_key\":\"" + IMP_KEY + "\",\"imp_secret\":\"" + IMP_SECRET + "\"}";
            StringEntity entity = new StringEntity(json);
            httpPost.setEntity(entity);

            try (CloseableHttpResponse response = client.execute(httpPost)) {
                // JSON데이터를 JAVA로 변환
                ObjectMapper mapper = new ObjectMapper();
                JsonNode node = mapper.readTree(response.getEntity().getContent());
                return node.get("response").get("access_token").asText();
            }
        }
    }

    // 결제 데이터 조회 메서드
    public JsonNode getPaymentData(String impUid, String accessToken) throws IOException {
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            HttpGet httpGet = new HttpGet("https://api.iamport.kr/payments/" + impUid);
            httpGet.setHeader("Authorization", accessToken);

            try (CloseableHttpResponse response = client.execute(httpGet)) {
                ObjectMapper mapper = new ObjectMapper();
                return mapper.readTree(response.getEntity().getContent()).get("response");
            }
        }
    }

    public int insert(PaymentVo vo) throws Exception {

        return paymentMapper.insert(vo);
    }

    // //결제 취소 메서드
    // public JsonNode cancelPaymentByOrder(String impUid, int cancelAmount) throws IOException {
    //     String accessToken = getAccessToken(); // 결제 취소를 위해 access_token을 가져옴
    //     System.out.println("aaaaaa : " + accessToken);
        
    //     try (CloseableHttpClient client = HttpClients.createDefault()) {
    //         HttpPost httpPost = new HttpPost("https://api.iamport.kr/payments/cancel");
    //         httpPost.setHeader("Authorization", accessToken);
    //         httpPost.setHeader("Content-Type", "application/json");
    
    //         // JSON 형식의 요청 바디 구성
    //         String json = "{\"merchant_uid\":\"" + impUid + "\","
    //                     + "\"amount\":\"" + cancelAmount + "\","
    //                     + "\"reason\":\"주문 취소에 따른 결제 취소\"}";
    //         StringEntity entity = new StringEntity(json);
    //         httpPost.setEntity(entity);
    
    //         try (CloseableHttpResponse response = client.execute(httpPost)) {
    //             ObjectMapper mapper = new ObjectMapper();
    //             JsonNode node = mapper.readTree(response.getEntity().getContent());
    //             return node; // 취소 결과 반환
    //         }
    //     }
    // }

    // public PaymentVo getPaymentByOrderId(int orders_id) {
    //     return paymentMapper.selectPaymentByOrderId(orders_id);
    // }

    // shop_id 가져오기(웹소켓)
    public PaymentVo getPaymentByOrderId(int orders_id) {
        return paymentMapper.selectPaymentByOrderId(orders_id);
    }
    

}
// // 결제 데이터 검증 ( 고민되는 부분 영역)
// public void verifyPayment(String merchantUid, JsonNode payment) throws
// Exception {
// Order order = orderService.findById(merchantUid);

// if (order != null && order.getAmount() == payment.get("amount").asInt()) {
// switch (payment.get("status").asText()) {
// case "ready":
// // 가상 계좌 발급 시 처리 로직
// System.out.println("가상 계좌 발급 완료");
// break;
// case "paid":
// // 결제 완료 시 처리 로직
// System.out.println("결제 완료");
// break;
// default:
// System.out.println("알 수 없는 결제 상태: " + payment.get("status").asText());
// break;
// }
// } else {
// // 결제 금액 불일치 시 처리 (위조/변조 시도 의심)
// throw new Exception("결제 금액 불일치: 위조/변조 시도 의심");
// }
// }
