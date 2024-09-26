/*
-- owner_answer 
create table owner_answer(
            o_answer_id int auto_increment primary key,
            o_answer_content text not null,
            o_answer_cdate date default(current_date),
            admin_id int not null,
            o_inquiries_id int not null
);


alter table owner_answer add constraint 
fk_admin_to_owner_answer foreign key(admin_id) references owner(admin_id);

alter table owner_answer add constraint 
fk_owner_inquiries_to_owner_answer foreign key(o_inquiries_id) references owner(o_inquiries_id);

-- insert 더미데이터



*/