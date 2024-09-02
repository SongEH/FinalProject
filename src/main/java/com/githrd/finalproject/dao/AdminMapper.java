package com.githrd.finalproject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.finalproject.vo.AdminVo;
import com.githrd.finalproject.vo.MemberVo;
import com.githrd.finalproject.vo.OwnerVo;

@Mapper
public interface AdminMapper {
    List<AdminVo> selectList(); // 관리자 전체 조회

    AdminVo selectOneFromIdx(int admin_id);

    AdminVo selectOneFromId(String admin_accountId);

    List<MemberVo> member_selectList(); // 회원(고객) 전체조회

    List<OwnerVo> owner_selectList(); // 사장 전체조회

    MemberVo selectOneMemberIdx(int member_id); // 회원(고객) 일련번호 조회

    OwnerVo selectOneOwnerIdx(int owner_id); // 사장 일련번호 조회

    int update(MemberVo vo);

    int update(OwnerVo vo);

    int delete(MemberVo vo);

    int delete(OwnerVo vo);
}
