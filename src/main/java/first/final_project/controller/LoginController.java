package first.final_project.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import first.final_project.dao.AdminMapper;
import first.final_project.dao.MemberMapper;
import first.final_project.dao.OwnerMapper;
import first.final_project.vo.AdminVo;
import first.final_project.vo.MemberVo;
import first.final_project.vo.OwnerVo;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {
    // 자동연결(요청시 마다 Injection)
    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpSession session;

    @Autowired
    MemberMapper member_mapper;

    @Autowired
    OwnerMapper owner_mapper;

    @Autowired
    AdminMapper admin_mapper;

    // 회원가입 폼
    @RequestMapping("insert_form.do")
    public String insert_form() {
        return "insert_form";
    }

    // 회원가입
    @RequestMapping("/member/insert.do")
    public String insert(MemberVo vo) {
        member_mapper.insert(vo);
        session.setAttribute("vo", vo);
        return "redirect:/login_form.do";
    }

    // 사장 회원가입
    @RequestMapping("/owner/insert.do")
    public String insert(OwnerVo vo) {
        owner_mapper.insert(vo);
        session.setAttribute("vo", vo);
        return "redirect:/login_form.do";
    }

    // 로그인 폼
    @RequestMapping("login_form.do")
    public String login_form() {
        return "login_form";
    }

    // 회원의 로그인
    @RequestMapping("/member/login.do")
    public String member_login(String member_accountId, String member_pwd, String url, RedirectAttributes ra) {

        MemberVo user = member_mapper.selectOneFromId(member_accountId);

        if (user == null) {
            ra.addAttribute("reason", "fail_id");

            return "redirect:/login_form.do";
        }

        if (user.getMember_pwd().equals(member_pwd) == false) {
            ra.addAttribute("reason", "fail_pwd");
            ra.addAttribute("member_accountId", member_accountId);

            return "redirect:/login_form.do";
        }

        session.setAttribute("user", user);
        session.setAttribute("userType", "MEMBER");
        session.setAttribute("isLoggedIn", true);

        session.setAttribute("currentUser", user.getMember_accountId());
        // 절대 경로 사용
        // String redirectUrl = (url == null || url.isEmpty()) ? "/main.do" : url;
        // return "redirect:" + redirectUrl;

        // 절대 경로 사용 (수정 by 태광)
        return "redirect:../main/display.do";

        // if (url == null || url.isEmpty())
        // return "redirect:/main.do";
        // else
        // return "redirect:" + url;
    }

    // 아이디 중복 체크
    @RequestMapping("/member/check_member_accountId.do")
    @ResponseBody
    public Map<String, Boolean> check_member_id(@RequestParam("member_accountId") String member_accountId) {
        MemberVo vo = member_mapper.selectOneFromId(member_accountId);
        boolean bResult = (vo == null);
        Map<String, Boolean> map = new HashMap<>();
        map.put("result", bResult);
        return map;
    }

    // 닉네임 중복 체크
    @RequestMapping("/member/check_member_nickname.do")
    @ResponseBody
    public Map<String, Boolean> check_nickname(@RequestParam("member_nickname") String member_nickname) {
        MemberVo vo = member_mapper.selectOneFromNickname(member_nickname);
        boolean bResult = (vo == null);
        Map<String, Boolean> map = new HashMap<>();
        map.put("result", bResult);
        return map;
    }

    // 사장의 로그인
    @RequestMapping("/owner/login.do")
    public String owner_login(String owner_accountId, String owner_pwd, RedirectAttributes ra) {

        OwnerVo user = owner_mapper.selectOneFromId(owner_accountId);

        if (user == null) {
            ra.addAttribute("reason", "fail_id");
            ra.addAttribute("owner_accountId", owner_accountId);

            return "redirect:/login_form.do";
        }

        if (user.getOwner_pwd().equals(owner_pwd) == false) {
            ra.addAttribute("reason", "fail_pwd");
            ra.addAttribute("owner_accountId", owner_accountId);

            return "redirect:/login_form.do";
        }

        if ("PENDING".equals(user.getApproval_status())) {
            ra.addAttribute("reason", "pending");

            return "redirect:/login_form.do";
        }

        if ("REJECTED".equals(user.getApproval_status())) {
            ra.addAttribute("reason", "rejected");

            return "redirect:/login_form.do";
        }

        session.setAttribute("user", user);
        session.setAttribute("userType", "OWNER");
        session.setAttribute("currentUser", user.getOwner_accountId());
        System.out.println(user);
        // return "redirect:../main.do";
        // 태광 수정 
        return "redirect:../order/accept.do";
    }

    // 아이디 중복 체크
    @RequestMapping("/owner/check_owner_accountId.do")
    @ResponseBody
    public Map<String, Boolean> check_owner_id(@RequestParam("owner_accountId") String owner_accountId) {
        OwnerVo vo = owner_mapper.selectOneFromId(owner_accountId);
        boolean bResult = (vo == null);
        Map<String, Boolean> map = new HashMap<>();
        map.put("result", bResult);
        return map;
    }

    // 관리자 로그인
    @RequestMapping("/admin/login.do")
    public String admin_login(String admin_accountId, String admin_pwd, RedirectAttributes ra) {

        AdminVo user = admin_mapper.selectOneFromId(admin_accountId);

        if (user == null) {
            ra.addAttribute("reason", "fail_id");

            return "redirect:/login_form.do";
        }

        if (user.getAdmin_pwd().equals(admin_pwd) == false) {
            ra.addAttribute("reason", "fail_pwd");
            ra.addAttribute("admin_accountId", admin_accountId);

            return "redirect:/login_form.do";
        }

        session.setAttribute("user", user);
        session.setAttribute("userType", "ADMIN");
        
        return "redirect:/admin/member_list.do";
    }

    // 로그아웃
    @RequestMapping("logout.do")
    public String logout() {

        session.invalidate();

        // return "redirect:/main.do";
        return "redirect:/main/display.do";
    }

}
