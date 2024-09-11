package first.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("board")
public class BoardVo {
    int board_id;
    String board_type;
    String board_title;
    String board_content;
    String board_rdate;
    int member_id;
    int owner_id;
    int admin_id;

}
