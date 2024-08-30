/*

--회원테이블
CREATE TABLE `Member` (
	`member_id`	INT	AUTO_INCREMENT PRIMARY KEY,
	`member_name`	VARCHAR(50)	NOT NULL,
	`member_nickname`	VARCHAR(50)	NOT NULL,
	`member_accountId`	VARCHAR(100)	NOT NULL,
	`member_pwd`	VARCHAR(100)	NOT NULL,
	`member_email`	VARCHAR(100)	NOT NULL,
	`member_phone`	VARCHAR(100)	NOT NULL UNIQUE,
	`member_monthOrder`	INT	NOT NULL	DEFAULT 0	COMMENT '5,10,15',
	`member_cdate`	DATE NOT NULL	DEFAULT (CURRENT_DATE),
	`member_grade`	VARCHAR(50)	NOT NULL	DEFAULT 'SILVER'	COMMENT '실버,골드,다이아,마스터'
);

-- sample data
INSERT INTO member values(null,'홍길동','홍홍홍','hong','1234','hong@naver.com','010-1234-5678',5,CURRENT_DATE,'실버');


                      
select * from member 

*/