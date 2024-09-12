package first.final_project.controller;

import java.time.LocalDate;
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
            @RequestParam(name = "startDate", required = false) String startDate,
            @RequestParam(name = "endDate", required = false) String endDate,
            @RequestParam(name = "page", defaultValue = "1") int page,
            Model model) {

        // blockList는 필요에 따라 조정할 수 있음. 예: 한 페이지에 3개씩 보여줌.
        int blockList = 3;

        // 서비스 호출: 필터링 여부에 따라 배달 내역 및 총 수수료를 가져옴
        Map<String, Object> result = commissionService.getDeliveries(raiders_id, startDate, endDate, page, blockList);

        // 모델에 데이터를 추가하여 JSP로 전달
        model.addAttribute("completedDeliveries", result.get("deliveries"));
        model.addAttribute("totalCommission", result.get("totalCommission"));
        model.addAttribute("pageMenu", result.get("pageMenu"));
        model.addAttribute("currentPage", page);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("raiders_id", raiders_id);

        return "riders/riders_commission";
    }

    // 09_12 16:36분 최종코드
    // @GetMapping("list.do")
    // public String selectList(
    // @RequestParam(name = "raiders_id") int raiders_id,
    // @RequestParam(name = "page", defaultValue = "1") int page,
    // Model model) {

    // // // CommissionService를 통해 페이징 처리된 데이터를 가져옴
    // Map<String, Object> result = commissionService.getPagedDeliveries(raiders_id,
    // page);

    // // // 가져온 데이터를 JSP로 전달할 준비
    // model.addAttribute("completedDeliveries", result.get("deliveries"));
    // model.addAttribute("totalCommission", result.get("totalCommission"));
    // model.addAttribute("pageMenu", result.get("pageMenu"));
    // model.addAttribute("currentPage", page);

    // return "riders/riders_commission";
    // }
}
