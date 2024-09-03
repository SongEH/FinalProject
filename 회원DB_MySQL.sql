/*



-- 회원테이블
create table riders
(
   riders_id  	int primary key auto_increment,	-- 회원번호
   riders_name  	varchar(50) not null,			    -- 회원명
   riders_email   varchar(100) not null,          -- 이메일(로그인시 사용할 아이디)
   riders_pwd   	varchar(100) not null,			    -- 비밀번호
   riders_phone   varchar(100) not null,          -- 전화번호
   riders_region  varchar(100)                    -- 배달희망지역
)

-- 아이디(unique)
alter table member
  add constraint unique_riders_email unique(riders_email) ;

-- 회원등급(check)
alter table member
  add constraint ck_member_grade  check(mem_grade in('일반','관리자')) ;

-- sample data
insert into member values(null,
                          '김관리',
                          'test@naver.com',
                          'test1111',
                          '010-1111-1111',
                          '서울,경기,인천',
                          ) ;
                          


-- JDBC에서 사용할 insert문
insert into member values(null,?,?,?,?,?)


select * from member where mem_id='one1'

*/