package first.final_project.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
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
    public String shop_list(Model model) {

        List<ShopVo> list;
        try {
            list = shop_Service.selectList();
        } catch (Exception e) {
            model.addAttribute("errorMessage", "fail_shop_list");

            return "error/error_page";
        }
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
        int res = shop_Service.insert(vo);

        return "redirect:list.do";
    }

    // -------------------------------------------------------------------------------------------------------------
    // @RequestMapping("/shop/insert.do")
    // public String shop_insert(ShopVo vo, RedirectAttributes ra,
    // @RequestParam(name="photo")List<MultipartFile> photo_list) {
    // int res = 0 ;

    // List<String> filename_list = new ArrayList<String>();

    // String shop_img = null;

    // for (MultipartFile photo : photo_list){
    // if(!photo.isEmpty()){
    // shop_img = photo.getOriginalFilename();
    // File f = new File(filedir, shop_img);

    // if(f.exists()){
    // long tm = System.currentTimeMillis();
    // shop_img = String.format("%d_%s", tm, shop_img);

    // f = new File(filedir, shop_img);
    // }

    // photo.transferTo(f);
    // filename_list.add(shop_img);
    // }
    // }

    // return "redirect:list.do";
    // }
    // -------------------------------------------------------------------------------------------------------------

    // 가게 하나 선택
    @RequestMapping("/shop/select_one.do")
    // @ResponseBody
    public String shop_selectOne(int shop_id, Model model) {

        System.out.println(shop_id);
        ShopVo shop_vo;

        try {
            shop_vo = shop_Service.selectOne(shop_id);
            List<MenuVo> menu_list = menuMapper.selectList();
            model.addAttribute("shop_vo", shop_vo);
            model.addAttribute("menu_list", menu_list);
        } catch (Exception e) {
            model.addAttribute("errorMessage", "fail_select_one");
            return "error/error_page";
        }

        return "shop/shop_listOne";
    }

    // 가게 정보 수정
    @RequestMapping("/shop/modify_form.do")
    public String shop_modify(@RequestParam(value = "shop_id") int shop_id, Model model) {

        try {
            ShopVo vo = shop_Service.select_modify_shop_id(shop_id);
            model.addAttribute("vo", vo);
        } catch (Exception e) {
            model.addAttribute("errorMessage", "fail_select_one");

        }
        return "shop/shop_modify_form";
    }

    // 가게 정보 수정 업데이트
    @RequestMapping("/shop/modify.do")

    public String shop_modify(int shop_id, ShopVo vo, @RequestParam MultipartFile photo, RedirectAttributes ra,
            Model model) 
        // 기존 이미지 불러오기
        System.out.println(shop_id);
        String filename = shop_Service.selectOne(shop_id).getShop_img();
        System.out.println("vo.getShop_img filename = " + filename);

        String shop_img = "no_file";
        // 이미지 저장할 경로
        String absPath = application.getRealPath("/resources/images/");
        // 새로운 이미지 UUID 부여
        if (!photo.isEmpty()) {
            UUID uuid = UUID.randomUUID();
            shop_img = uuid + "_" + photo.getOriginalFilename();

            // 기존 이미지 확인 및 삭제
            File oldFile = new File(absPath, filename);
            boolean result = oldFile.delete();
            if (!result) {
                model.addAttribute("errorMessage", "Failed to delete the old image");
                return "error/error_page";
            }

            System.out.println(shop_img);
            // 새로운 이미지 파일 저장
            vo.setShop_img(shop_img);
            File f = new File(absPath, shop_img);
            try {
                photo.transferTo(f);
            } catch (Exception e) {
                return "error/error_page";
            }
        }
        try {
            photo.transferTo(f);
        } catch (Exception e) {
            model.addAttribute("errorMessage", "shop_update");
            return "error/error_page";
        }

                try

        {
            int res = shop_Service.update(vo);
            // shop_id = vo.getShop_id();
        } catch (Exception e) {
            return "error/error_page";
        }
        // return "redirect:modify_form.do?shop_id=" + shop_id;
        return "redirect:list.do";
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
