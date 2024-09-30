package first.final_project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import first.final_project.dao.MemberMapper;
import first.final_project.vo.MemberVo;
import jakarta.servlet.http.HttpSession;

@Controller
public class MainDisplayController {

    @Autowired
    HttpSession session;

    @Autowired
    MemberMapper member_mapper;


    @RequestMapping("/main/display.do")
    public String go_to_main(Model model) {
        MemberVo user = (MemberVo) session.getAttribute("user");
        StringBuilder sb = new StringBuilder();
        
        if(user!=null){
            MemberVo vo = member_mapper.getAddr(user.getMember_id());

            if(vo==null){
                // vo가 null일 경우의 처리 (예: 리다이렉트 또는 오류 메시지)
                model.addAttribute("errorMessage", "주소 정보가 존재하지 않습니다.");
                return "redirect:/addr/addr_insert_form.do"; // 주소 입력 폼으로 리다이렉트
            }

            if(vo.getAddr_line1() != null && !vo.getAddr_line1().isEmpty()){
                sb.append(vo.getAddr_line1());
            }

            if (vo.getAddr_line2() != null && !vo.getAddr_line2().isEmpty() && !"null".equals(vo.getAddr_line2())){
                sb.append(" ");
                sb.append(vo.getAddr_line2());
            }
            String order_addr = sb.toString();
            System.out.println(order_addr);
            model.addAttribute("order_addr", order_addr);
        }else{
            model.addAttribute("order_addr", "");
        }
        return "main_display";
    }

    @RequestMapping("/main/display/list")
    public String go_to_main_list() {

        return "shop/shop_list";
    }

}
