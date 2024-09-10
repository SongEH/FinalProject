package first.final_project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.MenuVo;

@Mapper
public interface MenuMapper {

    List<MenuVo> selectList();

    List<MenuVo> selectPageList(Map<String, Object> map);

    int selectRowTotal();

    MenuVo selectOne(int menu_id);

    int insert(MenuVo vo);

    int delete(int menu_id);

    int updateFilename(MenuVo vo);

    int update(MenuVo vo);

}