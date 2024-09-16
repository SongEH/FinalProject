/*
--문의사항 DB
create table inquiries(
            inquiries_id int auto_increment primary key,
            inquiries_title varchar(255) not null,
            inquiries_content text not null,
            inquiries_pwd varchar(50) not null,
            inquiries_cdate date not null default (current_date),
            member_id int null,
            owner_id int null
            );

alter table inquiries add constraint fk_member_to_inquiries foriegn key(member_id) references member(member_id);

alter table inquiries add constraint fk_owner_to_inquiries foriegn key(owner_id) references owner(owner_id);

--insert 더미데이터
INSERT INTO inquiries (inquiries_title, inquiries_content, inquiries_pwd, inquiries_cdate, member_id, owner_id)
VALUES
('서비스 개선 요청', '앱 속도가 너무 느립니다. 개선이 필요합니다.', 'secret123', CURRENT_DATE, 1, NULL),
('주문 누락', '최근 주문이 누락되었습니다. 확인 부탁드립니다.', 'secret456', CURRENT_DATE, 2, NULL),
('환불 요청', '구매한 상품의 환불을 요청합니다.', 'secret789', CURRENT_DATE, NULL, 1);



--문의답변 DB
create table answer(
            answer_id int auto_increment primary key,
            answer_content text not null,
            answer_cdate date not null default(current_date),
            admin_id int not null,
            inquiries_id int not null
)

alter table answer add constraint fk_admin_to_answer foriegn key(admin_id) references admin(admin_id);

alter table answer add constraint fk_inquiries_to_answer foriegn key(inquiries_id) references inquiries(inquiries_id);

--insert 더미데이터
INSERT INTO answer (answer_content, answer_cdate, admin_id, inquiries_id)
VALUES
('안녕하세요. 문의 주신 내용에 대해 확인 후, 속도 개선 작업을 진행하겠습니다. 기다려 주셔서 감사합니다.', CURRENT_DATE, 1, 1),
('주문 누락에 대해 사과드리며, 주문 확인 후 조치하겠습니다. 다시 한 번 불편을 드려 죄송합니다.', CURRENT_DATE, 1, 2),
('환불 요청은 확인 후 처리해드리겠습니다. 다시 한 번 불편을 드려 죄송합니다.', CURRENT_DATE, 1, 3);

*/