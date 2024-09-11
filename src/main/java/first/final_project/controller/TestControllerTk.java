package first.final_project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TestControllerTk {
    
    @RequestMapping("test")
    public String review_test(){

        return "/customer_review/review_form";
    }
}
