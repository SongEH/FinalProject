package first.final_project.vo;

import java.io.Serializable;
import java.util.Date;

public class CartsVo implements Serializable {
    private static final long serialVersionUID = 1L;

    private int cartsId;
    private int cartsQuantity;
    private int memberId;
    private int shopId;
    private int ordersId;
    private int menuId;
    private Date cartsCdate;

    // Default constructor
    public CartsVo() {}

    // Parameterized constructor
    public CartsVo(int cartsId, int cartsQuantity, int memberId, int shopId, int ordersId, int menuId, Date cartsCdate) {
        this.cartsId = cartsId;
        this.cartsQuantity = cartsQuantity;
        this.memberId = memberId;
        this.shopId = shopId;
        this.ordersId = ordersId;
        this.menuId = menuId;
        this.cartsCdate = cartsCdate;
    }

    // Getters and Setters
    public int getCartsId() {
        return cartsId;
    }

    public void setCartsId(int cartsId) {
        this.cartsId = cartsId;
    }

    public int getCartsQuantity() {
        return cartsQuantity;
    }

    public void setCartsQuantity(int cartsQuantity) {
        this.cartsQuantity = cartsQuantity;
    }

    public int getMemberId() {
        return memberId;
    }

    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }

    public int getShopId() {
        return shopId;
    }

    public void setShopId(int shopId) {
        this.shopId = shopId;
    }

    public int getOrdersId() {
        return ordersId;
    }

    public void setOrdersId(int ordersId) {
        this.ordersId = ordersId;
    }

    public int getMenuId() {
        return menuId;
    }

    public void setMenuId(int menuId) {
        this.menuId = menuId;
    }

    public Date getCartsCdate() {
        return cartsCdate;
    }

    public void setCartsCdate(Date cartsCdate) {
        this.cartsCdate = cartsCdate;
    }

    @Override
    public String toString() {
        return "Carts{" +
                "cartsId=" + cartsId +
                ", cartsQuantity=" + cartsQuantity +
                ", memberId=" + memberId +
                ", shopId=" + shopId +
                ", ordersId=" + ordersId +
                ", menuId=" + menuId +
                ", cartsCdate=" + cartsCdate +
                '}';
    }
}
