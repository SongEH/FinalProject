package com.delivery.finalproject.mapper;

import com.delivery.finalproject.vo.AddrVo;
import com.delivery.finalproject.vo.OrderVo;
import com.delivery.finalproject.vo.ShopVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface RiderMapper {

    OrderVo getOrderById(int orders_id);

    void updateOrderStatus(@Param("orders_id") int orders_id, @Param("status") String status);

    int assignDelivery(@Param("riders_id") int riders_id, @Param("method") String method,
            @Param("orders_id") int orders_id);

    int insertDeliveryHistory(@Param("status") String status, @Param("deliveriesId") int deliveries_id);

    List<OrderVo> findOrdersByStatus(@Param("status") String status);

    List<OrderVo> findOrdersByRiderAndStatus(Map<String, Object> params);

    AddrVo getAddrById(@Param("addr_id") int addr_id);

    ShopVo getShopById(@Param("shop_id") int shop_id);

    // 라이더가 완료한 배달 내역 가져오기
    List<OrderVo> findCompletedOrdersByRider(@Param("riders_id") int riders_id);
}
