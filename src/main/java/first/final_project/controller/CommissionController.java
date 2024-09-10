package first.final_project.controller;

import first.final_project.service.CommissionService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/commission")
public class CommissionController {

    private final CommissionService commissionService;

    public CommissionController(CommissionService commissionService) {
        this.commissionService = commissionService;
    }

    // 라이더의 총 수수료를 가져오는 API
    @GetMapping("/total")
    public double getTotalCommission(@RequestParam(name = "raiders_id") int raiders_id) {
        return commissionService.calculateTotalCommission(raiders_id);
    }
}
