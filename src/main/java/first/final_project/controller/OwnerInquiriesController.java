package first.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import first.final_project.dao.AdminMapper;
import first.final_project.dao.OwnerAnswerMapper;
import first.final_project.dao.OwnerInquiriesMapper;
import first.final_project.dao.OwnerMapper;
import first.final_project.vo.AdminVo;
import first.final_project.vo.OwnerAnswerVo;
import first.final_project.vo.OwnerInquiriesVo;
import first.final_project.vo.OwnerVo;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/owner_inquiries/")
public class OwnerInquiriesController {
 
    @Autowired
    HttpSession session;

    @Autowired
    HttpServletRequest request;

    @Autowired
    OwnerInquiriesMapper owner_inquiries_mapper;

    @Autowired
    OwnerAnswerMapper owner_answer_mapper;

    @Autowired
    OwnerMapper owner_mapper;

    @Autowired
    AdminMapper admin_mapper;

    @RequestMapping("list.do")
    public String list(Model model){

        List<OwnerInquiriesVo> list = owner_inquiries_mapper.selectList();

        for(OwnerInquiriesVo vo : list){
            OwnerVo owner = owner_mapper.selectOneFromIdx(vo.getOwner_id());
            if(owner == null){
                return "redirect:/login_form.do";
            }
            vo.setOwner_accountId(owner.getOwner_accountId());
        }

        model.addAttribute("list", list);
        return "owner_inquiries/inquiries_list";
    }

    @RequestMapping("detail.do")
    public String detail(@RequestParam(value="o_inquiries_id",required = true)Integer o_inquiries_id,Model model){

        OwnerInquiriesVo vo = owner_inquiries_mapper.selectFromIdx(o_inquiries_id);
        if(vo == null){
            return "redirect:/owner_inquiries/list.do";
        }
        OwnerVo owner = owner_mapper.selectOneFromIdx(vo.getOwner_id());
        if(owner == null){
            return "redirect:/login_form.do";
        }
        vo.setOwner_accountId(owner.getOwner_accountId());

        String content = vo.getO_inquiries_content().replace("\n", "<br/>");
        vo.setO_inquiries_content(content);
        model.addAttribute("vo", vo);

        List<OwnerAnswerVo> answer_list = owner_answer_mapper.selectListFromIdx(o_inquiries_id);
        if(answer_list != null && !answer_list.isEmpty()){
            for(OwnerAnswerVo answer : answer_list){
                String o_answer_content = answer.getO_answer_content();
                answer.setO_answer_content(o_answer_content);

                AdminVo admin = admin_mapper.selectOneFromIdx(answer.getAdmin_id());
                if(admin != null){
                    answer.setAdmin_accountId(admin.getAdmin_accountId());
                }
            }
        }
        String userType = (String)session.getAttribute("userType");
        model.addAttribute("userType", userType);
        model.addAttribute("answer_list", answer_list);
        
        return "owner_inquiries/inquiries_detail";
    }

    @RequestMapping("insert_form.do")
    public String insert_form() {
        String userType = (String) session.getAttribute("userType");
        if ("OWNER".equals(userType)) {
            return "owner_inquiries/inquiries_insert_form";
        } else {
            return "redirect:/login_form.do";
        }

    }

    @RequestMapping("insert.do")
    public String insert(String o_inquiries_title, String o_inquiries_content) {
        OwnerVo owner = (OwnerVo) session.getAttribute("user");
        if (owner == null) {
            return "redirect:/login_form.do";
        }

        String userType = (String) session.getAttribute("userType");
        if ("OWNER".equals(userType)) {
            OwnerInquiriesVo vo = new OwnerInquiriesVo();
            vo.setO_inquiries_title(o_inquiries_title);
            vo.setO_inquiries_content(o_inquiries_content);
            vo.setOwner_id(owner.getOwner_id());

            owner_inquiries_mapper.insert(vo);
            return "redirect:/owner_inquiries/list.do";
        } else {
            return "redirect:/login_form.do";
        }
    }

    @RequestMapping("modify_form.do")
    public String modify_form(Integer o_inquiries_id, Model model) {
        OwnerInquiriesVo vo = owner_inquiries_mapper.selectFromIdx(o_inquiries_id);
        if (vo == null) {
            return "redirect:/owner_inquiries/list.do";
        }
        OwnerVo owner = (OwnerVo) session.getAttribute("user");
        if (owner == null) {
            return "redirect:/login_form.do";
        }

        // member_id를 이용해 작성자의 정보를 조회
        OwnerVo owner_accountId = owner_mapper.selectOneFromIdx(vo.getOwner_id());
        if (owner_accountId != null) {
            // 작성자의 accountId를 조회해서 vo에 설정
            vo.setOwner_accountId(owner_accountId.getOwner_accountId());
        }

        model.addAttribute("vo", vo);
        return "owner_inquiries/inquiries_modify_form";
    }

    @RequestMapping("modify.do")
    public String modify(int o_inquiries_id, String o_inquiries_title, String o_inquiries_content, RedirectAttributes ra) {
        
        OwnerVo owner = (OwnerVo) session.getAttribute("user");
        if (owner == null) {
            return "redirect:/login_form.do";
        }

        OwnerInquiriesVo vo = new OwnerInquiriesVo();
        vo.setO_inquiries_id(o_inquiries_id);
        vo.setO_inquiries_title(o_inquiries_title);
        vo.setO_inquiries_content(o_inquiries_content);
        vo.setOwner_id(owner.getOwner_id());
        vo.setOwner_accountId(owner.getOwner_accountId());

        owner_inquiries_mapper.update(vo);
        return "redirect:/owner_inquiries/detail.do?o_inquiries_id=" + o_inquiries_id;
    }

    @RequestMapping("delete.do")
    public String delete(@RequestParam int o_inquiries_id) {
        owner_inquiries_mapper.delete(o_inquiries_id);
        return "redirect:/owner_inquiries/list.do";
    }

    @RequestMapping("answer_insert_form.do")
    public String answer_insert_form(@RequestParam(value="o_inquiries_id", required = true) Integer o_inquiries_id,Model model){
        String userType = (String)session.getAttribute("userType");
        if("ADMIN".equals(userType)){
            model.addAttribute("o_inquiries_id", o_inquiries_id);
            return "owner_answer/answer_insert_form";
        }else{
            return "redirect:/owner_inquiries/list.do";
        }
    }

    @RequestMapping("answer_insert.do")
    public String answer_insert(int o_inquiries_id,String o_answer_content){

        AdminVo admin = (AdminVo)session.getAttribute("user");
        if(admin == null){
            return "redirect:/login_form.do";
        }
        OwnerAnswerVo answer = new OwnerAnswerVo();
        answer.setO_inquiries_id(o_inquiries_id);
        answer.setO_answer_content(o_answer_content);
        answer.setAdmin_id(admin.getAdmin_id()); 
        owner_answer_mapper.insert(answer);
        System.out.println("o_inquiries_id:"+o_inquiries_id);
        
        return "redirect:/owner_inquiries/detail.do?o_inquiries_id="+ o_inquiries_id;
    }
    @RequestMapping("answer_modify_form.do")
    public String answer_modify_form(Integer o_answer_id, @RequestParam(value = "o_inquiries_id", required = true) Integer o_inquiries_id,Model model){

        //System.out.println("o_answer_id: " + o_answer_id + ", o_inquiries_id: " + o_inquiries_id); // 로깅
        OwnerAnswerVo vo = owner_answer_mapper.selectOne(o_answer_id);
        if(vo == null){
            return "redirect:/owner_inquiries/detail.do?o_inquiries_id=" + o_inquiries_id;
        }

        model.addAttribute("vo", vo);
        model.addAttribute("o_inquiries_id", vo.getO_inquiries_id());

        return "owner_answer/answer_modify_form";
    }

    @RequestMapping("answer_modify.do")
    public String answer_modify(int o_answer_id,String o_answer_content, int o_inquiries_id){
        AdminVo admin = (AdminVo)session.getAttribute("user");
        if(admin == null){
            System.out.println("admin:"+admin);
            return "redirect:/login_form.do";
        }

        OwnerAnswerVo answer = new OwnerAnswerVo();
        answer.setO_answer_id(o_answer_id);
        answer.setO_answer_content(o_answer_content);
        answer.setO_inquiries_id(o_inquiries_id);
        answer.setAdmin_id(admin.getAdmin_id());
        answer.setAdmin_accountId(admin.getAdmin_accountId());

        owner_answer_mapper.update(answer);
        return "redirect:/owner_inquiries/detail.do?o_inquiries_id="+ o_inquiries_id;
    }

    @RequestMapping("answer_delete.do")
    public String answer_delete(@RequestParam int o_inquiries_id,@RequestParam int o_answer_id){

        owner_answer_mapper.delete(o_answer_id);
        return "redirect:/owner_inquiries/detail.do?o_inquiries_id="+ o_inquiries_id;
    }
}    
