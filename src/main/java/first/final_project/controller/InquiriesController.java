package first.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import first.final_project.dao.InquiriesMapper;
import first.final_project.dao.MemberMapper;
import first.final_project.dao.OwnerMapper;
import first.final_project.vo.InquiriesVo;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/inquiries/")
public class InquiriesController {
    
    @Autowired
    HttpSession session;
    
     @Autowired
    HttpServletRequest request;

    @Autowired
    InquiriesMapper inquiries_mapper;

    @Autowired
    MemberMapper member_mapper;

    @Autowired
    OwnerMapper owner_mapper;

    @RequestMapping("list.do")
    public String list(Model model){

        List<InquiriesVo> list = inquiries_mapper.selectList();
        
        if(list == null){
            list = List.of();
        }

        model.addAttribute("list", list);
        
        return "inquiries/inquiries_list";
    }

    @RequestMapping("insert_form.do")
    public String insert_form(){

        return "inquiries/inquiries_insert_form";
    }
}
