package first.final_project.service;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class PaymentService {

    @Value("${imp.api.key}")
    private String apiKey;

    @Value("${imp.api.secretkey}")
    private String secretKey;

    private final String IMP_KEY = apiKey;
    private final String IMP_SECRET = secretKey;

    public String getAccessToken() throws Exception {
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            HttpPost httpPost = new HttpPost("https://api.iamport.kr/users/getToken");
            httpPost.setHeader("Content-Type", "application/json");

            String json = "{\"imp_key\":\"" + IMP_KEY + "\",\"imp_secret\":\"" + IMP_SECRET + "\"}";
            StringEntity entity = new StringEntity(json);
            httpPost.setEntity(entity);

            try (CloseableHttpResponse response = client.execute(httpPost)) {
                ObjectMapper mapper = new ObjectMapper();
                JsonNode node = mapper.readTree(response.getEntity().getContent());
                return node.get("response").get("access_token").asText();
            }
        }
    }

    public JsonNode getPaymentData(String impUid, String accessToken) throws Exception {
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            HttpGet httpGet = new HttpGet("https://api.iamport.kr/payments/" + impUid);
            httpGet.setHeader("Authorization", accessToken);

            try (CloseableHttpResponse response = client.execute(httpGet)) {
                ObjectMapper mapper = new ObjectMapper();
                return mapper.readTree(response.getEntity().getContent()).get("response");
            }
        }
    }
}
