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

    // 생성자를 통해 CommissionService를 주입받아 사용
    @Autowired
    public CommissionController(CommissionService commissionService) {
        this.commissionService = commissionService;
    }

    // "/list.do" URL에 대한 GET 요청을 처리
    @GetMapping("list.do")
    public String selectList(
            // 요청 파라미터로 라이더 ID를 받음
            @RequestParam(name = "raiders_id") int raiders_id,
            // 요청 파라미터로 페이지 번호를 받음. 기본값은 1
            @RequestParam(name = "page", defaultValue = "1") int page,
            // 모델을 통해 JSP로 데이터를 전달
            Model model) {

        // CommissionService를 통해 페이징 처리된 데이터를 가져옴
        Map<String, Object> result = commissionService.getPagedDeliveries(raiders_id, page);

        // 완료된 배달 목록 데이터를 모델에 추가하여 JSP에 전달
        model.addAttribute("completedDeliveries", result.get("deliveries"));
        // 총 수수료 데이터를 모델에 추가하여 JSP에 전달
        model.addAttribute("totalCommission", result.get("totalCommission"));
        // 페이지 메뉴 데이터를 모델에 추가하여 JSP에 전달 (페이징 처리된 페이지 번호)
        model.addAttribute("pageMenu", result.get("pageMenu"));
        // 현재 페이지 번호를 모델에 추가하여 JSP에 전달
        model.addAttribute("currentPage", page);

        // "riders/riders_commission.jsp"로 이동하여 데이터를 보여줌
        return "riders/riders_commission";
    }
}
