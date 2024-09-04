package first.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.OwnerVo;

@Mapper
public interface OwnerMapper {

    List<OwnerVo> selectList();

    List<OwnerVo> selectPendingRequests();

    OwnerVo selectOneFromIdx(int owner_id);

    OwnerVo selectOneFromId(String owner_accountId);

    int insert(OwnerVo vo);

    int update(OwnerVo vo);

    int update_status(OwnerVo owner);

    int delete(int owner_id);

}
