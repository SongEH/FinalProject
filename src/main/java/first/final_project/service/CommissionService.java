package first.final_project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import first.final_project.dao.CommissionMapper;
import first.final_project.vo.CompletedDeliveryVo;

@Service
public class CommissionService {

    private final CommissionMapper commissionMapper;

    public CommissionService(CommissionMapper commissionMapper) {
        this.commissionMapper = commissionMapper;
    }

    public List<CompletedDeliveryVo> selectList(int raiders_id) {
        // 완료된 배달 목록과 함께 수수료를 가져옴
        List<CompletedDeliveryVo> completedDeliveries = commissionMapper.selectList(raiders_id);

        // 데이터베이스에 수수료가 저장되지 않은 경우에만 수수료를 계산
        for (CompletedDeliveryVo delivery : completedDeliveries) {
            if (delivery.getCommission() == 0.0) { // 수수료가 0인 경우 계산하고 저장
                double commission = delivery.getOrders_price() * 0.03;
                delivery.setCommission(commission); // VO에 수수료 값을 설정
                saveCommission(raiders_id, delivery.getDeliveries_id(), commission); // 수수료 저장
            }
        }

        return completedDeliveries;
    }

    public void saveCommission(int raiders_id, int deliveries_id, double commission) {
        Map<String, Object> params = new HashMap<>();
        params.put("raiders_id", raiders_id);
        params.put("deliveries_id", deliveries_id);
        params.put("commission", commission);
        commissionMapper.insertCommission(params);
    }

    public boolean commissionExists(int raiders_id, int deliveries_id) {
        Map<String, Object> params = new HashMap<>();
        params.put("raiders_id", raiders_id);
        params.put("deliveries_id", deliveries_id);

        // 쿼리 결과가 0보다 크면 true를 반환
        int count = commissionMapper.commissionExists(params);
        return count > 0;
    }
}
// @Service
// public class CommissionService {

// private final CommissionMapper commissionMapper;

// public CommissionService(CommissionMapper commissionMapper) {
// this.commissionMapper = commissionMapper;
// }

// public List<CompletedDeliveryVo> selectList(int raiders_id) {
// // Fetch the completed deliveries
// List<CompletedDeliveryVo> completedDeliveries =
// commissionMapper.selectList(raiders_id);

// // Calculate commission only if it has not been inserted already
// for (CompletedDeliveryVo delivery : completedDeliveries) {
// boolean commissionExists = commissionMapper.commissionExists(raiders_id,
// delivery.getDeliveries_id());

// if (!commissionExists) {
// double commission = delivery.getOrders_price() * 0.03;
// delivery.setCommission(commission); // Set commission value in VO
// saveCommission(raiders_id, delivery.getDeliveries_id(), commission); // Save
// the commission
// }
// }

// return completedDeliveries;
// }

// public void saveCommission(int raiders_id, int deliveries_id, double
// commission) {
// Map<String, Object> params = new HashMap<>();
// params.put("raiders_id", raiders_id);
// params.put("deliveries_id", deliveries_id);
// params.put("commission", commission);
// commissionMapper.insertCommission(params);
// }

// public List<CompletedDeliveryVo> selectList(int raiders_id) {
// // 라이더의 완료된 배달 목록을 가져옴
// List<CompletedDeliveryVo> completedDeliveries =
// commissionMapper.selectList(raiders_id);

// // 각 주문의 수수료를 계산하여 DB에 저장
// for (CompletedDeliveryVo delivery : completedDeliveries) {
// double commission = delivery.getOrders_price() * 0.03;
// delivery.setCommission(commission); // VO에 수수료 값 설정
// saveCommission(raiders_id, commission); // DB에 수수료 저장
// }

// return completedDeliveries;
// }

// public void saveCommission(int raiders_id, double commission) {
// Map<String, Object> params = new HashMap<>();
// params.put("raiders_id", raiders_id);
// params.put("commission", commission);
// commissionMapper.insertCommission(params);
// }

// test
// public void saveCommissionsBatch(int raiders_id, List<Double> commissions) {
// List<Map<String, Object>> batchParams = new ArrayList<>();

// for (double commission : commissions) {
// Map<String, Object> params = new HashMap<>();
// params.put("raiders_id", raiders_id);
// params.put("commission", commission);
// batchParams.add(params);
// }

// commissionMapper.insertCommissionsBatch(batchParams); // Assuming a batch
// insert method is in the mapper
// }

// public double getTotalCommission(int raiders_id) {
// return commissionMapper.selectTotalCommission(raiders_id);
// }

// public List<Map<String, Object>> getCommissionHistory(int raiders_id, Date
// startDate, Date endDate) {
// return commissionMapper.selectCommissionHistory(raiders_id, startDate,
// endDate);
// }
