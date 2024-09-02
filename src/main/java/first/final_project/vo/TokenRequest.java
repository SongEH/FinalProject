package first.final_project.vo;

import lombok.Data;

@Data
public class TokenRequest {

    private String imp_key;
    private String imp_secret;

    public TokenRequest(String imp_key, String imp_secret) {
        this.imp_key = imp_key;
        this.imp_secret = imp_secret;
    }

}
