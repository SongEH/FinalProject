package first.final_project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import first.final_project.dao.ShopMapper;
import first.final_project.vo.ShopVo;

@Service
public class ShopServiceImpl implements ShopService {

    @Autowired
    ShopMapper shopMapper;

    // 가게 추가하기
    @Override
    public int insert(ShopVo vo) {

        return shopMapper.insert(vo);
    }

    // 가게 전체 리스트
    // @Override
    // public List<ShopVo> selectList() {
    // return shopMapper.selectList();
    // }

    // 가게 카테고리별 출력
    @Override
    public List<ShopVo> selectList(String food_category) {
        return shopMapper.selectList(food_category);
    }

    // 가게 1개 상세보기
    @Override
    public ShopVo selectOne(int shop_id) {
        return shopMapper.selectOne(shop_id);
    }

    // 가게 1개 정보 가져와서 수정하기
    
    @Override
    public ShopVo select_modify_owner_id(int owner_id) {
        return shopMapper.select_modify_owner_id(owner_id);
    }

    // 가게 업데이트
    @Override
    public int update(ShopVo vo) {
        return shopMapper.update(vo);
    }

    // 가게 삭제하기
    @Override
    public int delete(int shop_id) {
        return shopMapper.delete(shop_id);
    }

   
}
