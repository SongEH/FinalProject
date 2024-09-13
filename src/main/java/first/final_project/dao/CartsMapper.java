package first.final_project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.CartsVo;

@Mapper
public interface CartsMapper {

    List<CartsVo> selectList();

    List<CartsVo> selectPageList(Map<String, Object> map);

    int selectRowTotal();

    CartsVo selectOne(int carts_id);

    int insert(CartsVo vo);

    int delete(int carts_id);

    int update(int carts_id, int carts_quantity); // 수량만 수정

    // 메뉴id로 장바구니 검색 검색
    CartsVo findByMenuId(int member_id, int shop_id, int menu_id);

    List<CartsVo> findPendingOrders(int member_id, int shop_id);

    void updateOrderId(Map<String, Object> map);

    List<CartsVo> selectOrdersById(int orders_id);

}