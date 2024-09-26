package first.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("member_inquiries")
public class MemberInquiriesVo {
    
    private int m_inquiries_id;
    private String m_inquiries_title;
    private String m_inquiries_content;
    private String m_inquiries_cdate;
    private String m_inquiries_type;
    private int member_id;
    private String memberAccountId;
}
