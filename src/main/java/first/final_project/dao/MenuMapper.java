package first.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.MenuVo;

@Mapper
public interface MenuMapper {

    List<MenuVo> selectList(int shop_id);

    MenuVo selectOne(int menu_id);

    int insert(MenuVo vo);

    int delete(int menu_id);

    int updateFilename(MenuVo vo);

    int update(MenuVo vo);

    // 가게 이름에 따른 메뉴 리스트 출력 -fr 태광
    List<MenuVo> selectMenuList(int shop_id);

}
