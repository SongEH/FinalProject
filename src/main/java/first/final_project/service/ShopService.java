package first.final_project.service;

import first.final_project.vo.ShopVo;
import java.util.List;
import java.util.Map;

public interface ShopService {

    // 가게 추가하기
    int insert(ShopVo vo);

    // 가게 전체 리스트 출력
    // List<ShopVo> selectList();

    // 가게 카테고리별 출력
    List<ShopVo> selectList(String food_category);

    // 가게 1개 상세보기
    ShopVo selectOne(int shop_id);

    // 가게 정보 수정하기
    ShopVo select_modify_owner_id(int owner_id);

    // 가게 정보 수정 업데이트
    int update(ShopVo vo);

    // 가게 삭제하기
    int delete(int shop_id);

    // Owner_id로 shop_id 찾아오기 
    int select_one_shop_id(int owner_id);

    // 메뉴 개수와 리뷰 갯수 구하기 
    Map<String, Integer> selectMenuAndReviewsCount(int shop_id);

}
