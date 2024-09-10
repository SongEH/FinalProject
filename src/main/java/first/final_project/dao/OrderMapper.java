package first.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.OrderVo;

@Mapper
public interface OrderMapper {

    List<OrderVo> selectList();

    OrderVo selectOne(int carts_id);

    int insert(OrderVo vo);

    int delete(int carts_id);

    // 회원의 모든 주문을 조회
    List<OrderVo> selectOrderById(int member_id);
}
