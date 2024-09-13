package first.final_project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import first.final_project.vo.OrderVo;

@Mapper
public interface OrderMapper {

    List<OrderVo> selectList();

    OrderVo selectOne(int carts_id);

    int insert(OrderVo vo);

    int delete(int carts_id);

    List<OrderVo> getAcceptOrderList(Map<String, Object> params);

    void updateOrderStatus(@Param("orders_id") int orders_id, @Param("status") String status);

    void deleteOrder(@Param("orders_id") int orders_id);

}
