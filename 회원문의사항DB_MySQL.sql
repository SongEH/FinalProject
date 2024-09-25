/*
-- member_inquiries 
create table member_inquiries(
            m_inquiries_id int auto_increment primary key,
            m_inquiries_title varchar(50) not null,
            m_inquiries_content text not null,
            m_inquiries_cdate date not null default (current_date),
            m_inquiries_type varchar(50) not null default'전체' comment'전체,결제문의,주문문의,서비스이용,배송문의',
            member_id int not null
);

alter table member_inquiries add constraint ck_m_inquiries_type 
check(m_inquiries_type in('전체','결제문의','주문문의','서비스이용','배송문의'));

alter table member_inquiries add constraint 
fk_member_to_member_inquiries foreign key(member_id) references member(member_id);

--insert 더미데이터
INSERT INTO member_inquiries (m_inquiries_title, m_inquiries_content, m_inquiries_cdate, m_inquiries_type, member_id)
VALUES ('배송 관련 문의', '배송이 언제 도착할 예정인가요?', CURRENT_DATE, '배송문의', 1);

INSERT INTO member_inquiries (m_inquiries_title, m_inquiries_content, m_inquiries_cdate, m_inquiries_type, member_id)
VALUES ('결제 오류 문의', '결제 과정에서 오류가 발생했습니다. 어떻게 해결할 수 있나요?', CURRENT_DATE, '결제문의', 2);

INSERT INTO member_inquiries (m_inquiries_title, m_inquiries_content, m_inquiries_cdate, m_inquiries_type, member_id)
VALUES ('서비스 이용 방법', '서비스 이용에 대해 더 알고 싶습니다.', CURRENT_DATE, '서비스이용', 8);

INSERT INTO member_inquiries (m_inquiries_title, m_inquiries_content, m_inquiries_cdate, m_inquiries_type, member_id)
VALUES ('주문 상태 확인 요청', '주문한 상품이 아직 배송되지 않았습니다. 확인 부탁드립니다.', CURRENT_DATE, '주문문의', 9);

INSERT INTO member_inquiries (m_inquiries_title, m_inquiries_content, m_inquiries_cdate, m_inquiries_type, member_id)
VALUES ('기타 문의', '기타 사항에 대해 문의드립니다.', CURRENT_DATE, '전체', 12);

INSERT INTO member_inquiries (m_inquiries_title, m_inquiries_content, m_inquiries_cdate, m_inquiries_type, member_id)
VALUES ('배송지 변경 요청', '주문 후 배송지를 변경하고 싶은데 어떻게 해야 하나요?', CURRENT_DATE, '배송문의', 1);

INSERT INTO member_inquiries (m_inquiries_title, m_inquiries_content, m_inquiries_cdate, m_inquiries_type, member_id)
VALUES ('결제 완료 후 환불 요청', '결제 후 환불을 요청하고 싶습니다.', CURRENT_DATE, '결제문의', 2);

INSERT INTO member_inquiries (m_inquiries_title, m_inquiries_content, m_inquiries_cdate, m_inquiries_type, member_id)
VALUES ('서비스 이용 불만', '서비스가 기대에 미치지 못했습니다.', CURRENT_DATE, '서비스이용', 10);

INSERT INTO member_inquiries (m_inquiries_title, m_inquiries_content, m_inquiries_cdate, m_inquiries_type, member_id)
VALUES ('주문 취소 요청', '주문한 상품을 취소하고 싶습니다.', CURRENT_DATE, '주문문의', 11);

INSERT INTO member_inquiries (m_inquiries_title, m_inquiries_content, m_inquiries_cdate, m_inquiries_type, member_id)
VALUES ('일반 문의', '기타 일반적인 사항에 대한 문의입니다.', CURRENT_DATE, '전체', 8);

*/