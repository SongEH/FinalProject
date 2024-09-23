/*

select * from notice;

drop table notice;

create table notice(
	notice_id int auto_increment primary key,
    notice_title varchar(50) not null,
    notice_content text not null,
    notice_cdate date not null default(current_date),
    notice_type varchar(50) not null default'전체' comment '전체,서비스안내,점검안내,약관안내',
    admin_id int not null
);

alter table notice add constraint 
fk_admin_to_notice foreign key(admin_id) references admin(admin_id);

alter table notice add constraint ck_notice_type 
check(notice_type in('전체','서비스안내','점검안내','약관안내'));


--insert 더미데이터

INSERT INTO notice (notice_title, notice_content, notice_cdate, notice_type, admin_id)
VALUES ('서비스 점검 안내', '서비스 점검이 2024년 10월 1일에 예정되어 있습니다.', '2024-09-05', '점검안내', 1);

INSERT INTO notice (notice_title, notice_content, notice_cdate, notice_type, admin_id)
VALUES ('이용 약관 업데이트', '이용 약관이 2024년 10월 1일자로 업데이트됩니다.', '2024-09-01', '약관안내', 1);

INSERT INTO notice (notice_title, notice_content, notice_cdate, notice_type, admin_id)
VALUES ('서비스 이용 안내', '새로운 서비스가 추가되었습니다. 자세한 내용은 웹사이트를 참조해 주세요.', '2024-09-10', '서비스안내', 1);

INSERT INTO notice (notice_title, notice_content, notice_cdate, notice_type, admin_id)
VALUES ('전체 공지사항', '전체 공지사항입니다. 모든 사용자에게 공지됩니다.', '2024-09-01', '전체', 1);


*/