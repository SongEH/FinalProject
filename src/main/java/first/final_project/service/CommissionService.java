package first.final_project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import first.final_project.dao.CommissionMapper;
import first.final_project.util.MyCommon;
import first.final_project.util.Paging;
import first.final_project.vo.CompletedDeliveryVo;

@Service
public class CommissionService {

    private final CommissionMapper commissionMapper;

    public CommissionService(CommissionMapper commissionMapper) {
        this.commissionMapper = commissionMapper;
    }

    public Map<String, Object> getPagedDeliveries(int raiders_id, int page) {
        // 한 페이지당 보여질 배달 목록의 개수 (BLOCK_LIST)
        int blockList = MyCommon.Commission.BLOCK_LIST;
        // 한 화면에 보여질 페이지 번호의 개수 (BLOCK_PAGE)
        int blockPage = MyCommon.Commission.BLOCK_PAGE;

        // 전체 데이터 개수(배달 건수)를 가져옴
        int rowTotal = commissionMapper.getTotalCount(raiders_id);

        // 전체 페이지 수를 계산
        int totalPage = (rowTotal + blockList - 1) / blockList;

        // 페이지 경계 처리
        if (page < 1)
            page = 1;
        if (page > totalPage)
            page = totalPage;

        // 몇 번째 데이터부터 가져올지 계산 (offset)
        int offset = (page - 1) * blockList;

        // 데이터베이스 쿼리에서 사용할 파라미터를 Map에 담아 전달
        Map<String, Object> params = new HashMap<>();
        params.put("raiders_id", raiders_id);
        params.put("offset", offset);
        params.put("blockList", blockList);

        // 페이징 처리된 배달 데이터를 가져옴
        List<CompletedDeliveryVo> deliveries = commissionMapper.selectPageList(params);

        // 페이징 메뉴 생성
        String pageMenu = Paging.getPaging("list.do?raiders_id=" + raiders_id, page, rowTotal, blockList, blockPage);

        // 라이더의 총 수수료 계산
        double totalCommission = commissionMapper.selectTotalCommission(raiders_id);

        // JSP로 반환할 데이터를 Map에 담아 반환
        Map<String, Object> result = new HashMap<>();
        result.put("deliveries", deliveries);
        result.put("totalCommission", totalCommission);
        result.put("pageMenu", pageMenu);

        return result; // JSP로 전달될 데이터
    }

    // 총 수수료를 DB에 저장하는 메서드
    public void saveTotalCommission(int raiders_id, double totalCommission) {
        Map<String, Object> params = new HashMap<>();
        params.put("raiders_id", raiders_id);
        params.put("totalCommission", totalCommission);

        commissionMapper.insertTotalCommission(params); // DB에 총 수수료 저장
    }

    // // <!-- 라이더 배달내역에 따른 월별,일별 수입 TEST -->
    // 라이더의 날짜 필터링된 배달 내역과 총 수수료 계산
    public Map<String, Object> getFilteredDeliveries(int raiders_id, String startDate, String endDate, int page) {
        int blockList = 10; // 한 페이지당 보여줄 배달 내역 개수
        int blockPage = 5; // 한 번에 보여줄 페이지 번호 개수

        // 총 배달 건수를 계산 (필터링된 날짜 범위 내에서)
        int rowTotal = commissionMapper.getTotalCount(raiders_id);

        // 페이지 처리
        int totalPage = (rowTotal + blockList - 1) / blockList;
        if (page < 1)
            page = 1;
        if (page > totalPage)
            page = totalPage;

        int offset = (page - 1) * blockList;

        // 날짜 범위 및 페이징을 위한 파라미터 설정
        Map<String, Object> params = new HashMap<>();
        params.put("raiders_id", raiders_id);
        params.put("startDate", startDate);
        params.put("endDate", endDate);
        params.put("offset", offset);
        params.put("blockList", blockList);

        // 필터링된 배달 내역을 가져옴
        List<CompletedDeliveryVo> deliveries = commissionMapper.selectFilteredDeliveries(params);

        // 필터링된 기간의 총 수수료 계산
        double totalCommission = commissionMapper.selectTotalCommissionByDate(params);

        // 페이징 메뉴 생성
        String pageMenu = Paging.getPaging("list.do?raiders_id=" + raiders_id, page, rowTotal, blockList, blockPage);

        // 결과 데이터 반환
        Map<String, Object> result = new HashMap<>();
        result.put("deliveries", deliveries);
        result.put("totalCommission", totalCommission);
        result.put("pageMenu", pageMenu);

        return result;
    }
}