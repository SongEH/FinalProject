package com.githrd.demo_photo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.demo_photo.vo.RidersVo;

@Mapper
public interface RidersMapper {

    List<RidersVo> selectList();

    RidersVo selectOneFromId(int riders_id); // mem_idx

    RidersVo selectOneFromEmail(String riders_email); // mem_id

    int insert(RidersVo vo);

    int update(RidersVo vo);

    int delete(int riders_id);
}
