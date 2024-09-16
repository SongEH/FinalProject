/*
--문의사항 DB
create table inquiries(
            inquiries_id int auto_increment primary key,
            inquiries_title varchar(255) not null,
            inquiries_content varchar(255) not null,
            inquiries_pwd varchar(50) not null,
            inquiries_cdate date not null default (current_date),
            member_id int null,
            owner_id int null
            );

alter table inquiries add constraint fk_member_to_inquiries foriegn key(member_id) references member(member_id);

alter table inquiries add constraint fk_owner_to_inquiries foriegn key(owner_id) references owner(owner_id);

*/