package first.final_project.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;

import first.final_project.vo.OrderVo;
import first.final_project.vo.PaymentVo;

@Mapper
public interface PaymentMapper {

    // 결제 내역 추가
    int insert(PaymentVo vo);

    // 결제 내역 수정
    int update(PaymentVo vo);

    // 가계 id 가져오기
    PaymentVo selectPaymentByOrderId(@Param("orders_id") int orders_id);

    // // 결제 취소
    // PaymentVo selectPaymentByOrderId(@Param("orders_id") int orders_id);
}
