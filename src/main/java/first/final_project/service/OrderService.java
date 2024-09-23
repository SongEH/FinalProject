package first.final_project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import first.final_project.dao.OrderMapper;
import first.final_project.util.MyCommon;
import first.final_project.util.Paging;
import first.final_project.vo.OrderVo;

@Service
public class OrderService {

    @Autowired
    private OrderMapper order_mapper;

    // Websocket 활성화 시 주석 풀기
    // @Autowired
    // private SimpMessagingTemplate messagingTemplate;

    public List<OrderVo> getAcceptOrderList(int owner_id, String status) {
        Map<String, Object> params = new HashMap<>();
        params.put("owner_id", owner_id);
        params.put("status", status);

        return order_mapper.getAcceptOrderList(params);
    }

    @Transactional
    public void updateOrderStatus(int orders_id, String status) {
        // 주문 상태 업데이트
        order_mapper.updateOrderStatus(orders_id, status);

        // WebSocket으로 실시간 메시지 전송
        // messagingTemplate.convertAndSend("/topic/orders", "주문 상태가 업데이트 되었습니다.");
    }

    public void deleteOrder(int orders_id) {
        order_mapper.deleteOrder(orders_id);
    }

    public List<OrderVo> getCompleteOrderList(int owner_id, String status) {
        Map<String, Object> params = new HashMap<>();
        params.put("owner_id", owner_id);
        params.put("status", status);

        return order_mapper.getCompleteOrderList(params);
    }

    // 주문내역 삭제(소프트 삭제)
    public void softDelete(int orders_id) {
        order_mapper.softDelete(orders_id);
    }

    // 회원 주문목록 필터링
    // 1. 필터 없이 전체 주문 목록을 페이징 처리해서 가져오는 메서드
    public Map<String, Object> getPagedOrder(int member_id, int page) {

        // 한 페이지에 보여줄 주문 목록의 개수
        int blockList = MyCommon.Order.BLOCK_LIST;
        // 한 화면에 보여줄 페이지 번호의 개수
        int blockPage = MyCommon.Order.BLOCK_PAGE;
        // 해당 회원의 총 주문 개수를 가져옴
        int rowTotal = order_mapper.getTotalCount(member_id);

        // 전체 페이지 수 계산
        int totalPage = (rowTotal + blockList - 1) / blockList;
        // 페이지 경계 처리 (1보다 작을 경우 1로, 전체 페이지 수보다 클 경우 마지막 페이지로 설정)
        if (page < 1)
            page = 1;
        if (page > totalPage)
            page = totalPage;

        // 페이징 처리에 따른 시작점(offset) 계산
        int offset = (page - 1) * blockList;

        // 데이터베이스 쿼리에 사용할 파라미터를 Map에 담아 전달
        Map<String, Object> params = new HashMap<>();
        params.put("member_id", member_id); // 회원 ID
        params.put("offset", offset); // 가져올 데이터의 시작 위치
        params.put("blockList", blockList); // 한 페이지당 가져올 목록 개수

        // 페이징된 주문 목록을 가져옴
        List<OrderVo> order_list = order_mapper.selectPageList(params);

        // 페이징 메뉴를 생성 (HTML 형태로 페이지 번호 목록을 생성)
        String pageMenu = Paging.getPaging("list.do?member_id=" + member_id, page, rowTotal, blockList, blockPage);

        // 결과를 Map에 담아 반환
        Map<String, Object> result = new HashMap<>();
        result.put("order_list", order_list); // 주문 목록
        result.put("pageMenu", pageMenu); // 페이지 메뉴

        return result; // JSP로 반환할 데이터
    }

    // 필터(날짜 범위)가 적용된 데이터를 페이징 처리하여 가져오는 메서드
    public Map<String, Object> getPagedOrder(int member_id, int page, String startDate, String endDate) {
        // 한 페이지에 보여줄 배달 목록의 개수
        int blockList = MyCommon.Order.BLOCK_LIST;
        // 한 화면에 보여줄 페이지 Order 개수
        int blockPage = MyCommon.Order.BLOCK_PAGE;
        // 필터(날짜 범위)에 맞는 완료된 배달 총 개수를 가져옴
        int rowTotal = order_mapper.getTotalCountByDate(member_id, startDate, endDate);

        // 전체 페이지 수 계산
        int totalPage = (rowTotal + blockList - 1) / blockList;
        // 페이지 경계 처리 (1보다 작을 경우 1로, 전체 페이지 수보다 클 경우 마지막 페이지로 설정)
        if (page < 1)
            page = 1;
        if (page > totalPage)
            page = totalPage;

        // 페이징 처리에 따른 시작점(offset) 계산
        // int offset = (page - 1) * blockList;

        // 페이징 처리에 따른 시작점(offset) 계산
        int offset = (page - 1) * blockList;
        if (offset < 0) {
            offset = 0; // 음수 방지: offset이 음수인 경우 0으로 설정
        }

        // 데이터베이스 쿼리에 사용할 파라미터를 Map에 담아 전달
        Map<String, Object> params = new HashMap<>();
        params.put("member_id", member_id); // 라이더 ID
        params.put("offset", offset); // 가져올 데이터의 시작 위치
        params.put("blockList", blockList); // 한 페이지당 가져올 목록 개수
        params.put("startDate", startDate); // 필터: 시작 날짜
        params.put("endDate", endDate); // 필터: 종료 날짜

        // 페이징 처리된 필터된 배달 목록을 가져옴
        List<OrderVo> order_list = order_mapper.selectPageListByDate(params);

        // 필터와 함께 페이징 메뉴를 생성 (HTML 형태로 페이지 번호 목록을 생성)
        String pageMenu = Paging.getPaging(
                "list.do?member_id=" + member_id + "&startDate=" + startDate + "&endDate=" + endDate,
                page, rowTotal, blockList, blockPage);

        // 결과를 Map에 담아 반환 (배달 목록, 페이지 메뉴)
        Map<String, Object> result = new HashMap<>();
        result.put("order_list", order_list); // 필터된 배달 목록
        result.put("pageMenu", pageMenu); // 페이지 메뉴

        return result; // JSP로 반환할 데이터
    }

}
