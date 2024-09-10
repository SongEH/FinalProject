package first.final_project.vo;

import org.apache.ibatis.type.Alias;

@Alias("completedceliveryvo")
public class CompletedDeliveryVo {
    private int orders_id;
    private double orders_price;
    private double commission;

    // Getters and Setters
    public int getOrders_id() {
        return orders_id;
    }

    public void setOrders_id(int orders_id) {
        this.orders_id = orders_id;
    }

    public double getOrders_price() {
        return orders_price;
    }

    public void setOrders_price(double orders_price) {
        this.orders_price = orders_price;
    }

    public double getCommission() {
        return commission;
    }

    public void setCommission(double commission) {
        this.commission = commission;
    }
}
