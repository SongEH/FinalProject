package first.final_project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class OrderController {

    @RequestMapping("order/pay.do")
    public String order() {

        return "order/pay";
    }

}
