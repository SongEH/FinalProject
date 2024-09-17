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

import ch.qos.logback.core.net.SyslogOutputStream;
import first.final_project.dao.OrderMapper;
import first.final_project.dao.ReviewsMapper;
import first.final_project.vo.MemberVo;
import first.final_project.vo.OrderVo;
import first.final_project.vo.ReviewsImagesVo;
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

    @Autowired
    ReviewsMapper reviewsMapper;
    
    @Autowired
	OrderMapper order_mapper;

    @RequestMapping("/insert_form.do")
    public String insert_form(int orders_id ,Model model, RedirectAttributes ra){
        // user 로그인 상태 확인
        // 유효성 검증: orders_id가 0 이하인 경우
        // if (orders_id <= 0) {
        //     System.out.println("유효하지 않은 orders_id: " + orders_id);
        //     ra.addAttribute("reason", "invalid_orders_id");
        //     return "redirect:error/error_page"; // 유효하지 않은 경우 에러 페이지로 리다이렉트
        // }
        MemberVo user = (MemberVo) session.getAttribute("user");
        if(user==null){
            ra.addAttribute("reason", "session_timeout");
			return "redirect:../member/login.do";
        }
        // member_id 가져오기; 
        
        // 주문 정보 얻어오기 
        OrderVo vo = order_mapper.selectOneByOrdersId(orders_id);
        model.addAttribute("vo", vo);
        return "reviews/reviews_insert_form";
    }

    @RequestMapping("list.do")
    public String list(Model model, RedirectAttributes ra){
        
        MemberVo user = (MemberVo) session.getAttribute("user");

        if(user==null){
            ra.addAttribute("reason", "session_timeout");
			return "redirect:../member/login.do";
        }

        int member_id = user.getMember_id();
        System.out.println("도착");
        List<ReviewsVo> list = reviewsMapper.selectList(member_id);
        System.out.println("호출완료");

        model.addAttribute("list", list);
        return "reviews/reviews_list";
    }

    // reivews insert & reviews_images insert 
    @RequestMapping("insert.do")
    public String insert(@RequestParam(name="orders_id")int orders_id, ReviewsVo vo, @RequestParam(name="photo")List<MultipartFile> photo_list, Model model, RedirectAttributes ra) {

        if (orders_id <= 0) {
            System.out.println("유효하지 않은 orders_id: " + orders_id);
            return "redirect:error/error_page"; // 유효하지 않은 경우 에러 페이지로 리다이렉트
        }
        System.out.println(orders_id);
        System.out.println("도착");

        MemberVo user = (MemberVo) session.getAttribute("user");

        if(user==null){
            ra.addAttribute("reason", "session_timeout");
			return "redirect:../member/login.do";
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
                
                try {
                    photo.transferTo(f);
                } catch (IOException e) {
                    return "redirect:error/error_page";
                }
            }
            filename_list.add(reviews_img);
        }

        // reviews DB 에 인서트
        vo.setOrders_id(orders_id);

        // reviews 등록 
        int res = reviewsMapper.insert(vo);
        System.out.println("reviews 등록 완료 ");

        // reviews 의 id 받아오기 
        int reviews_id = reviewsMapper.getReviewIdFromOrderId(orders_id);
        System.out.println("reviews_id=" +  reviews_id);

        ReviewsImagesVo imageVo = new ReviewsImagesVo();
        imageVo.setReviews_id(reviews_id);
        System.out.println(imageVo.getReviews_id());
        // 이미지 insert
        for (String filename : filename_list){
            reviews_img = filename;
            imageVo.setReviews_img(reviews_img);

            res = reviewsMapper.insert_img(imageVo);
        }

        // ra.addAllAttributes();

        return "redirect:list.do";
    }

    @RequestMapping("delete.do")
    public String delete_reviews(int reviews_id,RedirectAttributes ra){

        List<String> imageFiles = reviewsMapper.getImageForReviews(reviews_id);
        String absPath = application.getRealPath("/resources/images/");
        for (String imageFile : imageFiles) {
            File file = new File(absPath + imageFile);
            if (file.exists()) {
                file.delete();
            }
        }

        reviewsMapper.deleteReviews(reviews_id);

        return "redirect:reviews/list.do";
    }
}
