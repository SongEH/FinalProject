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

INSERT INTO owner_answer (o_answer_content, admin_id, o_inquiries_id)
VALUES ('문의하신 사항에 대해 자세히 설명드리자면, 해당 문제는 시스템 설정과 관련이 있을 가능성이 높습니다. 따라서 설정을 다시 확인하신 후, 문제가 지속될 경우 고객센터에 다시 문의해주시면 감사하겠습니다.', 1, 1);

INSERT INTO owner_answer (o_answer_content, admin_id, o_inquiries_id)
VALUES ('안녕하세요. 문의하신 내용을 검토한 결과, 제공된 정보가 충분하지 않아 추가적인 정보가 필요합니다. 더 구체적인 상황 설명이나 관련 자료를 제공해주시면 더욱 빠르게 문제를 해결할 수 있을 것입니다.', 1, 2);

INSERT INTO owner_answer (o_answer_content, admin_id, o_inquiries_id)
VALUES ('문의 주신 사항에 대해 내부적으로 검토를 완료하였습니다. 현재 시스템 개선이 진행 중이며, 곧 새로운 업데이트를 통해 문제를 해결할 수 있을 것으로 보입니다. 업데이트가 적용되면 다시 안내드리겠습니다.', 1, 3);

INSERT INTO owner_answer (o_answer_content, admin_id, o_inquiries_id)
VALUES ('답변이 늦어져 죄송합니다. 해당 문제는 예상보다 복잡한 구조로 인해 시간이 소요되고 있습니다. 현재 관련 부서에서 집중적으로 문제를 해결하고 있으며, 곧 해결 방안을 안내드리겠습니다.', 1, 5);

INSERT INTO owner_answer (o_answer_content, admin_id, o_inquiries_id)
VALUES ('문의하신 기능 추가 요청에 대해 검토한 결과, 현재 시스템 구조상 바로 적용하기 어려운 부분이 있습니다. 하지만 추후 업데이트에 반영될 수 있도록 내부 논의를 진행 중입니다. 지속적인 관심 감사합니다.', 1, 4);

*/