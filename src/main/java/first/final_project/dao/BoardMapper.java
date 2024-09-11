package first.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import first.final_project.vo.BoardVo;

@Mapper
public interface BoardMapper {
    
    List<BoardVo> selectList(); //전체 게시물 조회

    BoardVo selectOneFromIdx(int board_id); //특정 board_id를 가진 게시물 조회

    int insert(BoardVo vo);     //게시물 등록

    int update(BoardVo vo);     //게시물 수정

    int delete(int board_id);      //게시물 삭제

    String selectBoardType(int board_id);   //특정 board_id의 게시물 타입 조회
}
