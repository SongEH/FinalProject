package first.final_project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.CommissionVo;

@Mapper
public interface CommissionMapper {

    List<CommissionVo> selectList(int raiders_id);

    void insertCommission(Map<String, Object> params);

    Double selectTotalCommission(int raiders_id);

    boolean commissionExists(int raiders_id, int deliveries_id);

    int commissionExists(Map<String, Object> params);

    List<CommissionVo> selectPageList(int raiders_id, int offset, int blockList);

    int getTotalCount(int raiders_id);

    List<CommissionVo> selectPageList(Map<String, Object> params);

    int getTotalCountByDate(int raiders_id, String startDate, String endDate);

    List<CommissionVo> selectPageListByDate(Map<String, Object> params);

    double selectTotalCommissionByDate(int raiders_id, String startDate, String endDate);

}
