package com.githrd.demo_final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.demo_final_project.vo.MemberVo;

@Mapper
public interface MemberMapper {
    List<MemberVo> selectList();
    MemberVo selectOneFromIdx(int mem_idx);
    MemberVo selectOneFromId(String mem_id);
    int insert(MemberVo vo);
    int update(MemberVo vo);
    int delete(int mem_idx);
}
