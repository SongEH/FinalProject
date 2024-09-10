package first.final_project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.CompletedDeliveryVo;

@Mapper
public interface CommissionMapper {

    List<CompletedDeliveryVo> getCompletedDeliveriesWithCommission(int raiders_id);

    void insertCommission(Map<String, Object> params);
}
