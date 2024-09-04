package first.final_project.vo;

import lombok.Data;

@Data
public class PayVo {

    private int pay_id;
    private String pay_merchant_uid;
    private String pay_status;
    private int orders_id;

    // // pay table
    // private String pay_id; // PK key
    // private String pay_merchant_uid; // 고유한 주문번호
    // private String pay_name; // 결제상품
    // private String pay_status; // 결제 상태 (결제완료(paid),결제취소)

    // //member table
    // private String member_name; // 회원이름
    // private String member_phone; // 회원 전화번호
    // private String addr_line1; // 회원 주소
    // private String addr_line2; // 회원 상세주소

    // // order table
    private String orders_payment; // 결제 방법
    private int orders_price; // 결제 금액
    // private String orders_cdate; //주문 생성일
    // private String orders_srequest; //가게 요청사항
    // private String

}
