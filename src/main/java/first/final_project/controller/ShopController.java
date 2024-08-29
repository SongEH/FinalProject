package first.final_project.controller;

import java.io.File;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import first.final_project.service.ShopService;
import first.final_project.vo.ShopVo;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ShopController {

    @Autowired
    ShopService shop_Service;

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
        @SuppressWarnings("unused")
        int res = shop_Service.insert(vo);

        ra.addAttribute("vo", vo);

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
        ShopVo vo;
        try {
            vo = shop_Service.selectOne(shop_id);
        } catch (Exception e) {

            model.addAttribute("errorMessage", "fail_select_one");

            return "error/error_page";
        }

        model.addAttribute("vo", vo);

        return "shop/shop_listOne";
    }

    // 가게 정보수정
    @RequestMapping("/shop/modify.do")
    public String shop_modify(int shop_id, Model model) {

        ShopVo vo;
        try {
            vo = shop_Service.select_modify_shop_id(shop_id);
        } catch (Exception e) {
            model.addAttribute("errorMessage", "fail_select_one");

            return "error/error_page";
        }

        model.addAttribute("vo", vo);

        return "shop/shop_modify_form";
    }

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
