package first.final_project.service;

import lombok.Data;

@Data
public class TokenRequest {

    public TokenRequest(String impkey, String impsecret) {
        this.impkey = impkey;
        this.impsecret = impsecret;
    }

    private String impkey;
    private String impsecret;

}
