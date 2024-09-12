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

    public Map<String, Object> getDeliveries(int raiders_id, String startDate, String endDate, int page,
            int blockList) {
        // 기본 페이징 설정
        int blockPage = 5; // 한 번에 보여줄 페이지 번호 개수
        boolean isFiltering = (startDate != null && endDate != null); // 필터링 여부 확인

        // 총 배달 건수 계산 (필터링된 날짜 범위가 있는 경우 필터링된 데이터만 계산)
        int rowTotal;
        if (isFiltering) {
            rowTotal = commissionMapper.getFilteredCount(raiders_id, startDate, endDate);
        } else {
            rowTotal = commissionMapper.getTotalCount(raiders_id); // 전체 배달 내역 개수
        }

        // 페이지 처리
        int totalPage = (rowTotal + blockList - 1) / blockList;
        if (page < 1)
            page = 1;
        if (page > totalPage)
            page = totalPage;

        int offset = (page - 1) * blockList;
        if (offset < 0) {
            offset = 0; // 음수 값 방지
        }

        // 파라미터 설정
        Map<String, Object> params = new HashMap<>();
        params.put("raiders_id", raiders_id);
        params.put("offset", offset);
        params.put("blockList", blockList);

        if (isFiltering) {
            params.put("startDate", startDate);
            params.put("endDate", endDate);
        }

        // 필터링된 배달 내역을 가져오거나 전체 배달 내역을 가져옴
        List<CompletedDeliveryVo> deliveries;
        if (isFiltering) {
            deliveries = commissionMapper.selectFilteredDeliveries(params);
        } else {
            deliveries = commissionMapper.selectPageList(params);
        }

        // 총 수수료 계산
        double totalCommission;
        if (isFiltering) {
            totalCommission = commissionMapper.selectTotalCommissionByDate(params); // 특정 기간 내 총 수수료
        } else {
            totalCommission = commissionMapper.selectTotalCommission(raiders_id); // 전체 배달에 대한 총 수수료
        }

        // 페이징 메뉴 생성
        String pageMenu = Paging.getPaging("list.do?raiders_id=" + raiders_id, page, rowTotal, blockList, blockPage);

        // 결과 데이터 반환
        Map<String, Object> result = new HashMap<>();
        result.put("deliveries", deliveries);
        result.put("totalCommission", totalCommission);
        result.put("pageMenu", pageMenu);

        return result;
    }

    // 총 수수료를 DB에 저장하는 메서드
    public void saveTotalCommission(int raiders_id, double totalCommission) {
        Map<String, Object> params = new HashMap<>();
        params.put("raiders_id", raiders_id);
        params.put("totalCommission", totalCommission);

        commissionMapper.insertTotalCommission(params); // DB에 총 수수료 저장
    }

}