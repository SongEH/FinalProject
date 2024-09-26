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
	`member_cdate`	DATE	NOT NULL	DEFAULT (CURRENT_DATE)
);







--SAMPLE DATA
INSERT INTO member values(null,'홍길동','홍홍홍','hong','1234','hong@naver.com','010-1234-5678',5,CURRENT_DATE,2);

INSERT INTO member values(null,'한길동','HONGHONG','hangildong','1234','han@naver.com','010-1134-5612',10,CURRENT_DATE,3);

INSERT INTO member (member_name, member_nickname, member_accountId, member_pwd, member_email, member_phone, member_cdate)
VALUES('김철수', '철수123', 'chulsoo123', 'password123!', 'chulsoo@example.com', '010-1234-5888', CURRENT_DATE);

INSERT INTO member (member_name, member_nickname, member_accountId, member_pwd, member_email, member_phone, member_cdate)
VALUES('이영희', '영희456', 'younghee456', 'password456!', 'younghee@example.com', '010-2345-6789', CURRENT_DATE);

INSERT INTO member (member_name, member_nickname, member_accountId, member_pwd, member_email, member_phone, member_cdate)
VALUES('박민준', '민준789', 'minjoon789', 'password789!', 'minjoon@example.com', '010-3456-7890', CURRENT_DATE);

INSERT INTO member (member_name, member_nickname, member_accountId, member_pwd, member_email, member_phone, member_cdate)
VALUES('최수지', '수지001', 'suzy001', 'password001!', 'suzy@example.com', '010-4567-8901', CURRENT_DATE);

INSERT INTO member (member_name, member_nickname, member_accountId, member_pwd, member_email, member_phone, member_cdate)
VALUES('정다은', '다은002', 'daeun002', 'password002!', 'daeun@example.com', '010-5678-9012', CURRENT_DATE);
*/