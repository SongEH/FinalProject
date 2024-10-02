package first.final_project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
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

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    public List<OrderVo> getAcceptOrderList(int owner_id, String status) {
        Map<String, Object> params = new HashMap<>();
        params.put("owner_id", owner_id);
        params.put("status", status);

        return order_mapper.getAcceptOrderList(params);
    }

    @Transactional
    public void updateOrderStatus(int orders_id, String status) {

        order_mapper.updateOrderStatus(orders_id, status);

        Map<String, Object> message = new HashMap<>();
        message.put("orderStatus", "주문 정보가 업데이트되었습니다.");
        message.put("orders_id", orders_id);

        messagingTemplate.convertAndSend("/topic/orders", message);
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

    public void softDelete(int orders_id) {
        order_mapper.softDelete(orders_id);
    }

    public Map<String, Object> getPagedOrder(int member_id, int page) {

        int blockList = MyCommon.Order.BLOCK_LIST;

        int blockPage = MyCommon.Order.BLOCK_PAGE;

        int rowTotal = order_mapper.getTotalCount(member_id);

        int totalPage = (rowTotal + blockList - 1) / blockList;

        if (totalPage == 0) {
            totalPage = 1;
        }

        if (page < 1)
            page = 1;
        if (page > totalPage)
            page = totalPage;

        int offset = (page - 1) * blockList;

        Map<String, Object> params = new HashMap<>();
        params.put("member_id", member_id);
        params.put("offset", offset);
        params.put("blockList", blockList);

        List<OrderVo> order_list = order_mapper.selectPageList(params);

        String pageMenu = Paging.getPaging("list.do?member_id=" + member_id, page, rowTotal, blockList, blockPage);

        Map<String, Object> result = new HashMap<>();
        result.put("order_list", order_list);
        result.put("pageMenu", pageMenu);

        return result;
    }

    public Map<String, Object> getPagedOrder(int member_id, int page, String startDate, String endDate) {
        
        int blockList = MyCommon.Order.BLOCK_LIST;
     
        int blockPage = MyCommon.Order.BLOCK_PAGE;
       
        int rowTotal = order_mapper.getTotalCountByDate(member_id, startDate, endDate);

        
        int totalPage = (rowTotal + blockList - 1) / blockList;
      
        if (page < 1)
            page = 1;
        if (page > totalPage)
            page = totalPage;

       
        int offset = (page - 1) * blockList;
        if (offset < 0) {
            offset = 0; /
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
