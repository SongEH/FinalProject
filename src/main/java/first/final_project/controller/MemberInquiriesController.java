package first.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import first.final_project.dao.AdminMapper;
import first.final_project.dao.MemberAnswerMapper;
import first.final_project.dao.MemberInquiriesMapper;
import first.final_project.dao.MemberMapper;
import first.final_project.vo.AdminVo;
import first.final_project.vo.MemberAnswerVo;
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
    MemberAnswerMapper member_answer_mapper;

    @Autowired
    MemberMapper member_mapper;

    @Autowired
    AdminMapper admin_mapper;

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

        List<MemberAnswerVo> answer_list = member_answer_mapper.selectListFromIdx(m_inquiries_id);
        if(answer_list != null && !answer_list.isEmpty()){
            for(MemberAnswerVo answer : answer_list){
                String m_answer_content = answer.getM_answer_content();
                answer.setM_answer_content(m_answer_content);

                AdminVo admin = admin_mapper.selectOneFromIdx(answer.getAdmin_id());
                if(admin != null){
                    answer.setAdmin_accountId(admin.getAdmin_accountId());
                }
            }
        }
        String userType = (String)session.getAttribute("userType");
        model.addAttribute("userType", userType);
        model.addAttribute("answer_list", answer_list);


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

    @RequestMapping("answer_insert_form.do")
    public String answer_insert_form(@RequestParam(value="m_inquiries_id", required = true) Integer m_inquiries_id,
            Model model) {
        String userType = (String) session.getAttribute("userType");
        if ("ADMIN".equals(userType)) {
            model.addAttribute("m_inquiries_id", m_inquiries_id);
            return "member_answer/answer_insert_form";
        } else {
            return "redirect:/member_inquiries/list.do";
        }
    }

    @RequestMapping("answer_insert.do")
    public String answer_insert(int m_inquiries_id, String m_answer_content) {

        AdminVo admin = (AdminVo) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login_form.do";
        }
        MemberAnswerVo answer = new MemberAnswerVo();
        answer.setM_inquiries_id(m_inquiries_id);
        answer.setM_answer_content(m_answer_content);
        answer.setAdmin_id(admin.getAdmin_id());
        member_answer_mapper.insert(answer);
        System.out.println("m_inquiries_id:" + m_inquiries_id);

        return "redirect:/member_inquiries/detail.do?m_inquiries_id=" + m_inquiries_id;
    }

    @RequestMapping("answer_modify_form.do")
    public String answer_modify_form(Integer m_answer_id,
            @RequestParam(value="m_inquiries_id", required = true) Integer m_inquiries_id, Model model) {

        MemberAnswerVo vo = member_answer_mapper.selectOne(m_answer_id);
        if (vo == null) {
            return "redirect:/member_inquiries/detail.do?m_inquiries_id=" + m_inquiries_id;
        }

        model.addAttribute("vo", vo);
        model.addAttribute("m_inquiries_id", vo.getM_inquiries_id());

        return "member_answer/answer_modify_form";
    }

    @RequestMapping("answer_modify.do")
    public String answer_modify(int m_answer_id, String m_answer_content, int m_inquiries_id) {
        AdminVo admin = (AdminVo) session.getAttribute("user");
        if (admin == null) {
            System.out.println("admin:" + admin);
            return "redirect:/login_form.do";
        }

        MemberAnswerVo answer = new MemberAnswerVo();
        answer.setM_answer_id(m_answer_id);
        answer.setM_answer_content(m_answer_content);
        answer.setM_inquiries_id(m_inquiries_id);
        answer.setAdmin_id(admin.getAdmin_id());
        answer.setAdmin_accountId(admin.getAdmin_accountId());

        member_answer_mapper.update(answer);
        return "redirect:/member_inquiries/detail.do?m_inquiries_id=" + m_inquiries_id;
    }

    @RequestMapping("answer_delete.do")
    public String answer_delete(@RequestParam int m_inquiries_id, @RequestParam int m_answer_id) {

        member_answer_mapper.delete(m_answer_id);
        return "redirect:/member_inquiries/detail.do?m_inquiries_id=" + m_inquiries_id;
    }
}
