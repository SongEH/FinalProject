package first.final_project.dao;

import java.util.List;
<<<<<<< HEAD

import org.apache.ibatis.annotations.Mapper;
=======
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
>>>>>>> main

import first.final_project.vo.OrderVo;

@Mapper
public interface OrderMapper {

    List<OrderVo> selectList(int i);

    OrderVo selectOne(int orders_id);

    int insert(OrderVo vo);

    int delete(int orders_id);

<<<<<<< HEAD
}
=======
    List<OrderVo> getAcceptOrderList(Map<String, Object> params);

    void updateOrderStatus(@Param("orders_id") int orders_id, @Param("status") String status);

    void deleteOrder(@Param("orders_id") int orders_id);

}
>>>>>>> main
