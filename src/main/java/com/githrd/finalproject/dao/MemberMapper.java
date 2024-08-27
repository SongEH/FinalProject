package com.githrd.finalproject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.finalproject.vo.MemberVo;

@Mapper
public interface MemberMapper {
    List<MemberVo> selectList();

    MemberVo selectOneFromIdx(int member_id); // 회원 일련번호 조회

    MemberVo selectOneFromId(String member_accountId); // 회원 아이디 조회

    MemberVo selectOneFromNickname(String member_nickname); // 회원 닉네임 조회

    int insert(MemberVo vo);

    int update(MemberVo vo);

    int delete(int member_id);

}
