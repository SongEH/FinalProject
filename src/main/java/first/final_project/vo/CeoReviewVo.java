package first.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("ceoreview")
public class CeoReviewVo {
    
    private int ceoreviews_id;
    private String ceoreviews_content;
    private String ceoreviews_cdate;
    
    // foreign key 
    private int owner_id;
    private int reviews_id;


}
