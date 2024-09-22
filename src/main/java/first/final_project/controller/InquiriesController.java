package first.final_project.controller;

import java.util.List;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import first.final_project.dao.InquiriesMapper;
import first.final_project.dao.MemberMapper;
import first.final_project.dao.OwnerMapper;
import first.final_project.vo.InquiriesVo;
import first.final_project.vo.MemberVo;
import first.final_project.vo.OwnerVo;
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

    //문의사항 조회
    @RequestMapping("list.do")
    public String list(@RequestParam(value="inquiries_type",defaultValue = "전체")String inquiries_type,Model model){
        
        String userType = (String) session.getAttribute("userType");
        List<InquiriesVo> list = inquiries_mapper.selectListByType(inquiries_type);

        for(InquiriesVo vo : list){
            // 회원 ID가 있을 경우 회원 정보를 가져옴
            if (vo.getMember_id() != null) {
                MemberVo member = member_mapper.selectOneFromIdx(vo.getMember_id());
                if (member != null) {
                    vo.setMemberAccountId(member.getMember_accountId());
                }
            }

            // 사장 ID가 있을 경우 사장 정보를 가져옴
            if (vo.getOwner_id() != null) {
                OwnerVo owner = owner_mapper.selectOneFromIdx(vo.getOwner_id());
                if (owner != null) {
                    vo.setOwnerAccountId(owner.getOwner_accountId());
                }
            }

            // 만약 회원과 사장 정보가 모두 없다면 로그인 페이지로 리디렉션
            if (vo.getMemberAccountId() == null && vo.getOwnerAccountId() == null) {
                return "redirect:/login_form.do";
            }
        }

        System.out.println("userType: " + userType);

        model.addAttribute("list", list);
        return "inquiries/inquiries_list";
    }


    @RequestMapping(value = "/inquiries/check_password.do", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
    @ResponseBody
    public Map<String, Boolean> check_pwd(@RequestParam("inquiries_id") int inquiries_id){
        InquiriesVo vo = inquiries_mapper.selectFromIdx(inquiries_id);
        boolean bResult = (vo == null);
        Map<String, Boolean> map = new HashMap<>();
        map.put("result", bResult);
        return map;
    }

    @RequestMapping("/detail.do")
    public String detail(@RequestParam(value = "inquiries_id", required = false) Integer inquiries_id,@RequestParam String inquiries_pwd, Model model) {
        if (inquiries_id == null) {
            return "redirect:/inquiries/list.do";
        }

        InquiriesVo vo = inquiries_mapper.selectFromIdx(inquiries_id);
        if (vo == null) {
            return "redirect:/inquiries/list.do";
        }

        // 회원 ID가 있을 경우 회원 정보를 가져옴
        if (vo.getMember_id() != null) {
            MemberVo member = member_mapper.selectOneFromIdx(vo.getMember_id());
            if (member != null) {
                vo.setMemberAccountId(member.getMember_accountId());
            }
        }

        // 사장 ID가 있을 경우 사장 정보를 가져옴
        if (vo.getOwner_id() != null) {
            OwnerVo owner = owner_mapper.selectOneFromIdx(vo.getOwner_id());
            if (owner != null) {
                vo.setOwnerAccountId(owner.getOwner_accountId());
            }
        }

        // 비밀번호 확인
        if (inquiries_pwd == null || !inquiries_pwd.equals(vo.getInquiries_pwd())) {
            model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
            return "redirect:/inquiries/check_password.do"; // 비밀번호 입력 페이지로 리디렉션
        }

        // 만약 회원과 사장 정보가 모두 없다면 로그인 페이지로 리디렉션
        if (vo.getMemberAccountId() == null && vo.getOwnerAccountId() == null) {
            return "redirect:/login_form.do";
        }

        String content = vo.getInquiries_content().replace("\n", "<br/>");
        vo.setInquiries_content(content);
        model.addAttribute("vo", vo);

        return "inquiries/inquiries_detail";
    }
    
    @RequestMapping("insert_form.do")
    public String insert_form(){

        return "inquiries/inquiries_insert_form";
    }

    @RequestMapping("insert.do")
    public String insert(){

        return "redirect:/inquiries/list.do";
    }


    @RequestMapping("delete.do")
    public String delete(@RequestParam int inquiries_id){
        inquiries_mapper.delete(inquiries_id);
        return "redirect:/list.do";
    }
}
