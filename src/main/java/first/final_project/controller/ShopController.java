package first.final_project.controller;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import first.final_project.dao.MenuMapper;
import first.final_project.service.ShopService;
import first.final_project.vo.MenuVo;
import first.final_project.vo.OwnerVo;
import first.final_project.vo.ShopVo;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ShopController {

    @Autowired
    ShopService shop_Service;

    @Autowired
    MenuMapper menuMapper;

    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpSession session;

    @Autowired
    ServletContext application;

    // 메인화면
    @RequestMapping("/shop/list.do")
    public String shop_list(String food_category, Model model) {

        List<ShopVo> list;
        System.out.println(food_category);

        list = shop_Service.selectList(food_category);
        
        model.addAttribute("list", list);

        return "shop/shop_list";
    }

    // 가게 등록 폼 이동
    @RequestMapping("/shop/insert_form.do")
    public String shop_insert_from() {

        return "shop/shop_insert_form";
    }

    // 가게 등록
    @RequestMapping("/shop/insert.do")
    public String shop_insert(ShopVo vo, RedirectAttributes ra, @RequestParam(name = "photo") MultipartFile photo)
            throws Exception {

        OwnerVo user = (OwnerVo) session.getAttribute("user");
        int owner_id = user.getOwner_id();
        System.out.println(owner_id);

        System.out.println("---shop_insert.do----");
        String shop_img = "no_file";

        String absPath = application.getRealPath("/resources/images/");

        // com.final_project.common.Util.createDirectoryIfNotExists(directoryPath);

        if (!photo.isEmpty()) {
            UUID uuid = UUID.randomUUID();
            shop_img = uuid + "_" + photo.getOriginalFilename();
            File f = new File(absPath, shop_img);
            photo.transferTo(f);
        }

        vo.setShop_img(shop_img);
        vo.setOwner_id(owner_id);
        int res = shop_Service.insert(vo);

        return "redirect:list.do";
    }

    // 가게 하나 선택
    @RequestMapping("/shop/select_one.do")
    public String shop_selectOne(int shop_id, Model model) {
        System.out.println("shop_id : " + shop_id);
        
        
        // Map<String, Integer> counts;  // Changed to CountsVo
        ShopVo vo = new ShopVo();
        try {

            vo = shop_Service.selectOne(shop_id);
            // counts = shop_Service.selectMenuAndReviewsCount(shop_id);
    
            // Adding attributes to the model

            // 한지혜브랜치2에만 있던 코드 
            List<MenuVo> menu_list = menuMapper.selectMenuList(shop_id);
          
            model.addAttribute("vo", vo);
          
            // if (vo != null) {
            //     vo.setMenu_count(counts != null ? counts.get("menu_count") : 0);
            //     vo.setReviews_count(counts != null ? counts.get("reviews_count") : 0);
            // }
            System.out.println("정상 실행 ");
            return "shop/shop_listOne";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "fail_select_one");
            return "error/error_page";
        }
    }

    // 가게 정보 수정
    @RequestMapping("/shop/modify_form.do")
    public String shop_modify(Model model) {

        try {
            OwnerVo user = (OwnerVo) session.getAttribute("user");
            int owner_id = user.getOwner_id();
            System.out.println("owner_id : " + owner_id);

            ShopVo vo = shop_Service.select_modify_owner_id(owner_id);
            System.out.println("수행");
            // System.out.println(vo.getShop_id());
            model.addAttribute("vo", vo);
            return "shop/shop_modify_form";
        } catch (Exception e) {
            return "error/error_page";
        }

    }

    // 가게 정보 수정 업데이트
    @RequestMapping("/shop/modify.do")
    public String shop_modify(ShopVo vo, @RequestParam MultipartFile photo, RedirectAttributes ra,
            Model model) {
        // 기존 이미지 불러오기
        System.out.println();
        String filename = shop_Service.selectOne(vo.getShop_id()).getShop_img();
        System.out.println("vo.getShop_img filename = " + filename);

        String shop_img = "no_file";
        // 이미지 저장할 경로
        String absPath = application.getRealPath("/resources/images/");
        System.out.println(absPath);
        // 새로운 이미지 UUID 부여
        if (!photo.isEmpty()) {
            UUID uuid = UUID.randomUUID();
            shop_img = uuid + "_" + photo.getOriginalFilename();

            // 기존 이미지 확인 및 삭제
            File oldFile = new File(absPath, filename);
            if (oldFile.exists()) {
                boolean result = oldFile.delete();
                if (result) {
                    System.out.println("파일이 성공적으로 삭제되었습니다.");
                } else {
                    System.out.println("파일 삭제에 실패했습니다.");
                }
            } else {
                System.out.println("파일이 존재하지 않습니다.");
            }
            System.out.println("이미지 삭제 완료");
            // if (!result) {
            // model.addAttribute("errorMessage", "Failed to delete the old image");
            // return "error/error_page";
            // }

            System.out.println(shop_img);
            // 새로운 이미지 파일 저장
            vo.setShop_img(shop_img);
            File f = new File(absPath, shop_img);

            try {
                photo.transferTo(f);
                System.out.println("이미지 저장 완료");
            } catch (Exception e) {
                e.printStackTrace();
            }

        }

        try {
            int res = shop_Service.update(vo);
            return "redirect:list.do";
            // shop_id = vo.getShop_id();
        } catch (Exception e) {
            return "error/error_page";
        }
        // return "redirect:modify_form.do?shop_id=" + shop_id;

    }

    // 가게 삭제
    @RequestMapping("/shop/delete.do")
    public String shop_delete(int shop_id, RedirectAttributes ra, Model model) {
        try {
            @SuppressWarnings("unused")
            int res = shop_Service.delete(shop_id);
        } catch (Exception e) {
            model.addAttribute("errorMessage", "fail_select_one");
            return "error/error_page";
        }
        return "redirect:list.do";
    }
}
