/*

--회원테이블
CREATE TABLE `Member` (
	`member_id`	INT	AUTO_INCREMENT PRIMARY KEY,
	`member_name`	VARCHAR(50)	NOT NULL,
	`member_nickname`	VARCHAR(50)	NOT NULL,
	`member_accountId`	VARCHAR(100)	NOT NULL,
	`member_pwd`	VARCHAR(100)	NOT NULL,
	`member_email`	VARCHAR(100)	NOT NULL,
	`member_phone`	VARCHAR(100)	NOT NULL  UNIQUE,
	`member_monthOrder`	INT	NOT NULL	DEFAULT 0	COMMENT '5,10,15',
	`member_cdate`	DATE	NOT NULL	DEFAULT (CURRENT_DATE),
	`grade_id`	INT	NOT NULL
);

ALTER TABLE `Member` ADD CONSTRAINT `FK_Grade_TO_Member` FOREIGN KEY (
	`grade_id`
)
REFERENCES `Grade` (
	`grade_id`
);

--등급 테이블

CREATE TABLE `Grade` (
	`grade_id`	INT	AUTO_INCREMENT PRIMARY KEY,
	`grade_name`	VARCHAR(50)	NOT NULL	DEFAULT 'SILVER'	COMMENT '실버,골드,다이아,마스터',
	`grade_discount`	DOUBLE	NOT NULL
);

insert into `Grade` (`grade_name`,`grade_discount`) values ('SILVER',2.0),('GOLD',5.0),('DIA',7.0),('MASTER',10.0);



--SAMPLE DATA
INSERT INTO member values(null,'홍길동','홍홍홍','hong','1234','hong@naver.com','010-1234-5678',5,CURRENT_DATE,2);

INSERT INTO member values(null,'한길동','HONGHONG','hangildong','1234','han@naver.com','010-1134-5612',10,CURRENT_DATE,3);
*/