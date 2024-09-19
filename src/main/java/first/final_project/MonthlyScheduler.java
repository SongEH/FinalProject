package first.final_project;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import first.final_project.service.MemberService;

@Component
public class MonthlyScheduler {

    @Autowired
    private MemberService member_service;

    // 매월 1일 자정에 실행
    @Scheduled(cron = "0 0 0 1 * ?")
    @Transactional
    public void resetMonthlyOrderCountsAndUpdateGrades() {
        member_service.resetMonthlyData();  //주문 건수 초기화
       
    }
}
