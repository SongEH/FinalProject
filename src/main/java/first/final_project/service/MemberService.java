package first.final_project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import first.final_project.dao.MemberMapper;
import first.final_project.vo.CouponVo;

// 쿠폰활용 TEST
@Service
public class MemberService {

    @Autowired
    private MemberMapper memberMapper;

    // Fetch member with coupons
    // public MemberVo getMemberWithCoupons(int member_id) {
    // return memberMapper.getMemberWithCoupons(member_id);
    // }

    public List<CouponVo> getMemberWithCoupons(int member_id) {
        return memberMapper.selectOne("getMemberWithCoupons", member_id); // This is wrong
    }
}
