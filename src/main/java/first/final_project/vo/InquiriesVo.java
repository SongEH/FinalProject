package first.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("inquiries")
public class InquiriesVo {
    private int inquiries_id;
    private String inquiries_title;
    private String inquiries_content;
    private String inquiries_pwd;
    private String inquiries_cdate;
    private int member_id;
    private int owner_id;
}
