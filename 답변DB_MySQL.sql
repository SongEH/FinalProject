/*
create table answer(
	answer_id int auto_increment primary key,
	answer_content varchar(100) not null,
	answer_rdate date not null default (current_date),
	board_id int not null,
	admin_id int not null
);

alter table answer add constraint fk_board_to_answer foreign key(board_id) references board(board_id);

alter table answer add constraint fk_admin_to_answer foreign key(admin_id) references admin(admin_id);

insert into answer values(null,'서비스 점검에 의해 오류가 발생한거 같습니다.환불 문의는 전화를 주시면 바로 조치를 취하도록 하겠습니다.',current_date,2,1);

select * from answer;

drop table answer;
*/