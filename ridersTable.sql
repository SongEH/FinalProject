
CREATE TABLE riders (
    raiders_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    rider_name VARCHAR(50) NOT NULL,
    riders_phone VARCHAR(100) NOT NULL,
    riders_email VARCHAR(100) NOT NULL,
    riders_pwd VARCHAR(100) NOT NULL,
    riders_region VARCHAR(100) NULL
);

CREATE TABLE member (
    member_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    member_name VARCHAR(50) NOT NULL,
    member_nickname VARCHAR(50) NOT NULL,
    member_accountId VARCHAR(100) NOT NULL,
    member_pwd VARCHAR(100) NOT NULL,
    member_email VARCHAR(100) NOT NULL,
    member_phone VARCHAR(100) NOT NULL UNIQUE,
    member_monthOrder INT NOT NULL DEFAULT 0,
    member_cdate DATE NOT NULL,
    member_grade VARCHAR(50) NOT NULL DEFAULT 'SILVER'
);

CREATE TABLE owner (
    owner_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    owner_name VARCHAR(50) NOT NULL,
    owner_accountId VARCHAR(100) NOT NULL,
    owner_pwd VARCHAR(100) NOT NULL,
    owner_email VARCHAR(100) NOT NULL,
    owner_phone VARCHAR(100) NOT NULL UNIQUE,
    owner_license VARCHAR(100) NOT NULL,
    owner_registration VARCHAR(100) NOT NULL,
    owner_bankbook VARCHAR(100) NOT NULL,
    owner_cdate DATE NOT NULL DEFAULT (CURRENT_DATE)
);

CREATE TABLE addr (
    addr_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    addr_zipcode CHAR(5) NOT NULL,
    addr_line1 VARCHAR(100) NOT NULL,
    addr_line2 VARCHAR(100) NULL,
    addr_name VARCHAR(20) NOT NULL DEFAULT 'HOUSE' COMMENT '집, 회사, 직접입력',
    member_id INT NOT NULL,
    CONSTRAINT Addr_member_id FOREIGN KEY (member_id) REFERENCES Member(member_id) ON DELETE CASCADE
);

CREATE TABLE shop (
    shop_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    shop_name VARCHAR(90) NOT NULL,
    shop_img VARCHAR(255) NULL,
    shop_addr VARCHAR(255) NOT NULL,
    food_category VARCHAR(30) NOT NULL,
    shop_call VARCHAR(20) NOT NULL,
    shop_content VARCHAR(255) NULL,
    shop_min_price INT NOT NULL DEFAULT 0,
    shop_delivery_time VARCHAR(30) NOT NULL,
    shop_rate DECIMAL(2,1) NOT NULL DEFAULT 0,
    shop_stemp_count INT NOT NULL DEFAULT 0,
    shop_review_count INT NOT NULL DEFAULT 0,
    shop_open_time VARCHAR(30) NOT NULL,
    shop_close_day DATE NULL,
    shop_area VARCHAR(255) NOT NULL,
    shop_cdate DATE NOT NULL DEFAULT (CURRENT_DATE),
    shop_mdate DATE NOT NULL DEFAULT (CURRENT_DATE),
    shop_status VARCHAR(30) NOT NULL DEFAULT 'Before Sales',
    owner_id INT NOT NULL,
    CONSTRAINT Shop_owner_id FOREIGN KEY (owner_id) REFERENCES Owner(owner_id) ON DELETE CASCADE
);

CREATE TABLE orders (
    orders_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    orders_payment VARCHAR(30) NOT NULL DEFAULT 'Easy Payment' COMMENT '간편결제(카카오페이, 토스페이)',
    orders_price INT NOT NULL,
    orders_srequest VARCHAR(255),
    orders_drequest VARCHAR(255),
    orders_cdate DATE NOT NULL DEFAULT (CURRENT_DATE),
    orders_status VARCHAR(20) NOT NULL DEFAULT 'Processing Order' COMMENT '주문확인중,주문접수,조리시작',
    shop_id INT NOT NULL,
    addr_id INT NOT NULL,
    CONSTRAINT Orders_shop_id FOREIGN KEY (shop_id) REFERENCES Shop(shop_id) ON DELETE CASCADE,
    CONSTRAINT Orders_addr_id FOREIGN KEY (addr_id) REFERENCES Addr(addr_id) ON DELETE CASCADE
);
ALTER TABLE orders ADD delivery_time INT;

CREATE TABLE deliveries (
    deliveries_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    raiders_id INT NOT NULL,
    deliveries_method VARCHAR(50) NOT NULL,
    orders_id INT NOT NULL,
    CONSTRAINT Deliveries_raiders_id FOREIGN KEY (raiders_id) REFERENCES Riders(raiders_id) ON DELETE CASCADE,
    CONSTRAINT Deliveries_orders_id FOREIGN KEY (orders_id) REFERENCES Orders(orders_id) ON DELETE CASCADE
);

CREATE TABLE delivery_history (
    delivery_history_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    delivery_history_status VARCHAR(20) NOT NULL,
    deliveries_id INT NOT NULL,
    CONSTRAINT Delivery_history_deliveries_id FOREIGN KEY (deliveries_id) REFERENCES Deliveries(deliveries_id) ON DELETE CASCADE
);

CREATE TABLE Commissions (
    commissions_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,  -- 기본 키
    raiders_id INT NOT NULL,  -- Riders 테이블의 외래 키
    deliveries_id INT,  -- 배달 ID (추가된 컬럼)
    commission DOUBLE NOT NULL,  -- 커미션 금액
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- 생성 시간 (기본값: 현재 시간)
    CONSTRAINT fk_raiders_commissions FOREIGN KEY (raiders_id) REFERENCES Riders(raiders_id) ON DELETE CASCADE,  -- 외래 키 제약 조건
    CONSTRAINT unique_commission UNIQUE (raiders_id, deliveries_id)  -- raiders_id와 deliveries_id의 조합에 대한 중복 방지 제약 조건
);
-- Main으로 넘어오면서 추가 해야하는 테이블

CREATE TABLE `menu` (
	`menu_id`	        INT	        NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`menu_category`	    VARCHAR(30)	NOT NULL,
	`menu_name`	        VARCHAR(50)	NOT NULL,
	`menu_content`	    VARCHAR(255),
	`menu_price`	    INT	        NOT NULL,
	`menu_img`	        VARCHAR(255),
	`menu_popularity`	INT	        NOT NULL	DEFAULT 0,
	`menu_hidden`	    INT	        NOT NULL	DEFAULT 0,
	`menu_soldout`	    INT	        NOT NULL	DEFAULT 0,
	`menu_cdate`	    DATE	    NOT NULL	DEFAULT (CURRENT_DATE),
	`menu_mdate`	    DATE	    NOT NULL	DEFAULT (CURRENT_DATE),
	`menu_status`	    INT	        NOT NULL	DEFAULT 1,
	`shop_id`	        INT	        NOT NULL,
    CONSTRAINT menu_shop_id FOREIGN KEY (shop_id) REFERENCES shop(shop_id) ON DELETE CASCADE
);

CREATE TABLE `carts` (
	`carts_id`	        INT	    NOT NULL    AUTO_INCREMENT PRIMARY KEY,
	`carts_quantity`	INT	    NOT NULL	DEFAULT 1,
	`member_id`	        INT	    NOT NULL,
	`shop_id`	        INT	    NOT NULL,
	`orders_id`	        INT	    NOT NULL,
	`menu_id`	        INT	    NOT NULL,
	`carts_cdate`	    DATE	NOT NULL	DEFAULT (CURRENT_DATE),
    CONSTRAINT carts_member_id FOREIGN KEY (member_id) REFERENCES member(member_id) ON DELETE CASCADE,
    CONSTRAINT carts_shop_id FOREIGN KEY (shop_id) REFERENCES shop(shop_id) ON DELETE CASCADE,
    CONSTRAINT carts_orders_id FOREIGN KEY (orders_id) REFERENCES orders(orders_id) ON DELETE CASCADE,
    CONSTRAINT carts_menu_id FOREIGN KEY (menu_id) REFERENCES menu(menu_id) ON DELETE CASCADE
);

CREATE TABLE `reviews` (
	`reviews_id`	    INT	            NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`reviews_rating`	INT	            NOT NULL,
	`reviews_content`	VARCHAR(255)	NOT NULL,
	`reviews_img`	    VARCHAR(255),
	`reviews_cdate`	    DATE	        NOT NULL DEFAULT (CURRENT_DATE),
	`member_id`	        INT	            NOT NULL,
	`menu_id`	        INT	            NOT NULL,
	`shop_id`	        INT	            NOT NULL,
    CONSTRAINT reviews_member_id FOREIGN KEY (member_id) REFERENCES member(member_id) ON DELETE CASCADE,
    CONSTRAINT reviews_menu_id FOREIGN KEY (menu_id) REFERENCES menu(menu_id) ON DELETE CASCADE,
    CONSTRAINT reviews_shop_id FOREIGN KEY (shop_id) REFERENCES shop(shop_id) ON DELETE CASCADE
);

CREATE TABLE `ceoReview` (
	`ceoreviews_id`	INT	NOT NULL primary key auto_increment,
	`ceoreviews_content`	VARCHAR(255)	NOT NULL,
	`ceoreviews_cdate`	DATE	NOT NULL	DEFAULT (CURRENT_DATE),
	`shop_id`	INT	NOT NULL,
	`owner_id`	INT	NOT NULL,
	`reviews_id2`	INT	NOT NULL,
	`menu_id`	INT	NOT NULL,
    CONSTRAINT ceoreviews_shop_id FOREIGN KEY (shop_id) REFERENCES shop(shop_id) ON DELETE CASCADE,
    CONSTRAINT ceoreviews_owner_id FOREIGN KEY (owner_id) REFERENCES owner(owner_id) ON DELETE CASCADE,
    CONSTRAINT ceoreviews_reviews_id2 FOREIGN KEY (reviews_id2) REFERENCES reviews(reviews_id) ON DELETE CASCADE,
    CONSTRAINT ceoreviews_menu_id FOREIGN KEY (menu_id) REFERENCES menu(menu_id) ON DELETE CASCADE
);

CREATE TABLE `admin` (
	`admin_id`	INT	NOT NULL primary key auto_increment,
	`admin_accountId`	VARCHAR(50)	NOT NULL,
	`admin_pwd`	VARCHAR(50)	NOT NULL
);

-- 더 추가할 테이블이 있지만 테이블 삭제해야하는 경우로 나중에 추가


-- Riders 테이블 더미 데이터
INSERT INTO riders (rider_name, riders_phone, riders_email, riders_pwd, riders_region)
VALUES 
('사장님나뻐요', '010-1234-5678', 'SJN@naver.com', '1234', '서울'),
('외노자', '010-2345-6789', 'WNJ@naver.com', '1324', '서울');

-- Member 테이블 더미 데이터
INSERT INTO member (member_name, member_nickname, member_accountId, member_pwd, member_email, member_phone, member_cdate)
VALUES 
('천사고객', '악마', 'devil', '1234', 'dev@naver.com', '010-3456-7890', CURRENT_DATE),
('일반고객', '일반', 'normal', '1234', 'nomal@naver.com', '010-4567-8901', CURRENT_DATE);

-- Owner 테이블 더미 데이터
INSERT INTO owner (owner_name, owner_accountId, owner_pwd, owner_email, owner_phone, owner_license, owner_registration, owner_bankbook)
VALUES 
('가계오우너', 'owner', '1234', 'owner@naver.com', '010-5678-9012', 'LIC123', 'REG123', 'BANK123'),
('사좡님', 'sajang', '1234', 'sajang@naver.com', '010-6789-0123', 'LIC456', 'REG456', 'BANK456');

-- Addr 테이블 더미 데이터
INSERT INTO addr (addr_zipcode, addr_line1, addr_line2, addr_name, member_id)
VALUES 
('12345', '서울시 구로구 구일로4길 65', '101동 101호', '마이홈', 1),
('54321', '서울특별시 관악구 청룡동 862-1', NULL, '안경점', 2);

-- Shop 테이블 더미 데이터
INSERT INTO shop (shop_name, shop_img, shop_addr, food_category, shop_call, shop_content, shop_min_price, shop_delivery_time, shop_rate, shop_stemp_count, shop_review_count, shop_open_time, shop_close_day, shop_area, owner_id)
VALUES 
('피자천국', NULL, '서울특별시 관악구 남부순환로 1862', '피자', '02-123-4567', '최고의 피자', 15000, '30 mins', 4.5, 10, 100, '10:00 AM', null, '서울', 1),
('버거월드', NULL, '서울특별시 관악구 남부순환로 1796', '햄버거', '051-987-6543', '마약넣은 햄버거', 8000, '20 mins', 4.2, 5, 50, '11:00 AM', null, '서울', 2);

-- Orders 테이블 더미 데이터
INSERT INTO orders (orders_payment, orders_price, orders_srequest, orders_drequest, orders_cdate, orders_status, shop_id, addr_id) VALUES
('카카오페이', 20000, '노피클', '집앞에두세요', '2024-08-27', '배차 대기', 1, 1),
('토스페이', 12000, '치즈폭탄추가', '링링링링마벨', '2024-08-27', '배차 대기', 2, 2);

-- Delivery_history 테이블 더미 데이터
INSERT INTO delivery_history (delivery_history_status, deliveries_id) VALUES
('배차 대기', 1),
('배차 대기', 2);

-- 관리자 아이디 생성(로컬)
INSERT INTO admin (admin_accountId, admin_pwd) VALUES
('admin', 'admin');
