package first.final_project.service;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;

@Service
public class PortOneService {

    private final IamportClient iamportClient;

    @Value("${imp.api.key}")
    private String apiKey;

    @Value("${imp.api.secretkey}")
    private String secretKey;

    public PortOneService() {
        this.iamportClient = new IamportClient(apiKey, secretKey);
    }

    public String issueToken() throws IamportResponseException, IOException {
        return iamportClient.getAuth().getResponse().getToken();
    }
}
