/*

-- 일련번호관리객체
create sequence  seq_photo_idx


drop table photo

-- 테이블생성
create table photo
(
   p_idx	  int   primary key auto_increment,						-- 일련번호
   p_title    varchar(200)  not null, 	-- 제목
   p_content  varchar(2000) not null,	-- 내용
   p_filename varchar(200) not null,   -- 화일명
   p_ip       varchar(100)  not null,	-- 아이피
   p_regdate  datetime  default now(),			-- 등록일자
   mem_idx    int,						-- 회원번호
   mem_name   varchar(100)  not null	-- 회원명
)

-- 기본키
alter table photo
  add constraint pk_photo_idx primary key(p_idx) ;

-- 외래키
alter table photo
  add constraint fk_photo_mem_idx foreign key(mem_idx)
                                  references member(mem_idx)
                                  on delete cascade
                                  -- 부모삭제시-> 자식게시물도 삭제


select * from photo








*/