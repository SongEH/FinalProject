/*
create table inquiries(
            inquiries_id int auto_increment primary key,
            inquiries_title varchar(255) not null,
            inquiries_content text not null,
            inquiries_pwd varchar(50) not null,
            inquiries_cdate date not null default (current_date),
            inquiries_type varchar(50) not null default'전체' comment'전체,결제문의,주문문의,서비스이용,배송문의',
            member_id int null,
            owner_id int null
);

alter table inquiries add constraint ck_inquiries_type 
check(inquiries_type in('전체','결제문의','주문문의','서비스이용','배송문의'));

alter table inquiries add constraint fk_member_to_inquiries foreign key(member_id) references member(member_id);

alter table inquiries add constraint fk_owner_to_inquiries foreign key(owner_id) references owner(owner_id);

-- insert 더미데이터(member)
INSERT INTO inquiries (inquiries_title, inquiries_content, inquiries_pwd, inquiries_cdate, inquiries_type, member_id, owner_id)
VALUES ('배송 지연 문의', '주문한 상품이 아직 도착하지 않았습니다. 배송 상태를 확인해 주세요.', 'password1', CURRENT_DATE, '배송문의', 1, NULL);

INSERT INTO inquiries (inquiries_title, inquiries_content, inquiries_pwd, inquiries_cdate, inquiries_type, member_id, owner_id)
VALUES ('주문 취소 요청', '주문 번호 12345의 취소를 요청합니다.', 'password2', CURRENT_DATE, '주문문의', 1, NULL);

INSERT INTO inquiries (inquiries_title, inquiries_content, inquiries_pwd, inquiries_cdate, inquiries_type, member_id, owner_id)
VALUES ('제품 사용법 문의', '구입한 제품의 사용법에 대해 문의드립니다.', 'password3', CURRENT_DATE, '전체', 2, NULL);

INSERT INTO inquiries (inquiries_title, inquiries_content, inquiries_pwd, inquiries_cdate, inquiries_type, member_id, owner_id)
VALUES ('상품 교환 요청', '주문한 상품이 마음에 들지 않아 교환하고 싶습니다.', 'password4', CURRENT_DATE, '주문문의', 2, NULL);

INSERT INTO inquiries (inquiries_title, inquiries_content, inquiries_pwd, inquiries_cdate, inquiries_type, member_id, owner_id)
VALUES ('할인 이벤트 문의', '할인 이벤트에 대해 알고 싶습니다.', 'password5', CURRENT_DATE, '전체', 1, NULL);

-- 사장이 작성한 문의사항
INSERT INTO inquiries (inquiries_title, inquiries_content, inquiries_pwd, inquiries_cdate, inquiries_type, member_id, owner_id)
VALUES ('결제 오류 발생', '결제 과정에서 오류가 발생했습니다. 확인 부탁드립니다.', 'password6', CURRENT_DATE, '결제문의', NULL, 2);

INSERT INTO inquiries (inquiries_title, inquiries_content, inquiries_pwd, inquiries_cdate, inquiries_type, member_id, owner_id)
VALUES ('서비스 이용 관련 질문', '서비스 이용 중 문제가 발생했습니다. 도움 요청합니다.', 'password7', CURRENT_DATE, '서비스이용', NULL, 3);

INSERT INTO inquiries (inquiries_title, inquiries_content, inquiries_pwd, inquiries_cdate, inquiries_type, member_id, owner_id)
VALUES ('신규 서비스 제안', '새로운 서비스에 대한 제안을 드리고 싶습니다.', 'password8', CURRENT_DATE, '서비스이용', NULL, 1);

INSERT INTO inquiries (inquiries_title, inquiries_content, inquiries_pwd, inquiries_cdate, inquiries_type, member_id, owner_id)
VALUES ('환불 요청', '주문 번호 54321에 대한 환불 요청합니다.', 'password9', CURRENT_DATE, '결제문의', NULL, 2);


INSERT INTO inquiries (inquiries_title, inquiries_content, inquiries_pwd, inquiries_cdate, inquiries_type, member_id, owner_id)
VALUES ('기타 문의사항', '기타 문의사항이 있습니다. 빠른 답변 부탁드립니다.', 'password10', CURRENT_DATE, '전체', NULL, 3);


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