package first.final_project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
    OwnerMapper owner_mapper;

    @RequestMapping("ownerpage.do")
    public String showOnwerPage(OwnerVo vo, Model model) {
        OwnerVo user = (OwnerVo) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login_form.do";
        }
        OwnerVo owner = owner_mapper.selectOneFromIdx(user.getOwner_id());
        model.addAttribute("owner", owner);

        return "owner/owner_page";
    }

    @RequestMapping(value = "ownerpage/modify_form.do", method = RequestMethod.GET)
    public String ownerPageEditForm(Model model) {
        OwnerVo user = (OwnerVo) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login_form.do";
        }

        OwnerVo owner = owner_mapper.selectOneFromIdx(user.getOwner_id());
        model.addAttribute("owner", owner);
        return "owner/ownerpage_modify";

    }

    @RequestMapping(value = "ownerpage/modify.do", method = RequestMethod.POST)
    public String ownerPageEdit(OwnerVo vo) {
        owner_mapper.update(vo);
        session.setAttribute("owner", vo);
        return "redirect:/owner/ownerpage.do";
    }

    @RequestMapping(value = "ownerpage/delete.do", method = RequestMethod.GET)
    public String ownerPageDelete(@RequestParam int owner_id) {
        owner_mapper.delete(owner_id);
        session.invalidate();
        return "redirect:/main/display.do";
    }

}