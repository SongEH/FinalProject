package first.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.AddrVo;

@Mapper
public interface AddrMapper {

    List<AddrVo> selectList(Integer member_id);

    AddrVo selectOneFromIdx(int addr_id); 

    int insert(AddrVo vo);

    int update(AddrVo vo);

    int delete(int addr_id);

    int insertNewAddr(AddrVo vo);
}
