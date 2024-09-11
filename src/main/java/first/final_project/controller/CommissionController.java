package first.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import first.final_project.dao.CommissionMapper;
import first.final_project.service.CommissionService;
import first.final_project.vo.CompletedDeliveryVo;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/riders/mypage/")
public class CommissionController {

    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpSession session;

    @Autowired
    CommissionMapper commissionMapper;
    private final CommissionService commissionService;

    public CommissionController(CommissionService commissionService) {
        this.commissionService = commissionService;
    }

    @GetMapping("list.do")
    // test
    public String selectList(@RequestParam(name = "raiders_id") int raiders_id, Model model) {
        // 라이더의 완료된 배달 목록과 수수료를 계산하여 가져옴
        List<CompletedDeliveryVo> completedDeliveries = commissionService.selectList(raiders_id);

        double totalCommission = commissionMapper.selectTotalCommission(raiders_id); // 총 수수료 계산

        // JSP로 데이터 전달
        model.addAttribute("completedDeliveries", completedDeliveries);
        model.addAttribute("totalCommission", totalCommission);

        // riders_commission.jsp로 포워딩
        return "riders/riders_commission";
    }

}
