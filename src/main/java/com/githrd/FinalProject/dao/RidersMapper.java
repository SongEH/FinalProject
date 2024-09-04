package com.githrd.FinalProject.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.githrd.FinalProject.vo.AddrVo;
import com.githrd.FinalProject.vo.OrderVo;
import com.githrd.FinalProject.vo.RidersVo;
import com.githrd.FinalProject.vo.ShopVo;

@Mapper
public interface RidersMapper {

    List<RidersVo> selectList();

    RidersVo selectOneFromId(int riders_id); // mem_idx

    RidersVo selectOneFromEmail(String riders_email); // mem_id

    int insert(RidersVo vo);

    int update(RidersVo vo);

    int delete(int riders_id);

    // =======
    OrderVo getOrderById(int orders_id);

    void updateOrderStatus(@Param("orders_id") int orders_id, @Param("status") String status);

    int assignDelivery(@Param("") int riders_id, @Param("deliveries_method") String deliveries_method,
            @Param("orders_id") int orders_id);

    int insertDeliveryHistory(@Param("status") String status, @Param("deliveries_id") int deliveries_id);

    List<OrderVo> findOrdersByStatus(@Param("status") String status);

    List<OrderVo> findOrdersByRiderAndStatus(Map<String, Object> params);

    AddrVo getAddrById(@Param("addr_id") int addr_id);

    ShopVo getShopById(@Param("shop_id") int shop_id);

    // 라이더가 완료한 배달 내역 가져오기
    List<OrderVo> findCompletedOrdersByRider(@Param("riders_id") int riders_id);
}
