package first.final_project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import first.final_project.dao.OrderMapper;
import first.final_project.vo.OrderVo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

}
