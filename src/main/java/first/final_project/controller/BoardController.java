package first.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import first.final_project.dao.BoardMapper;
import first.final_project.vo.BoardVo;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/board/")
public class BoardController {
    
    @Autowired
    BoardMapper board_mapper;

    @Autowired
    HttpSession session;

    @Autowired
    HttpServletRequest request;

    public BoardController(){

        System.out.println("---BoardController()---");
    }

    //전체 게시글 조회
    @RequestMapping("list.do")
    public String selectList(Model model){

        List<BoardVo> list = board_mapper.selectList();

        model.addAttribute("list",list);

        return "board/board_list";
    }

    //특정 게시글 조회
    @RequestMapping("detail.do")
    public String selectOneFromIdx(int board_id, Model model){

        BoardVo vo = board_mapper.selectOneFromIdx(board_id);

        model.addAttribute("vo", vo);

        return "board/board_detail";
    }

    //게시글 등록 폼 띄우기
    @RequestMapping("insert_form.do")
    public String insert_form(){
         

        return "board/board_insert_form";
    }

    //게시글 등록 처리
    @RequestMapping("insert.do")
    public String insert(BoardVo vo){
        board_mapper.insert(vo);

        session.setAttribute("vo", vo);

        return "redirect:list.do";
    }

    //게시글 수정 폼 
    @RequestMapping("modify_form.do")
    public String modify_form(int board_id, Model model){

        BoardVo vo = board_mapper.selectOneFromIdx(board_id);

        model.addAttribute("vo", vo);

        return "board/board_modify_form";
    }

    //게시글 수정 처리
    @RequestMapping("modify.do")
    public String modify(BoardVo vo){

        board_mapper.update(vo);

        return "redirect:detail.do";
    }

    //게시글 삭제 
    @RequestMapping("delete.do")
    public String delete(int board_id){

        board_mapper.delete(board_id);
        return "redirect:list.do";
    }  
}