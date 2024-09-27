package first.final_project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import first.final_project.dao.AddrMapper;
import first.final_project.dao.MemberMapper;
import first.final_project.vo.AddrVo;
import first.final_project.vo.MemberVo;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/addr/")
public class AddrController {

  @Autowired
  HttpSession session;

  @Autowired
  HttpServletRequest request;

  @Autowired
  AddrMapper addr_mapper;

  @Autowired
  MemberMapper member_mapper;

  // 주소 조회
  @RequestMapping("addr_list.do")
  public String addr_list(Model model) {
    // 로그인을 하면 session에 저장되어 있는 user정보를 불러온다
    MemberVo user = (MemberVo) session.getAttribute("user");

    // user정보가 없을 경우에 로그인 폼으로 다시 돌아가기
    if (user == null) {
      return "redirect:/member/login_form.do";
    }

    Integer member_id = user.getMember_id();

    List<AddrVo> addr_list = addr_mapper.selectList(member_id);

    model.addAttribute("addr_list", addr_list);

    return "addr/addr_list";
  }

  @RequestMapping("addr_insert_form.do")
  public String addr_insert_form(Model model) {
    MemberVo user = (MemberVo) session.getAttribute("user");

    if (user == null) {
      return "redirect:/member/login_form.do";
    }

    return "addr/addr_insert_form";
  }

  @RequestMapping("addr_insert.do")
  public String addr_insert(AddrVo vo) {
    MemberVo user = (MemberVo) session.getAttribute("user");

    if (user == null) {
      return "redirect:/member/login_form.do";
    }

    vo.setMember_id(user.getMember_id());

    addr_mapper.insert(vo);

    session.setAttribute("vo", vo);

    return "redirect:/addr/addr_list.do";

  }

  // 주문할 때 새 주소 추가시 - 한지혜
  @RequestMapping("addr_insert2.do")
  @ResponseBody
  public int addr_insert2(
      @RequestParam String addr_zipcode,
      @RequestParam String addr_name,
      @RequestParam String addr_line1,
      @RequestParam String addr_line2) {

    MemberVo user = (MemberVo) session.getAttribute("user");

    AddrVo vo = new AddrVo();
    vo.setMember_id(user.getMember_id());
    vo.setAddr_zipcode(addr_zipcode);
    vo.setAddr_name(addr_name);
    vo.setAddr_line1(addr_line1);
    vo.setAddr_line2(addr_line2);

    // db insert
    int addr_id = addr_mapper.insertNewAddr(vo);

    // MAPPER 하나 더 만들고 int로 받아서 그걸 리턴하기!!!
    addr_mapper.insertNewAddr(vo); // DB에 주소 추가
    System.out.println("생성된 addr_id: " + vo.getAddr_id()); // 생성된 ID 확인


    // 필요한 경우 addr_id도 반환
    return vo.getAddr_id();
  }

  @RequestMapping("addr_modify_form.do")
  public String addr_modify_form(@RequestParam("addr_id") int addr_id, Model model) {
    MemberVo user = (MemberVo) session.getAttribute("user");

    if (user == null) {
      return "redirect:/member/login_form.do";
    }

    AddrVo addr = addr_mapper.selectOneFromIdx(addr_id);

    if (addr == null) {
      return "redirect:/addr/addr_list.do";
    }

    model.addAttribute("addr", addr);

    return "addr/addr_modify_form";
  }

  @RequestMapping("addr_modify.do")
  public String addr_modify(@RequestParam("addr_id") int addr_id,
      @RequestParam("addr_zipcode") String addr_zipcode,
      @RequestParam("addr_line1") String addr_line1,
      @RequestParam("addr_line2") String addr_line2,
      @RequestParam("addr_name") String addr_name) {
    MemberVo user = (MemberVo) session.getAttribute("user");

    if (user == null) {
      return "redirect:/member/login_form.do";
    }

    AddrVo vo = new AddrVo();
    vo.setAddr_id(addr_id);
    vo.setAddr_zipcode(addr_zipcode);
    vo.setAddr_line1(addr_line1);
    vo.setAddr_line2(addr_line2);
    vo.setAddr_name(addr_name);
    vo.setMember_id(user.getMember_id());

    addr_mapper.update(vo);

    return "redirect:/addr/addr_list.do";
  }

  @RequestMapping("addr_delete.do")
  public String addr_delete(@RequestParam int addr_id) {
    MemberVo user = (MemberVo) session.getAttribute("user");

    if (user == null) {
      return "redirect:/member/login_form.do";
    }

    addr_mapper.delete(addr_id);

    session.setAttribute("addr_id", addr_id);
    session.setAttribute("user", user);

    return "redirect:/addr/addr_list.do";
  }
}
