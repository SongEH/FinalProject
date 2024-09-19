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

    int delete(int orders_id);

    OrderVo selectOneByOrdersId(int orders_id);

    List<OrderVo> getAcceptOrderList(Map<String, Object> params);

    void updateOrderStatus(@Param("orders_id") int orders_id, @Param("status") String status);

    void deleteOrder(@Param("orders_id") int orders_id);

    List<OrderVo> getCompleteOrderList(Map<String, Object> params);


    int getShopIdByOrderId(int orders_id);

}
