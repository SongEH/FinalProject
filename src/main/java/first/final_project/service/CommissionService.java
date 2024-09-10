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

    public List<CompletedDeliveryVo> getCompletedDeliveriesWithCommission(int raiders_id) {
        return commissionMapper.getCompletedDeliveriesWithCommission(raiders_id);
    }

    public void saveCommission(int raiders_id, double commission) {
        Map<String, Object> params = new HashMap<>();
        params.put("raiders_id", raiders_id);
        params.put("commission", commission);
        commissionMapper.insertCommission(params);
    }

}