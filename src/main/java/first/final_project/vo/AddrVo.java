package first.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("addr")
public class AddrVo {

    int addr_id;
    int member_id;
    String addr_zipcode;
    String addr_line1;
    String addr_line2;
    String addr_name;

<<<<<<< HEAD
}
=======
}
>>>>>>> main
