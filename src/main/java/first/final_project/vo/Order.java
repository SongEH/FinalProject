package first.final_project.vo;

import lombok.Data;

@Data
public class Order {

    private String id;

    private String merchantUid;
    private int amount;
    private String status;
}
