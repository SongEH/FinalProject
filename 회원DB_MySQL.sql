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
	`member_grade`	VARCHAR(50)	NOT NULL	DEFAULT 'SILVER'	COMMENT 'SILVER,GOLD,DIA,MASTER'
);

-- sample data
INSERT INTO member values(null,'홍길동','홍홍홍','hong','1234','hong@naver.com','010-1234-5678',5,CURRENT_DATE,'SILVER');
INSERT INTO member values(null,'한길동','HONGHONG','hangildong','1234','han@naver.com','010-1134-5612',10,CURRENT_DATE,'GOLD');
              
select * from member 

*/