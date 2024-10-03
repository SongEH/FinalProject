package first.final_project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import first.final_project.vo.AddrVo;
import first.final_project.vo.DeliveriesVo;
import first.final_project.vo.OrderVo;
import first.final_project.vo.RiderVo;
import first.final_project.vo.ShopVo;

@Mapper
public interface RidersMapper {

    List<RiderVo> selectList();

    RiderVo selectOneFromId(int riders_id); // mem_idx

    RiderVo selectOneFromEmail(String riders_email); // mem_id

    int insert(RiderVo vo);

    int update(RiderVo vo);

    int delete(int riders_id);

    OrderVo getOrderById(int orders_id);

    void updateOrderStatus(@Param("orders_id") int orders_id, @Param("status") String status);

    void updateDeliveryHistory(@Param("orders_id") int orders_id, @Param("status") String status);

    int assignDelivery(DeliveriesVo deliveriesVo);

    int insertDeliveryHistory(@Param("status") String status, @Param("deliveries_id") int deliveries_id);

    List<OrderVo> findOrdersByStatus(@Param("status") String status, @Param("raiders_id") int raiders_id);

    List<OrderVo> findOrdersByRiderAndStatus(Map<String, Object> params);

    AddrVo getAddrById(@Param("addr_id") int addr_id);

    ShopVo getShopById(@Param("shop_id") int shop_id);

    void updateDeliveryTime(@Param("orders_id") int orders_id, @Param("delivery_time") int delivery_time);

    List<OrderVo> findCompletedOrdersByRider(@Param("raiders_id") int raiders_id);

    double getTotalCommissionByRiderId(int raiders_id);
}
