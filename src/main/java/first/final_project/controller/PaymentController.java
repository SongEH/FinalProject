package first.final_project.controller;

import java.io.IOException;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import jakarta.servlet.http.HttpSession;

@Controller
public class PaymentController {

    private IamportClient api;

    @Value("${imp.api.key}")
    private String apiKey;

    @Value("${imp.api.secretkey}")
    private String secretKey;

    @RequestMapping("pay/find_addr.do")
    public String payment() {

        return "order/pay";
    }

    @ResponseBody
    @RequestMapping(value = "paymenet//verifyIamport/{imp_uid}")
    public IamportResponse<Payment> paymentByImpUid(
            Model model, Locale locale, HttpSession session, @PathVariable(value = "imp_uid") String imp_uid)
            throws IamportResponseException, IOException {
        return api.paymentByImpUid(imp_uid);
    }
}
