package first.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("notice")
public class NoticeVo {

    private int notice_id;
    private String notice_title;
    private String notice_content;
    private String notice_cdate;
    private String notice_type;
    private int admin_id;
    private String adminAccountId;
}
