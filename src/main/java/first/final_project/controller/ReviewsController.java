package first.final_project.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import first.final_project.vo.MemberVo;
import first.final_project.vo.ReviewsImageVo;
import first.final_project.vo.ReviewsVo;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/reviews")
public class ReviewsController {

    @Autowired
    HttpSession session;

    @Autowired
    ServletContext application;
    
    @RequestMapping("/insert_form.do")
    public String insert_form(){

        return "reviews/insert_form";
    }

    @RequestMapping("insert.do")
    public String insert(@RequestParam(name="photo")List<MultipartFile> photo_list, Model model, RedirectAttributes ra) throws IllegalStateException, IOException{

        System.out.println("도착");

        ReviewsVo vo;
        ReviewsImageVo imgvo;

        MemberVo user = (MemberVo) session.getAttribute("user");

        if(user==null){
            ra.addAttribute("reason", "session_timeout");
			return "redirect:../member/login_form.do";
        }

        // 이미지 저장 경로 
        String absPath = application.getRealPath("/resources/images/");
        // 이미지 저장 List 객체 생성 
        List<String> filename_list = new ArrayList<String>();
        // 초기화
        String reviews_img = "no_file";
        // 이미지 저장 경로에 저장 
        for(MultipartFile photo : photo_list){
            if(!photo.isEmpty()){
                UUID uuid = UUID.randomUUID();
                reviews_img = uuid + "_" + photo.getOriginalFilename();
                File f = new File(absPath, reviews_img);
                photo.transferTo(f);
            }
            filename_list.add(reviews_img);
        }

        // reviews DB 에 인서트
        vo.setMember_id(user.getMember_id());
        vo.setShop_id(1);

        // reviews 등록 
        int res = 

        // reviews 의 id 받아오기 
        int reviews_id = 1;
        imgvo.setReviews_id(reviews_img);
        // 이미지 insert
        for (String filename : filename_list){
            reviews_img = filename;
            imgvo.setReviews_ima_name(reviews_img);
        }





        return "reviews";
    }
}
