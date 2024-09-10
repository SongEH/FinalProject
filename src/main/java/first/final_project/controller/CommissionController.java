package first.final_project.controller;

import first.final_project.service.CommissionService;
import first.final_project.vo.CompletedDeliveryVo;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/riders/mypage/")
public class CommissionController {

    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpSession session;

    private final CommissionService commissionService;

    public CommissionController(CommissionService commissionService) {
        this.commissionService = commissionService;
    }

    @GetMapping("list.do")
    public String getCompletedDeliveriesWithCommission(
            @RequestParam(name = "raiders_id") int raiders_id, Model model) {

        List<CompletedDeliveryVo> completedDeliveries = commissionService
                .getCompletedDeliveriesWithCommission(raiders_id);

        model.addAttribute("completedDeliveries", completedDeliveries);

        return "riders/riders_commission";
    }
}
