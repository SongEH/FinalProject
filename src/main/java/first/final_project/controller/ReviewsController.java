package first.final_project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import first.final_project.vo.MemberVo;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/review/")
public class ReviewsController {

    @Autowired
    HttpSession session;
<<<<<<< HEAD

    @RequestMapping("insert_form.do")
    public String insert_form() {
=======
    
    @RequestMapping("insert_form.do")
    public String insert_form(){
>>>>>>> main

        return "reviews/insert_form";
    }

    @RequestMapping("insert.do")
<<<<<<< HEAD
    public String insert() {
=======
    public String insert(){
>>>>>>> main

        MemberVo user = (MemberVo) session.getAttribute("user");

        return "reviews";
    }
<<<<<<< HEAD
}
=======
}
>>>>>>> main
