create database finalproject;

use finalproject;

-- -------------------------------- 테이블 생성
CREATE TABLE `Menu` (
    `menu_id` INT NOT NULL AUTO_INCREMENT,
    `menu_name` VARCHAR(50) NOT NULL,
    `menu_content` VARCHAR(255),
    `menu_price` INT NOT NULL,
    `menu_img` VARCHAR(255),
    `menu_popularity` INT NOT NULL DEFAULT 0 COMMENT '일반, 인기',
    `menu_cdate` DATE NOT NULL DEFAULT (CURRENT_DATE),
    `menu_status` INT NOT NULL DEFAULT 1 COMMENT '활성화, 비활성화',
    `menu_hidden` INT NOT NULL DEFAULT 0 COMMENT '숨김, 표시',
    `menu_soldout` INT NOT NULL DEFAULT 0 COMMENT '품절, 판매중',
    `shop_id` INT NOT NULL,
    PRIMARY KEY (`menu_id`)
);

CREATE TABLE `Orders` (
	`orders_id`	INT	NOT NULL primary key auto_increment,
	`orders_payment`	VARCHAR(30)	NOT NULL	COMMENT '간편결제(카카오페이,토스페이)',
	`orders_method`	VARCHAR(30)	NOT NULL	DEFAULT "card",
	`orders_imp_uid`	VARCHAR(30)	NOT NULL,
	`orders_merchant_uid`	VARCHAR(20)	NOT NULL,
	`orders_name`	VARCHAR(50)	NOT NULL,
	`orders_price`	INT	NOT NULL,
	`orders_srequest`	VARCHAR(255)	NULL,
	`orders_drequest`	VARCHAR(255)	NULL,
	`orders_cdate`	DATE	NOT NULL	DEFAULT (CURRENT_DATE),
	`orders_status` VARCHAR(20) NOT NULL DEFAULT 'Order Confirmed' COMMENT 'Order Confirmed, 
		Order Received, 
		Cooking Started, 
		Cooking Finished, 
		Delivery Picked Up, 
		Delivery Delivered',
	`shop_id`	INT	NOT NULL,
	`addr_id`	INT	NOT NULL,
	`member_id`	INT	NOT NULL
);

CREATE TABLE `Carts` (
    `carts_id` INT NOT NULL AUTO_INCREMENT,
    `carts_quantity` INT NOT NULL DEFAULT 1,
    `member_id` INT NOT NULL,
    `shop_id` INT NOT NULL,
    `orders_id` INT NULL,
    `menu_id` INT NOT NULL,
    `carts_cdate` DATE NOT NULL DEFAULT (CURRENT_DATE),
    PRIMARY KEY (`carts_id`)
);


-- -------------------------------- 조회
SELECT * FROM MENU;
SELECT * FROM Carts;

-- -------------------------------- 
Drop table MENU;
Drop table Carts;


delete from menu;
delete from carts;



-- 외래키 설정

-- Menu 테이블에 외래 키 추가
ALTER TABLE `Menu`
ADD CONSTRAINT `fk_menu_shop`
    FOREIGN KEY (`shop_id`) REFERENCES `shop`(`shop_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- Carts 테이블에 외래 키 추가
ALTER TABLE `Carts`
ADD CONSTRAINT `fk_carts_shop`
    FOREIGN KEY (`shop_id`) REFERENCES `shop`(`shop_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Carts`
ADD CONSTRAINT `fk_carts_menu`
    FOREIGN KEY (`menu_id`) REFERENCES `Menu`(`menu_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Carts`
ADD CONSTRAINT `fk_carts_orders`
    FOREIGN KEY (`orders_id`) REFERENCES `Orders`(`orders_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Carts`
ADD CONSTRAINT `fk_carts_member`
    FOREIGN KEY (`member_id`) REFERENCES `Member`(`member_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- Orders 테이블에 외래 키 추가 
ALTER TABLE `Orders`
ADD CONSTRAINT `fk_orders_shop`
    FOREIGN KEY (`shop_id`) REFERENCES `shop`(`shop_id`) ON DELETE CASCADE ON UPDATE CASCADE;



-- --------------------------------------------------------
