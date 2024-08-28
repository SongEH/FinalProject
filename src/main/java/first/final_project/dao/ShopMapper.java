package first.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.ShopVo;

@Mapper
public interface ShopMapper {

    // 가게 추가하기
    int insert(ShopVo vo);

    // 가게 전체 출력
    List<ShopVo> selectList();

    // 가게 상세보기
    ShopVo selectOne(int shop_id);

    // 가게 정보 수정하기
    ShopVo select_modify_shop_id(int shop_id);

    // 가게 삭제 하기
    int delete(int shop_id);
}
