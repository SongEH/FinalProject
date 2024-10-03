package first.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.AdminVo;
import first.final_project.vo.MemberVo;
import first.final_project.vo.OwnerVo;

@Mapper
public interface AdminMapper {
    List<AdminVo> selectList(); 

    AdminVo selectOneFromIdx(int admin_id);

    AdminVo selectOneFromId(String admin_accountId);

    List<MemberVo> member_selectList(); 
    List<OwnerVo> owner_selectList(); 

    MemberVo selectOneMemberIdx(int member_id); 

    OwnerVo selectOneOwnerIdx(int owner_id); 

    int update(MemberVo vo);

    int update(OwnerVo vo);

    int delete(MemberVo vo);

    int delete(OwnerVo vo);
}