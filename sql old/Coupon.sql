/*
CREATE TABLE coupon (
coupon_id INT PRIMARY KEY AUTO_INCREMENT,
coupon_code VARCHAR(50) NOT NULL UNIQUE,
discount_amount INT, 
start_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
end_date TIMESTAMP NULL, 
used_date DATETIME DEFAULT NULL, 
member_id INT, 
FOREIGN KEY (member_id) REFERENCES member(member_id) ON DELETE CASCADE
);



-- 쿠폰 만료 설정 트리거
DELIMITER $$
CREATE TRIGGER set_end_date_before_insert
BEFORE INSERT ON coupon
FOR EACH ROW BEGIN
SET NEW.end_date = DATE_ADD(NEW.start_date, INTERVAL 60 MINUTE);
END $$
DELIMITER ;

*/