package first.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("owner_inquiries")
public class OwnerInquiriesVo {
    private int o_inquiries_id;
    private String o_inquiries_title;
    private String o_inquiries_content;
    private String o_inquiries_cdate;
    private int owner_id;
    private String owner_accountId;

    private int owner_null_answer_count;
    private String o_answer_content;
}
