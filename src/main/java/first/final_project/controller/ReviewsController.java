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

import first.final_project.dao.CeoReviewMapper;
import first.final_project.dao.OrderMapper;
import first.final_project.dao.ReviewsMapper;
import first.final_project.vo.MemberVo;
import first.final_project.vo.OrderVo;
import first.final_project.vo.OwnerVo;
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

    @Autowired
    CeoReviewMapper ceoreviewMapper;

    @RequestMapping("/insert_form.do")
    public String insert_form(int orders_id, Model model, RedirectAttributes ra) {
        // user 로그인 상태 확인
        // 유효성 검증: orders_id가 0 이하인 경우
        // if (orders_id <= 0) {
        // System.out.println("유효하지 않은 orders_id: " + orders_id);
        // ra.addAttribute("reason", "invalid_orders_id");
        // return "redirect:error/error_page"; // 유효하지 않은 경우 에러 페이지로 리다이렉트
        // }
        MemberVo user = (MemberVo) session.getAttribute("user");
        if (user == null) {
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
    public String list(Model model, RedirectAttributes ra) {

        MemberVo user = (MemberVo) session.getAttribute("user");

        if (user == null) {
            ra.addAttribute("reason", "session_timeout");
            return "redirect:../member/login.do";
        }

        int member_id = user.getMember_id();
        System.out.println("도착");
        List<ReviewsVo> list = reviewsMapper.selectList(member_id);
        for (ReviewsVo vo : list) {
            Boolean result = reviewsMapper.checkCeoReviewExists(vo.getReviews_id());
            boolean hasCeoReview = (result != null) ? result : false;
            vo.setHasCeoReview(hasCeoReview);
            String reviews_content = vo.getReviews_content().replaceAll("\n", "<br>");
            vo.setReviews_content(reviews_content);
        }
        System.out.println("호출완료");

        model.addAttribute("list", list);
        return "reviews/reviews_list";
    }

    @RequestMapping("listByShopId.do")
    public String listByShopId(int shop_id, Model model) {
        System.out.println("listByShopId에 도착");
        System.out.println("shop_id = " + shop_id);
        // if (shop_id == null) {
        // // Handle null shop_id case
        // return "error/errorPage";
        // }
        List<ReviewsVo> list = reviewsMapper.selectListByShopId(shop_id);
        for (ReviewsVo vo : list) {
            Boolean result = reviewsMapper.checkCeoReviewExists(vo.getReviews_id());
            boolean hasCeoReview = (result != null) ? result : false;
            vo.setHasCeoReview(hasCeoReview);
        }
        model.addAttribute("list", list);
        System.out.println("List size: " + list.size());
        return "reviews/reviews_listByShopId";
    }

    @RequestMapping("listByOwner.do")
    public String listByOwner(Model model, RedirectAttributes ra) {
        OwnerVo user = (OwnerVo) session.getAttribute("user");
        if (user == null) {
            ra.addAttribute("reason", "session_timeout");
            return "redirect:../member/login.do";
        }
        int shop_id = order_mapper.getShopIdByOrderId(user.getOwner_id());
        System.out.println("shop_id : " + shop_id);
        List<ReviewsVo> list = reviewsMapper.selectListByShopId(shop_id);

        for (ReviewsVo vo : list) {
            Boolean result = reviewsMapper.checkCeoReviewExists(vo.getReviews_id());
            boolean hasCeoReview = (result != null) ? result : false;
            vo.setHasCeoReview(hasCeoReview);
        }

        model.addAttribute("list", list);

        return "reviews/reviews_listByOwner";
    }

    // reivews insert & reviews_images insert
    @RequestMapping("insert.do")
    public String insert(@RequestParam(name = "orders_id") int orders_id, ReviewsVo vo,
            @RequestParam(name = "photo") List<MultipartFile> photo_list, Model model, RedirectAttributes ra) {

        if (orders_id <= 0) {
            System.out.println("유효하지 않은 orders_id: " + orders_id);
            return "redirect:error/error_page"; // 유효하지 않은 경우 에러 페이지로 리다이렉트
        }
        System.out.println(orders_id);
        System.out.println("도착");

        MemberVo user = (MemberVo) session.getAttribute("user");

        if (user == null) {
            ra.addAttribute("reason", "session_timeout");
            return "redirect:../member/login.do";
        }

        // reviews DB 에 인서트
        vo.setOrders_id(orders_id);
        // reviews 등록
        int res = reviewsMapper.insert(vo);

        System.out.println("reviews 등록 완료 ");

        // 첫 번째 파일을 가져옴
        if (!photo_list.isEmpty() && !photo_list.get(0).isEmpty()) {
            String absPath = application.getRealPath("/resources/images/");
            List<String> filename_list = new ArrayList<>();

            for (MultipartFile photo : photo_list) {
                if (!photo.isEmpty()) {
                    String reviews_img = UUID.randomUUID() + "_" + photo.getOriginalFilename();
                    filename_list.add(reviews_img);
                    File f = new File(absPath, reviews_img);

                    try {
                        photo.transferTo(f);
                    } catch (IOException e) {
                        e.printStackTrace();
                        return "redirect:error/error_page"; // Redirect on file upload failure
                    }
                }
            }

            // Insert review images
            int reviews_id = reviewsMapper.getReviewIdFromOrderId(orders_id);
            ReviewsImagesVo imageVo = new ReviewsImagesVo();
            imageVo.setReviews_id(reviews_id);

            for (String filename : filename_list) {
                imageVo.setReviews_img(filename);
                res = reviewsMapper.insert_img(imageVo);
            }
        }

        ra.addFlashAttribute("message", "Review submitted successfully.");
        return "redirect:list.do";
    }

    @RequestMapping("delete.do")
    public String delete_reviews(int reviews_id, RedirectAttributes ra) {

        List<String> imageFiles = reviewsMapper.getImageForReviews(reviews_id);
        String absPath = application.getRealPath("/resources/images/");
        for (String imageFile : imageFiles) {
            File file = new File(absPath + imageFile);
            if (file.exists()) {
                file.delete();
            }
        }
        int res = order_mapper.setHasReview(reviews_id);
        reviewsMapper.deleteReviews(reviews_id);
        return "redirect:list.do";
    }

}
