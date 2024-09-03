/*



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
alter table riders
  add constraint unique_riders_email unique(riders_email);
  
 INSERT INTO riders (riders_name, riders_email, riders_pwd, riders_phone, riders_region) VALUES
('test', 'test@naver.com', 'test1234', '010-1234-5678', '서울')


select * from riders


*/