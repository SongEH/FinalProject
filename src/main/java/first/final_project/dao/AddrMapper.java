package first.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.AddrVo;

@Mapper
public interface AddrMapper {

    List<AddrVo> selectList(Integer member_id);

    AddrVo selectOneFromIdx(int addr_id); // 주소 일련번호 조회

    int insert(AddrVo vo);

    int update(AddrVo vo);

    int delete(int addr_id);
}
