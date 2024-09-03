package first.final_project.util;

import java.io.IOException;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.AccessToken;
import com.siot.IamportRestClient.response.IamportResponse;

public class GetToken {

    public void IamGetToken() {
        System.err.println(">>> testGetToken");
        IamportClient client = new IamportClient("5625016054463015",
                "1U0EWkXpNH5tCbQSXhfFtQmQ0ciaNfgG5g5guMt8PiC6Shvn1djKoIeW0rsx9a7yBq9fGdpLrKcPUypQ");

        try {
            IamportResponse<AccessToken> auth_response = client.getAuth();
            System.err.println("getMessage : " + auth_response.getMessage());
            System.err.println("getResponse : " + auth_response.getResponse());

            AccessToken result = auth_response.getResponse();
            System.err.println("___getToken : " + result.getToken());
            System.err.println("___getClass : " + result.getClass());
        } catch (IamportResponseException e) {
            System.err.println(e.getMessage());

            switch (e.getHttpStatusCode()) {
                case 401:
                    System.err.println("401");
                    break;
                case 500:
                    System.err.println("500");
                    break;
            }
        } catch (IOException e) {
            // 서버 연결 실패
            e.printStackTrace();
        }
    }
}
