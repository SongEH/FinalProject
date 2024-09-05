package first.final_project.service;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class KakaoMapService {

    private final String apiKey = "468780eb2df5022cd5c83fcacdc8b927"; // 실제 API 키를 넣으세요

    public double[] getCoordinates(String address) throws Exception {
        String url = "https://dapi.kakao.com/v2/local/search/address.json?query=" + address;

        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "KakaoAK " + apiKey);

        HttpEntity<String> entity = new HttpEntity<>(headers);

        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);

        ObjectMapper mapper = new ObjectMapper();
        JsonNode root = mapper.readTree(response.getBody());
        JsonNode documents = root.path("documents");

        if (documents.isArray() && documents.size() > 0) {
            JsonNode location = documents.get(0).path("road_address"); // 도로명 주소 우선 사용
            if (location.isMissingNode()) {
                location = documents.get(0).path("address"); // 지번 주소 사용
            }
            double latitude = location.path("y").asDouble();
            double longitude = location.path("x").asDouble();
            return new double[] { latitude, longitude };
        }

        throw new RuntimeException("입력한 주소를 찾을 수 없습니다. 정확한 주소를 입력해주세요.");
    }
}
