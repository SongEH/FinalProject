package first.final_project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import first.final_project.dao.CeoReviewMapper;
import first.final_project.vo.CeoReviewVo;

@Controller
@RequestMapping("/ceoReview/")
public class CeoReviewController {
    
    @Autowired
    CeoReviewMapper ceoreviewsMapper;

    @RequestMapping("insert.do")
    public String ceoReviewInsert(CeoReviewVo vo, RedirectAttributes ra){

        String ceoreviews_content = vo.getCeoreviews_content();
        ceoreviews_content.replaceAll("<br>", "\n");
        vo.setCeoreviews_content(ceoreviews_content);
        int res = ceoreviewsMapper.insert(vo);

        

        return "redirect:../reviews/listByOwner.do";
    }


    @RequestMapping("delete.do")
    public String ceoReviewDelete(int ceoreviews_id, RedirectAttributes ra){
        int res = ceoreviewsMapper.delete(ceoreviews_id);
        
        return "redirect:../reviews/listByOwner.do";
    }
}
