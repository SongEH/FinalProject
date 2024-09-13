package first.final_project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import first.final_project.dao.MemberMapper;
import first.final_project.vo.MemberVo;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member/")
public class MemberController {

    // 자동연결(요청시 마다 Injection)
    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpSession session;

    @Autowired
    MemberMapper member_mapper;


    // 마이페이지
    @RequestMapping("mypage.do")
    public String showMyPage(MemberVo vo, Model model) {
        MemberVo user = (MemberVo) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login_form.do";
        }
        MemberVo member = member_mapper.selectOneFromIdx(user.getMember_id());
        model.addAttribute("member", member);
        // 다른 데이터 모델 추가
        return "member/member_mypage";
    }

    // 마이페이지에서 회원 수정폼 띄우기
    @RequestMapping(value = "mypage/modify_form.do", method = RequestMethod.GET)
    public String myPageEditForm(Model model) {
        MemberVo user = (MemberVo) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login_form.do";
        }
        // 로그인한 유저의 정보를 가져옴
        MemberVo member = member_mapper.selectOneFromIdx(user.getMember_id());
        model.addAttribute("member", member);
        return "member/mypage_modify"; // 수정 폼 JSP 페이지
    }

    // 회원정보 수정을 처리하는 메소드
    @RequestMapping(value = "mypage/modify.do", method = RequestMethod.POST)
    public String myPageEdit(MemberVo vo) {
        // 회원 정보 업데이트
        member_mapper.update(vo);

        // 세션의 사용자 정보도 업데이트
        session.setAttribute("user", vo);

        return "redirect:/member/mypage.do"; // 수정 후 마이페이지로 리다이렉트
    }

    // 마이페이지에서 회원 탈퇴
    @RequestMapping(value = "mypage/delete.do", method = RequestMethod.GET)
    public String myPageDelete(@RequestParam int member_id) {
        member_mapper.delete(member_id);
        session.invalidate(); // 세션 무호화 -> 사용자가 탈퇴할 때 세션에 저장된 정보가 더이상 유효하지 않기에 세션을 무효화 시켜야 한다
        return "redirect:/main.do";
    }

}
