package first.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.OrderVo;

@Mapper
public interface OrderMapper {

    List<OrderVo> selectList(int i);

    OrderVo selectOne(int orders_id);

    int insert(OrderVo vo);

    int delete(int orders_id);



}
