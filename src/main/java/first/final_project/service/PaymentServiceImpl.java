package first.final_project.service;

import org.springframework.stereotype.Service;

import first.final_project.vo.PaymentOutVo;

@Service
public class PaymentServiceImpl implements PaymentService {

    @Override
    public boolean processPayment(String impUid) {
        // 1. imp_uid로 아임포트 API를 통해 결제 정보 조회
        PaymentOutVo PaymentVo = findPaymentFromIamport(impUid);

        // 2. merchant_uid로 데이터베이스에서 결제되었어야 하는 금액 조회
        int amountToBePaid = findAmountToBePaid(PaymentVo.getMerchantUid());

        // 3. 결제 상태 및 금액 확인
        if ("paid".equals(PaymentVo.getStatus()) && PaymentVo.getAmount() == amountToBePaid) {
            // 성공 처리
            successPostProcess(PaymentVo);
            return true;
        } else if ("ready".equals(PaymentVo.getStatus()) && "vbank".equals(PaymentVo.getPayMethod())) {
            // 가상계좌 발급 처리
            vbankNumberAssigned(PaymentVo);
            return true;
        } else {
            // 실패 처리
            failPostProcess(PaymentVo);
            return false;
        }
    }

    private PaymentOutVo findPaymentFromIamport(String impUid) {
        // 여기에 아임포트 REST API를 사용하여 결제 정보를 조회하는 로직을 작성합니다.
        // 예: RestTemplate 또는 HttpClient를 사용하여 API 호출
        return new PaymentOutVo(); // 조회한 결제 정보를 반환
    }

    private int findAmountToBePaid(String merchantUid) {
        // 여기에 merchant_uid를 기반으로 결제되어야 하는 금액을 조회하는 로직을 작성합니다.
        // 예: 데이터베이스 조회
        return 14000; // 예시로 14000원을 반환
    }

    private void successPostProcess(PaymentOutVo PaymentVo) {
        // 결제 성공 후 처리 로직 작성
    }

    private void vbankNumberAssigned(PaymentOutVo PaymentVo) {
        // 가상계좌 발급 성공 처리 로직 작성
    }

    private void failPostProcess(PaymentOutVo PaymentVo) {
        // 결제 실패 처리 로직 작성
    }
}
