package first.final_project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.CompletedDeliveryVo;

@Mapper
public interface CommissionMapper {

    // 특정 라이더의 완료된 배달 목록을 가져오는 메서드
    List<CompletedDeliveryVo> selectList(int raiders_id);

    // 라이더의 배달 수수료 정보를 데이터베이스에 저장하는 메서드
    void insertCommission(Map<String, Object> params);

    // 특정 라이더의 총 수수료를 계산하는 메서드 (MyBatis에서 작성된 쿼리와 연결)
    Double selectTotalCommission(int raiders_id);

    // 특정 라이더의 특정 배달 건에 대해 수수료 정보가 이미 존재하는지 확인하는 메서드 (존재 여부를 boolean으로 반환)
    boolean commissionExists(int raiders_id, int deliveries_id);

    // 특정 라이더와 배달 건에 대해 수수료가 존재하는지 확인하는 메서드 (Map으로 전달된 파라미터 기반)
    int commissionExists(Map<String, Object> params);

    // 특정 라이더의 완료된 배달 목록을 페이징 처리하여 가져오는 메서드
    // raiders_id: 라이더 ID, offset: 데이터를 가져올 시작 위치, blockList: 한 페이지당 보여줄 목록의 개수
    List<CompletedDeliveryVo> selectPageList(int raiders_id, int offset, int blockList);

    // 특정 라이더의 완료된 배달 건수(총 개수)를 가져오는 메서드
    int getTotalCount(int raiders_id);

    // 특정 라이더의 완료된 배달 목록을 Map 형태로 전달된 파라미터를 기반으로 페이징 처리하여 가져오는 메서드
    List<CompletedDeliveryVo> selectPageList(Map<String, Object> params);

    // 총 수수료를 저장하는 메서드
    void insertTotalCommission(Map<String, Object> params);

    // <!-- 라이더 배달내역에 따른 월별,일별 수입 TEST -->
    // 라이더의 날짜 범위에 따른 배달 내역 조회
    List<CompletedDeliveryVo> selectFilteredDeliveries(Map<String, Object> params);

    // 라이더의 날짜 범위에 따른 총 수수료 조회
    double selectTotalCommissionByDate(Map<String, Object> params);

    int getFilteredCount(int raiders_id, String startDate, String endDate);
}
