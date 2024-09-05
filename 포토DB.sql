/*

-- 테이블생성
create table photo
(
   p_idx	  int primary key auto_increment,	-- 일련번호
   p_title    varchar(200)  not null, 	-- 제목
   p_content  varchar(2000) not null,	-- 내용
   p_filename varchar(200)  not null,   -- 화일명
   p_ip       varchar(100)  not null,	-- 아이피
   p_regdate  datetime,						-- 등록일자
   mem_idx    int,						-- 회원번호
   mem_name   varchar(100)  not null	-- 회원명
)

-- 외래키
alter table photo
  add constraint fk_photo_mem_idx foreign key(mem_idx)
                                  references member(mem_idx)
                                  on delete cascade
                                  -- 부모삭제시-> 자식게시물도 삭제

======================================

-- p의 모든컬럼과, 추가적인 컬럼 (p_ip) 
-- p를 안쓰고 그냥 * 로하면 에러난다.   
select p.*, 'p_ip=' || p_ip 
	from (select * from photo) p
	

-- paging 처리를 위한 SQL

-- from 절, where 절, select 절 순서로 실행되니까 where절에서 no는 모르니까 에러난다. 
select
	rank() over(order by p_idx desc) as no,  --no라는 별명을 가진 컬럼을 만든다. rank로 순서를 부여 p_idx를 내림차순한 순서대로  
	p.* 
from 
 	(select * from photo) p 
where 
	no between 1 and 8
  
  
-- 해결 코드 
		select * from 
		( 
			select
				rank() over(order by p_idx desc) as no,  --no라는 별명을 가진 컬럼을 만든다. rank로 순서를 부여 p_idx를 내림차순한 순서대로  
				p.* 
			from 
		 		(select * from photo) p
		) 
		where 
			no between 1 and 8

-- 전체 게시물 수 구하기 
select nvl(count(*), 0) from photo 
-- null 이면 0으로 바꾼다.  









*/