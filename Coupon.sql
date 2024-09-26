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

*/