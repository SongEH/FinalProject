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

    // 의존성 주입을 통한 데이터베이스 매핑 객체
    private final CommissionMapper commissionMapper;

    // 생성자를 통해 CommissionMapper를 주입받아 사용
    public CommissionService(CommissionMapper commissionMapper) {
        this.commissionMapper = commissionMapper;
    }

    // 라이더 ID와 페이지 번호를 기반으로 페이징 처리된 배달 데이터를 가져오는 메서드
    public Map<String, Object> getPagedDeliveries(int raiders_id, int page) {
        // 한 페이지당 보여질 배달 목록의 개수 (BLOCK_LIST)
        int blockList = MyCommon.Commission.BLOCK_LIST;
        // 한 화면에 보여질 페이지 번호의 개수 (BLOCK_PAGE)
        int blockPage = MyCommon.Commission.BLOCK_PAGE;

        // 전체 데이터 개수(배달 건수)를 가져옴
        int rowTotal = commissionMapper.getTotalCount(raiders_id);

        // 전체 페이지 수를 계산 (총 배달 건수를 한 페이지당 보여줄 목록 수로 나눈 값)
        int totalPage = (rowTotal + blockList - 1) / blockList;

        // 경계 처리: 페이지 값이 1보다 작으면 1로 설정, 페이지 값이 전체 페이지 수보다 크면 마지막 페이지로 설정
        if (page < 1)
            page = 1;
        if (page > totalPage)
            page = totalPage;

        // 페이지 번호에 따른 데이터 가져오기: 몇 번째 데이터부터 가져올지 계산 (offset)
        int offset = (page - 1) * blockList;

        // 데이터베이스 쿼리에서 사용할 파라미터를 Map에 담아 전달
        Map<String, Object> params = new HashMap<>();
        params.put("raiders_id", raiders_id); // 라이더 ID
        params.put("offset", offset); // 시작 지점 (offset)
        params.put("blockList", blockList); // 한 페이지당 보여줄 데이터 수 (limit)

        // 페이징 처리된 배달 데이터를 가져옴
        List<CompletedDeliveryVo> deliveries = commissionMapper.selectPageList(params);

        // 페이징 메뉴 생성 (화면 하단에 페이지 번호를 표시하기 위한 HTML 생성)
        String pageMenu = Paging.getPaging("list.do?raiders_id=" + raiders_id, page, rowTotal, blockList, blockPage);

        // 라이더의 총 수수료 계산
        double totalCommission = commissionMapper.selectTotalCommission(raiders_id);

        // 최종적으로 JSP로 반환할 데이터를 Map에 담아 반환
        Map<String, Object> result = new HashMap<>();
        result.put("deliveries", deliveries); // 배달 목록 데이터
        result.put("totalCommission", totalCommission); // 총 수수료 데이터
        result.put("pageMenu", pageMenu); // 페이징 메뉴

        return result; // JSP로 전달될 데이터 Map
    }

}

// public Map<String, Object> getPagedDeliveries(int raiders_id, int page) {
// // TODO Auto-generated method stub
// throw new UnsupportedOperationException("Unimplemented method
// 'getPagedDeliveries'");
// }

// 라이더 ID와 페이지 번호를 기반으로 페이징 처리된 배달 데이터를 가져오는 메서드
// public Map<String, Object> getPagedDeliveries(int raiders_id, int page) {
// // 한 페이지당 보여질 배달 목록의 개수 (BLOCK_LIST)
// int blockList = MyCommon.Commission.BLOCK_LIST;
// // 한 화면에 보여질 페이지 번호의 개수 (BLOCK_PAGE)
// int blockPage = MyCommon.Commission.BLOCK_PAGE;

// // 전체 데이터 개수(배달 건수)를 가져옴
// int rowTotal = commissionMapper.getTotalCount(raiders_id);

// // 전체 페이지 수를 계산 (총 배달 건수를 한 페이지당 보여줄 목록 수로 나눈 값)
// int totalPage = (rowTotal + blockList - 1) / blockList;

// // 경계 처리: 페이지 값이 1보다 작으면 1로 설정, 페이지 값이 전체 페이지 수보다 크면 마지막 페이지로 설정
// if (page < 1)
// page = 1;
// if (page > totalPage)
// page = totalPage;

// // 페이지 번호에 따른 데이터 가져오기: 몇 번째 데이터부터 가져올지 계산 (offset)
// int offset = (page - 1) * blockList;

// // 데이터베이스 쿼리에서 사용할 파라미터를 Map에 담아 전달
// Map<String, Object> params = new HashMap<>();
// params.put("raiders_id", raiders_id); // 라이더 ID
// params.put("offset", offset); // 시작 지점 (offset)
// params.put("blockList", blockList); // 한 페이지당 보여줄 데이터 수 (limit)

// // 페이징 처리된 배달 데이터를 가져옴
// List<CompletedDeliveryVo> deliveries =
// commissionMapper.selectPageList(params);

// // 페이징 메뉴 생성 (화면 하단에 페이지 번호를 표시하기 위한 HTML 생성)
// String pageMenu = Paging.getPaging("list.do?raiders_id=" + raiders_id, page,
// rowTotal, blockList, blockPage);

// // 라이더의 총 수수료 계산
// double totalCommission = commissionMapper.selectTotalCommission(raiders_id);

// // 최종적으로 JSP로 반환할 데이터를 Map에 담아 반환
// Map<String, Object> result = new HashMap<>();
// result.put("deliveries", deliveries); // 배달 목록 데이터
// result.put("totalCommission", totalCommission); // 총 수수료 데이터
// result.put("pageMenu", pageMenu); // 페이징 메뉴

// return result; // JSP로 전달될 데이터 Map
// }

// public List<CompletedDeliveryVo> getPagedDeliveries(Map<String, Object>
// params) {
// // TODO Auto-generated method stub
// throw new UnsupportedOperationException("Unimplemented method
// 'getPagedDeliveries'");
// }
