
CREATE TABLE Riders (
    raiders_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    rider_name VARCHAR(50) NOT NULL,
    riders_phone VARCHAR(100) NOT NULL,
    riders_email VARCHAR(100) NOT NULL,
    riders_pwd VARCHAR(100) NOT NULL,
    riders_region VARCHAR(100) NULL
);

CREATE TABLE Member (
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

CREATE TABLE Owner (
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

CREATE TABLE Addr (
    addr_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    addr_zipcode CHAR(5) NOT NULL,
    addr_line1 VARCHAR(100) NOT NULL,
    addr_line2 VARCHAR(100) NULL,
    addr_name VARCHAR(20) NOT NULL DEFAULT 'HOUSE' COMMENT '집, 회사, 직접입력',
    member_id INT NOT NULL,
    CONSTRAINT Addr_member_id FOREIGN KEY (member_id) REFERENCES Member(member_id) ON DELETE CASCADE
);

CREATE TABLE Shop (
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

CREATE TABLE Orders (
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

CREATE TABLE Deliveries (
    deliveries_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    raiders_id INT NOT NULL,
    deliveries_method VARCHAR(50) NOT NULL,
    orders_id INT NOT NULL,
    CONSTRAINT Deliveries_raiders_id FOREIGN KEY (raiders_id) REFERENCES Riders(raiders_id) ON DELETE CASCADE,
    CONSTRAINT Deliveries_orders_id FOREIGN KEY (orders_id) REFERENCES Orders(orders_id) ON DELETE CASCADE
);

CREATE TABLE Delivery_history (
    delivery_history_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    delivery_history_status VARCHAR(20) NOT NULL,
    deliveries_id INT NOT NULL,
    CONSTRAINT Delivery_history_deliveries_id FOREIGN KEY (deliveries_id) REFERENCES Deliveries(deliveries_id) ON DELETE CASCADE
);




-- Riders 테이블 더미 데이터
INSERT INTO Riders (rider_name, riders_phone, riders_email, riders_pwd, riders_region)
VALUES 
('사장님나뻐요', '010-1234-5678', 'SJN@naver.com', '1234', '서울'),
('외노자', '010-2345-6789', 'WNJ@naver.com', '1324', '서울');

-- Member 테이블 더미 데이터
INSERT INTO Member (member_name, member_nickname, member_accountId, member_pwd, member_email, member_phone, member_cdate)
VALUES 
('천사고객', '악마', 'devil', '1234', 'dev@naver.com', '010-3456-7890', CURRENT_DATE),
('일반고객', '일반', 'normal', '1234', 'nomal@naver.com', '010-4567-8901', CURRENT_DATE);

-- Owner 테이블 더미 데이터
INSERT INTO Owner (owner_name, owner_accountId, owner_pwd, owner_email, owner_phone, owner_license, owner_registration, owner_bankbook)
VALUES 
('가계오우너', 'owner', '1234', 'owner@naver.com', '010-5678-9012', 'LIC123', 'REG123', 'BANK123'),
('사좡님', 'sajang', '1234', 'sajang@naver.com', '010-6789-0123', 'LIC456', 'REG456', 'BANK456');

-- Addr 테이블 더미 데이터
INSERT INTO Addr (addr_zipcode, addr_line1, addr_line2, addr_name, member_id)
VALUES 
('12345', '서울시 구로구 구일로4길 65', '101동 101호', '마이홈', 1),
('54321', '서울특별시 관악구 청룡동 862-1', NULL, '안경점', 2);

-- Shop 테이블 더미 데이터
INSERT INTO Shop (shop_name, shop_img, shop_addr, food_category, shop_call, shop_content, shop_min_price, shop_delivery_time, shop_rate, shop_stemp_count, shop_review_count, shop_open_time, shop_close_day, shop_area, owner_id)
VALUES 
('피자천국', NULL, '서울특별시 관악구 남부순환로 1862', '피자', '02-123-4567', '최고의 피자', 15000, '30 mins', 4.5, 10, 100, '10:00 AM', null, '서울', 1),
('버거월드', NULL, '서울특별시 관악구 남부순환로 1796', '햄버거', '051-987-6543', '마약넣은 햄버거', 8000, '20 mins', 4.2, 5, 50, '11:00 AM', null, '서울', 2);

-- Orders 테이블 더미 데이터
INSERT INTO Orders (orders_payment, orders_price, orders_srequest, orders_drequest, orders_cdate, orders_status, shop_id, addr_id) VALUES
('카카오페이', 20000, '노피클', '집앞에두세요', '2024-08-27', '배차 대기', 1, 1),
('토스페이', 12000, '치즈폭탄추가', '링링링링마벨', '2024-08-27', '배차 대기', 2, 2);


-- Deliveries 테이블 더미 데이터
INSERT INTO Deliveries (raiders_id, deliveries_method, orders_id)
VALUES 
(1, '자전거', 1),
(2, '오토바이', 2);

-- Delivery_history 테이블 더미 데이터
INSERT INTO Delivery_history (delivery_history_status, deliveries_id) VALUES
('배차 대기', 1),
('배차 대기', 2);

