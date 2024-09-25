package first.final_project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.CommissionVo;

@Mapper
public interface CommissionMapper {

    // 특정 라이더의 완료된 배달 목록을 가져오는 메서드
    List<CommissionVo> selectList(int raiders_id);

    // 라이더의 배달 수수료 정보를 데이터베이스에 저장하는 메서드
    void insertCommission(Map<String, Object> params);

    // 특정 라이더의 총 수수료를 계산하는 메서드
    Double selectTotalCommission(int raiders_id);

    // 특정 라이더의 특정 배달 건에 대해 수수료 정보가 이미 존재하는지 확인하는 메서드
    boolean commissionExists(int raiders_id, int deliveries_id);

    // 특정 라이더와 배달 건에 대해 수수료가 존재하는지 확인하는 메서드
    int commissionExists(Map<String, Object> params);

    // 특정 라이더의 완료된 배달 목록을 페이징 처리하여 가져오는 메서드
    List<CommissionVo> selectPageList(int raiders_id, int offset, int blockList);

    // 특정 라이더의 완료된 배달 건수(총 개수)를 가져오는 메서드
    int getTotalCount(int raiders_id);

    // 특정 라이더의 완료된 배달 목록을 Map 형태로 전달된 파라미터를 기반으로 페이징 처리하여 가져오는 메서드
    List<CommissionVo> selectPageList(Map<String, Object> params);

    // 특정 라이더의 완료된 배달 건수를 날짜 범위에 맞게 가져오는 메서드
    int getTotalCountByDate(int raiders_id, String startDate, String endDate);

    // 특정 라이더의 완료된 배달 목록을 날짜 범위에 맞게 페이징 처리하여 가져오는 메서드
    List<CommissionVo> selectPageListByDate(Map<String, Object> params);

    // 특정 라이더의 총 수수료를 날짜 범위에 맞게 계산하는 메서드
    double selectTotalCommissionByDate(int raiders_id, String startDate, String endDate);

}
