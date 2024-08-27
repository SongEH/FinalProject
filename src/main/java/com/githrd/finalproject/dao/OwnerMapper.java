package com.githrd.finalproject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.finalproject.vo.OwnerVo;

@Mapper
public interface OwnerMapper {

    List<OwnerVo> selectList();

    OwnerVo selectOneFromIdx(int owner_id);

    OwnerVo selectOneFromId(String owner_accountId);

    int insert(OwnerVo vo);

    int update(OwnerVo vo);

    int delete(int owner_id);
}
