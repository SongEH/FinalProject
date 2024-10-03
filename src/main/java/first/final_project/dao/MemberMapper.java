package first.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.CouponVo;
import first.final_project.vo.MemberVo;

@Mapper
public interface MemberMapper {
    List<MemberVo> selectList();

    MemberVo selectOneFromIdx(int member_id); 

    MemberVo selectOneFromId(String member_accountId); 

    MemberVo selectOneFromNickname(String member_nickname); 

    int insert(MemberVo vo);

    int update(MemberVo vo);

    int delete(int member_id);

    MemberVo getAddr(int member_id);

    MemberVo getMemberWithCoupons(int member_id);

    List<CouponVo> selectOne(String string, int member_id);

}
