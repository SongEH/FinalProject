package first.final_project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import first.final_project.dao.GradeMapper;
import first.final_project.dao.MemberMapper;
import first.final_project.vo.GradeVo;
import first.final_project.vo.MemberVo;

@Service
public class MemberService{

    @Autowired
    MemberMapper member_mapper;

    @Autowired
    GradeMapper grade_mapper;

    // 회원의 주문 수를 증가시키고 등급을 업데이트 한다??
    public MemberVo updateMemberOrder(int member_id) {

        // 회원의 현재 정보를 가져온다
        MemberVo member = member_mapper.selectOneFromIdx(member_id);
        if (member == null) {
            throw new RuntimeException("회원 정보를 찾을 수 없습니다");
        }

        // 주문 수를 증가시키고 업데이트한다
        int newOrderCount = member.getMember_monthOrder() + 1;
        member_mapper.updateOrderCount(member_id, newOrderCount);

        // 새로운 등급을 결정한다
        GradeVo grade = determineGrade(newOrderCount);
        member.setGrade_id(grade.getGrade_id());
        member_mapper.update(member);

        return member;
    }

    private GradeVo determineGrade(int orderCount) {
        if (orderCount >= 15) {
            return grade_mapper.selectOne("MASTER");
        } else if (orderCount >= 10) {
            return grade_mapper.selectOne("DIA");
        } else if (orderCount >= 5) {
            return grade_mapper.selectOne("GOLD");
        } else {
            return grade_mapper.selectOne("SILVER");
        }
    }

    
    @Transactional
    public void resetMonthlyData() {
        // 모든 회원의 주문 건수를 초기화
        member_mapper.resetOrderCounts();

        // 모든 회원의 등급을 SILVER로 초기화
        GradeVo silverGrade = grade_mapper.selectOne("SILVER");
        member_mapper.resetGrades(silverGrade.getGrade_id());
    }

}
