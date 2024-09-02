drop table shop drop table menu

CREATE TABLE `shop` (
    `shop_id` int not null primary key auto_increment,
    `shop_name` varchar(90) NOT NULL,
    `shop_img` varchar(255) NULL,
    `shop_addr` varchar(255) NOT NULL,
    `food_category` varchar(30) NOT NULL,
    `shop_call` varchar(20) NOT NULL,
    `shop_content` varchar(255) NULL,
    `shop_min_price` int NULL DEFAULT 0,
    `shop_rate` decimal(2, 1) NOT NULL DEFAULT 0,
    `shop_stemp_count` int NOT NULL DEFAULT 0,
    `shop_review_count` int NOT NULL DEFAULT 0,
    `shop_open_time` varchar(30) NOT NULL,
    `shop_close_time` varchar(30) NOT NULL,
    `shop_close_day` varchar(30) NOT NULL,
    `shop_area` varchar(255) NOT NULL,
    `shop_cdate` date NOT NULL default(current_date),
    `shop_mdate` date NULL default(current_date),
    `shop_status` varchar(30) NOT NULL default '오픈전',
);

`owner_id` INT NOT NULL,
Foreign Key (owner_id) REFERENCES owner (owner_id)

CREATE TABLE `Menu` (
    `menu_id` INT NOT NULL AUTO_INCREMENT,
    `menu_category` VARCHAR(30) NOT NULL,
    `menu_name` VARCHAR(50) NOT NULL,
    `menu_content` VARCHAR(255),
    `menu_price` INT NOT NULL,
    `menu_img` VARCHAR(255),
    `menu_popularity` INT NOT NULL DEFAULT 0 COMMENT '일반, 인기',
    `menu_cdate` DATE NOT NULL DEFAULT(CURRENT_DATE),
    `menu_status` INT NOT NULL DEFAULT 1 COMMENT '활성화, 비활성화',
    `menu_hidden` INT NOT NULL DEFAULT 0 COMMENT '숨김, 표시',
    `menu_soldout` INT NOT NULL DEFAULT 0 COMMENT '품절, 판매중',
    `shop_id` INT NOT NULL,
    PRIMARY KEY (`menu_id`)
);

CREATE TABLE `Orders` (
    `orders_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `orders_payment` VARCHAR(30) NOT NULL DEFAULT Easy Payment COMMENT '간편결제(카카오페이,토스페이)',
    `orders_price` INT NOT NULL,
    `orders_srequest` VARCHAR(255) NULL,
    `orders_drequest` VARCHAR(255) NULL,
    `orders_cdate` DATE NOT NULL DEFAULT CURRENT_DATE,
    `orders_status` VARCHAR(20) NOT NULL DEFAULT Processing Order COMMENT '주문확인중,주문접수,조리시작,조리완료,배송픽업,배송완료',
    `shop_id` INT NOT NULL,
    `addr_id` INT NOT NULL
);