package first.final_project.dao;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.PayVo;

@Mapper
public interface PayMapper {

    // 결제 내역 추가
    int insert(PayVo vo);

    // 결제 내역 수정
    int update(PayVo vo);
}
