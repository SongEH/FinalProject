package first.final_project.service;

import org.springframework.beans.factory.annotation.Value;
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

    @Value("${kakao.api.key}")
    private String apiKey;

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

    // 좌표 간 거리 계산 (Haversine Formula)
    public double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
        double earthRadius = 6371e3; // 지구 반지름 (미터)
        double dLat = Math.toRadians(lat2 - lat1);
        double dLon = Math.toRadians(lon2 - lon1);
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2)
                + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2))
                * Math.sin(dLon / 2) * Math.sin(dLon / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return earthRadius * c;  // 거리 (미터 단위)
    }
}
