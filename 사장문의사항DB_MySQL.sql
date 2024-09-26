/*
-- owner_inquiries 
create table owner_inquiries(
            o_inquiries_id int auto_increment primary key,
            o_inquiries_title varchar(50) not null,
            o_inquiries_content text not null,
            o_inquiries_cdate date not null default (current_date),
            owner_id int not null
);


alter table owner_inquiries add constraint 
fk_owner_to_owner_inquiries foreign key(owner_id) references owner(owner_id);

-- insert 더미데이터

INSERT INTO owner_inquiries (o_inquiries_title, o_inquiries_content, o_inquiries_cdate, owner_id)
VALUES('기타 문의', '경영 관련 기타 문의 사항입니다.', CURRENT_DATE, 5);

INSERT INTO owner_inquiries (o_inquiries_title, o_inquiries_content, o_inquiries_cdate, owner_id)
VALUES('가게 운영 시간 문의', '가게 운영 시간 연장 관련 상담을 요청합니다.', CURRENT_DATE, 1);

INSERT INTO owner_inquiries (o_inquiries_title, o_inquiries_content, o_inquiries_cdate, owner_id)
VALUES('세금 관련 문의', '세금 신고와 관련된 문의입니다.', CURRENT_DATE, 2);

INSERT INTO owner_inquiries (o_inquiries_title, o_inquiries_content, o_inquiries_cdate, owner_id)
VALUES('서비스 개선 요청', '고객 서비스 개선 방안에 대해 논의하고 싶습니다.', CURRENT_DATE, 3);

INSERT INTO owner_inquiries (o_inquiries_title, o_inquiries_content, o_inquiries_cdate, owner_id)
VALUES('주문 시스템 오류 문의', '주문 시스템에서 발생한 오류에 대해 문의합니다.', CURRENT_DATE, 4);

INSERT INTO owner_inquiries (o_inquiries_title, o_inquiries_content, o_inquiries_cdate, owner_id)
VALUES('기타 경영 관련 문의', '기타 경영 사항에 대해 질문합니다.', CURRENT_DATE, 5);

INSERT INTO owner_inquiries (o_inquiries_title, o_inquiries_content, o_inquiries_cdate, owner_id)
VALUES('리뷰 관리 문의', '리뷰 관리를 효율적으로 할 수 있는 방법에 대해 문의합니다.', CURRENT_DATE, 1);

INSERT INTO owner_inquiries (o_inquiries_title, o_inquiries_content, o_inquiries_cdate, owner_id)
VALUES('직원 관리 방안', '직원 관리와 관련한 조언이 필요합니다.', CURRENT_DATE, 2);

INSERT INTO owner_inquiries (o_inquiries_title, o_inquiries_content, o_inquiries_cdate, owner_id)
VALUES('매출 향상 방법 문의', '매출 향상을 위한 마케팅 전략을 문의합니다.', CURRENT_DATE, 3);

INSERT INTO owner_inquiries (o_inquiries_title, o_inquiries_content, o_inquiries_cdate, owner_id)
VALUES('재고 관리 시스템 문의', '재고 관리 시스템 도입에 대한 문의입니다.', CURRENT_DATE, 4);

*/