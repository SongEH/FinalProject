package first.final_project.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import first.final_project.service.CommissionService;

@Controller
@RequestMapping("/riders/mypage/")
public class CommissionController {

    private final CommissionService commissionService;

    @Autowired
    public CommissionController(CommissionService commissionService) {
        this.commissionService = commissionService;
    }

    @GetMapping("list.do")
    public String selectList(
            @RequestParam(name = "raiders_id") int raiders_id,
            @RequestParam(name = "page", defaultValue = "1") int page,
            @RequestParam(name = "startDate", required = false) String startDate,
            @RequestParam(name = "endDate", required = false) String endDate,
            Model model) {

        Map<String, Object> result;

        // 필터 값이 없으면 전체 목록, 있으면 필터된 목록 가져오기
        if ((startDate == null || startDate.isEmpty()) && (endDate == null || endDate.isEmpty())) {
            result = commissionService.getPagedDeliveries(raiders_id, page); // 전체 목록
        } else {
            result = commissionService.getPagedDeliveries(raiders_id, page, startDate, endDate); // 필터 적용된 목록
        }

        // 모델에 데이터 추가
        model.addAttribute("completedDeliveries", result.get("deliveries"));
        model.addAttribute("totalCommission", result.get("totalCommission"));
        model.addAttribute("pageMenu", result.get("pageMenu"));
        model.addAttribute("currentPage", page);

        // 필터 값도 모델에 추가하여 JSP에서 유지
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);

        return "riders/riders_commission";
    }
}
