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
            Model model) {

        // CommissionService를 통해 페이징 처리된 데이터를 가져옴
        Map<String, Object> result = commissionService.getPagedDeliveries(raiders_id, page);

        // 가져온 데이터를 JSP로 전달할 준비
        model.addAttribute("completedDeliveries", result.get("deliveries"));
        model.addAttribute("totalCommission", result.get("totalCommission"));
        model.addAttribute("pageMenu", result.get("pageMenu"));
        model.addAttribute("currentPage", page);

        return "riders/riders_commission";
    }
}
