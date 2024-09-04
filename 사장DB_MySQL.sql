/*
CREATE TABLE `Owner` (
	`owner_id`	INT	AUTO_INCREMENT PRIMARY KEY,
	`owner_name`	VARCHAR(50)	NOT NULL,
	`owner_accountId`	VARCHAR(100)	NOT NULL,
	`owner_pwd`	VARCHAR(100)	NOT NULL,
	`owner_email` VARCHAR(100)	NOT NULL,
	`owner_phone`	VARCHAR(100)	NOT NULL UNIQUE,
	`owner_license`	VARCHAR(100)	NOT NULL,
	`owner_registration` DATE NOT NULL	DEFAULT (CURRENT_DATE),
	`owner_bankbook`	VARCHAR(100)	NOT NULL,
	`owner_rdate`	DATE NOT NULL	DEFAULT (CURRENT_DATE),
    `approval_status` VARCHAR(50) NOT NULL DEFAULT 'PENDING' COMMENT 'PENDING,APPROVED,REJECTED'
);

insert into owner values(null,'김사장','kimowner','1234','kim@naver.com','010-1212-3333','305-72-00673',CURRENT_DATE,'320-1342-1368-67',CURRENT_DATE,'APPROVED');
insert into owner values(null,'나사장','sktkwkd','1234','sktkwkd@naver.com','010-1212-1212','356-62-00846',CURRENT_DATE,'385-1182-7753-75',CURRENT_DATE,'APPROVED');
*/