package first.final_project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import first.final_project.dao.MemberMapper;
import first.final_project.vo.MemberVo;
import first.final_project.vo.RiderVo;
import jakarta.servlet.http.HttpSession;

@Controller
public class MainDisplayController {

    @Autowired
    HttpSession session;

    @Autowired
    MemberMapper member_mapper;


    @RequestMapping("/main/display.do")
    public String go_to_main(Model model) {
        Object userObj = session.getAttribute("user");
        StringBuilder sb = new StringBuilder();
        
        if (userObj != null) {
            if (userObj instanceof MemberVo) {
                MemberVo user = (MemberVo) userObj;
                MemberVo vo = member_mapper.getAddr(user.getMember_id());
    
                if (vo == null) {
                    model.addAttribute("errorMessage", "주소 정보가 존재하지 않습니다.");
                    return "redirect:/addr/addr_insert_form.do"; // 주소 입력 폼으로 리다이렉트
                }
    
                if (vo.getAddr_line1() != null && !vo.getAddr_line1().isEmpty()) {
                    sb.append(vo.getAddr_line1());
                }
    
                if (vo.getAddr_line2() != null && !vo.getAddr_line2().isEmpty() && !"null".equals(vo.getAddr_line2())) {
                    sb.append(" ");
                    sb.append(vo.getAddr_line2());
                }
            }else if(userObj instanceof RiderVo){
                // RiderVo를 사용하는 경우 로그아웃 처리
                session.removeAttribute("user");
            }else{
                // 주소가 없을 경우 order_addr 없어서 오류나는 걸 빈칸으로 해서 작동
                model.addAttribute("order_addr", "");
            }
        }
        return "main_display";
    }

    @RequestMapping("/main/display/list")
    public String go_to_main_list() {

        return "shop/shop_list";
    }

}
