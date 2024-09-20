package first.final_project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import first.final_project.vo.OrderVo;

@Mapper
public interface OrderMapper {

    List<OrderVo> selectList(int i);

    OrderVo selectOne(int orders_id);

    int insert(OrderVo vo);

    void softDelete(int orders_id);

    OrderVo selectOneByOrdersId(int orders_id);

    List<OrderVo> getAcceptOrderList(Map<String, Object> params);

    void updateOrderStatus(@Param("orders_id") int orders_id, @Param("status") String status);

    void deleteOrder(@Param("orders_id") int orders_id);

    List<OrderVo> getCompleteOrderList(Map<String, Object> params);

    ///////////////////// 페이징 //////////////////////
    // 회원의 총 주문 건수
    int getTotalCount(int member_id);

    // 회원의 주문 목록을 페이징 처리
    List<OrderVo> selectPageList(Map<String, Object> params);

    // 회원의 주문 건수를 날짜 범위에 맞게 가져옴
    int getTotalCountByDate(int member_id, String startDate, String endDate);

    // 회원의 주문 목록을 날짜 범위에 맞게 페이징 처리
    List<OrderVo> selectPageListByDate(Map<String, Object> params);
    ///////////////////// 페이징 END //////////////////////

    int getShopIdByOrderId(int orders_id);

}
