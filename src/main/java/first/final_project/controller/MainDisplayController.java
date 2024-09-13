package first.final_project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainDisplayController {

    @RequestMapping("/main/display")
    public String go_to_main() {

        return "main_display";
    }

    @RequestMapping("/main/display/list")
    public String go_to_main_list() {

        return "shop/shop_list";
    }

}