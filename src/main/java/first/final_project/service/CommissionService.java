package first.final_project.service;

import first.final_project.dao.RidersMapper;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

@Service
public class CommissionService {

    private final RidersMapper ridersMapper;

    public CommissionService(RidersMapper ridersMapper) {
        this.ridersMapper = ridersMapper;
    }

    // 이 메소드는 raiders_id에 따라 라이더의 총 3% 수수료를 계산합니다.
    public double calculateTotalCommission(@RequestParam(name = "raiders_id") int raiders_id) {
        return ridersMapper.getTotalCommissionByRiderId(raiders_id);
    }
}
