package first.final_project.controller;

import java.io.IOException;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import first.final_project.service.PaymentServiceImpl;
import first.final_project.vo.PaymentInVo;
import jakarta.servlet.http.HttpSession;

@Controller
public class PaymentController {

    @Autowired
    PaymentServiceImpl paymentService;

    private IamportClient api;

    public void init() {
        this.api = new IamportClient(apiKey, secretKey);
    }

    @Value("${imp.api.key}")
    private String apiKey;

    @Value("${imp.api.secretkey}")
    private String secretKey;

    @RequestMapping("pay/find_addr.do")
    public String payment() {

        return "order/pay";
    }

    @ResponseBody
    @RequestMapping(value = "payment/verify_iamport/{imp_uid}")
    public IamportResponse<Payment> paymentByImpUid(
            Model model, Locale locale, HttpSession session, @PathVariable(value = "imp_uid") String imp_uid)
            throws IamportResponseException, IOException {
        System.out.println("여기도착");
        return api.paymentByImpUid(imp_uid);
    }

    @PostMapping("payment/complete")
    public ResponseEntity<String> completePayment(@RequestBody PaymentInVo paymentInVo) {
        try {
            boolean paymentSuccess = paymentService.processPayment(paymentInVo.getImpUid());

            if (paymentSuccess) {
                return ResponseEntity.ok("결제가 완료되었습니다.");
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("결제에 실패하였습니다.");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류가 발생하였습니다.");
        }
    }
}
