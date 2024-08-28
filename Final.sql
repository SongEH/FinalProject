CREATE TABLE `배달 히스토리` (
	`delivery_history_id`	INT	NOT NULL,
	`delivery_history_status`	VARCHAR(20)	NOT NULL,
	`deliveries_id`	INT	NOT NULL
);

CREATE TABLE `배달` (
	`deliveries_id`	INT	NOT NULL,
	`raiders_id`	INT	NOT NULL
);

CREATE TABLE `배달기사` (
	`raiders_id`	INT	NOT NULL,
	`rider_name`	VARCHAR(50)	NOT NULL,
	`riders_phone`	VARCHAR(100)	NOT NULL
);

CREATE TABLE `Member` (
	`member_idx`	INT	NOT NULL,
	`member_name`	VARCHAR(50)	NOT NULL,
	`member_nickname`	VARCHAR(50)	NOT NULL,
	`member_id`	VARCHAR(100)	NOT NULL,
	`member_pwd`	VARCHAR(100)	NOT NULL,
	`member_phone`	VARCHAR(100)	NOT NULL,
	`member_zipcode`	VARCHAR(20)	NOT NULL,
	`member_addr`	VARCHAR(100)	NOT NULL,
	`member_rdate`	TIMESTAMP	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`member_type`	VARCHAR(50)	NOT NULL	COMMENT '일반,관리자'
);

CREATE TABLE `Menu` (
	`menu_id`	INT	NOT NULL,
	`shop_id`	int	NOT NULL,
	`menu_category`	VARCHAR(30)	NOT NULL,
	`menu_name`	VARCHAR(50)	NOT NULL,
	`menu_price`	INT	NOT NULL,
	`menu_img`	VARCHAR(255)	NULL,
	`menu_popularity`	INT	NOT NULL	DEFAULT 0	COMMENT '일반, 인기',
	`menu_cdate`	TIMESTAMP	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`menu_status`	INT	NOT NULL	DEFAULT 1	COMMENT '활성화,비활성화'
);

CREATE TABLE `가게` (
	`shop_id`	int	NOT NULL,
	`shop_name`	varchar(90)	NOT NULL,
	`shop_img`	varchar(255)	NULL,
	`shop_addr`	varchar(255)	NOT NULL,
	`food_category`	varchar(30)	NOT NULL,
	`shop_call`	varchar(20)	NOT NULL,
	`shop_content`	varchar(255)	NULL,
	`shop_min_price`	int	NULL	DEFAULT 0,
	`shop_delivery_tip`	int	NOT NULL	DEFAULT 0,
	`shop_delivery_time`	int	NOT NULL,
	`shop_rate`	decimal(2,1)	NOT NULL	DEFAULT 0,
	`shop_stemp_count`	int	NOT NULL	DEFAULT 0,
	`shop_review_count`	int	NOT NULL	DEFAULT 0,
	`shop_open_time`	varchar(30)	NOT NULL,
	`shop_close_time`	varchar(30)	NOT NULL,
	`shop_close_day`	date	NOT NULL,
	`shop_area`	varchar(255)	NOT NULL,
	`shop_create_day`	date	NOT NULL,
	`shop_modify_day`	date	NULL,
	`shop_status`	varchar(30)	NOT NULL
);

CREATE TABLE `Orders` (
	`orders_orderId`	INT	NOT NULL,
	`shop_id`	INT	NOT NULL,
	`member_idx`	INT	NOT NULL,
	`orders_paymentMethod`	VARCHAR(30)	NOT NULL,
	`orders_price`	INT	NOT NULL,
	`orders_srequest`	VARCHAR(255)	NULL,
	`orders_drequest`	VARCHAR(255)	NULL,
	`orders_createdDate`	TIMESTAMP	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`orders_status`	VARCHAR(20)	NOT NULL	DEFAULT '주문확인중'	COMMENT ''주문확인중',주문'접수','조리시작','조리완료','배송픽업','배송완료''
);

CREATE TABLE `Owner` (
	`owner_idx`	INT	NOT NULL,
	`owner_name`	VARCHAR(50)	NOT NULL,
	`owner_id`	VARCHAR(100)	NOT NULL,
	`owner_pwd`	VARCHAR(100)	NOT NULL,
	`owner_phone`	VARCHAR(100)	NOT NULL,
	`owner_license`	VARCHAR(100)	NOT NULL,
	`owner_registration`	VARCHAR(100)	NOT NULL,
	`owner_bankbook`	VARCHAR(100)	NOT NULL,
	`owner_rdate`	TIMESTAMP	NOT NULL	DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE `배달 히스토리` ADD CONSTRAINT `PK_배달 히스토리` PRIMARY KEY (
	`delivery_history_id`
);

ALTER TABLE `배달` ADD CONSTRAINT `PK_배달` PRIMARY KEY (
	`deliveries_id`
);

ALTER TABLE `배달기사` ADD CONSTRAINT `PK_배달기사` PRIMARY KEY (
	`raiders_id`
);

ALTER TABLE `Member` ADD CONSTRAINT `PK_MEMBER` PRIMARY KEY (
	`member_idx`
);

ALTER TABLE `Menu` ADD CONSTRAINT `PK_MENU` PRIMARY KEY (
	`menu_id`,
	`shop_id`
);

ALTER TABLE `가게` ADD CONSTRAINT `PK_가게` PRIMARY KEY (
	`shop_id`
);

ALTER TABLE `Orders` ADD CONSTRAINT `PK_ORDERS` PRIMARY KEY (
	`orders_orderId`,
	`shop_id`,
	`member_idx`
);

ALTER TABLE `Owner` ADD CONSTRAINT `PK_OWNER` PRIMARY KEY (
	`owner_idx`
);

ALTER TABLE `Menu` ADD CONSTRAINT `FK_가게_TO_Menu_1` FOREIGN KEY (
	`shop_id`
)
REFERENCES `가게` (
	`shop_id`
);

ALTER TABLE `Orders` ADD CONSTRAINT `FK_가게_TO_Orders_1` FOREIGN KEY (
	`shop_id`
)
REFERENCES `가게` (
	`shop_id`
);

ALTER TABLE `Orders` ADD CONSTRAINT `FK_Member_TO_Orders_1` FOREIGN KEY (
	`member_idx`
)
REFERENCES `Member` (
	`member_idx`
);

