CREATE TABLE `delivery_history` (
	`delivery_history_id`	INT	NOT NULL primary key auto_increment,
	`delivery_history_status`	VARCHAR(20)	NOT NULL	DEFAULT 'Before_Delivery'	COMMENT '배송전,배송중,배송완료',
	`deliveries_id`	INT	NOT NULL
);

CREATE TABLE `deliveries` (
	`deliveries_id`	INT	NOT NULL primary key auto_increment,
	`raiders_id`	INT	NOT NULL,
	`deliveries_method`	VARCHAR(50)	NOT NULL COMMENT '도보,자전거,자동차 (경로확인용)',
	`orders_id`	INT	NOT NULL
);

CREATE TABLE `riders` (
	`raiders_id`	INT	NOT NULL primary key auto_increment,
	`rider_name`	VARCHAR(50)	NOT NULL,
	`riders_phone`	VARCHAR(100)	NOT NULL,
	`riders_email`	varchar(100)	NOT NULL	COMMENT '로그인 시 사용할 이메일',
	`riders_pwd`	varchar(100)	NOT NULL,
	`riders_region`	varchar(100)	NULL
);

CREATE TABLE `member` (
	`member_id`	INT	NOT NULL primary key auto_increment,
	`member_name`	VARCHAR(50)	NOT NULL,
	`member_nickname`	VARCHAR(50)	NOT NULL,
	`member_accountId`	VARCHAR(100)	NOT NULL,
	`member_pwd`	VARCHAR(100)	NOT NULL,
	`member_email`	VARCHAR(100)	NOT NULL,
	`member_phone`	VARCHAR(100)	NOT NULL	UNIQUE,
	`member_monthOrder`	INT	NOT NULL	DEFAULT 0	COMMENT '5,10,15',
	`member_cdate`	DATE	NOT NULL	DEFAULT (CURRENT_DATE),
	`grade_id`	INT	NOT NULL
);

CREATE TABLE `menu` (
	`menu_id`	INT	NOT NULL primary key auto_increment,
	`menu_category`	VARCHAR(30)	NOT NULL,
	`menu_name`	VARCHAR(50)	NOT NULL,
	`menu_content`	VARCHAR(255)	NULL,
	`menu_price`	INT	NOT NULL,
	`menu_img`	VARCHAR(255)	NULL,
	`menu_popularity`	INT	NOT NULL	DEFAULT 0	COMMENT '일반, 인기',
	`menu_hidden`	INT	NOT NULL	DEFAULT 0	COMMENT '숨김,표시',
	`menu_soldout`	INT	NOT NULL	DEFAULT 0	COMMENT '품절,판매중',
	`menu_cdate`	DATE	NOT NULL	DEFAULT (CURRENT_DATE),
	`menu_mdate`	DATE	NOT NULL	DEFAULT (CURRENT_DATE),
	`menu_status`	INT	NOT NULL	DEFAULT 1	COMMENT '활성화,비활성화',
	`shop_id`	INT	NOT NULL
);

CREATE TABLE `shop` (
	`shop_id`	INT	NOT NULL primary key auto_increment,
	`shop_name`	VARCHAR(90)	NOT NULL,
	`shop_img`	VARCHAR(255)	NOT NULL,
	`shop_addr`	VARCHAR(255)	NOT NULL,
	`food_category`	VARCHAR(30)	NOT NULL,
	`shop_call`	VARCHAR(20)	NOT NULL,
	`shop_content`	VARCHAR(255)	NULL,
	`shop_min_price`	INT	NULL	DEFAULT 0,
	`shop_rate`	DECIMAL(2,1)	NOT NULL	DEFAULT 0,
	`shop_stemp_count`	INT	NOT NULL	DEFAULT 0,
	`shop_review_count`	INT	NOT NULL	DEFAULT 0,
	`shop_hours`	VARCHAR(30)	NOT NULL,
	`shop_close_day`	VARCHAR(20)	NOT NULL,
	`shop_area`	VARCHAR(255)	NOT NULL,
	`shop_cdate`	DATE	NOT NULL	DEFAULT (CURRENT_DATE),
	`shop_mdate`	DATE	NULL	DEFAULT (CURRENT_DATE),
	`shop_status`	VARCHAR(30)	NOT NULL	DEFAULT '영업전'	COMMENT '영업전,영업중,휴무',
	`owner_id`	INT	NOT NULL
);

CREATE TABLE `owner` (
	`owner_id`	INT	NOT NULL primary key auto_increment,
	`owner_name`	VARCHAR(50)	NOT NULL,
	`owner_accountId`	VARCHAR(100)	NOT NULL,
	`owner_pwd`	VARCHAR(100)	NOT NULL,
	`owner_email`	VARCHAR(100)	NOT NULL,
	`owner_phone`	VARCHAR(100)	NOT NULL	UNIQUE,
	`owner_license`	VARCHAR(100)	NOT NULL,
	`owner_registration`	DATE	NOT NULL	DEFAULT (CURRENT_DATE),
	`owner_bankbook`	VARCHAR(100)	NOT NULL,
	`owner_cdate`	DATE	NOT NULL	DEFAULT (CURRENT_DATE),
	`approval_status`	VARCHAR(50)	NOT NULL	DEFAULT 'PENDING'	COMMENT 'PENDING,APPROVED,REJECTED'
);

CREATE TABLE `admin` (
	`admin_id`	INT	NOT NULL primary key auto_increment,
	`admin_accountId`	VARCHAR(50)	NOT NULL,
	`admin_pwd`	VARCHAR(50)	NOT NULL
);

CREATE TABLE `orders` (
	`orders_id`	INT	NOT NULL primary key auto_increment,
	`orders_payment`	VARCHAR(30)	NOT NULL	DEFAULT 'kakaopay'	COMMENT '간편결제(카카오페이,토스페이)',
	`orders_method`	VARCHAR(30)	NOT NULL	DEFAULT "card",
	`orders_imp_uid`	VARCHAR(30)	NOT NULL,
	`orders_merchant_uid`	VARCHAR(20)	NOT NULL,
	`orders_name`	VARCHAR(50)	NOT NULL,
	`orders_price`	INT	NOT NULL,
	`orders_srequest`	VARCHAR(255)	NULL,
	`orders_drequest`	VARCHAR(255)	NULL,
	`orders_cdate`	DATE	NOT NULL	DEFAULT (CURRENT_DATE),
	`orders_status`	VARCHAR(20)	NOT NULL	DEFAULT 'Processing_Order'	COMMENT '주문확인중,주문접수,조리시작,조리완료,배송픽업,배송완료',
	`shop_id`	INT	NOT NULL,
	`addr_id`	INT	NOT NULL,
	`member_id`	INT	NOT NULL,
	`orders_addr`	VARCHAR(255)	NULL
);

CREATE TABLE `addr` (
	`addr_id`	INT	NOT NULL primary key auto_increment,
	`addr_zipcode`	CHAR(5)	NOT NULL,
	`addr_line1`	VARCHAR(100)	NOT NULL,
	`addr_line2`	VARCHAR(100)	NOT NULL,
	`addr_name`	VARCHAR(20)	NOT NULL	DEFAULT 'HOUSE'	COMMENT '집, 회사, 직접입력',
	`member_id`	INT	NOT NULL
);

CREATE TABLE `carts` (
	`carts_id`	INT	NOT NULL primary key auto_increment,
	`carts_quantity`	INT	NOT NULL	DEFAULT 1,
	`member_id`	INT	NOT NULL,
	`shop_id`	INT	NOT NULL,
	`orders_id`	INT	NOT NULL,
	`menu_id`	INT	NOT NULL,
	`carts_cdate`	DATE	NOT NULL	DEFAULT (CURRENT_DATE)
);

CREATE TABLE `reviews` (
	`reviews_id`	INT	NOT NULL primary key auto_increment,
	`reviews_rating`	INT	NOT NULL,
	`reviews_content`	VARCHAR(255)	NOT NULL,
	`reviews_img`	VARCHAR(255)	NULL,
	`reviews_cdate`	DATE	NOT NULL	DEFAULT (CURRENT_DATE),
	`member_id`	INT	NOT NULL,
	`menu_id`	INT	NOT NULL,
	`shop_id`	INT	NOT NULL
);

CREATE TABLE `ceoReview` (
	`ceoreviews_id`	INT	NOT NULL primary key auto_increment,
	`ceoreviews_content`	VARCHAR(255)	NOT NULL,
	`ceoreviews_cdate`	DATE	NOT NULL	DEFAULT (CURRENT_DATE),
	`shop_id`	INT	NOT NULL,
	`owner_id`	INT	NOT NULL,
	`reviews_id2`	INT	NOT NULL,
	`menu_id`	INT	NOT NULL
);

CREATE TABLE `grade` (
	`grade_id`	INT	NOT NULL primary key auto_increment,
	`grade_name`	VARCHAR(50)	NOT NULL	DEFAULT 'SILVER'	COMMENT '실버,골드,다이아,마스터',
	`grade_discount`	DOUBLE	NOT NULL
);

CREATE TABLE `board` (
	`board_id`	INT	NOT NULL primary key auto_increment,
	`board_type`	VARCHAR(50)	NOT NULL	COMMENT '일반,공지',
	`board_title`	VARCHAR(50)	NOT NULL,
	`board_content`	VARCHAR(100)	NOT NULL,
	`board_rdate`	DATE	NOT NULL	DEFAULT (CURRENT_DATE),
	`member_id`	INT	NULL,
	`admin_id`	INT	NULL,
	`owner_id`	INT	NULL
);

CREATE TABLE `answer` (
	`answer_id`	INT	NOT NULL primary key auto_increment,
	`answer_content`	VARCHAR(100)	NOT NULL,
	`answer_rdate`	DATE	NOT NULL,
	`board_id`	INT	NOT NULL
);


-- 가게에 사장 ID 외래키 설정 
alter table shop
add constraint fk_owner_id foreign key (owner_id) 
                            references owner (owner_id) 


-- 메뉴에 가게 ID 외래키 설정 
alter table menu
add constraint fk_shop_id foreign key (shop_id) 
                            references shop (shop_id) on delete casacade