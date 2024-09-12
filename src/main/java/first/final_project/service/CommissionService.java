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

    // 의존성 주입을 통해 CommissionMapper를 사용하여 데이터베이스와 상호작용
    private final CommissionMapper commissionMapper;

    // 생성자를 통해 CommissionMapper를 주입받아 사용
    public CommissionService(CommissionMapper commissionMapper) {
        this.commissionMapper = commissionMapper;
    }

    // 라이더의 완료된 배달 목록을 페이징 처리하여 가져오는 메서드
    public Map<String, Object> getPagedDeliveries(int raiders_id, int page) {
        // 한 페이지에 보여줄 배달 목록의 개수 (BLOCK_LIST)
        int blockList = MyCommon.Commission.BLOCK_LIST;
        // 한 화면에 보여줄 페이지 번호의 개수 (BLOCK_PAGE)
        int blockPage = MyCommon.Commission.BLOCK_PAGE;

        // 해당 라이더의 완료된 배달 총 개수를 가져옴
        int rowTotal = commissionMapper.getTotalCount(raiders_id);

        // 전체 페이지 수를 계산
        // 전체 배달 건수를 한 페이지당 보여줄 배달 개수로 나누어 총 페이지 수를 구함
        int totalPage = (rowTotal + blockList - 1) / blockList;

        // 페이지 경계 처리
        // 페이지가 1보다 작은 경우 1로 설정, 페이지가 전체 페이지 수를 초과할 경우 마지막 페이지로 설정
        if (page < 1)
            page = 1;
        if (page > totalPage)
            page = totalPage;

        // 페이징 처리에 따른 시작점(offset)을 계산
        int offset = (page - 1) * blockList;

        // 데이터베이스 쿼리에 사용할 파라미터를 Map에 담아 전달
        Map<String, Object> params = new HashMap<>();
        params.put("raiders_id", raiders_id); // 라이더 ID
        params.put("offset", offset); // 데이터 시작 위치
        params.put("blockList", blockList); // 한 페이지에 보여줄 목록의 개수

        // 페이징 처리된 배달 목록을 가져옴
        List<CompletedDeliveryVo> deliveries = commissionMapper.selectPageList(params);

        // 페이징 메뉴를 생성
        String pageMenu = Paging.getPaging("list.do?raiders_id=" + raiders_id, page, rowTotal, blockList, blockPage);

        // 라이더의 총 수수료를 계산
        double totalCommission = commissionMapper.selectTotalCommission(raiders_id);

        // 최종적으로 JSP로 반환할 데이터를 Map에 담아 반환
        Map<String, Object> result = new HashMap<>();
        result.put("deliveries", deliveries); // 배달 목록 데이터
        result.put("totalCommission", totalCommission); // 총 수수료 데이터
        result.put("pageMenu", pageMenu); // 페이징 메뉴 데이터

        return result; // JSP로 전달할 데이터 Map 반환
    }
}
