package first.final_project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.CompletedDeliveryVo;

@Mapper
public interface CommissionMapper {

    List<CompletedDeliveryVo> selectList(int raiders_id);

    void insertCommission(Map<String, Object> params);

    Double selectTotalCommission(int raiders_id); // MyBatis 쿼리와 연결된 메소드

    boolean commissionExists(int raiders_id, int deliveries_id);

    int commissionExists(Map<String, Object> params);
}
