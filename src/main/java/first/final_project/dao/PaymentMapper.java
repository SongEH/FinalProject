package first.final_project.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;

import first.final_project.vo.PaymentVo;

@Mapper
public interface PaymentMapper {

    // 결제 내역 추가
    int insert(PaymentVo vo);

    // 결제 내역 수정
    int update(PaymentVo vo);
}
