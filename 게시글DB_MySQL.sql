/*
create table `board` (
	`board_id` int auto_increment primary key,
	`board_type` varchar(50) not null,
	`board_title` varchar(50) not null,
	`board_content` varchar(100) not null,
	`board_rdate` date not null default (current_date),
	`member_id` int null,
	`owner_id` int null,
	`admin_id` int null
);

alter table `board` add constraint `ck_board_type` check ((`board_type`='notice' and `member_id` is null and `owner_id` is null and `admin_id` is not null) 
or (`board_type`='support' and `member_id` is not null and `owner_id` is null and `admin_id` is null) 
or (`board_type`='support' and `member_id` is null and `owner_id` is not null and `admin_id` is null));

alter table `board` add constraint `fk_member_to_board` foreign key(`member_id`) references `member` (`member_id`);

alter table `board` add constraint `fk_owner_to_board` foreign key(`owner_id`) references `owner` (`owner_id`);

alter table `board` add constraint `fk_admin_to_board` foreign key(`admin_id`) references `admin` (`admin_id`);

insert into `board` (`board_type`,`board_title`,`board_content`,`board_rdate`,`admin_id`) 
values('notice','서비스 점검 안내','서비스 점검 안내드립니다.서비스 점검이 예정되어 있습니다. 점검 시간 동안 서비스 이용이 제한될 수 있습니다.', current_date,1);

insert into `board` (`board_type`,`board_title`,`board_content`,`board_rdate`,`member_id`) 
values('support','결제 문의','결제 과정에서 오류가 발생했습니다. 확인 부탁드립니다.', current_date,1);

select * from board;

SHOW ERRORS;

drop table board;



*/