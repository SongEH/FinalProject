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

    @RequestMapping("list.do")
    public String selectList(
            @RequestParam(name = "raiders_id") int raiders_id,
            @RequestParam(name = "page", defaultValue = "1") int page,
            @RequestParam(name = "startDate", required = false) String startDate,
            @RequestParam(name = "endDate", required = false) String endDate,
            Model model) {

        Map<String, Object> result;

        if ((startDate == null || startDate.isEmpty()) && (endDate == null || endDate.isEmpty())) {
            result = commissionService.getPagedDeliveries(raiders_id, page);
        } else {

            result = commissionService.getPagedDeliveries(raiders_id, page, startDate, endDate);
        }

        model.addAttribute("completedDeliveries", result.get("deliveries"));

        model.addAttribute("totalCommission", result.get("totalCommission"));

        model.addAttribute("pageMenu", result.get("pageMenu"));

        model.addAttribute("currentPage", page);

        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);

        return "riders/riders_commission";
    }
}
