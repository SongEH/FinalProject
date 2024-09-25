package first.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
        
        List<InquiriesVo> list = inquiries_mapper.selectListByType(inquiries_type);
        
        for (InquiriesVo vo : list) {
            if (vo.getMember_id() != 0) {
                // 회원이 작성한 문의만 회원 ID를 설정
                MemberVo member = member_mapper.selectOneFromIdx(vo.getMember_id());
                if (member != null) {
                    vo.setMemberAccountId(member.getMember_accountId());
                }
            }  
            if (vo.getOwner_id() != 0) {
                // 사장이 작성한 문의만 사장 ID를 설정
                OwnerVo owner = owner_mapper.selectOneFromIdx(vo.getOwner_id());
                if (owner != null) {
                    vo.setOwnerAccountId(owner.getOwner_accountId());
                }
            }
        }

        model.addAttribute("list", list);
        model.addAttribute("inquiries_type", inquiries_type);
        return "inquiries/inquiries_list";
    }



    @RequestMapping("/detail.do")
    public String detail(@RequestParam(value = "inquiries_id", required = false) Integer inquiries_id, Model model) {

        if (inquiries_id == null) {
            return "redirect:/inquiries/list.do";
        }

        InquiriesVo vo = inquiries_mapper.selectFromIdx(inquiries_id);
        if (vo == null) {
            return "redirect:/inquiries/list.do";
        }

        String userType = (String)session.getAttribute("userType");
        if(userType == null){
            return "redirect:/login_form.do";
        }
        model.addAttribute("vo", vo);

        Object user = session.getAttribute("user");
        boolean isAuthor = false;

        if (user instanceof MemberVo) {
            isAuthor = vo.getMember_id() == ((MemberVo) user).getMember_id();
        } else if (user instanceof OwnerVo) {
            isAuthor = vo.getOwner_id() == ((OwnerVo) user).getOwner_id();
        }

        model.addAttribute("isAuthor", isAuthor); // 작성자 여부 추가

        return "inquiries/inquiries_detail"; // 상세 페이지 반환
    }
    
    @RequestMapping("insert_form.do")
    public String insert_form(){
        String userType = (String)session.getAttribute("userType");
        if("MEMBER".equals(userType) || "OWNER".equals(userType)){
            return "inquiries/inquiries_insert_form";
        }else{
            return "redirect:/login_form.do";
        }
    }

    @RequestMapping("insert.do")
    public String insert(String inquiries_title, String inquiries_type,String inquiries_content){

        Object user = session.getAttribute("user");
        String userType = (String) session.getAttribute("userType");

        InquiriesVo inquiries = new InquiriesVo();
        inquiries.setInquiries_title(inquiries_title);
        inquiries.setInquiries_type(inquiries_type);
        inquiries.setInquiries_content(inquiries_content);

        if("MEMBER".equals(userType) && user instanceof MemberVo){
            MemberVo member = (MemberVo)user;
            inquiries.setMember_id(member.getMember_id());
            inquiries.setOwner_id(0);
        }else if ("OWNER".equals(userType) && user instanceof OwnerVo) {
            OwnerVo owner = (OwnerVo) user;
            inquiries.setOwner_id(owner.getOwner_id());
            inquiries.setMember_id(0);
        }

        inquiries_mapper.insert(inquiries);
        return "redirect:/inquiries/list.do";
        // MemberVo member = (MemberVo)session.getAttribute("user");
        // OwnerVo owner = (OwnerVo)session.getAttribute("user");
        // // if(member == null || owner == null){
        // //     return "redirect:/login_form.do";
        // // }
        // String userType = (String)session.getAttribute("userType");
        // if("MEMBER".equals(userType) || "OWNER".equals(userType)){
        //     InquiriesVo inquiries = new InquiriesVo();

        //     inquiries.setInquiries_title(inquiries_title);
        //     inquiries.setInquiries_type(inquiries_type);
        //     inquiries.setInquiries_content(inquiries_content);
        //     inquiries.setMember_id(member.getMember_id());
        //     inquiries.setOwner_id(owner.getOwner_id());

        //     inquiries_mapper.insert(inquiries);
        // }
        // return "redirect:/inquiries/list.do";

    }

    @RequestMapping("modify_form.do")
    public String modify_form(Integer inquiries_id,Model model){

        InquiriesVo vo = inquiries_mapper.selectFromIdx(inquiries_id);
        if(vo == null){
            return "redirect:/inquiries/list.do";
        }
        String userType = (String) session.getAttribute("userType");
        if(userType == null){
            return "redirect:/login_form.do";
        }

        model.addAttribute("vo", vo);
        return "inquiries/inquiries_modify_form";
    }

    @RequestMapping("modify.do")
    public String modify(int inquiries_id,String inquiries_title,String inquiries_type,String inquiries_content){
        String userType = (String)session.getAttribute("userType");
        if(userType == null || !"MEMBER".equals(userType) || !"OWNER".equals(userType)){
            return "redirect:/login_form.do";
        }

        MemberVo member = (MemberVo)session.getAttribute("user");
        OwnerVo owner = (OwnerVo)session.getAttribute("user");
        if(member == null || owner == null){
            return "redirect:/login_form.do";
        }

        InquiriesVo inquiries = new InquiriesVo();
        inquiries.setInquiries_title(inquiries_title);
        inquiries.setInquiries_type(inquiries_type);
        inquiries.setInquiries_content(inquiries_content);
        inquiries.setMember_id(member.getMember_id());
        inquiries.setOwner_id(owner.getOwner_id());

        inquiries_mapper.update(inquiries);

        return "redirect:/inquiries/detail.do?inquiries_id=" + inquiries_id;
    }

    @RequestMapping("delete.do")
    public String delete(@RequestParam int inquiries_id){
        inquiries_mapper.delete(inquiries_id);
        return "redirect:/inquiries/list.do";
    }
}
