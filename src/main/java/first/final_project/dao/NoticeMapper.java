package first.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.NoticeVo;

@Mapper
public interface NoticeMapper {

    List<NoticeVo> selectListByType(String notice_type);

    NoticeVo selectOneFromIdx(int notice_id);

    int insert(NoticeVo vo);

    int update(NoticeVo vo);

    int delete(int notice_id);
<<<<<<< HEAD
}
=======
}
>>>>>>> main
