package com.delivery.finalproject.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.delivery.finalproject.vo.AddrVo;
import com.delivery.finalproject.vo.DeliveriesVo;
import com.delivery.finalproject.vo.OrderVo;
import com.delivery.finalproject.vo.ShopVo;

@Mapper
public interface RiderMapper {

    OrderVo getOrderById(int orders_id);

    void updateOrderStatus(@Param("orders_id") int orders_id, @Param("status") String status);

    void updateDeliveryHistory(@Param("orders_id") int orders_id, @Param("status") String status);

    int assignDelivery(DeliveriesVo deliveriesVo);

    int insertDeliveryHistory(@Param("status") String status, @Param("deliveries_id") int deliveries_id);

    List<OrderVo> findOrdersByStatus(@Param("status") String status);

    List<OrderVo> findOrdersByRiderAndStatus(Map<String, Object> params);

    AddrVo getAddrById(@Param("addr_id") int addr_id);

    ShopVo getShopById(@Param("shop_id") int shop_id);

    // 라이더가 완료한 배달 내역 가져오기
    List<OrderVo> findCompletedOrdersByRider(@Param("raiders_id") int raiders_id);
}
