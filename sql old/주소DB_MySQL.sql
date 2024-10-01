/*

--주소 테이블
CREATE TABLE `Addr` (
	`addr_id`	INT	AUTO_INCREMENT PRIMARY KEY,
	`member_id`	INT	NOT NULL,
	`addr_zipcode`	CHAR(5)	NOT NULL,
	`addr_line1`	VARCHAR(100)	NOT NULL,
	`addr_line2`	VARCHAR(100)	NOT NULL,
	`addr_name`	VARCHAR(20)	NOT NULL	DEFAULT 'HOUSE'	COMMENT '집, 회사, 직접입력'
);

--외래키
ALTER TABLE `Addr` ADD CONSTRAINT `FK_Member_TO_Addr` FOREIGN KEY (
	`member_id`
)
REFERENCES `Member` (
	`member_id`
);

*/