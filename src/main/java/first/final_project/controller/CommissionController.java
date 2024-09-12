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

    // CommissionService를 사용하여 비즈니스 로직을 처리
    private final CommissionService commissionService;

    // 의존성 주입: Spring이 CommissionService를 주입하여 사용할 수 있게 함
    @Autowired
    public CommissionController(CommissionService commissionService) {
        this.commissionService = commissionService;
    }

    // GET 요청을 처리하는 메서드, "/list.do" URL로 요청이 들어오면 이 메서드가 실행됨
    @GetMapping("list.do")
    public String selectList(
            @RequestParam(name = "raiders_id") int raiders_id, // 요청 파라미터로 라이더 ID를 받음
            @RequestParam(name = "page", defaultValue = "1") int page, // 요청 파라미터로 페이지 번호를 받음, 없으면 기본값 1
            Model model) { // 모델을 통해 JSP로 데이터를 전달

        // CommissionService를 통해 페이징 처리된 데이터를 가져옴
        Map<String, Object> result = commissionService.getPagedDeliveries(raiders_id, page);

        // 가져온 데이터를 JSP로 전달할 준비
        model.addAttribute("completedDeliveries", result.get("deliveries")); // 완료된 배달 목록 전달
        model.addAttribute("totalCommission", result.get("totalCommission")); // 총 수수료 전달
        model.addAttribute("pageMenu", result.get("pageMenu")); // 페이징 메뉴 전달
        model.addAttribute("currentPage", page); // 현재 페이지 번호 전달

        // "riders_commission.jsp"로 이동하여 데이터를 보여줌
        return "riders/riders_commission";
    }
}

// @GetMapping("list.do")
// public String selectList(
// @RequestParam(name = "raiders_id") int raiders_id,
// @RequestParam(name = "page", defaultValue = "1") int page,
// @RequestParam(name = "startDate", required = false) @DateTimeFormat(pattern =
// "yyyy-MM-dd") Date startDate,
// @RequestParam(name = "endDate", required = false) @DateTimeFormat(pattern =
// "yyyy-MM-dd") Date endDate,
// @RequestParam(name = "year", required = false) Integer year,
// @RequestParam(name = "month", required = false) Integer month,
// Model model) {

// // 서비스에서 페이징된 데이터를 가져옴
// Map<String, Object> result = commissionService.getPagedDeliveries(raiders_id,
// page, startDate, endDate, year,
// month);

// // JSP로 데이터 전달
// model.addAttribute("completedDeliveries", result.get("deliveries"));
// model.addAttribute("totalCommission", result.get("totalCommission"));
// model.addAttribute("pageMenu", result.get("pageMenu"));
// model.addAttribute("currentPage", page);

// return "riders/riders_commission";
// }
