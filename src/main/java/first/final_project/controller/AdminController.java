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
import first.final_project.vo.AdminVo;
import first.final_project.vo.MemberVo;
import first.final_project.vo.OwnerVo;
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
    AdminMapper adminMapper;

    @Autowired
    OwnerMapper ownerMapper;

    @Autowired
    MemberMapper memberMapper;

    // 관리자페이지
    @RequestMapping("adminpage.do")
    public String showAdminPage(AdminVo vo, Model model) {
        AdminVo user = (AdminVo) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login_form.do";
        }
        AdminVo admin = adminMapper.selectOneFromIdx(user.getAdmin_id());
        model.addAttribute("admin", admin);
        // 다른 데이터 모델 추가
        return "admin/admin_page";
    }

    // 관리자페이지에서 회원 목록을 조회
    @RequestMapping("member_list.do")
    public String memberList(Model model) {
        List<MemberVo> member_list = memberMapper.selectList();
        // 회원목록이 없다면 빈 목록으로 초기화
        if (member_list == null) {
            member_list = List.of();
        }
        model.addAttribute("member_list", member_list);
        return "admin/member_list";
    }

    // 관리자페이지에서 회원 삭제
    @RequestMapping("delete_member.do")
    public String deleteMember(@RequestParam("member_id") int member_id) {
        // 회원 삭제
        memberMapper.delete(member_id);

        // 세션에서 해당 회원 정보 제거
        MemberVo member = (MemberVo) session.getAttribute("member_user");
        if (member != null && member.getMember_id() == member_id) {
            session.removeAttribute("member_user");
        }

        return "redirect:adminpage.do";
    }

    // 관리자 페이지에서 사장 목록을 조회
    @RequestMapping("owner_list.do")
    public String ownerList(Model model) {
        List<OwnerVo> owner_list = ownerMapper.selectList();
        model.addAttribute("owner_list", owner_list);
        return "admin/owner_list";
    }

    // 관리자 페이지에서 사장 삭제
    @RequestMapping("delete_owner.do")
    public String deleteOwner(@RequestParam("owner_id") int owner_id) {
        ownerMapper.delete(owner_id);

        return "redirect:adminpage.do";
    }

    // 관리자가 대기 중인 사장 등록 요청 확인
    @RequestMapping("pending_requests.do")
    public String pendingRequests(Model model) {
        List<OwnerVo> pendingRequests = ownerMapper.selectPendingRequests(); // 'PENDING' 상태의 요청만 조회할 수 있도록 수정 필요
        model.addAttribute("requests", pendingRequests);
        return "admin/pending_requests";
    }

    // 관리자가 사장 승인 처리
    @RequestMapping("approve_request.do")
    public String approveRequest(@RequestParam("owner_id") int owner_id) {
        OwnerVo owner = ownerMapper.selectOneFromIdx(owner_id);
        if (owner != null) {
            owner.setApproval_status("APPROVED");
            ownerMapper.update_status(owner);
        }
        return "redirect:adminpage.do";
    }

    // 관리자가 사장 거절 처리
    @RequestMapping("reject_request.do")
    public String rejectRequest(@RequestParam("owner_id") int owner_id) {
        OwnerVo owner = ownerMapper.selectOneFromIdx(owner_id);
        if (owner != null) {
            owner.setApproval_status("REJECTED");
            ownerMapper.update_status(owner);
        }
        return "redirect:adminpage.do";
    }
}
