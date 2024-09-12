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

        // 기본 날짜 범위 설정 (필요 시)
        if (startDate == null || endDate == null) {
            LocalDate today = LocalDate.now();
            startDate = today.withDayOfMonth(1).toString(); // 이번 달의 첫날
            endDate = today.toString(); // 오늘 날짜
        }

        // 서비스로부터 필터링된 배달 내역과 총 수수료를 가져옴
        Map<String, Object> result = commissionService.getFilteredDeliveries(raiders_id, startDate, endDate, page);

        // 데이터를 모델에 추가하여 JSP로 전달
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
