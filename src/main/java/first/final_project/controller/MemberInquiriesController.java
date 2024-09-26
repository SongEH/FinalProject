package first.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import first.final_project.dao.MemberInquiriesMapper;
import first.final_project.dao.MemberMapper;
import first.final_project.vo.MemberInquiriesVo;
import first.final_project.vo.MemberVo;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member_inquiries/")
public class MemberInquiriesController {

    @Autowired
    HttpSession session;

    @Autowired
    HttpServletRequest request;

    @Autowired
    MemberInquiriesMapper member_inquiries_mapper;

    @Autowired
    MemberMapper member_mapper;

    @RequestMapping("list.do")
    public String list(@RequestParam(value = "m_inquiries_type", defaultValue = "전체") String m_inquiries_type,
            Model model) {
        List<MemberInquiriesVo> list = member_inquiries_mapper.selectListByType(m_inquiries_type);

        for (MemberInquiriesVo vo : list) {
            MemberVo member = member_mapper.selectOneFromIdx(vo.getMember_id());
            if (member == null) {
                return "redirect:/login_form.do";
            }
            vo.setMemberAccountId(member.getMember_accountId());
        }

        model.addAttribute("list", list);
        model.addAttribute("m_inquiries_type", m_inquiries_type);

        return "member_inquiries/inquiries_list";
    }

    @RequestMapping("detail.do")
    public String detail(@RequestParam(value = "m_inquiries_id", required = false) Integer m_inquiries_id,
            Model model) {

        // if (m_inquiries_id == null) {
        //     return "redirect:/login_form.do";
        // }
        MemberInquiriesVo vo = member_inquiries_mapper.selectFromIdx(m_inquiries_id);
        if (vo == null) {
            return "redirect:/member_inquiries/list.do";
        }
        MemberVo member = member_mapper.selectOneFromIdx(vo.getMember_id());
        if (member == null) {
            return "redirect:/login_form.do";
        }
        vo.setMemberAccountId(member.getMember_accountId());

        String content = vo.getM_inquiries_content().replace("\n", "<br/>");
        vo.setM_inquiries_content(content);

        model.addAttribute("vo", vo);


        return "member_inquiries/inquiries_detail";
    }

    @RequestMapping("insert_form.do")
    public String insert_form() {
        String userType = (String) session.getAttribute("userType");
        if ("MEMBER".equals(userType)) {
            return "member_inquiries/inquiries_insert_form";
        } else {
            return "redirec:/login_form.do";
        }

    }

    @RequestMapping("insert.do")
    public String insert(String m_inquiries_title, String m_inquiries_content, String m_inquiries_type,
            RedirectAttributes ra) {
        MemberVo member = (MemberVo) session.getAttribute("user");
        if (member == null) {
            return "redirect:/login_form.do";
        }

        String userType = (String) session.getAttribute("userType");
        if ("MEMBER".equals(userType)) {
            MemberInquiriesVo vo = new MemberInquiriesVo();

            vo.setM_inquiries_title(m_inquiries_title);
            vo.setM_inquiries_content(m_inquiries_content);
            vo.setM_inquiries_type(m_inquiries_type);
            vo.setMember_id(member.getMember_id());

            member_inquiries_mapper.insert(vo);
            return "redirect:/member_inquiries/list.do";
        } else {
            return "redirect:/login_form.do";
        }
    }

    @RequestMapping("modify_form.do")
    public String modify_form(Integer m_inquiries_id, Model model) {
        MemberInquiriesVo vo = member_inquiries_mapper.selectFromIdx(m_inquiries_id);
        if (vo == null) {
            return "redirect:/member_inquiries/list.do";
        }
        MemberVo member = (MemberVo)session.getAttribute("user");
        if(member == null){
            return "redirect:/login_form.do";
        }
        
        // member_id를 이용해 작성자의 정보를 조회
        MemberVo member_accountId = member_mapper.selectOneFromIdx(vo.getMember_id());
        if (member_accountId != null) {
            // 작성자의 accountId를 조회해서 vo에 설정
            vo.setMemberAccountId(member_accountId.getMember_accountId());
        }

        System.out.println("------------------------------------------------");
        System.out.println(vo);
        System.out.println("------------------------------------------------");

        model.addAttribute("vo", vo);
        return "member_inquiries/inquiries_modify_form";
    }

    @RequestMapping("modify.do")
    public String modify(int m_inquiries_id, String m_inquiries_title, String m_inquiries_content,
            String m_inquiries_type, RedirectAttributes ra) {
        // String userType = (String) session.getAttribute("userType");
        // if (userType == null || !"MEMBER".equals(userType)) {
        //     return "redirect:/login_form.do"; 
        // }
        MemberVo member = (MemberVo) session.getAttribute("user");
        if (member == null) {
           return "redirect:/login_form.do";
        }

        MemberInquiriesVo vo = new MemberInquiriesVo();
        vo.setM_inquiries_id(m_inquiries_id);
        vo.setM_inquiries_title(m_inquiries_title);
        vo.setM_inquiries_content(m_inquiries_content);
        vo.setM_inquiries_type(m_inquiries_type);
        vo.setMember_id(member.getMember_id());
        vo.setMemberAccountId(member.getMember_accountId());

        System.out.println("member :" + member);
        System.out.println(vo.getMemberAccountId());
        System.out.println(vo.getMember_id());


        member_inquiries_mapper.update(vo);

        System.out.println("여기까지왔나?");
        return "redirect:/member_inquiries/detail.do?m_inquiries_id=" + m_inquiries_id;
    }

    @RequestMapping("delete.do")
    public String delete(@RequestParam int m_inquiries_id) {
        member_inquiries_mapper.delete(m_inquiries_id);
        return "redirect:/member_inquiries/list.do";
    }
}
