package com.githrd.demo_photo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.demo_photo.vo.PhotoVo;

@Mapper
public interface PhotoMapper {

    List<PhotoVo> selectList();

    List<PhotoVo> selectPageList(Map<String,Object> map);

    int           selectRowTotal();

    PhotoVo       selectOne(int p_idx);

    int           insert(PhotoVo vo);

    int           delete(int p_idx);

    int           updateFilename(PhotoVo vo);

    int           update(PhotoVo vo);

}
