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
            @RequestParam(name = "raiders_id") int raiders_id, // 요청 파라미터로 라이더 ID를 받음
            @RequestParam(name = "page", defaultValue = "1") int page, // 요청 파라미터로 페이지 번호를 받음. 기본값은 1
            @RequestParam(name = "startDate", required = false) String startDate, // 요청 파라미터로 시작 날짜 필터를 받음. 필수 값이 아니기
                                                                                  // 때문에 null일 수 있음
            @RequestParam(name = "endDate", required = false) String endDate, // 요청 파라미터로 종료 날짜 필터를 받음. 필수 값이 아니기 때문에
                                                                              // null일 수 있음
            Model model) { // 데이터를 JSP로 전달하기 위한 모델 객체
        // CommissionService에서 결과를 담을 Map 객체
        Map<String, Object> result;

        // 필터가 없는 경우(날짜 필터 값이 null이거나 빈 값일 경우) 전체 목록을 가져옴
        if ((startDate == null || startDate.isEmpty()) && (endDate == null || endDate.isEmpty())) {
            result = commissionService.getPagedDeliveries(raiders_id, page); // 전체 배달 목록
        } else {
            // 필터가 있는 경우 해당 날짜 범위에 맞는 목록을 가져옴
            result = commissionService.getPagedDeliveries(raiders_id, page, startDate, endDate); // 필터 적용된 목록
        }

        // 모델에 완료된 배달 목록 데이터를 추가하여 JSP에 전달
        model.addAttribute("completedDeliveries", result.get("deliveries"));
        // 모델에 총 수수료 데이터를 추가하여 JSP에 전달
        model.addAttribute("totalCommission", result.get("totalCommission"));
        // 페이지 메뉴 데이터를 모델에 추가하여 JSP에 전달 (페이징 처리된 페이지 번호)
        model.addAttribute("pageMenu", result.get("pageMenu"));
        // 현재 페이지 번호를 모델에 추가하여 JSP에 전달
        model.addAttribute("currentPage", page);

        // 필터 값을 모델에 추가하여 JSP에서 필터를 유지할 수 있게 함
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);

        // "riders/riders_commission.jsp" 뷰로 이동하여 데이터를 보여줌
        return "riders/riders_commission";
    }
}
