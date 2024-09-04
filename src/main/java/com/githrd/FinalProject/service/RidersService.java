package com.githrd.FinalProject.service;

import com.githrd.FinalProject.dao.RidersMapper;
import com.githrd.FinalProject.vo.AddrVo;
import com.githrd.FinalProject.vo.DeliveriesVo;
import com.githrd.FinalProject.vo.OrderVo;
import com.githrd.FinalProject.vo.ShopVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class RidersService {

    @Autowired
    private RidersMapper ridersMapper;

    @Transactional
    public void updateOrderStatus(int orders_id, String status) {
        ridersMapper.updateOrderStatus(orders_id, status);
    }

    public OrderVo getOrderById(int orders_id) {
        return ridersMapper.getOrderById(orders_id);
    }

    public AddrVo getAddrById(int addr_id) {
        return ridersMapper.getAddrById(addr_id);
    }

    public ShopVo getShopById(int shop_id) {
        return ridersMapper.getShopById(shop_id);
    }

    public List<OrderVo> getOrdersByStatus(String status) {
        return ridersMapper.findOrdersByStatus(status);
    }

    public List<OrderVo> getOrdersByRiderAndStatus(int riders_id, String status) {
        Map<String, Object> params = new HashMap<>();
        params.put("riders_id", riders_id);
        params.put("status", status);
        return ridersMapper.findOrdersByRiderAndStatus(params);
    }

    @Transactional
    public synchronized boolean assignOrderToRider(int orders_id, int riders_id, String deliveries_method) {
        OrderVo order = ridersMapper.getOrderById(orders_id);
        if (order == null || !order.getOrders_status().equals("배차 대기")) {
            return false; // 이미 수락된 주문이거나 존재하지 않는 경우
        }

        ridersMapper.updateOrderStatus(orders_id, "배차 완료");

        // int deliveries_id = riderMapper.assignDelivery(riders_id, deliveries_method,
        // orders_id);
        DeliveriesVo deliveriesVo = new DeliveriesVo();
        deliveriesVo.setRiders_id(riders_id);
        deliveriesVo.setDeliveries_method(deliveries_method);
        deliveriesVo.setOrders_id(orders_id);

        // 배차 정보 삽입 후, MyBatis가 자동 생성된 deliveries_id를 가져옴
        ridersMapper.assignDelivery(riders_id, deliveries_method, orders_id);
        int deliveries_id = deliveriesVo.getDeliveries_id();

        // 배차 이력 생성
        int delivery_history_id = ridersMapper.insertDeliveryHistory("배차 완료", deliveries_id);

        return delivery_history_id > 0;
    }

    public List<OrderVo> getCompletedOrdersByRider(int riders_id) {
        return ridersMapper.findCompletedOrdersByRider(riders_id);
    }

}