--회원의 등급과 해당 등급의 할인 금액을 저장합니다.
CREATE TABLE grade (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,  -- 등급 ID
    grade_name VARCHAR(50) NOT NULL,          -- 등급명 (실버, 골드, 다이아, 마스터)
    grade_discount INT NOT NULL               -- 해당 등급의 할인 금액 (3000, 5000, 7000, 10000)
);

-- member 테이블 (회원 정보) 회원의 기본 정보와 등급을 저장하는 테이블입니다.
CREATE TABLE member (
    member_id INT AUTO_INCREMENT PRIMARY KEY,    -- 회원 ID
    member_name VARCHAR(100) NOT NULL,           -- 회원 이름
    member_nickname VARCHAR(100),                -- 회원 닉네임
    member_accountId VARCHAR(100) NOT NULL,      -- 회원 계정 ID
    member_pwd VARCHAR(255) NOT NULL,            -- 비밀번호
    member_email VARCHAR(100),                   -- 이메일
    member_phone VARCHAR(20),                    -- 전화번호
    member_monthOrder INT,                       -- 월별 주문 수
    member_cdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 가입 일자
    grade_id INT,                                -- 회원 등급 ID (외래키)
    FOREIGN KEY (grade_id) REFERENCES grade(grade_id)
);

-- coupon 테이블 (쿠폰 정보) 회원에게 발행된 쿠폰 정보를 저장하는 테이블입니다.
CREATE TABLE coupon (
    coupon_id INT AUTO_INCREMENT PRIMARY KEY,    -- 쿠폰 ID
    member_id INT,                               -- 회원 ID (외래키)
    coupon_code VARCHAR(20) NOT NULL,            -- 쿠폰 코드
    discount_amount INT NOT NULL,                -- 할인 금액
    issued_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 발행 일자
    used_date TIMESTAMP,                         -- 사용 일자 (NULL이면 미사용 상태)
    FOREIGN KEY (member_id) REFERENCES member(member_id)
);
