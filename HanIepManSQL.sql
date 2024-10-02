CREATE TABLE `admin` (
  `admin_id` int NOT NULL AUTO_INCREMENT,
  `admin_accountId` varchar(50) NOT NULL,
  `admin_pwd` varchar(50) NOT NULL,
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `member` (
  `member_id` int NOT NULL AUTO_INCREMENT,
  `member_name` varchar(50) NOT NULL,
  `member_nickname` varchar(50) NOT NULL,
  `member_accountId` varchar(100) NOT NULL,
  `member_pwd` varchar(100) NOT NULL,
  `member_email` varchar(100) NOT NULL,
  `member_phone` varchar(100) NOT NULL,
  `member_cdate` date NOT NULL DEFAULT (curdate()),
  PRIMARY KEY (`member_id`),
  UNIQUE KEY `member_phone` (`member_phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `notice` (
  `notice_id` int NOT NULL AUTO_INCREMENT,
  `notice_title` varchar(50) NOT NULL,
  `notice_content` text NOT NULL,
  `notice_cdate` date NOT NULL DEFAULT (curdate()),
  `notice_type` varchar(50) NOT NULL DEFAULT '전체' COMMENT '전체,서비스안내,점검안내,약관안내',
  `admin_id` int NOT NULL,
  PRIMARY KEY (`notice_id`),
  KEY `fk_admin_to_notice` (`admin_id`),
  CONSTRAINT `fk_admin_to_notice` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`),
  CONSTRAINT `ck_notice_type` CHECK ((`notice_type` in (_utf8mb4'전체',_utf8mb4'서비스안내',_utf8mb4'점검안내',_utf8mb4'약관안내')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `owner` (
  `owner_id` int NOT NULL AUTO_INCREMENT,
  `owner_name` varchar(50) NOT NULL,
  `owner_accountId` varchar(100) NOT NULL,
  `owner_pwd` varchar(100) NOT NULL,
  `owner_email` varchar(100) NOT NULL,
  `owner_phone` varchar(100) NOT NULL,
  `owner_license` varchar(100) NOT NULL,
  `owner_registration` date NOT NULL DEFAULT (curdate()),
  `owner_bankbook` varchar(100) NOT NULL,
  `owner_cdate` date NOT NULL DEFAULT (curdate()),
  `approval_status` varchar(50) NOT NULL DEFAULT 'PENDING' COMMENT 'PENDING,APPROVED,REJECTED',
  PRIMARY KEY (`owner_id`),
  UNIQUE KEY `owner_phone` (`owner_phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `riders` (
  `raiders_id` int NOT NULL AUTO_INCREMENT,
  `rider_name` varchar(50) NOT NULL,
  `riders_phone` varchar(100) NOT NULL,
  `riders_email` varchar(100) NOT NULL COMMENT '로그인 시 사용할 이메일',
  `riders_pwd` varchar(100) NOT NULL,
  `riders_region` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`raiders_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `shop` (
  `shop_id` int NOT NULL AUTO_INCREMENT,
  `shop_name` varchar(90) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shop_img` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shop_addr1` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `food_category` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shop_call` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shop_content` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `shop_min_price` int DEFAULT '0',
  `shop_open_hour` time NOT NULL,
  `shop_close_hour` time NOT NULL,
  `shop_close_day` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shop_cdate` date NOT NULL DEFAULT (curdate()),
  `shop_mdate` date DEFAULT (curdate()),
  `owner_id` int NOT NULL,
  `shop_addr2` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shop_status` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`shop_id`),
  KEY `fk_owner_id` (`owner_id`),
  CONSTRAINT `fk_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `owner` (`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `reviews` (
  `reviews_id` int NOT NULL AUTO_INCREMENT,
  `reviews_rating` int NOT NULL,
  `reviews_content` varchar(255) NOT NULL,
  `reviews_cdate` date NOT NULL DEFAULT (curdate()),
  `orders_id` int NOT NULL,
  PRIMARY KEY (`reviews_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `reviews_images` (
  `reviews_images_id` int NOT NULL AUTO_INCREMENT,
  `reviews_img` varchar(255) DEFAULT NULL,
  `reviews_id` int NOT NULL,
  PRIMARY KEY (`reviews_images_id`),
  KEY `fk_reviews_images_reviews_id` (`reviews_id`),
  CONSTRAINT `fk_reviews_images_reviews_id` FOREIGN KEY (`reviews_id`) REFERENCES `reviews` (`reviews_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `owner_inquiries` (
  `o_inquiries_id` int NOT NULL AUTO_INCREMENT,
  `o_inquiries_title` varchar(50) NOT NULL,
  `o_inquiries_content` text NOT NULL,
  `o_inquiries_cdate` date NOT NULL DEFAULT (curdate()),
  `owner_id` int NOT NULL,
  PRIMARY KEY (`o_inquiries_id`),
  KEY `fk_owner_to_owner_inquiries` (`owner_id`),
  CONSTRAINT `fk_owner_to_owner_inquiries` FOREIGN KEY (`owner_id`) REFERENCES `owner` (`owner_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `owner_answer` (
  `o_answer_id` int NOT NULL AUTO_INCREMENT,
  `o_answer_content` text NOT NULL,
  `o_answer_cdate` date DEFAULT (curdate()),
  `admin_id` int NOT NULL,
  `o_inquiries_id` int NOT NULL,
  PRIMARY KEY (`o_answer_id`),
  KEY `fk_admin_to_owner_answer` (`admin_id`),
  KEY `fk_owner_inquiries_to_owner_answer` (`o_inquiries_id`),
  CONSTRAINT `fk_admin_to_owner_answer` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`),
  CONSTRAINT `fk_owner_inquiries_to_owner_answer` FOREIGN KEY (`o_inquiries_id`) REFERENCES `owner_inquiries` (`o_inquiries_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `menu` (
  `menu_id` int NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(50) NOT NULL,
  `menu_content` varchar(255) DEFAULT NULL,
  `menu_price` int NOT NULL,
  `menu_img` varchar(255) DEFAULT NULL,
  `menu_popularity` int NOT NULL DEFAULT '0' COMMENT '일반, 인기',
  `menu_hidden` int NOT NULL DEFAULT '0' COMMENT '숨김,표시',
  `menu_soldout` int NOT NULL DEFAULT '0' COMMENT '품절,판매중',
  `menu_cdate` datetime DEFAULT CURRENT_TIMESTAMP,
  `menu_mdate` datetime DEFAULT CURRENT_TIMESTAMP,
  `menu_status` int NOT NULL DEFAULT '1' COMMENT '활성화,비활성화',
  `shop_id` int NOT NULL,
  PRIMARY KEY (`menu_id`),
  KEY `fk_menu_shop_id` (`shop_id`),
  CONSTRAINT `fk_menu_shop_id` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`shop_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `member_inquiries` (
  `m_inquiries_id` int NOT NULL AUTO_INCREMENT,
  `m_inquiries_title` varchar(50) NOT NULL,
  `m_inquiries_content` text NOT NULL,
  `m_inquiries_cdate` date NOT NULL DEFAULT (curdate()),
  `m_inquiries_type` varchar(50) NOT NULL DEFAULT '전체' COMMENT '전체,결제문의,주문문의,서비스이용,배송문의',
  `member_id` int NOT NULL,
  PRIMARY KEY (`m_inquiries_id`),
  KEY `fk_member_to_member_inquiries` (`member_id`),
  CONSTRAINT `fk_member_to_member_inquiries` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE CASCADE,
  CONSTRAINT `ck_m_inquiries_type` CHECK ((`m_inquiries_type` in (_utf8mb3'전체',_utf8mb3'결제문의',_utf8mb3'주문문의',_utf8mb3'서비스이용',_utf8mb3'배송문의')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `member_answer` (
  `m_answer_id` int NOT NULL AUTO_INCREMENT,
  `m_answer_content` text NOT NULL,
  `m_answer_cdate` date DEFAULT (curdate()),
  `admin_id` int NOT NULL,
  `m_inquiries_id` int NOT NULL,
  PRIMARY KEY (`m_answer_id`),
  KEY `fk_admin_to_member_answer` (`admin_id`),
  KEY `fk_member_inquiries_to_member_answer` (`m_inquiries_id`),
  CONSTRAINT `fk_admin_to_member_answer` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`),
  CONSTRAINT `fk_member_inquiries_to_member_answer` FOREIGN KEY (`m_inquiries_id`) REFERENCES `member_inquiries` (`m_inquiries_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `coupon` (
  `coupon_id` int NOT NULL AUTO_INCREMENT,
  `coupon_code` varchar(50) NOT NULL,
  `discount_amount` int DEFAULT NULL,
  `start_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `end_date` timestamp NULL DEFAULT NULL,
  `used_date` datetime DEFAULT NULL,
  `member_id` int DEFAULT NULL,
  PRIMARY KEY (`coupon_id`),
  UNIQUE KEY `coupon_code` (`coupon_code`),
  KEY `member_id` (`member_id`),
  CONSTRAINT `coupon_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `ceoreview` (
  `ceoreviews_id` int NOT NULL AUTO_INCREMENT,
  `ceoreviews_content` varchar(255) NOT NULL,
  `ceoreviews_cdate` date NOT NULL DEFAULT (curdate()),
  `owner_id` int NOT NULL,
  `reviews_id` int NOT NULL,
  PRIMARY KEY (`ceoreviews_id`),
  KEY `fk_ceoreview_reviews_id` (`reviews_id`),
  CONSTRAINT `fk_ceoreview_reviews_id` FOREIGN KEY (`reviews_id`) REFERENCES `reviews` (`reviews_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `addr` (
  `addr_id` int NOT NULL AUTO_INCREMENT,
  `addr_zipcode` char(5) NOT NULL,
  `addr_line1` varchar(100) NOT NULL,
  `addr_line2` varchar(100) NOT NULL,
  `addr_name` varchar(20) NOT NULL DEFAULT 'HOUSE' COMMENT '집, 회사, 직접입력',
  `member_id` int NOT NULL,
  PRIMARY KEY (`addr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `orders` (
  `orders_id` int NOT NULL AUTO_INCREMENT,
  `orders_payment` varchar(30) NOT NULL COMMENT '간편결제(카카오페이,토스페이)',
  `orders_method` varchar(30) NOT NULL DEFAULT 'card',
  `orders_imp_uid` varchar(30) NOT NULL,
  `orders_merchant_uid` varchar(20) NOT NULL,
  `orders_name` varchar(50) NOT NULL,
  `orders_price` int NOT NULL,
  `orders_srequest` varchar(255) DEFAULT NULL,
  `orders_drequest` varchar(255) DEFAULT NULL,
  `orders_cdate` datetime DEFAULT CURRENT_TIMESTAMP,
  `orders_status` varchar(20) NOT NULL DEFAULT '주문 대기' COMMENT 'Order Confirmed, \n		Order Received, \n		Cooking Started, \n		Cooking Finished, \n		Delivery Picked Up, \n		Delivery Delivered',
  `shop_id` int NOT NULL,
  `addr_id` int NOT NULL,
  `member_id` int NOT NULL,
  `delivery_time` int DEFAULT NULL,
  `orders_isdelete` int NOT NULL DEFAULT '0',
  `reviews_delete` int DEFAULT NULL,
  PRIMARY KEY (`orders_id`),
  KEY `fk_orders_shop_id` (`shop_id`),
  KEY `fk_orders_addr_id` (`addr_id`),
  KEY `fk_orders_member_id` (`member_id`),
  CONSTRAINT `fk_orders_addr_id` FOREIGN KEY (`addr_id`) REFERENCES `addr` (`addr_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_orders_member_id` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_orders_shop_id` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`shop_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `deliveries` (
  `deliveries_id` int NOT NULL AUTO_INCREMENT,
  `raiders_id` int NOT NULL,
  `deliveries_method` varchar(50) NOT NULL COMMENT '도보,자전거,자동차 (경로확인용)',
  `orders_id` int NOT NULL,
  PRIMARY KEY (`deliveries_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `delivery_history` (
  `delivery_history_id` int NOT NULL AUTO_INCREMENT,
  `delivery_history_status` varchar(20) NOT NULL DEFAULT 'Before_Delivery' COMMENT '배송전,배송중,배송완료',
  `deliveries_id` int NOT NULL,
  PRIMARY KEY (`delivery_history_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `commissions` (
  `commissions_id` int NOT NULL AUTO_INCREMENT,
  `raiders_id` int NOT NULL,
  `deliveries_id` int DEFAULT NULL,
  `commission` double NOT NULL,
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`commissions_id`),
  UNIQUE KEY `unique_commission` (`raiders_id`,`deliveries_id`),
  CONSTRAINT `fk_raiders_commissions` FOREIGN KEY (`raiders_id`) REFERENCES `riders` (`raiders_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `carts` (
  `carts_id` int NOT NULL AUTO_INCREMENT,
  `carts_quantity` int NOT NULL DEFAULT '1',
  `member_id` int NOT NULL,
  `shop_id` int NOT NULL,
  `orders_id` int DEFAULT NULL,
  `menu_id` int NOT NULL,
  `carts_cdate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`carts_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

