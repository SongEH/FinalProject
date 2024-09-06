package first.final_project.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import first.final_project.dao.OwnerMapper;
import first.final_project.vo.OwnerVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/owner/")
public class OwnerController {
    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpSession session;

    @Autowired
    OwnerMapper ownerMapper;

    // 사장 회원가입
    @RequestMapping("insert_form.do")
    public String insert_form() {
        return "insert_form";
    }

    // 사장 회원가입
    @RequestMapping("insert.do")
    public String insert(OwnerVo vo) {
        ownerMapper.insert(vo);
        return "redirect:login_form.do";
    }

    // 아이디 중복 체크
    @RequestMapping("check_owner_accountId.do")
    @ResponseBody
    public Map<String, Boolean> check_id(@RequestParam("owner_accountId") String owner_accountId) {
        OwnerVo vo = ownerMapper.selectOneFromId(owner_accountId);
        boolean bResult = (vo == null);
        Map<String, Boolean> map = new HashMap<>();
        map.put("result", bResult);
        return map;
    }

    // 로그인 폼
    @RequestMapping("login_form.do")
    public String login_form() {
        return "login_form";
    }

    // 로그인
    @RequestMapping("login.do")
    public String login(String owner_accountId, String owner_pwd, RedirectAttributes ra) {

        OwnerVo user = ownerMapper.selectOneFromId(owner_accountId);

        if (user == null) {
            ra.addAttribute("reason", "fail_id");
            ra.addAttribute("owner_accountId", owner_accountId);

            return "redirect:login_form.do";
        }

        if (user.getOwner_pwd().equals(owner_pwd) == false) {
            ra.addAttribute("reason", "fail_pwd");
            ra.addAttribute("owner_accountId", owner_accountId);

            return "redirect:login_form.do";
        }

        if ("PENDING".equals(user.getApproval_status())) {
            ra.addAttribute("reason", "pending");

            return "redirect:login_form.do";
        }

        if ("REJECTED".equals(user.getApproval_status())) {
            ra.addAttribute("reason", "rejected");

            return "redirect:login_form.do";
        }

        session.setAttribute("user", user);
        System.out.println(user);
        return "redirect:../main.do";
    }

    // 로그아웃
    @RequestMapping("logout.do")
    public String logout() {

        session.removeAttribute("owner_user");

        return "redirect:../main.do";
    }

    // 사장의 마이페이지
    @RequestMapping("ownerpage.do")
    public String showOnwerPage(OwnerVo vo, Model model) {
        OwnerVo owner_user = (OwnerVo) session.getAttribute("owner_user");
        if (owner_user == null) {
            return "redirect:/owner/login_form.do";
        }
        OwnerVo owner = ownerMapper.selectOneFromIdx(owner_user.getOwner_id());
        model.addAttribute("owner", owner);

        return "owner/owner_page";
    }

    // 사장의 마이페이지에서 수정폼 띄우기
    @RequestMapping(value = "ownerpage/modify_form.do", method = RequestMethod.GET)
    public String ownerPageEditForm(Model model) {
        OwnerVo owner_user = (OwnerVo) session.getAttribute("owner_user");
        if (owner_user == null) {
            return "redirect:/owner/login_form.do";
        }

        OwnerVo owner = ownerMapper.selectOneFromIdx(owner_user.getOwner_id());
        model.addAttribute("owner", owner);
        return "owner/ownerpage_modify";

    }

    // 사장의 마이페이지에서 수정을 처리하는 메소드
    @RequestMapping(value = "ownerpage/modify.do", method = RequestMethod.POST)
    public String ownerPageEdit(OwnerVo vo) {
        ownerMapper.update(vo);
        session.setAttribute("owner", vo);
        return "redirect:/owner/ownerpage.do";
    }

    // 사장의 마이페이지에서 회원 탈퇴
    @RequestMapping(value = "ownerpage/delete.do", method = RequestMethod.GET)
    public String ownerPageDelete(@RequestParam int owner_id) {
        ownerMapper.delete(owner_id);
        session.invalidate();
        return "redirect:/main.do";
    }

}
