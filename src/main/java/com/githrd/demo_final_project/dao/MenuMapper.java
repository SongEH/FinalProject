package com.githrd.demo_final_project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.demo_final_project.vo.MenuVo;

@Mapper
public interface MenuMapper {

    List<MenuVo> selectList();

    List<MenuVo> selectPageList(Map<String, Object> map);

    int selectRowTotal();

    MenuVo selectOne(int p_idx);

    int insert(MenuVo vo);

    int delete(int p_idx);
    
    int updateFilename(MenuVo vo);

    int update(MenuVo vo);

}
