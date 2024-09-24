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
        String userType = (String) session.getAttribute("userType");
        
        if (userType == null) {
            return "redirect:/login_form.do";
        }

        for (InquiriesVo vo : list) {
            if ("MEMBER".equals(userType)) {
                // 회원이 작성한 문의만 회원 ID를 설정
                MemberVo member = member_mapper.selectOneFromIdx(vo.getMember_id());
                if (member != null) {
                    vo.setMemberAccountId(member.getMember_accountId());
                }
            } else if ("OWNER".equals(userType)) {
                // 사장이 작성한 문의만 사장 ID를 설정
                OwnerVo owner = owner_mapper.selectOneFromIdx(vo.getOwner_id());
                if (owner != null) {
                    vo.setOwnerAccountId(owner.getOwner_accountId());
                }
            }

            // 작성자가 없으면 로그인 폼으로 리디렉션
            if ((userType.equals("MEMBER") && vo.getMemberAccountId() == null) ||
                    (userType.equals("OWNER") && vo.getOwnerAccountId() == null)) {
                return "redirect:/login_form.do";
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

        // MemberVo member = member_mapper.selectOneFromIdx(vo.getMember_id());
        // OwnerVo owner = owner_mapper.selectOneFromIdx(vo.getOwner_id());
        // if (member == null || owner == null) {
        //     return "redirect:/login_form.do";
        // }
        // vo.setMemberAccountId(member.getMember_accountId());
        // vo.setOwnerAccountId(owner.getOwner_accountId());



        String content = vo.getInquiries_content().replace("\n", "<br/>");
        vo.setInquiries_content(content);

        model.addAttribute("vo", vo);

        return "inquiries/inquiries_detail";
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

        MemberVo member = (MemberVo)session.getAttribute("user");
        OwnerVo owner = (OwnerVo)session.getAttribute("user");
        if(member == null || owner == null){
            return "redirect:/login_form.do";
        }
        String userType = (String)session.getAttribute("userType");
        if("MEMBER".equals(userType) || "OWNER".equals(userType)){
            InquiriesVo inquiries = new InquiriesVo();

            inquiries.setInquiries_title(inquiries_title);
            inquiries.setInquiries_type(inquiries_type);
            inquiries.setInquiries_content(inquiries_content);
            inquiries.setMember_id(member.getMember_id());
            inquiries.setOwner_id(owner.getOwner_id());

            inquiries_mapper.insert(inquiries);
            return "redirect:/inquiries/list.do";
        }else{
            return "redirect:/login_form.do";
        }

    }

    @RequestMapping("modify_form.do")
    public String modify_form(Integer inquiries_id,Model model){

        InquiriesVo vo = inquiries_mapper.selectFromIdx(inquiries_id);
        if(vo == null){
            return "redirect:/inquiries/list.do";
        }
        String userType = (String) session.getAttribute("userType");
        if(userType == null || !"MEMBER".equals(userType) || !"OWNER".equals(userType)){
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
        return "redirect:/list.do";
    }
}
