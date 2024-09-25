package first.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import first.final_project.dao.AdminMapper;
import first.final_project.dao.NoticeMapper;
import first.final_project.vo.AdminVo;
import first.final_project.vo.NoticeVo;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/notice/")
public class NoticeController {
    
    @Autowired
    HttpSession session;

    @Autowired
    HttpServletRequest request;

    @Autowired
    NoticeMapper notice_mapper;

    @Autowired
    AdminMapper admin_mapper;

    //공지사항 조회(type별 조회)
    @RequestMapping("list.do")
    public String list(@RequestParam(value="notice_type",defaultValue="전체")String notice_type,Model model){

        List<NoticeVo> list = notice_mapper.selectListByType(notice_type);
        for(NoticeVo vo : list){
            AdminVo admin = admin_mapper.selectOneFromIdx(vo.getAdmin_id());
            if(admin == null){
                return "redirect:/login_form.do";
            }
            vo.setAdminAccountId(admin.getAdmin_accountId());
        }
        model.addAttribute("list", list);
        model.addAttribute("notice_type", notice_type);
        return "notice/notice_list";
    }

    @RequestMapping("detail.do")
    public String detail(@RequestParam(value="notice_id",required = false) Integer notice_id,Model model){
        if(notice_id == null){
            return "redirect:/login_form.do";
        }
        NoticeVo vo = notice_mapper.selectOneFromIdx(notice_id);
        if(vo == null){
            //공지사항이 존재하지 않는 경우 처리
            return "redirect:/notice/list.do";
        }
        AdminVo admin = admin_mapper.selectOneFromIdx(vo.getAdmin_id());
        if (admin == null) {
            return "redirect:/login_form.do";
        }
        vo.setAdminAccountId(admin.getAdmin_accountId());

        String content = vo.getNotice_content().replace("\n", "<br/>");
        vo.setNotice_content(content);
        
        model.addAttribute("vo", vo);
        return "notice/notice_detail";
    }

    @RequestMapping("insert_form.do")
    public String insert_form(){
        String userType = (String) session.getAttribute("userType");
        if("ADMIN".equals(userType)){
            return "notice/notice_insert_form";
        }else{
            return "redirect:/login_form.do";
        }
    }

    @RequestMapping("insert.do")
    public String insert(String notice_title,String notice_content,String notice_type){
        // 세션에서 user 객체를 가져옴
        AdminVo admin = (AdminVo) session.getAttribute("user");
        if (admin == null) {
            // 로그인하지 않은 경우
            return "redirect:/login_form.do";
        }

        // 사용자 타입을 확인
        String userType = (String) session.getAttribute("userType");
        if ("ADMIN".equals(userType)) {
            // NoticeVo 객체 생성 및 필드 설정
            NoticeVo notice = new NoticeVo();
            
            notice.setNotice_title(notice_title);
            notice.setNotice_content(notice_content);
            notice.setNotice_type(notice_type);
            notice.setAdmin_id(admin.getAdmin_id()); // 관리자 ID 설정

            // 데이터베이스에 공지사항 삽입
            notice_mapper.insert(notice);

            return "redirect:/notice/list.do";
        } else {
            // 권한이 없는 경우 로그인 페이지로 리다이렉트
            return "redirect:/login_form.do";
        }
    }

    @RequestMapping("modify_form.do")
    public String modify_form(Integer notice_id, Model model) {
        NoticeVo vo = notice_mapper.selectOneFromIdx(notice_id);
        if (vo == null) {
            return "redirect:list.do"; // 공지사항이 존재하지 않으면 목록으로 리디렉션
        }

        String userType = (String) session.getAttribute("userType");
        if (userType == null || !"ADMIN".equals(userType)) {
            return "redirect:/login_form.do"; // 로그인되지 않았거나 ADMIN이 아닌 경우 로그인 페이지로 리디렉션
        }

        model.addAttribute("vo", vo);
        return "notice/notice_modify_form";
    }

    @RequestMapping("modify.do")
    public String modify(int notice_id, String notice_title, String notice_content, String notice_type) {
        String userType = (String) session.getAttribute("userType");
        if (userType == null || !"ADMIN".equals(userType)) {
            return "redirect:/login_form.do"; // 로그인되지 않았거나 ADMIN이 아닌 경우 로그인 페이지로 리디렉션
        }
        AdminVo admin = (AdminVo)session.getAttribute("user");
        if(admin == null){
            return "redirect:/login_form.do";
        }

        System.out.println("admin_id:"+admin.getAdmin_id());
        
        NoticeVo notice = new NoticeVo();
        notice.setNotice_id(notice_id);
        notice.setNotice_title(notice_title);
        notice.setNotice_content(notice_content);
        notice.setNotice_type(notice_type);
        notice.setAdmin_id(admin.getAdmin_id());

        notice_mapper.update(notice);
        return "redirect:/notice/detail.do?notice_id=" + notice_id;
    }

    @RequestMapping("delete.do")
    public String delete(@RequestParam int notice_id){
        notice_mapper.delete(notice_id);
        return "redirect:/notice/list.do";
    }
}
