package first.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import first.final_project.dao.AdminMapper;
import first.final_project.dao.MemberMapper;
import first.final_project.dao.OwnerMapper;
import first.final_project.service.ShopService;
import first.final_project.vo.AdminVo;
import first.final_project.vo.MemberVo;
import first.final_project.vo.OwnerVo;
import first.final_project.vo.ShopVo;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin/")
public class AdminController {
    // 자동연결(요청시 마다 Injection)
    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpSession session;

    @Autowired
    AdminMapper admin_mapper;

    @Autowired
    OwnerMapper owner_mapper;

    @Autowired
    MemberMapper member_mapper;

    @Autowired
    ShopService shop_Service;


    @RequestMapping("adminpage.do")
    public String showAdminPage(AdminVo vo, Model model) {
        AdminVo user = (AdminVo) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login_form.do";
        }
        AdminVo admin = admin_mapper.selectOneFromIdx(user.getAdmin_id());
        model.addAttribute("admin", admin);
        return "admin/admin_page";
    }


    @RequestMapping("member_list.do")
    public String memberList(Model model) {
        List<MemberVo> member_list = member_mapper.selectList();

        if (member_list == null) {
            member_list = List.of();
        }
        model.addAttribute("member_list", member_list);
        return "admin/member_list";
    }


    @RequestMapping("delete_member.do")
    public String deleteMember(@RequestParam("member_id") int member_id) {

        member_mapper.delete(member_id);

        MemberVo member = (MemberVo) session.getAttribute("member_user");
        if (member != null && member.getMember_id() == member_id) {
            session.removeAttribute("member_user");
        }

        return "redirect:/admin/member_list.do";
    }


    @RequestMapping("owner_list.do")
    public String ownerList(Model model) {
        List<OwnerVo> owner_list = owner_mapper.selectList();
        model.addAttribute("owner_list", owner_list);
        return "admin/owner_list";
    }

    @RequestMapping("delete_owner.do")
    public String deleteOwner(@RequestParam("owner_id") int owner_id) {
        owner_mapper.delete(owner_id);

        return "redirect:/admin/member_list.do";
    }

    @RequestMapping("shop_list.do")
    public String shopList(Model model){
        List<ShopVo> shop_list = shop_Service.selectListAll();
        model.addAttribute("shop_list", shop_list);
        return "admin/shop_list";
    }

    @RequestMapping("delete_shop.do")
    public String deleteShop(@RequestParam("shop_id")int shop_id){
        shop_Service.delete(shop_id);

        return "redirect:shop_list.do";
    } 

    @RequestMapping("pending_requests.do")
    public String pendingRequests(Model model) {
        List<OwnerVo> pendingRequests = owner_mapper.selectPendingRequests(); 
        model.addAttribute("requests", pendingRequests);
        return "admin/pending_requests";
    }

    @RequestMapping("approve_request.do")
    public String approveRequest(@RequestParam("owner_id") int owner_id) {
        OwnerVo owner = owner_mapper.selectOneFromIdx(owner_id);
        if (owner != null) {
            owner.setApproval_status("APPROVED");
            owner_mapper.update_status(owner);
        }
        return "redirect:/admin/pending_requests.do";
    }

    @RequestMapping("reject_request.do")
    public String rejectRequest(@RequestParam("owner_id") int owner_id) {
        OwnerVo owner = owner_mapper.selectOneFromIdx(owner_id);
        if (owner != null) {
            owner.setApproval_status("REJECTED");
            owner_mapper.update_status(owner);
        }
        return "redirect:/admin/pending_requests.do";
    }
}