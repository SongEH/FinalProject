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

    int update(CartsVo vo);

}
