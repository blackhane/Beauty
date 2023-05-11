-- --------------------------------------------------------
-- 호스트:                          43.201.83.163
-- 서버 버전:                        5.5.68-MariaDB - MariaDB Server
-- 서버 OS:                        Linux
-- HeidiSQL 버전:                  12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- beauty 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `beauty` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `beauty`;

-- 테이블 beauty.board 구조 내보내기
CREATE TABLE IF NOT EXISTS `board` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `group` varchar(45) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` varchar(255) NOT NULL,
  `rdate` datetime NOT NULL,
  `hit` int(11) NOT NULL DEFAULT '0',
  `parent` int(11) DEFAULT NULL,
  `uid` varchar(255) DEFAULT NULL,
  `comment` int(11) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 beauty.board:~0 rows (대략적) 내보내기

-- 테이블 beauty.cart 구조 내보내기
CREATE TABLE IF NOT EXISTS `cart` (
  `cartNo` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) DEFAULT NULL,
  `prodNo` int(11) NOT NULL,
  `count` int(11) NOT NULL DEFAULT '1',
  `color` varchar(255) NOT NULL DEFAULT '',
  `size` varchar(255) NOT NULL,
  `rdate` datetime NOT NULL,
  PRIMARY KEY (`cartNo`),
  KEY `fk_Cart_Product1_idx` (`prodNo`),
  CONSTRAINT `fk_Cart_Product1` FOREIGN KEY (`prodNo`) REFERENCES `product` (`prodNo`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- 테이블 데이터 beauty.cart:~7 rows (대략적) 내보내기
INSERT INTO `cart` (`cartNo`, `uid`, `prodNo`, `count`, `color`, `size`, `rdate`) VALUES
	(14, '3d79c2f7-b32a-4b7a-8c0f-7cf3959c03a9', 630, 1, '핫핑크', 'free', '2023-03-22 02:50:08'),
	(29, 'gpaj123ehdm@gmail.com', 590, 6, '다크그레이', 'FREE', '2023-03-24 01:38:34'),
	(31, 'adea3662-9281-4c50-966e-e4d32db83d6f', 589, 2, '아이보리', 'M', '2023-03-24 04:18:26'),
	(34, '54511f28-5d84-4922-b5f5-fce1add04167', 607, 1, '아이보리', 'M', '2023-03-26 23:56:56'),
	(35, '54511f28-5d84-4922-b5f5-fce1add04167', 601, 3, '라이트핑크', 'M', '2023-03-27 00:03:02'),
	(38, '924fd605-2bc4-4dda-a100-88e0dce91e0b', 591, 3, '핑크', 'M', '2023-03-27 01:43:03'),
	(39, '924fd605-2bc4-4dda-a100-88e0dce91e0b', 623, 2, '베이지', 'S', '2023-03-27 02:02:40');

-- 테이블 beauty.cate1 구조 내보내기
CREATE TABLE IF NOT EXISTS `cate1` (
  `cate` int(11) NOT NULL,
  `c1Name` char(10) NOT NULL,
  PRIMARY KEY (`cate`),
  UNIQUE KEY `c1Name` (`c1Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 beauty.cate1:~5 rows (대략적) 내보내기
INSERT INTO `cate1` (`cate`, `c1Name`) VALUES
	(300, 'BOTTOM'),
	(400, 'DRESS'),
	(500, 'ETC'),
	(100, 'OUTER'),
	(200, 'TOP');

-- 테이블 beauty.cate2 구조 내보내기
CREATE TABLE IF NOT EXISTS `cate2` (
  `cate` int(11) NOT NULL,
  `c1Name` char(10) NOT NULL,
  `c2Name` char(10) NOT NULL,
  PRIMARY KEY (`cate`),
  KEY `FK_cate2_cate1` (`c1Name`),
  CONSTRAINT `FK_cate2_cate1` FOREIGN KEY (`c1Name`) REFERENCES `cate1` (`c1Name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 beauty.cate2:~21 rows (대략적) 내보내기
INSERT INTO `cate2` (`cate`, `c1Name`, `c2Name`) VALUES
	(101, 'OUTER', '가디건'),
	(102, 'OUTER', '자켓/코트'),
	(103, 'OUTER', '패딩/점퍼'),
	(104, 'OUTER', '집업/조끼'),
	(201, 'TOP', '티셔츠'),
	(202, 'TOP', '니트/스웨터'),
	(203, 'TOP', '셔츠/블라우스'),
	(204, 'TOP', '맨투맨/후드'),
	(205, 'TOP', '조끼/나시'),
	(301, 'BOTTOM', '스커트'),
	(302, 'BOTTOM', '데님'),
	(303, 'BOTTOM', '팬츠'),
	(304, 'BOTTOM', '슬랙스'),
	(305, 'BOTTOM', '레깅스'),
	(401, 'DRESS', '원피스'),
	(402, 'DRESS', '투피스'),
	(403, 'DRESS', '점프수트'),
	(501, 'ETC', '신발'),
	(502, 'ETC', '가방'),
	(503, 'ETC', '모자'),
	(504, 'ETC', '쥬얼리');

-- 테이블 beauty.member 구조 내보내기
CREATE TABLE IF NOT EXISTS `member` (
  `uid` varchar(255) NOT NULL,
  `pass` varchar(255) NOT NULL,
  `name` varchar(5) NOT NULL,
  `level` char(1) NOT NULL DEFAULT '1',
  `point` int(11) NOT NULL DEFAULT '0',
  `phone` varchar(20) DEFAULT NULL,
  `zip` varchar(45) DEFAULT NULL,
  `addr1` varchar(255) DEFAULT NULL,
  `addr2` varchar(255) DEFAULT NULL,
  `regip` varchar(45) NOT NULL,
  `rdate` varchar(45) NOT NULL,
  `height` int(11) DEFAULT '0',
  `weight` int(11) DEFAULT '0',
  `pass1` varchar(255) DEFAULT NULL,
  `pass2` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 beauty.member:~8 rows (대략적) 내보내기
INSERT INTO `member` (`uid`, `pass`, `name`, `level`, `point`, `phone`, `zip`, `addr1`, `addr2`, `regip`, `rdate`, `height`, `weight`, `pass1`, `pass2`) VALUES
	('123@123', '$2a$10$cDQ4Siv5YYhWY1ujWAzfWOD4hztLZmznvRB4uOBLY846RRMHy0j3q', '123', '1', 0, '010-1234-1234', '123', '', '123', '0:0:0:0:0:0:0:1', '2023-03-08 04:06:14', 0, 0, NULL, NULL),
	('555@naver.com', '$2a$10$SBBZx2472Q8/aan9j36/Aelras9l.YerjqVTBMz/7L9JLrXnpUXuu', '기기기', '1', 0, '010-8545-4558', '47387', '부산 부산진구 엄광로 2', '123', '0:0:0:0:0:0:0:1', '2023-03-17 00:06:57', 111, 111, NULL, NULL),
	('888@naver.com', '$2a$10$Dq2yvQgHGYU8R8Owm5gPTui.oZA38ezov5C1Ki5WAtNFGt2kravd2', '가가가', '1', 0, '010-7474-7474', '47387', '부산 부산진구 엄광로 2', '11111', '0:0:0:0:0:0:0:1', '2023-03-17 00:09:22', 111, 111, NULL, NULL),
	('admin@admin', '$2a$10$FnRsA4cGZCZUedh6MJvgN.IPXzIEg3IcPP.cjqnyhSaLMOD99oCIu', '관리자', '3', 28138, '011-0000-0000', '11', '부산진구', '11', '0:0:0:0:0:0:0:1', '2023-03-09 04:12:34', 0, 0, NULL, NULL),
	('c101@naver.com', '$2a$10$zSrtXCshMLghGwsH7f6a7.JbLiOdppr3umR6wI8VUmxC/r7uvdvee', '홍길길', '1', 0, '010-5656-5656', '12', '', '12', '0:0:0:0:0:0:0:1', '2023-03-08 03:26:50', 111, 111, NULL, NULL),
	('c102@naver.com', '123', '홍길', '1', 0, '010-4545-4545', '123', '', '123', '0:0:0:0:0:0:0:1', '2023-03-08 03:28:37', 0, 0, NULL, NULL),
	('gpaj123ehdm@gmail.com', '$2a$10$k7kjH4bPcEmL8rZHEXUK9.y4QkdoBwAwkjSbdZm4w/GwI/sqKR7E2', '김동근', '1', 5235, '010-4859-4859', '11111', '부산진구', '루미너스 호텔', '0:0:0:0:0:0:0:1', '2023-03-08 03:28:37', 170, 63, NULL, NULL),
	('sinsunkangg@naver.com', '$2a$10$eCi8msSqkVI6U8wnRw1K3ul4NVvrRJhu1xp/eAD.DOaeijGRRhu7K', '강중현', '1', 0, '010-4584-4584', '47187', '부산 부산진구 백양대로 12-1', '123', '0:0:0:0:0:0:0:1', '2023-03-20 01:37:56', 111, 111, NULL, NULL);

-- 테이블 beauty.order 구조 내보내기
CREATE TABLE IF NOT EXISTS `order` (
  `ordNo` int(11) NOT NULL,
  `prodNo` int(11) NOT NULL,
  `count` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `discount` int(11) NOT NULL DEFAULT '0',
  `disPrice` int(11) NOT NULL DEFAULT '0',
  `point` int(11) NOT NULL DEFAULT '0',
  `total` int(11) NOT NULL,
  `color` char(10) NOT NULL,
  `size` char(10) NOT NULL,
  `rdate` datetime NOT NULL,
  KEY `fk_Order_Product1_idx` (`prodNo`),
  KEY `FK_order_ordercomplete` (`ordNo`),
  CONSTRAINT `FK_order_ordercomplete` FOREIGN KEY (`ordNo`) REFERENCES `ordercomplete` (`ordNo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Product1` FOREIGN KEY (`prodNo`) REFERENCES `product` (`prodNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 beauty.order:~13 rows (대략적) 내보내기
INSERT INTO `order` (`ordNo`, `prodNo`, `count`, `price`, `discount`, `disPrice`, `point`, `total`, `color`, `size`, `rdate`) VALUES
	(1000071, 580, 1, 24000, 0, 0, 648, 24000, '블랙', 'FREE', '2023-03-24 00:57:41'),
	(1000072, 590, 1, 54000, 0, 0, 1539, 54000, '다크그레이', 'FREE', '2023-03-24 00:58:33'),
	(1000072, 597, 8, 38400, 0, 0, 576, 307200, '화이트', 'M', '2023-03-24 00:58:33'),
	(1000073, 636, 7, 89000, 10, 8900, 712, 560700, '아이보리', 'free', '2023-03-24 01:01:03'),
	(1000074, 589, 2, 54000, 0, 0, 1296, 108000, '아이보리', 'M', '2023-03-24 01:17:10'),
	(1000075, 590, 1, 54000, 0, 0, 1539, 54000, '베이지', 'FREE', '2023-03-24 01:17:20'),
	(1000075, 589, 1, 54000, 0, 0, 1296, 54000, '다크그레이', 'S', '2023-03-24 01:17:20'),
	(1000076, 590, 1, 54000, 0, 0, 1539, 54000, '베이지', 'FREE', '2023-03-24 03:04:42'),
	(1000077, 589, 1, 54000, 0, 0, 1296, 54000, '다크그레이', 'M', '2023-03-24 08:44:15'),
	(1000078, 592, 1, 70000, 0, 0, 630, 70000, '다크그레이', 'L', '2023-03-26 10:11:58'),
	(1000079, 589, 1, 54000, 0, 0, 1296, 54000, '다크그레이', 'M', '2023-03-27 01:42:38'),
	(1000079, 591, 1, 24000, 0, 0, 648, 24000, '블랙', 'M', '2023-03-27 01:42:38'),
	(1000080, 591, 1, 24000, 0, 0, 648, 24000, '블랙', 'M', '2023-03-27 02:46:29');

-- 테이블 beauty.ordercomplete 구조 내보내기
CREATE TABLE IF NOT EXISTS `ordercomplete` (
  `ordNo` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) DEFAULT NULL,
  `password` char(20) DEFAULT NULL,
  `ordCount` int(11) NOT NULL DEFAULT '0',
  `ordPrice` int(11) NOT NULL DEFAULT '0',
  `ordDisprice` int(11) NOT NULL DEFAULT '0',
  `ordDelivery` int(11) NOT NULL DEFAULT '0',
  `savePoint` int(11) NOT NULL DEFAULT '0',
  `usedPoint` int(11) NOT NULL DEFAULT '0',
  `total` int(11) NOT NULL DEFAULT '0',
  `orderer` char(5) NOT NULL,
  `orderHp` char(13) NOT NULL,
  `orderZip` varchar(255) NOT NULL,
  `orderAddr1` varchar(255) NOT NULL,
  `orderAddr2` varchar(255) NOT NULL,
  `orderEmail` varchar(255) NOT NULL,
  `recipName` char(5) NOT NULL,
  `recipHp` char(13) NOT NULL,
  `recipZip` varchar(255) NOT NULL,
  `recipAddr1` varchar(255) NOT NULL,
  `recipAddr2` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `payment` char(1) NOT NULL,
  `ordComplete` char(10) NOT NULL DEFAULT '1',
  `ordDate` datetime NOT NULL,
  PRIMARY KEY (`ordNo`)
) ENGINE=InnoDB AUTO_INCREMENT=1000081 DEFAULT CHARSET=utf8;

-- 테이블 데이터 beauty.ordercomplete:~10 rows (대략적) 내보내기
INSERT INTO `ordercomplete` (`ordNo`, `uid`, `password`, `ordCount`, `ordPrice`, `ordDisprice`, `ordDelivery`, `savePoint`, `usedPoint`, `total`, `orderer`, `orderHp`, `orderZip`, `orderAddr1`, `orderAddr2`, `orderEmail`, `recipName`, `recipHp`, `recipZip`, `recipAddr1`, `recipAddr2`, `message`, `payment`, `ordComplete`, `ordDate`) VALUES
	(1000071, '078e70f7-f24d-4a08-a2c9-f055b3aa2fc7', '123123!', 1, 24000, 0, 2500, 0, 0, 26500, '박진휘', '010-3051-4336', '05696', '서울 송파구 가락로12길 5-8', '123', '123123@naver.com', '박진휘', '010-3051-4336', '05696', '서울 송파구 가락로12길 5-8', '123', '', '1', '1', '2023-03-24 00:57:41'),
	(1000072, '078e70f7-f24d-4a08-a2c9-f055b3aa2fc7', '123123!', 9, 361200, 0, 0, 0, 0, 361200, '박진휘', '010-3051-4336', '01012', '서울 강북구 4.19로12길 5', '123213!', '123123@naver.com', '박진휘', '010-3051-4336', '01012', '서울 강북구 4.19로12길 5', '123213!', '', '6', '1', '2023-03-24 00:58:33'),
	(1000073, 'admin@admin', NULL, 7, 623000, 62300, 0, 4984, 0, 560700, '관리자', '011-0000-0000', '11', '부산진구', '11', 'admin@naver.com', '관리자', '011-0000-0000', '11', '부산진구', '11', '', '1', '1', '2023-03-24 01:01:03'),
	(1000074, 'admin@admin', NULL, 2, 108000, 0, 0, 2592, 3000, 105000, '관리자', '011-0000-0000', '11', '부산진구', '11', 'admin@naver.com', '관리자', '011-0000-0000', '11', '부산진구', '11', '', '1', '1', '2023-03-24 01:17:10'),
	(1000075, 'admin@admin', NULL, 2, 108000, 0, 0, 2835, 0, 108000, '관리자', '011-0000-0000', '11', '부산진구', '11', 'admin@daum.net', '관리자', '011-0000-0000', '11', '부산진구', '11', '', '6', '1', '2023-03-24 01:17:20'),
	(1000076, 'admin@admin', NULL, 1, 54000, 0, 0, 1539, 0, 54000, '관리자', '011-0000-0000', '11', '부산진구', '11', 'admin@naver.com', '관리자', '011-0000-0000', '11', '부산진구', '11', '', '1', '1', '2023-03-24 03:04:42'),
	(1000077, 'e63fd129-7ec2-4361-95a1-18e7c8a7134e', '123123!', 1, 54000, 0, 0, 0, 0, 54000, '박진휘', '010-3051-4336', '05696', '서울 송파구 가락로12길 5-6', '123', '123123@naver.com', '박진휘', '010-3051-4336', '05696', '서울 송파구 가락로12길 5-6', '123', '', '6', '1', '2023-03-24 08:44:15'),
	(1000078, 'ad5a2174-9279-44a4-8a11-d4be3cc15967', '123123!', 1, 70000, 0, 0, 0, 0, 70000, '박진휘', '010-3051-4336', '01030', '서울 강북구 삼양로123길 1', '123', '123@naver.com', '박진휘', '010-3051-4336', '01030', '서울 강북구 삼양로123길 1', '123', '', '2', '1', '2023-03-26 10:11:58'),
	(1000079, '924fd605-2bc4-4dda-a100-88e0dce91e0b', '123123!', 2, 78000, 0, 0, 0, 0, 78000, '박진휘', '010-3051-4336', '28322', '충북 청주시 청원구 1순환로 42', '123', '123@naver.com', '박진휘', '010-3051-4336', '28322', '충북 청주시 청원구 1순환로 42', '123', '', '1', '1', '2023-03-27 01:42:38'),
	(1000080, 'admin@admin', NULL, 1, 24000, 0, 2500, 648, 0, 26500, '관리자', '011-0000-0000', '11', '부산진구', '11', 'admin@daum.net', '관리자', '011-0000-0000', '11', '부산진구', '11', '', '6', '1', '2023-03-27 02:46:29');

-- 테이블 beauty.product 구조 내보내기
CREATE TABLE IF NOT EXISTS `product` (
  `prodNo` int(11) NOT NULL AUTO_INCREMENT,
  `prodName` varchar(255) NOT NULL,
  `descript` varchar(255) NOT NULL,
  `prodCate1` char(10) NOT NULL,
  `prodCate2` char(10) NOT NULL,
  `price` int(11) NOT NULL DEFAULT '0',
  `discount` int(11) NOT NULL DEFAULT '0',
  `disPrice` int(11) NOT NULL DEFAULT '0',
  `point` int(11) NOT NULL DEFAULT '0',
  `stock` int(11) NOT NULL DEFAULT '0',
  `sold` int(11) NOT NULL DEFAULT '0',
  `hit` int(11) NOT NULL DEFAULT '0',
  `score` int(11) NOT NULL DEFAULT '0',
  `review` int(11) NOT NULL DEFAULT '0',
  `thumb1` varchar(255) DEFAULT NULL,
  `thumb2` varchar(255) DEFAULT NULL,
  `thumb3` varchar(255) DEFAULT NULL,
  `thumb4` varchar(255) DEFAULT NULL,
  `thumb5` varchar(255) DEFAULT NULL,
  `thumb6` varchar(255) DEFAULT NULL,
  `detail1` varchar(255) DEFAULT NULL,
  `detail2` varchar(255) DEFAULT NULL,
  `detail3` varchar(255) DEFAULT NULL,
  `company` varchar(45) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `origin` varchar(45) DEFAULT NULL,
  `thick` varchar(45) DEFAULT NULL,
  `flex` varchar(45) DEFAULT NULL,
  `through` varchar(45) DEFAULT NULL,
  `lining` varchar(45) DEFAULT NULL,
  `rdate` datetime NOT NULL,
  PRIMARY KEY (`prodNo`)
) ENGINE=InnoDB AUTO_INCREMENT=638 DEFAULT CHARSET=utf8;

-- 테이블 데이터 beauty.product:~45 rows (대략적) 내보내기
INSERT INTO `product` (`prodNo`, `prodName`, `descript`, `prodCate1`, `prodCate2`, `price`, `discount`, `disPrice`, `point`, `stock`, `sold`, `hit`, `score`, `review`, `thumb1`, `thumb2`, `thumb3`, `thumb4`, `thumb5`, `thumb6`, `detail1`, `detail2`, `detail3`, `company`, `status`, `origin`, `thick`, `flex`, `through`, `lining`, `rdate`) VALUES
	(580, 'V 넥 니트 가디건, 여성 봄과 가을 2022 년 새로운 짧은 스웨터 코트, 느슨한 유휴 스타일 긴 소매 아우터웨어 탑', 'V 넥 니트 가디건, 여성 봄과 가을 2022 년 새로운 짧은 스웨터 코트, 느슨한 유휴 스타일 긴 소매 아우터웨어 탑', '100', '103', 24000, 0, 0, 648, 0, 0, 4, 0, 0, '28bbdddd-50bc-4382-bf1d-b2ef3fb09643.jpg', '35a3d6a3-447c-4aa6-b8fc-2f9777f6e273.jpg', 'c3438e91-d4c2-4052-83cc-ec2ec72bce33.jpg', '74298721-4d15-4efa-8bb9-dcbca49e8165.jpg', '96b2adfb-fe2e-48a5-941c-73221a88fedd.jpg', '956518a8-0ef6-44c1-9ae4-a18d62bca114.jpg', 'b5d8e9a7-e157-4df1-8d49-97a9e2471983.jpg', '42864d88-7645-42a2-bedf-43d53d80bfe1.jpg', '8df8703f-abad-48c1-84de-d4f84ba27e6e.jpg', '러쉬', '폴리', '한국', '두꺼움', '좋음', '비침', '있음', '2023-03-01 00:00:00'),
	(588, '여성 롱가디건 울혼방 니트 숄 간절기 신상 봄 가을 겨울 카디건 심플 데일리', '여성 롱가디건 울혼방 니트 숄 간절기 신상 봄 가을 겨울 카디건 심플 데일리', '100', '101', 24000, 0, 0, 684, 0, 0, 1, 0, 0, 'eb2fad09-a05b-4889-bad0-2c7367dbd6d1.jpg', '8aa723b5-0193-4968-aa6e-a126ea7d28ba.jpg', 'e3bd61a6-4885-4284-a33e-c33c3930f6a0.jpg', 'a37df36d-3866-495e-963f-d02e15d6d8f8.jpg', 'a0db715a-14ee-439d-93ad-09a4c6c43cb5.jpg', 'ee353a7a-4571-40c2-ac4e-42013cad386f.jpg', '87fc9ff9-4294-4907-a13c-a019ab57786a.jpg', 'fa7a6ccf-51e6-4d01-bb71-b3a52366d52d.jpg', '817aa6dc-3fb5-42a1-a84a-7c765f380aec.jpg', '러쉬', '울혼방', '한국', '두꺼움', '보통', '없음', '없음', '2023-03-04 00:00:00'),
	(589, '여름 얇은 가디건 사무실 간절기 니트 카디건 MDN519', '여름 얇은 가디건 사무실 간절기 니트 카디건 MDN519', '100', '101', 54000, 0, 0, 1296, 0, 0, 29, 0, 0, '6f4d9764-0fc3-4b48-89ee-bbad21eac944.jpg', '56c19269-4a17-4b28-8e82-657e6276fbae.jpg', '268a7309-f101-47f1-81cf-86863fc511f6.jpg', 'f8c746aa-d202-4560-9b05-68095a2b9125.jpg', '2a989b82-4097-4d28-b51f-b6950f926a21.jpg', 'dc07ef41-79b6-43b2-9bf2-3e3f09b884d6.jpg', '095053ee-5cfb-4e6f-9f30-241e894b6757.jpg', '69d5e472-91ee-449a-a4ea-e1845f39b1f4.jpg', '0db1692f-389a-4b1d-ae31-c2fb52473b7c.jpg', '러쉬', '폴리', '한국', '얇음', '보통', '약간있음', '없음', '2023-03-03 00:00:00'),
	(590, 'G125811_(벨트세트) 더블 롱 트렌치 코트', 'G125811_(벨트세트) 더블 롱 트렌치 코트', '100', '102', 54000, 0, 0, 1539, 0, 0, 34, 0, 0, '9e0ed05d-f534-4d84-b916-79ea64db4eb4.jpg', '274a5be6-5bf5-4854-9e56-e838e8ab7eee.jpg', 'da9523eb-e2fb-4799-ad7f-6836d5205bd5.jpg', '8bebb826-2af3-437c-8e11-e05466289a2f.jpg', '61fd3c85-71d1-4063-a728-c5c8e11c6741.jpg', 'df1fc4aa-8e2e-4bdd-ab4d-71b8df55f3fd.jpg', '38efe2b7-dfb5-4478-953c-eeb5191cb3fe.jpg', '7aa67952-69a0-4933-b405-1748c752887c.jpg', '2369e2bf-4975-4d3b-b43b-8d538eca3fe8.jpg', '러쉬', '폴리', '한국', '보통', '없음', '없음', '부분안감', '2023-03-03 00:00:00'),
	(591, 'OHS-CTDD2708 여성 뽀글이 하프 코트 자켓', 'OHS-CTDD2708 여성 뽀글이 하프 코트 자켓', '100', '102', 24000, 0, 0, 648, 0, 0, 15, 0, 0, 'be6b736d-0b4b-4cfe-944b-0212d9e46e19.jpg', 'acaabe1a-f966-4ba9-b94c-12ca02eda8ce.jpg', 'a5c718d6-628d-446d-b26b-84b7aaac77f5.jpg', '997d9529-2bbd-4af6-b8d2-f21ef4912f2e.jpg', '1c52954b-e77b-4d71-8e77-42ab7932b595.jpg', '831d3c4f-18fa-4897-bef4-877300713537.jpg', '13ab7bca-2a2c-4c0c-bc7d-c3b5c3b39b57.jpg', 'da81ba61-9646-4868-84ab-efd46d0e8765.jpg', '76b50afc-c42e-42f9-80bd-0d7f10c41cc1.jpg', '러쉬', '폴리', '한국', '두꺼움', '없음', '없음', '없음', '2023-03-02 00:00:00'),
	(592, '+봄신상 코트+ 빅사이즈/오버핏/롱/하프/체크/루즈핏/싱글/더블/자켓/스트랩/모던/클래식/야상/트렌치코트', '+봄신상 코트+ 빅사이즈/오버핏/롱/하프/체크/루즈핏/싱글/더블/자켓/스트랩/모던/클래식/야상/트렌치코트', '100', '102', 70000, 0, 0, 630, 0, 0, 7, 0, 0, '10204c02-423b-45f1-9a4b-bd66ad754b28.jpg', '8187bfe9-ca00-4128-b16d-d2598cd95437.jpg', '189504c4-94ae-485e-afae-ad61fd04b573.jpg', '510bb706-b891-4651-a0a6-488701faa802.jpg', 'f75f6b5b-32d0-4470-b5fd-25133e7cdb83.jpg', '47171bfa-df2d-4e04-8bfd-22a3528e9867.jpg', 'a93a75dd-cb86-43d7-99df-d419d01c12be.jpg', '0f8707e1-99b0-44f1-87b3-3c2f969184aa.jpg', '679a42eb-503f-441e-857c-be0d7c49f168.jpg', '함소아', '폴리', '한국', '보통', '없음', '없음', '없음', '2023-02-07 00:00:00'),
	(593, '모직 코트 모던 클래식 여성울코트19 캐시미어 헤링본 솔리드 울혼방 더블 브레스트', '모직 코트 모던 클래식 여성울코트19 캐시미어 헤링본 솔리드 울혼방 더블 브레스트', '100', '102', 600000, 10, 60000, 4200, 0, 0, 2, 0, 0, '9ce8e015-b739-4e90-bc22-42c5b577ff7e.jpg', '1fa26b29-600a-4414-8e2e-26cea97ebb8a.jpg', '031000fd-2f9c-45e3-81f6-d0a7fdf1f1e3.jpg', '58b957e9-26ee-449f-a1a9-b3ec3cb954c4.jpg', '64e666de-a44d-48d1-80c0-da44c31dbf8f.jpg', 'b2926a97-0dad-4b61-ae5d-c6a79b82d029.jpg', 'ba8ad0c8-c49f-4225-a61e-fb545045e5ef.jpg', 'f387e992-cb4d-4c42-a3d3-4c63ae988e49.jpg', '26b4bb91-1b83-4b94-bd85-1ed7e8054aa7.jpg', '러쉬', '폴리', '한국', '보통', '없음', '없음', '없음', '2023-02-08 00:00:00'),
	(594, '퍼 아우터 빅사이즈 부드러운 모피 코트 겨울 코디', '퍼 아우터 빅사이즈 부드러운 모피 코트 겨울 코디', '100', '102', 150000, 10, 15000, 1425, 0, 0, 0, 0, 0, '0b842728-ad0f-4874-bd9b-46374d1bff01.jpg', 'a89ceee9-f2c2-416c-b720-9f3a54545504.jpg', 'c82a617a-0894-40d1-ad1a-303d80b2acb7.jpg', 'e28e31d5-9794-4eaa-8b3d-2533345edbcd.jpg', '04a29098-386a-49bc-bfe8-7c5c47be3701.jpg', 'd470db3d-f3be-446f-93fe-5ab760c5a6e9.jpg', '8e36b9db-1c1d-42e6-ac75-11cac393881c.jpg', 'c92101d4-836f-42bb-b49c-c032af405c70.jpg', 'e91af557-0f63-4ece-8a88-26fba1ba7cc8.jpg', '러쉬', '울혼방', '한국', '두꺼움', '없음', '없음', '없음', '2022-12-21 00:00:00'),
	(595, '캘린 트위드 자켓 스커트 세트', '반드시 드라이 클리닝으로 관리해주세요', '400', '402', 230000, 10, 23000, 2070, 0, 0, 0, 0, 0, '0839e75d-548c-4d95-b51b-48008b82de16.jpg', '94d8bcec-9598-4c5f-98ca-a515c7024db4.jpg', 'fbbd37d2-16fb-496a-92d7-9d3facfbc4d6.jpg', 'e1d961f7-12ee-4373-bc22-191176555f9f.jpg', 'd760b041-48d4-4ffc-8bc6-c2fec766fc04.jpg', '95a41d97-e910-4f39-a282-48a1a142badf.jpg', 'fcb27727-68ab-45f0-9db2-99fdea4796b9.jpg', 'dd0b5449-1e2e-4980-9c23-bf43d2b48c27.jpg', 'bc9d03d5-fb96-47ef-9821-bc88b389ec7f.jpg', '리즈 하이엔드', '폴리', '한국', '보통', '없음', '없음', '있음', '2023-03-14 00:00:00'),
	(596, '루보 랩 셔링 롱 원피스 벚꽃룩', '손세탁 해주세요', '400', '401', 110000, 10, 11000, 660, 0, 0, 0, 0, 0, '84f5b161-6afe-42b6-bc35-50c58a9ee8f5.jpg', '0cb688c6-c303-474f-ae55-24993fb60dcc.jpg', '8bbce0ba-149e-463f-8032-b13374e8c5d9.jpg', 'f77f00ab-cc2d-4ff3-a009-3ad0693607b2.jpg', '9b1cc7d3-ebca-4dd0-82b0-69194bf75331.jpg', '9d94a76e-ddd0-4cb8-9de2-fb221f6ce59f.jpg', '72eb2d60-c437-4a03-a42f-3762fda4ca1b.png', '81840673-122a-4322-93cf-c4e606dc9827.png', '8d4bec2a-8acc-4bf4-908f-b46aab344605.png', '아뜨랑스', '폴리', '한국', '보통', '보통', '없음', '있음', '2023-03-11 00:00:00'),
	(597, '라이키 노버튼 브이넥 카라 셔츠 블라우스/ 봄 가을 간절기 오피스 결혼식 하객 데일리 면접 직장인 정장 기본 남방', '라이키 노버튼 브이넥 카라 셔츠 블라우스/ 봄 가을 간절기 오피스 결혼식 하객 데일리 면접 직장인 정장 기본 남방', '200', '200', 38400, 0, 0, 576, 0, 0, 2, 0, 0, '70fd7f42-d489-43f2-a8f5-51aac444c55b.jpg', '9e1db30d-7e06-4634-b426-00e0d64aa5ff.jpg', 'c96e6f23-8ad8-4ec1-8c44-9b3cb8ded31e.jpg', '05941a1f-9cad-40cc-a587-85aea453260d.jpg', '16576dd4-db59-4c17-a7d0-0bf15cb8e5b1.jpg', '1f52e416-af5a-4d25-b101-edf87a742ff7.jpg', '75d0d020-b03c-42f3-8121-312babbf2f8f.jpg', 'dc8758df-90da-4802-9c90-895e8fdad34c.jpg', '20938542-3790-4473-9480-44ff15531ed6.jpg', '뷰티샵', '폴리53, 면47', '대한민국', '얇음', '보통', '약간있음', '없음', '2023-03-01 00:00:00'),
	(598, '시그니쳐 탄탄 베이직 자켓 스커트 셋업 벚꽃룩', '세탁기 금지', '400', '401', 120000, 10, 12000, 960, 0, 0, 0, 0, 0, '62dc3df0-bd88-4d05-80db-d75cb1b9c85c.jpg', 'c5681bb0-e962-4445-b1a7-2fdd9b4c4f32.jpg', 'c8cc383d-588f-4267-872e-d15332f02c8c.jpg', '74cb22b2-56a5-446f-8c95-5e2abc045dd6.jpg', '5b3c1591-1d12-46bb-b9d8-6c2979fbe047.jpg', '60c08b9b-9c71-4d8d-b9ba-f59aec7a46af.jpg', '14722669-a527-4fd5-b8f4-3ac4bc58b240.png', '62a16ed1-a1b7-4f9f-879e-2ba962ea184b.png', '96747870-d09c-4ceb-a3e8-35b593203622.jpg', '아우라', '폴리', '한국', '두꺼움', '보통', '없음', '있음', '2023-03-21 00:00:00'),
	(599, '*핏조절가능* 나링 투웨이 사이드버튼 라인 슬림 루즈핏 셔츠 / 봄 가을 간절기 오피스룩 하객룩 소개팅룩 결혼식 데이트룩 레이어드룩 벚꽃룩 나들이룩', '*핏조절가능* 나링 투웨이 사이드버튼 라인 슬림 루즈핏 셔츠 / 봄 가을 간절기 오피스룩 하객룩 소개팅룩 결혼식 데이트룩 레이어드룩 벚꽃룩 나들이룩', '200', '201', 28900, 0, 0, 867, 0, 0, 0, 0, 0, '18ba9859-e509-4cff-93d3-3d8ed4059b1a.jpg', 'b8dfc95f-f41d-4874-9f0b-c50adaf88682.jpg', 'b7856b44-2f00-4b44-81a0-1f78d0ad9ca0.jpg', '1b287f21-095a-423e-83ff-2c6d3231b072.jpg', 'cf501ee8-57b9-461f-b8db-f09959acc0e6.jpg', '969828e4-0301-4447-8845-ebacd3abd119.jpg', '616d51e3-bef6-4152-bf03-dbf6f42926b8.jpg', 'd4677b40-b9e7-439e-aec7-28a7e6b0cc23.jpg', '0f7f66f2-60aa-4e12-8576-20596a223e36.jpg', '뷰티샵', '면35, 폴리65', '대한민국', '보통', '없음', '없음', '없음', '2023-03-01 00:00:00'),
	(600, '블루스 트렌치 벨트 원피스 벚꽃룩', '드라이 해주세요', '400', '401', 140000, 10, 14000, 980, 0, 0, 0, 0, 0, 'f2c5f9bb-814b-4646-9cba-f96f4bfdfa30.jpg', '0b932d6f-7532-4369-ad53-b2d7667c0ce0.jpg', '6d92a5fa-22fa-45ae-b281-effeaee71c2b.jpg', '506c0510-45a7-46a4-8df6-247d05182477.jpg', 'c7133697-cfaa-4d6c-8102-c17e1ed85c1d.jpg', 'b5562b55-109f-4279-a9bf-00a547900528.jpg', '9c4c0277-fe39-4ed2-9f9b-7047553e0c6a.jpg', 'ec793c12-220c-4160-85ed-4566a6d8afe8.jpg', '09f90447-9a27-4dc6-98d4-7c4a3c3005cf.jpg', '아뜨랑스', '면,코튼', '한국', '두꺼움', '보통', '없음', '부분안감', '2023-03-01 00:00:00'),
	(601, '오트 슬림핏 잔골지 오프숄더 스퀘어넥 언발 트임 긴팔 티셔츠 / 봄 가을 오피스룩 하객룩 데일리룩 소개팅룩 결혼식 데이트룩 20대하객룩 벚꽃룩 꽃놀이룩 나들이룩', '오트 슬림핏 잔골지 오프숄더 스퀘어넥 언발 트임 긴팔 티셔츠 / 봄 가을 오피스룩 하객룩 데일리룩 소개팅룩 결혼식 데이트룩 20대하객룩 벚꽃룩 꽃놀이룩 나들이룩', '200', '202', 35400, 0, 0, 1062, 0, 0, 2, 0, 0, '80922cf4-a312-46cd-bd30-2f4e63d43af1.jpg', '04ac52e9-c790-40f4-bd77-f231c308724a.jpg', '6ae2793e-a1a4-4a46-a936-c616acd74181.jpg', 'a096e092-4bac-41eb-bdd2-0281294bfaa7.jpg', '90dffb93-ad91-4534-911d-0b00b2b6edc9.jpg', '48275021-7332-456a-914f-aca708ac85d5.jpg', 'd220e24c-16bb-485c-b10f-96ceb342fec6.jpg', 'e1335ca0-4fde-4415-9d62-15cc634be52d.jpg', '8e603b43-4869-40c7-82dc-b59e1b094914.jpg', '뷰티샵', '폴리29, 레이온77, 스판4', '대한민국', '보통', '좋음', '없음', '없음', '2023-03-01 00:00:00'),
	(602, '*세트가능* 멜티드 오버핏 코튼 크롭 자켓 / 봄 가을 간절기 데일리룩 꾸안꾸 데이트룩 트윈룩 개강룩 새내기룩 투피스세트 청순 여리핏', '*세트가능* 멜티드 오버핏 코튼 크롭 자켓 / 봄 가을 간절기 데일리룩 꾸안꾸 데이트룩 트윈룩 개강룩 새내기룩 투피스세트 청순 여리핏', '200', '203', 32800, 0, 0, 984, 0, 0, 0, 0, 0, '910f25d5-9653-4981-ba45-67123684648c.jpg', 'e4efd300-44dd-4cf9-bbf9-38b817555a97.jpg', '249222d5-c89c-441d-9898-446740281ebd.jpg', 'c5350175-adf9-4e28-931d-8e12b323096b.jpg', '3cd262b9-66af-4265-9460-4daa1729e76a.jpg', '2eeb9454-7fff-4e65-a204-4a1e58b729ec.jpg', 'c4c68513-8325-445e-8860-2b2796e394b4.jpg', '001d95cc-bf17-430d-9de7-ddcc92621d22.jpg', 'ddc7b33e-adc6-4559-baf2-402b8f59e3ba.jpg', '뷰티샵', '면', '대한민국', '보통', '없음', '없음', '없음', '2023-03-01 00:00:00'),
	(603, '더블 V 서스펜더 원피스', '표백제 금지', '400', '401', 89000, 10, 8900, 801, 0, 0, 0, 0, 0, '62dda511-0370-4b23-9fb9-faaed272747f.jpg', '430fa585-0d28-4f8c-a33d-1fa2e0a23786.jpg', 'ceafb3b0-064a-404a-9304-9b17082d99e2.jpg', 'fa04f282-24a9-4024-a7cf-c7d8294cca17.jpg', '19d76bab-35b2-4530-86bf-61fb3296d909.jpg', '3dcc388a-175f-4bd1-9112-3923e2d75e71.jpg', '670b1e21-c1e5-4f05-89fb-da26d6d60796.jpg', '8c964b77-9e97-42e4-9b53-5d59ce30678d.jpg', '0800dba6-f645-482b-a062-34039048b0e3.jpg', '리즈 하이엔드', '폴리', '한국', '보통', '없음', '없음', '없음', '2023-03-05 00:00:00'),
	(605, '라벤더 쫀쫀 슬림핏 보트넥 언발 트임 티셔츠 / 봄 가을 간절기 데일리룩 데이트룩 하객룩 소개팅룩 결혼식 오피스룩 레어이드룩 기본템 베이직템 벚꽃룩 나들이룩', '라벤더 쫀쫀 슬림핏 보트넥 언발 트임 티셔츠 / 봄 가을 간절기 데일리룩 데이트룩 하객룩 소개팅룩 결혼식 오피스룩 레어이드룩 기본템 베이직템 벚꽃룩 나들이룩', '200', '202', 31800, 0, 0, 954, 0, 0, 0, 0, 0, 'db25ab36-5a7e-4202-aa27-62c79da040b5.jpg', 'c1bd077e-d8cd-412b-9faa-8b0428be3b58.jpg', '6891a83b-f502-480d-be68-5ff7d5af50a7.jpg', '1ac6a0df-dab7-43f7-9b1f-ac6bcf28c0e4.jpg', '5f6a4e64-da1f-41d0-824f-519527169f75.jpg', '7f076545-e8fc-4289-9f8c-28f210516879.jpg', '42940d65-ae66-436b-81d5-572a450a9b41.jpg', 'f8c4a1be-0591-42d6-ab91-87688b5f2115.jpg', '95e2fe12-77ed-4ebb-8c5c-af1d6ae0395f.jpg', '뷰티샵', '폴리72, 레이온24, 스판4', '대한민국', '얇음', '좋음', '약간있음', '없음', '2023-03-03 00:00:00'),
	(606, '솔레아 보트넥 2기장 H라인 원피스 dress 벚꽃룩', '드라이만 해주세요', '400', '401', 85000, 10, 8500, 680, 0, 0, 0, 0, 0, 'b8165e0e-5668-46b6-a845-90d9d0175f4c.jpg', '05e7d003-c2ab-4e42-ae15-5d357cf63f2c.jpg', '877869de-8078-4570-9b48-a7fa260d7d6b.jpg', '38f3b56e-0a0a-44a5-9ddc-734c867151a9.jpg', 'e8b1ed5c-cff6-4f99-8ba4-6a8707ff50f1.jpg', '8a8d2711-9d09-42ab-881d-36a114501347.jpg', '1d8b7b0a-d70e-4acf-a013-1b63c487b7e0.png', '4a3ee682-77f8-48c2-9bf1-ba8312da4066.jpg', '2bbd8040-d07c-4e8a-96ac-50cf96cb9bbc.jpg', '아르떼', '폴리', '한국', '얇음', '보통', '없음', '없음', '2023-03-11 00:00:00'),
	(607, '*투피스set* 다이아 배색 리본 나시 프릴소매 크롭 가디건 세트 / 봄 여름 가을 데일리룩 데이트룩 소개팅룩 나들이룩 새내기룩 청순 여리핏', '*투피스set* 다이아 배색 리본 나시 프릴소매 크롭 가디건 세트 / 봄 여름 가을 데일리룩 데이트룩 소개팅룩 나들이룩 새내기룩 청순 여리핏', '200', '202', 26900, 0, 0, 807, 0, 0, 1, 0, 0, '70dec3a2-d911-4f09-b043-eef5b07b4261.jpg', '9285facf-b811-40d2-96d3-0918e7e32844.jpg', '0d05f843-e13b-4c31-9a2d-8f9796d4d3e6.jpg', 'af05907b-e88a-4649-bb08-d0db5325812f.jpg', 'eff34790-21f5-4ade-a747-b2705d52ca25.jpg', 'f6533dde-06d1-4386-8e2b-e7a8db380d7b.jpg', 'bf762b62-7f15-4706-8109-f7efacc9f107.jpg', '8de064d1-c22e-4f0d-8234-800fc699c79f.jpg', '38b9d686-fb18-4f52-9ae9-ec68912568ce.jpg', '뷰티샵', '폴리95, 스판5', '대한민국', '얇음', '좋음', '없음', '없음', '2023-03-02 00:00:00'),
	(608, '해온 스퀘어넥 오프숄더 쫀쫀 슬림핏 언발 티셔츠 / 봄 가을 데이트룩 데일리룩 새내기룩 개강룩 클럽룩 볼륨핏 모임룩', '해온 스퀘어넥 오프숄더 쫀쫀 슬림핏 언발 티셔츠 / 봄 가을 데이트룩 데일리룩 새내기룩 개강룩 클럽룩 볼륨핏 모임룩', '200', '203', 24900, 0, 0, 747, 0, 0, 0, 0, 0, '44670090-4960-4562-8a73-634154accff0.jpg', 'd68ef2db-f0ea-4d05-8aae-51ec430ad0b0.jpg', '0a81e65d-1549-4495-84a4-0b8508e60bd9.jpg', 'df0def2e-e1cb-479a-8455-577ece18d8dd.jpg', 'ab8a2bdd-74b6-4ac3-ab69-5870e39c80d7.jpg', 'be9c3d0a-b433-44b8-9747-82d41fc61701.jpg', '42fa05ab-9456-4479-8888-7537ab3ade54.jpg', 'e091e040-dd14-47cd-9c01-f4eb11f5a30c.jpg', 'af00f8dc-7311-45c8-9733-6ca3a6ffded6.jpg', '뷰티샵', '폴리65, 레이온30, 스판5', '대한민국', '보통', '보통', '없음', '없음', '2023-03-04 00:00:00'),
	(609, '비비 트위드 반팔 원피스', '드라이만 해주세요', '400', '401', 89000, 10, 8900, 712, 0, 0, 0, 0, 0, '32f360a5-3232-480b-b13b-ffd51dd8dbed.jpg', '01d929eb-4ef8-498c-9ada-1c399e0b1c1a.jpg', '572b348e-d46d-4a05-8e4b-db617ec0df44.jpg', '33ce20b8-2eb2-4567-884a-6df0b135cb29.jpg', '1a0e5af6-5399-496b-b041-266057ab546c.jpg', '2022a98e-58d8-431d-bfe3-78fecce27a6d.jpg', '8dd40b69-d166-4c6f-a35f-6656aca4068a.png', 'ab94d1ba-43f4-4626-83b6-ee22af4c4cff.png', 'd8d4ef88-6787-4a46-962f-1265a1cf6e0e.png', '아르떼', '폴리', '한국', '보통', '없음', '없음', '부분안감', '2023-03-21 00:00:00'),
	(610, '기모 촉촉 슬림 무지 폴라 니트', '기모 촉촉 슬림 무지 폴라 니트', '200', '204', 20000, 0, 0, 600, 0, 0, 0, 0, 0, '5a5ff23c-1629-40cc-9582-a61461ac7c89.jpg', '2dd52c22-184c-4411-b48b-b34474f6691b.jpg', '440a270d-c2ef-4581-b3b2-2b1413fc4464.jpg', 'eb088756-00cc-4298-862c-c301c107b08b.jpg', '26ebb189-1d7d-4000-869a-9cbe56ce0c56.jpg', 'bb053d96-9e60-4f64-9829-6a15bdb2577a.jpg', '17f85d35-9178-4cc3-9b5c-86e20528fa3e.jpg', '482b6d59-5b84-438d-a559-419f22fd9916.jpg', 'a1eadd10-c67a-4160-8880-9f749932056e.jpg', '뷰티샵', '폴리70, 레이온30', '대한민국', '보통', '좋음', '없음', '없음', '2023-03-04 00:00:00'),
	(611, '[울함유] 미뉴엣 울 트위드 자켓 스커트 셋업 투피스 벚꽃룩', '드라이만 해주세요', '400', '401', 158000, 10, 15800, 1264, 0, 0, 0, 0, 0, 'ffafdca2-17e2-4bdc-bae6-853aea2f205f.jpg', '82e10b0b-bb4a-4f40-8968-c28dce203d7a.jpg', '175c62b7-d31a-4ca3-8723-8a83236e734b.jpg', '08068ae2-c148-425b-8689-55893b8bbdd3.jpg', '8243a64a-e94c-4ec4-a508-7d4c55890436.jpg', '51aebe88-8406-4dc2-abcb-143ece277dc4.jpg', '957c17c4-48b8-4c3f-87c4-661537a5d12b.png', '73b4380e-515d-43b1-80b6-a27b3b9cc3ec.png', '40e878e7-e121-43da-b5f7-748b62cc11c5.jpg', '아르떼', '폴리,울', '한국', '보통', '없음', '없음', '없음', '2023-02-28 00:00:00'),
	(612, '젠느 자켓 스커트 투피스 셋업', '단독세탁해주세요', '400', '402', 129000, 10, 12900, 1161, 0, 0, 0, 0, 0, '962eb2d6-0529-411c-a499-d42aeb4fdf85.jpg', '8bf50705-b80e-49df-8900-625cde10be51.jpg', '63ecb0ef-456e-418b-8e9d-3581bbbac102.jpg', 'a5a5c63b-d0da-4399-b1f9-b2d8f5e56c93.jpg', 'cb1e4839-4295-45e8-8aa7-2e772c9729f5.jpg', 'b8c3cfbb-f90f-46b3-a99b-448bb3b395aa.jpg', '2f82d27b-f784-458a-ab45-d0049342afb3.png', '69874438-885e-403e-869f-942ecfeb84f2.png', 'b1e3b4ba-a1ed-4141-b115-ac958989733a.jpg', '아르떼', '폴리,스판', '한국', '얇음', '보통', '약간있음', '없음', '2023-03-06 00:00:00'),
	(613, '두가지 패브릭의 크롭 자켓과 A라인 미니스커트 투피스 세트', '드라이만 해주세요', '400', '402', 128000, 10, 12800, 896, 0, 0, 0, 0, 0, '23bc09e6-9f23-4c6f-9451-037a68205305.jpg', '6b17bfd8-d468-414e-9967-921f24803e4c.jpg', 'c7c43e18-eaa1-4545-aaea-54b3345ad711.jpg', 'e7468e9b-5f83-4f64-a827-913e4e9fdbf8.jpg', '5d5cf29f-2ccd-43b6-99a7-bfcec8b9e0e2.jpg', 'bf5525f3-6ed5-4f1d-b31d-b92ca1953e5a.jpg', '2a02a5ee-5cd2-4d2c-8bca-c8d0d2009139.png', 'e27468c6-129c-4419-9275-ac3d6c8e10e7.png', '151c25d1-133d-4ba2-b83a-6c0839cc1e4d.png', '아르떼', '폴리', '한국', '두꺼움', '없음', '없음', '없음', '2023-02-02 00:00:00'),
	(614, '블라썸 트위드 더블 자켓 스커트 투피스 세트', '드라이만 해주세요', '400', '402', 165000, 10, 16500, 1320, 0, 0, 0, 0, 0, 'deacf700-c8ac-48cf-8e53-5b82396e095c.jpg', '7af7be01-d070-40e6-a171-a50190a3f4f7.jpg', '4c30b317-73d7-4b66-b9b5-3b33d4fc613d.jpg', '6083d8e8-d35f-44af-9cc9-303338f45abd.jpg', '4b70ef29-09cb-4b62-844a-ccab270e5860.jpg', 'fe4ba472-561b-4c7f-9a52-d8bc78e6c615.jpg', '24ed6546-7bcc-46b9-aa15-91eac3e56321.png', '50f4b9c7-7be1-4395-87bc-27922a8748e9.jpg', '7f6639d4-0523-46a9-8b3a-9f1c08e20c14.jpg', '아르떼', '폴리', '한국', '보통', '보통', '없음', '부분안감', '2023-03-09 00:00:00'),
	(615, '제이에스 션샤인II 여성 롱 니트티 긴팔티', '제이에스 션샤인II 여성 롱 니트티 긴팔티', '200', '202', 12900, 0, 0, 117, 0, 0, 0, 0, 0, 'b3fbca1e-40ab-4aeb-9d42-eaf10b1344ca.png', '65d8c5b5-dd4c-4878-b4dd-fa54c0538758.png', 'e35a2993-d57c-465a-b669-3dbb37cb9713.png', '424946b4-09e0-4135-acbb-dee4a0e3101b.png', '6e1c40ad-9f6a-4178-9515-cae7be6d6c3e.png', '824cf499-dd84-4555-9d0a-94d1970c48ed.png', '22b87928-6336-49f3-b06d-824d0c33585f.png', 'fd0f0225-0a5a-46d8-843f-d1fff70945b8.png', 'dd73b747-d56a-4913-839e-2b4e6204efa2.png', '러쉬', '울혼방', '한국', '두꺼움', '보통', '없음', '없음', '2023-02-27 00:00:00'),
	(616, '선데이 자수 세일러넥 맨투맨 조거팬츠 세트 벚꽃룩', '찬물 세탁해주세요', '400', '402', 62000, 0, 0, 496, 0, 0, 0, 0, 0, 'f3b4958d-5390-4074-84fc-b27b5be92323.jpg', '9dcd9683-bb0e-489e-898f-43272761a3a2.jpg', 'a45d0d84-d74c-4813-8b6c-2ea330ca0629.jpg', 'f7d274de-8a43-4128-924a-bf3153c3253a.jpg', 'c9e4f964-aaaa-4613-9133-2f7e4e71d1c1.jpg', '1a238d36-c954-4dc4-9494-a7a06396137e.jpg', '179ebe9e-1571-490d-9218-74cf021448f8.png', '02858103-11bf-4d70-9713-180033e361be.png', '838ee0f2-c2be-4d35-8981-251e05035fea.png', '아뜨랑스', '면', '한국', '얇음', '보통', '약간있음', '없음', '2023-03-10 00:00:00'),
	(617, '데님 패브릭의 크롭 자켓과 A라인 미니 스커트 투피스 세트', '손세탁해주세요', '400', '402', 77000, 10, 7700, 693, 0, 0, 0, 0, 0, '72afb3e4-9987-4414-a7e9-bc3403ae4736.jpg', '4eb8f849-79c8-4297-b26e-c9993bc77aa3.jpg', '29a52bd0-cf16-45a3-82c5-955cc3160c99.jpg', '807fcfad-9228-4a0e-b214-4e277355e71e.jpg', '6560c672-b7c4-472e-ab6f-8c12670b4061.jpg', 'a4d64ed6-fb3a-4aca-a162-a8defe3ccf62.jpg', '2d64b1d0-7a2b-46e3-a62d-9198ccf854a8.jpg', 'aee9ae74-cd1e-463d-9ce6-e917b1c5d5f8.jpg', '704ecd0a-b6b0-4607-b2a6-9687fd048054.jpg', '아뜨랑스', '면', '한국', '보통', '보통', '없음', '부분안감', '2023-03-16 00:00:00'),
	(618, 'MORGAN 골지 버튼 브이넥 니트 3종', 'MORGAN 골지 버튼 브이넥 니트 3종', '200', '202', 59900, 0, 0, 552, 0, 0, 0, 0, 0, '436a4079-4143-446a-bdcf-18ffb4089ca7.jpg', '34689900-e704-4abe-9344-cbdd62b60e2c.jpg', 'f48baefe-d7a4-45b9-842b-5d0e3397eb55.jpg', '1dbc37db-48a0-4dd6-9181-00ff56ea9c89.jpg', '7aaaa675-91e8-48df-a2a5-a69e41dd0528.jpg', 'dfb455ba-917d-4108-a316-7fb8667da45f.jpg', 'ea203889-4403-4639-82fd-19ab6eba007e.jpg', '065c36a2-d6a8-4220-aeb3-a27dcf8756af.jpg', '232cbd95-28a0-498f-b001-80d533ed35aa.jpg', '러쉬', '폴리', '한국', '보통', '보통', '없음', '없음', '2022-11-17 00:00:00'),
	(619, '시그니쳐 탄탄 베이직 자켓 스커트 셋업 벚꽃룩', '드라이만 해주세요', '400', '402', 120000, 10, 12000, 1080, 0, 0, 1, 0, 0, '3ff78be3-08d8-4397-99e1-fb6a374e94bd.jpg', 'aa3f5835-9fef-4f5d-9694-ba8e16f7e866.jpg', '069e5f91-785c-43df-9be9-1e316555ce64.jpg', '64318ceb-0d80-4878-ade6-3816de110858.jpg', 'bcf1c87f-6388-4403-9aa6-dc20a284866f.jpg', '676404d9-dcae-44b2-b558-a3f0d4dad375.jpg', '316532cd-2749-41e0-bf9b-b5a3c01921e6.jpg', 'e6fea80f-8ff3-4ea7-9596-d88f76889d1b.jpg', '6d9eaf48-3282-4f08-a8e0-f4980d18af07.jpg', '아우라', '폴리,스판', '한국', '보통', '좋음', '없음', '부분안감', '2023-03-17 00:00:00'),
	(620, '뮤즐리 트위드 자켓 팬츠 세트', '드라이만 해주세요', '400', '402', 150000, 10, 15000, 1200, 0, 0, 0, 0, 0, 'ebb1e22b-e7bf-4bba-bc23-f9698f6c8da7.jpg', 'fbaa300c-6a8b-48d9-ae9c-9af6c7030624.jpg', '1a3ec4ef-6254-4f70-86af-909f2b10b085.jpg', '24dcca25-98b8-4925-81dd-3d25d482c655.jpg', '896c7914-ef9b-45c4-958c-bdc177c56439.jpg', '5548dac6-e432-4e30-b5cd-8129fdccb1b2.jpg', '669561c9-b2ee-4bda-8949-14abda56d35b.png', 'bf4d7c4d-8ffc-4d8c-b9bc-50e03bcb4569.png', 'fcff4467-3423-4fd4-a38b-bbf2f89e41c3.png', '아르떼', '폴리', '한국', '보통', '보통', '없음', '부분안감', '2023-02-27 00:00:00'),
	(621, '[나인(NAIN)]N시그니처 T025-데일리 케이블 패턴 니트(R-T-6584)', '[나인(NAIN)]N시그니처 T025-데일리 케이블 패턴 니트(R-T-6584)', '200', '202', 75000, 0, 0, 563, 0, 0, 0, 0, 0, '0d2eedaf-0b69-42ab-a68b-86a40696bc8b.jpg', 'a4732225-f385-47c7-8b31-2fda8d06fd8f.jpg', '4fb33eb1-84d3-4e4e-948e-751937b68d94.jpg', '7c62273e-b840-4078-bf56-c46640009770.jpg', '66724dac-6a85-47ef-8826-a00c8c3fda0c.jpg', 'aab294c2-06ff-43dd-884d-c5926afde495.jpg', '3252d9cd-2e62-4619-b121-68db9a8671e2.jpg', 'd6a5294b-c782-4283-9547-18265d4bcc49.jpg', 'da3c9cf7-5543-4bd8-88e3-d1168c0da7ac.jpg', '러쉬', '폴리', '한국', '보통', '보통', '없음', '없음', '2023-02-27 00:00:00'),
	(622, '[VOV]보브 부클 리브드 브이넥 니트', '[VOV]보브 부클 리브드 브이넥 니트', '200', '202', 199800, 10, 19980, 1759, 0, 0, 0, 0, 0, 'f7ea3539-dfec-4aa2-acbe-38604e9773ea.jpg', '34c1c0a8-c427-4d85-ab53-2ee0922ebdfc.jpg', '07d0a40e-a063-4fcd-b27e-6e63e4a8fbf5.jpg', '0776208f-9667-4c3d-9e01-8975dca8fa5a.jpg', 'f2a241c3-db88-4495-a6b3-ef18b96ad429.jpg', 'e14362a3-0fc6-459b-b404-8a5aa592f1c3.jpg', 'fe8d5390-2bf4-4273-a413-fac2a05020f3.jpg', '2fe4b8eb-ae79-4287-80d9-abeab4d2ca8e.jpg', '99ad11f7-d51b-464e-aa82-2327cd8c77c9.jpg', '러쉬', '울혼방', '한국', '두꺼움', '보통', '없음', '없음', '2023-02-26 00:00:00'),
	(623, '라브린 A라인 미니 나시 원피스', '드라이만 해주세요', '400', '401', 53000, 0, 0, 477, 0, 0, 3, 0, 0, '56cc0354-8a70-42f1-a7c8-93aafc73af17.jpg', '1d02320c-aa19-4972-bca3-b6638d623828.jpg', '1ba12fd0-0e81-4596-9754-bd04d613cd68.jpg', '44deb2a1-b5c7-4b33-8470-4ef4e5e10c76.jpg', '9cdafaff-7d89-4d6f-a7f7-10cc2605c0c6.jpg', 'a5c16b81-66ae-471e-9c00-6addc7ba4cae.jpg', '120643ec-2e40-4573-bebf-64fb7eac6772.png', 'ef4e6d4c-3063-4da3-b349-3c010c0839b1.png', 'e633c963-709e-4f88-9375-866d6d3fac64.jpg', '아르떼', '폴리', '한국', '얇음', '보통', '약간있음', '부분안감', '2023-03-22 00:00:00'),
	(624, '다이아 체크 배색 라운드 니트', '다이아 체크 배색 라운드 니트', '200', '202', 70000, 0, 0, 560, 0, 0, 1, 0, 0, '31c0cc3b-54ca-49e3-81ea-e1b63fb02c1b.jpg', '7d2c313f-b5c0-4b62-97c0-462f81623ebc.jpg', '83242bea-356f-4dd7-87c6-1fa6faec7e3a.jpg', 'cca70539-d617-4079-90a0-306ab7f8c8f0.jpg', '32971aec-d00f-4e8e-b688-7677b1a2f9be.jpg', '5f3e2dd1-6ce1-4ef4-92f7-9721feab9bea.jpg', '23b6508e-91d5-4cb2-91f1-9aa86d4e0dab.jpg', '27185403-0987-49d5-877b-686ea5d73975.jpg', '0fb2de8f-d50f-402b-8b1d-92dd9493d89c.jpg', '러쉬', '폴리', '한국', '보통', '보통', '없음', '없음', '2023-02-28 00:00:00'),
	(625, '세련된 무드의 벨트 세트 점프슈트 ', '손세탁 해주세요', '400', '403', 110000, 10, 11000, 770, 0, 0, 0, 0, 0, '1aab12e7-9716-4c7d-8543-045d9cfd6384.jpg', 'dbee454f-5ec2-4fb9-a9c4-fe603d4ca159.jpg', '8d497272-1aa2-4f57-b22a-3f6eb629e5bd.jpg', 'f3c7866a-c393-4e4e-920d-c8377dbe673d.jpg', 'a9afd927-89af-4219-b77b-c4a4c811bbe5.jpg', '4d12b70d-0f5f-49e2-8bcb-18c209ebda81.jpg', 'df86d68f-2eaa-48a9-a7d3-8ad0c2da95c1.jpg', '321f5f3f-0f39-49ed-86e1-47662f3904ff.jpg', '92bc48ac-7e21-4f50-ba38-f003e051c856.jpg', '아뜨랑스', '폴리', '한국', '보통', '보통', '없음', '부분안감', '2023-03-12 00:00:00'),
	(626, '하이퀄리티로 제작된 금장 벨트 세트 더블 케이프 숏 점프슈트', '드라이만 해주세요', '400', '403', 78000, 10, 7800, 702, 0, 0, 0, 0, 0, 'e9e68ac1-3b74-4e97-ad18-ae5f94432977.jpg', '11362cea-4b28-4bc1-8c87-c7cbf2b19808.jpg', 'e5cb8fab-5605-4dfa-8474-5897fb5b6c68.jpg', '9fe121e9-b2f0-45c9-bee9-b2b4f7c41e47.jpg', '45f4da03-8615-4d52-9201-9ef2ab243cf3.jpg', '2659d719-5d32-4823-a737-79a793215d63.jpg', 'a8a42c98-ad23-41a1-9dd1-4377e3d26f39.jpg', '7963b8a0-58a8-4989-ae28-9da0a85cbc74.jpg', '4a97ea49-e0c7-476a-90dc-cf4890f162da.jpg', '아뜨랑스', '폴리,스판', '한국', '얇음', '좋음', '없음', '부분안감', '2023-02-26 00:00:00'),
	(627, '롱 랩스커트 치마 롱플레어 패턴롱 스커트 여름여행', '롱 랩스커트 치마 롱플레어 패턴롱 스커트 여름여행', '300', '301', 18500, 0, 0, 81, 0, 0, 0, 0, 0, '55d03df0-6a0b-4f31-be0e-ac6f08891761.jpg', '618f0061-4a3f-4528-b6a3-6d90736b4710.jpg', '524f9dd8-6081-4e79-ad7d-7beff68a4ca5.jpg', '70f136c9-692a-4ec2-9c44-388c67a6581e.jpg', 'f9368ab7-41c7-4f25-bb87-77bf029c5f7d.jpg', '40804b15-6ac7-4e18-a99f-861e5add4651.jpg', '67fc83a7-ba0f-48be-95e2-9a2014123ed0.jpg', '8013151f-1c1a-478e-b6c5-60f24de12776.jpg', '82d7c683-3142-4211-9df8-4f88c9f0943d.jpg', '러쉬', '폴리', '한국', '얇음', '없음', '없음', '부분안감', '2023-02-28 00:00:00'),
	(628, '와이드한 퍼프소매와 벨트세트 구성의 미니 점프수트', '손세탁 해주세요', '400', '403', 78000, 10, 7800, 702, 0, 0, 0, 0, 0, 'dae78b6d-f250-45c6-826d-c0546350f1a7.jpg', '0f9a8f4e-9e9a-4ed8-9c51-e8a4e7caa30f.jpg', 'bbc346a8-0c9f-4ca7-89c7-ace7d767b555.jpg', '693a1044-9df6-4f96-a614-627a3859d102.jpg', '6ea40390-97c6-48a6-a16d-5d6ef877da53.jpg', '5aa299fa-1d34-491a-9da6-7bd438ca577b.jpg', '7832f537-294f-417a-b204-13ca6ad5edf4.png', '1260045e-10ca-4b7c-a51b-597a4da7e7fa.png', 'd7a499ea-d141-4c77-88e3-e03c9466032e.jpg', '아뜨랑스', '폴리', '한국', '보통', '없음', '없음', '부분안감', '2023-03-04 00:00:00'),
	(629, '스페셜한 무드의 언발 플리츠 카라V넥 뒷밴딩 점프수트', '손세탁 해주세요', '400', '403', 87000, 10, 8700, 696, 0, 0, 0, 0, 0, '75db5398-79d4-4e3d-8c55-32bf687a755c.jpg', '28e08013-0c88-478b-9813-bdc2217d52b4.jpg', 'e8ce7021-4ad0-4aec-883b-2439431088cf.jpg', '7ffa150a-e79f-47b6-bf2c-c067e2263396.jpg', 'e1560f8c-5560-45de-b733-d5376845c184.jpg', 'c37097ff-8cf6-4145-95a1-97d51f28c3e4.jpg', '2ed36ee0-ec71-4967-a704-67db67f4f87c.png', '85db07db-0d07-408a-9f6b-5f18ad4a14a6.png', 'd07a8541-d901-4985-a3d5-c5d5feba74aa.png', '아뜨랑스', '폴리', '한국', '보통', '보통', '없음', '부분안감', '2023-03-03 00:00:00'),
	(630, '니실레 플레어 스커트', '니실레 플레어 스커트', '300', '301', 39800, 0, 0, 387, 0, 0, 2, 0, 0, 'a2317199-eaa5-4f3e-8fb5-68a782b751f3.jpg', '1af53bb5-5a2d-41f7-96fe-57d25086a1b5.jpg', 'e74be36b-47da-4d83-affe-3773a2f4666b.jpg', '7a3498c7-ae19-49bc-80b5-2fb6ea8f3d1f.jpg', '79553010-e7cf-4fbf-b29f-29cbacb6bed6.jpg', '72f6ee6e-b5d8-4ceb-b55a-b20485d9acf3.jpg', '67ed1e01-7dfe-4834-a33f-61f9ad345589.jpg', '4fa76c91-d5db-47ce-ba4f-60e9713d2cd2.jpg', '2f81eb43-dd81-414b-9a8d-893f99e525c2.jpg', '러쉬', '폴리', '한국', '얇음', '보통', '약간있음', '부분안감', '2023-03-01 00:00:00'),
	(631, '시스루 오픈 슬리브 테일러드 카라 미니 점프수트', '드라이만 해주세요', '400', '403', 90000, 10, 9000, 810, 0, 0, 0, 0, 0, '903e3e6d-3618-4298-9483-4b13cb837253.jpg', '4388dc81-14f8-4afb-8c01-70a76138cd57.jpg', 'f96266ea-9084-4770-be88-0f100935f0b9.jpg', 'bcfd60e3-8def-4342-8e75-e57a71c39459.jpg', '91812559-9742-479b-a208-5cb7031d3fb4.jpg', '376f15a7-1074-442e-b4c6-a7b84546de33.jpg', '397b85fc-4e71-48e0-90e1-2fa1a4417e33.jpg', '2d6bb3a0-2cd4-4f22-8a46-1602af1fcb0c.jpg', '7454ed21-5b1f-4844-9c81-8370b18fafb9.jpg', '아뜨랑스', '폴리,스판', '한국', '얇음', '없음', '없음', '부분안감', '2023-03-04 00:00:00'),
	(632, '르블랑페이우 23SS 벨라 샤 스커트', '르블랑페이우 23SS 벨라 샤 스커트', '300', '301', 72000, 0, 0, 663, 0, 0, 1, 0, 0, 'daf920b7-c9d3-4d3d-a834-9d67f7ef1f02.jpg', '3c1ba5de-97bf-4057-bddb-250444212b38.jpg', '6eae05d1-bc29-4cd1-a9aa-698bb0a66aef.jpg', '869018f2-8d37-4e08-b4e3-b68547c95fe7.jpg', 'bf4e13b0-1898-4ee0-aeba-fc1ac664fbb5.jpg', '52c35404-b700-46f1-9069-31e9fab96ce2.jpg', '7119fe89-ef0e-43e9-8286-660ca741416e.jpg', '522af436-2045-403d-948f-6eeb35ab342f.jpg', '03c467cc-a547-4f03-af26-a5665fdb71b4.jpg', '러쉬', '폴리', '한국', '보통', '없음', '없음', '부분안감', '2023-02-27 00:00:00'),
	(633, '꾸안꾸 무드의 프릴서스펜더로 포인트를 준 와이드핏 데일리 점프슈트', '손세탁 해주세요', '400', '403', 25000, 0, 0, 235, 0, 0, 2, 0, 0, 'cf44fe69-9ee1-4a7d-a910-4d70ed8661fe.jpg', '4b3a4302-9b80-49e5-b4ab-24a38fc858e1.jpg', '393ea1f2-27c4-4aa9-84cc-ccb9c4a08ac9.jpg', 'c73f46fe-68b1-4763-98b8-1942d0d12843.jpg', 'c5845954-8d54-4222-80ea-648e0c4f7141.jpg', 'ad5a0541-c08a-4aa7-91b4-945aeebfb239.jpg', '30929ed6-5d8b-47fb-93cd-4a8e0f44a4db.jpg', 'a1b7239a-8b14-4521-bc70-3ac3806c0acc.jpg', 'dda7513b-76c4-4b59-a42e-bbbbbb580050.jpg', '아뜨랑스', '폴리,스판', '한국', '보통', '좋음', '없음', '부분안감', '2023-03-09 00:00:00'),
	(634, '멜버른 하이퀄리티 오버롤 팬츠 벚꽃룩', '손세탁 해주세요', '400', '403', 105000, 10, 10500, 945, 0, 0, 6, 0, 0, 'eed887f5-decf-4de8-a6e9-9697d7213a0f.jpg', '3f18a469-ed0e-4c31-ad1c-deef87594f08.jpg', '7e7492d7-3075-4f41-86b6-00dc1bd53012.jpg', '8878331f-fbf4-488d-8e41-9500914f4bc3.jpg', '8e9486bd-2fec-451f-b69a-db9c829a5c31.jpg', '6c19c3cd-9e6a-46b7-a615-d88edd422e61.jpg', 'b17bf6f3-2feb-4a6d-ad4a-dcf623b91b02.png', '5fb122dc-2f33-4db1-b71c-0f4ae7d80ebd.png', '48e7ad20-1eb5-45cd-aeb7-c9f7710eb351.png', '아뜨랑스', '면,코튼', '한국', '보통', '보통', '없음', '부분안감', '2023-03-03 00:00:00'),
	(635, '에디티드 EDITED 튤 스커트 1종', '에디티드 EDITED 튤 스커트 1종', '300', '301', 50000, 0, 0, 380, 0, 0, 0, 0, 0, '3455d11d-d50b-427a-9fd8-4bd2556f2463.jpg', 'dca0c3db-56f5-48ce-8a8a-2febb32630a2.jpg', '65a819f1-4381-43f4-b8fe-a79f75b3c9f3.jpg', 'a2ca1aa7-4fd6-4a9a-a4cb-39736fe9c33c.jpg', '66dd96c3-837b-43a0-8edd-1390a396deb1.jpg', '91336944-4fc4-4dea-b320-9cab918b765e.jpg', 'c5fcf963-0aeb-4017-be4a-5cc30d6e0d24.jpg', '7629957c-6d76-4122-bb52-5e1cd5c3ab22.jpg', '18bb354a-6314-48ff-b02a-d52ec67072dd.jpg', '러쉬', '폴리', '한국', '보통', NULL, NULL, NULL, '2023-02-27 00:00:00'),
	(636, '론드 멜빵 와이드 오버롤 팬츠', '손세탁 해주세요', '400', '403', 89000, 10, 8900, 712, 0, 0, 3, 0, 0, '6ffaa2b4-f5a2-4144-b183-3cfcad3ca939.jpg', 'e343abfd-eb42-4931-a938-a98705675064.jpg', '300a6261-243b-4120-a121-780bc4ae2702.jpg', '8438056f-327f-4239-951a-e10a1edcde8f.jpg', '212bbaf7-5bc7-4340-9da7-c0e2d497c085.jpg', '23311376-5544-4541-b4f9-37bbc3ee772f.jpg', '05e44903-7cb0-4625-ab33-c85ddfbfa43e.png', '4f2d9eee-a680-495b-b9b3-2d226821b803.png', '7e9f6d1b-f39e-46bf-a0d8-710463f3f3e0.png', '아뜨랑스', '면,코튼', '한국', '보통', '보통', '없음', '부분안감', '2023-03-07 00:00:00');

-- 테이블 beauty.product_option 구조 내보내기
CREATE TABLE IF NOT EXISTS `product_option` (
  `prodNo` int(11) NOT NULL,
  `color` char(10) NOT NULL,
  `colorName` char(10) DEFAULT NULL,
  `size` char(4) DEFAULT NULL,
  `sold` int(11) DEFAULT NULL,
  KEY `FK_colorcode_product` (`prodNo`),
  CONSTRAINT `FK_colorcode_product` FOREIGN KEY (`prodNo`) REFERENCES `product` (`prodNo`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 beauty.product_option:~269 rows (대략적) 내보내기
INSERT INTO `product_option` (`prodNo`, `color`, `colorName`, `size`, `sold`) VALUES
	(580, '#000000', '블랙', 'FREE', 50),
	(580, '#000000', '블랙', 'S', 50),
	(580, '#000000', '블랙', 'M', 50),
	(580, '#000080', '네이비', 'FREE', 50),
	(580, '#000080', '네이비', 'S', 50),
	(580, '#000080', '네이비', 'M', 50),
	(588, '#000000', '블랙', 'S', 50),
	(588, '#000000', '블랙', 'M', 50),
	(588, '#000000', '블랙', 'L', 50),
	(588, '#000080', '네이비', 'S', 50),
	(588, '#000080', '네이비', 'M', 50),
	(588, '#000080', '네이비', 'L', 50),
	(588, '#a9a9a9', '다크그레이', 'S', 50),
	(588, '#a9a9a9', '다크그레이', 'M', 50),
	(588, '#a9a9a9', '다크그레이', 'L', 50),
	(588, '#fffff0', '아이보리', 'S', 50),
	(588, '#fffff0', '아이보리', 'M', 50),
	(588, '#fffff0', '아이보리', 'L', 50),
	(589, '#a9a9a9', '다크그레이', 'S', 50),
	(589, '#a9a9a9', '다크그레이', 'M', 50),
	(589, '#fffff0', '아이보리', 'S', 50),
	(589, '#fffff0', '아이보리', 'M', 50),
	(589, '#ffffff', '화이트', 'S', 50),
	(589, '#ffffff', '화이트', 'M', 50),
	(590, '#000000', '블랙', 'FREE', 50),
	(590, '#a9a9a9', '다크그레이', 'FREE', 50),
	(590, '#f5f5dc', '베이지', 'FREE', 50),
	(591, '#000000', '블랙', 'S', 50),
	(591, '#000000', '블랙', 'M', 50),
	(591, '#000080', '네이비', 'S', 50),
	(591, '#000080', '네이비', 'M', 50),
	(591, '#ffc0cb', '핑크', 'S', 50),
	(591, '#ffc0cb', '핑크', 'M', 50),
	(592, '#000000', '블랙', 'S', 50),
	(592, '#000000', '블랙', 'M', 50),
	(592, '#000000', '블랙', 'L', 50),
	(592, '#000080', '네이비', 'S', 50),
	(592, '#000080', '네이비', 'M', 50),
	(592, '#000080', '네이비', 'L', 50),
	(592, '#a9a9a9', '다크그레이', 'S', 50),
	(592, '#a9a9a9', '다크그레이', 'M', 50),
	(592, '#a9a9a9', '다크그레이', 'L', 50),
	(593, '#000000', '블랙', 'S', 50),
	(593, '#000000', '블랙', 'M', 50),
	(593, '#000000', '블랙', 'L', 50),
	(593, '#000080', '네이비', 'S', 50),
	(593, '#000080', '네이비', 'M', 50),
	(593, '#000080', '네이비', 'L', 50),
	(594, '#000000', '블랙', 'FREE', 50),
	(594, '#a9a9a9', '다크그레이', 'FREE', 50),
	(595, '#000000', '블랙', 'FREE', 50),
	(595, '#000000', '블랙', 'L', 50),
	(595, '#d3d3d3', '라이트그레이', 'FREE', 50),
	(595, '#d3d3d3', '라이트그레이', 'L', 50),
	(595, '#800080', '퍼플', 'FREE', 50),
	(595, '#800080', '퍼플', 'L', 50),
	(595, '#f5f5dc', '베이지', 'FREE', 50),
	(595, '#f5f5dc', '베이지', 'L', 50),
	(596, '#000000', '블랙', 'S', 50),
	(596, '#000000', '블랙', 'M', 50),
	(596, '#a9a9a9', '다크그레이', 'S', 50),
	(596, '#a9a9a9', '다크그레이', 'M', 50),
	(596, '#ffd700', '골드', 'S', 50),
	(596, '#ffd700', '골드', 'M', 50),
	(596, '#a52a2a', '브라운', 'S', 50),
	(596, '#a52a2a', '브라운', 'M', 50),
	(597, '#fffff0', '아이보리', 'S', 50),
	(597, '#fffff0', '아이보리', 'M', 50),
	(597, '#ffffff', '화이트', 'S', 50),
	(597, '#ffffff', '화이트', 'M', 50),
	(598, '#000000', '블랙', 'S', 50),
	(598, '#000000', '블랙', 'M', 50),
	(598, '#000000', '블랙', 'L', 50),
	(598, '#87ceeb', '스카이블루', 'S', 50),
	(598, '#87ceeb', '스카이블루', 'M', 50),
	(598, '#87ceeb', '스카이블루', 'L', 50),
	(598, '#f5f5dc', '베이지', 'S', 50),
	(598, '#f5f5dc', '베이지', 'M', 50),
	(598, '#f5f5dc', '베이지', 'L', 50),
	(599, '#f5f5dc', '베이지', 'S', 50),
	(599, '#f5f5dc', '베이지', 'M', 50),
	(599, '#f5f5dc', '베이지', 'L', 50),
	(599, '#fffff0', '아이보리', 'S', 50),
	(599, '#fffff0', '아이보리', 'M', 50),
	(599, '#fffff0', '아이보리', 'L', 50),
	(599, '#c0c0c0', '실버', 'S', 50),
	(599, '#c0c0c0', '실버', 'M', 50),
	(599, '#c0c0c0', '실버', 'L', 50),
	(599, '#ffffff', '화이트', 'S', 50),
	(599, '#ffffff', '화이트', 'M', 50),
	(599, '#ffffff', '화이트', 'L', 50),
	(600, '#000000', '블랙', 'FREE', 50),
	(600, '#000000', '블랙', 'L', 50),
	(600, '#ff7f50', '코랄', 'FREE', 50),
	(600, '#ff7f50', '코랄', 'L', 50),
	(601, '#000000', '블랙', 'S', 50),
	(601, '#000000', '블랙', 'M', 50),
	(601, '#000000', '블랙', 'L', 50),
	(601, '#ffb6c1', '라이트핑크', 'S', 50),
	(601, '#ffb6c1', '라이트핑크', 'M', 50),
	(601, '#ffb6c1', '라이트핑크', 'L', 50),
	(601, '#ffffff', '화이트', 'S', 50),
	(601, '#ffffff', '화이트', 'M', 50),
	(601, '#ffffff', '화이트', 'L', 50),
	(602, '#000000', '블랙', 'S', 50),
	(602, '#000000', '블랙', 'M', 50),
	(602, '#000000', '블랙', 'L', 50),
	(602, '#f5f5dc', '베이지', 'S', 50),
	(602, '#f5f5dc', '베이지', 'M', 50),
	(602, '#f5f5dc', '베이지', 'L', 50),
	(603, '#000000', '블랙', 'FREE', 50),
	(603, '#000000', '블랙', 'L', 50),
	(603, '#ffd700', '골드', 'FREE', 50),
	(603, '#ffd700', '골드', 'L', 50),
	(603, '#f5f5dc', '베이지', 'FREE', 50),
	(603, '#f5f5dc', '베이지', 'L', 50),
	(605, '#000000', '블랙', 'S', 50),
	(605, '#000000', '블랙', 'M', 50),
	(605, '#000000', '블랙', 'L', 50),
	(605, '#e6e6fa', '라벤더', 'S', 50),
	(605, '#e6e6fa', '라벤더', 'M', 50),
	(605, '#e6e6fa', '라벤더', 'L', 50),
	(605, '#f5f5dc', '베이지', 'S', 50),
	(605, '#f5f5dc', '베이지', 'M', 50),
	(605, '#f5f5dc', '베이지', 'L', 50),
	(605, '#fffff0', '아이보리', 'S', 50),
	(605, '#fffff0', '아이보리', 'M', 50),
	(605, '#fffff0', '아이보리', 'L', 50),
	(606, '#000000', '블랙', 'S', 50),
	(606, '#000000', '블랙', 'M', 50),
	(606, '#000000', '블랙', 'L', 50),
	(606, '#ffd700', '골드', 'S', 50),
	(606, '#ffd700', '골드', 'M', 50),
	(606, '#ffd700', '골드', 'L', 50),
	(607, '#000000', '블랙', 'S', 50),
	(607, '#000000', '블랙', 'M', 50),
	(607, '#000000', '블랙', 'L', 50),
	(607, '#ffc0cb', '핑크', 'S', 50),
	(607, '#ffc0cb', '핑크', 'M', 50),
	(607, '#ffc0cb', '핑크', 'L', 50),
	(607, '#fffff0', '아이보리', 'S', 50),
	(607, '#fffff0', '아이보리', 'M', 50),
	(607, '#fffff0', '아이보리', 'L', 50),
	(608, '#000000', '블랙', 'S', 50),
	(608, '#000000', '블랙', 'M', 50),
	(608, '#000000', '블랙', 'L', 50),
	(608, '#ffc0cb', '핑크', 'S', 50),
	(608, '#ffc0cb', '핑크', 'M', 50),
	(608, '#ffc0cb', '핑크', 'L', 50),
	(608, '#f5f5dc', '베이지', 'S', 50),
	(608, '#f5f5dc', '베이지', 'M', 50),
	(608, '#f5f5dc', '베이지', 'L', 50),
	(608, '#fffff0', '아이보리', 'S', 50),
	(608, '#fffff0', '아이보리', 'M', 50),
	(608, '#fffff0', '아이보리', 'L', 50),
	(609, '#0000ff', '블루', 'S', 50),
	(609, '#0000ff', '블루', 'M', 50),
	(609, '#ffc0cb', '핑크', 'S', 50),
	(609, '#ffc0cb', '핑크', 'M', 50),
	(609, '#fffff0', '아이보리', 'S', 50),
	(609, '#fffff0', '아이보리', 'M', 50),
	(610, '#000000', '블랙', 'S', 50),
	(610, '#000000', '블랙', 'L', 50),
	(610, '#87ceeb', '스카이블루', 'S', 50),
	(610, '#87ceeb', '스카이블루', 'L', 50),
	(610, '#f0e68c', '카키', 'S', 50),
	(610, '#f0e68c', '카키', 'L', 50),
	(610, '#f5f5dc', '베이지', 'S', 50),
	(610, '#f5f5dc', '베이지', 'L', 50),
	(610, '#fffff0', '아이보리', 'S', 50),
	(610, '#fffff0', '아이보리', 'L', 50),
	(611, '#000000', '블랙', 'S', 50),
	(611, '#000000', '블랙', 'M', 50),
	(611, '#ffb6c1', '라이트핑크', 'S', 50),
	(611, '#ffb6c1', '라이트핑크', 'M', 50),
	(611, '#ffff00', '옐로우', 'S', 50),
	(611, '#ffff00', '옐로우', 'M', 50),
	(612, '#000000', '블랙', 'S', 50),
	(612, '#000000', '블랙', 'M', 50),
	(612, '#e6e6fa', '라벤더', 'S', 50),
	(612, '#e6e6fa', '라벤더', 'M', 50),
	(613, '#000000', '블랙', 'S', 50),
	(613, '#000000', '블랙', 'M', 50),
	(613, '#f5f5dc', '베이지', 'S', 50),
	(613, '#f5f5dc', '베이지', 'M', 50),
	(614, '#000000', '블랙', 'S', 50),
	(614, '#000000', '블랙', 'M', 50),
	(614, '#ffc0cb', '핑크', 'S', 50),
	(614, '#ffc0cb', '핑크', 'M', 50),
	(615, '#000000', '블랙', 'FREE', 50),
	(615, '#808080', '그레이', 'FREE', 50),
	(615, '#ffc0cb', '핑크', 'FREE', 50),
	(615, '#fffff0', '아이보리', 'FREE', 50),
	(616, '#000080', '네이비', 'FREE', 50),
	(616, '#808080', '그레이', 'FREE', 50),
	(616, '#ffff00', '옐로우', 'FREE', 50),
	(617, '#0000ff', '블루', 'S', 50),
	(617, '#0000ff', '블루', 'M', 50),
	(618, '#000000', '블랙', 'S', 50),
	(618, '#000000', '블랙', 'M', 50),
	(618, '#000000', '블랙', 'L', 50),
	(618, '#ffff00', '옐로우', 'S', 50),
	(618, '#ffff00', '옐로우', 'M', 50),
	(618, '#ffff00', '옐로우', 'L', 50),
	(618, '#e6e6fa', '라벤더', 'S', 50),
	(618, '#e6e6fa', '라벤더', 'M', 50),
	(618, '#e6e6fa', '라벤더', 'L', 50),
	(619, '#000000', '블랙', 'S', 50),
	(619, '#000000', '블랙', 'M', 50),
	(619, '#000000', '블랙', 'L', 50),
	(619, '#f5f5dc', '베이지', 'S', 50),
	(619, '#f5f5dc', '베이지', 'M', 50),
	(619, '#f5f5dc', '베이지', 'L', 50),
	(620, '#000000', '블랙', 'S', 50),
	(620, '#000000', '블랙', 'M', 50),
	(620, '#000000', '블랙', 'L', 50),
	(620, '#0000ff', '블루', 'S', 50),
	(620, '#0000ff', '블루', 'M', 50),
	(620, '#0000ff', '블루', 'L', 50),
	(620, '#fffff0', '아이보리', 'S', 50),
	(620, '#fffff0', '아이보리', 'M', 50),
	(620, '#fffff0', '아이보리', 'L', 50),
	(621, '#000000', '블랙', 'FREE', 50),
	(621, '#e6e6fa', '라벤더', 'FREE', 50),
	(621, '#f5f5dc', '베이지', 'FREE', 50),
	(621, '#fffff0', '아이보리', 'FREE', 50),
	(622, '#000080', '네이비', 'S', 50),
	(622, '#000080', '네이비', 'M', 50),
	(622, '#000080', '네이비', 'L', 50),
	(622, '#fffff0', '아이보리', 'S', 50),
	(622, '#fffff0', '아이보리', 'M', 50),
	(622, '#fffff0', '아이보리', 'L', 50),
	(623, '#000000', '블랙', 'S', 50),
	(623, '#000000', '블랙', 'M', 50),
	(623, '#f5f5dc', '베이지', 'S', 50),
	(623, '#f5f5dc', '베이지', 'M', 50),
	(624, '#ffff00', '옐로우', 'FREE', 50),
	(624, '#ee82ee', '바이올렛', 'FREE', 50),
	(625, '#000000', '블랙', 'FREE', 50),
	(625, '#ffc0cb', '핑크', 'FREE', 50),
	(625, '#a52a2a', '브라운', 'FREE', 50),
	(626, '#000000', '블랙', 'FREE', 50),
	(626, '#f5f5dc', '베이지', 'FREE', 50),
	(627, '#000000', '블랙', 'FREE', 50),
	(627, '#008000', '그린', 'FREE', 50),
	(627, '#fffff0', '아이보리', 'FREE', 50),
	(628, '#000000', '블랙', 'FREE', 50),
	(628, '#f5f5dc', '베이지', 'FREE', 50),
	(629, '#000000', '블랙', 'FREE', 50),
	(629, '#0000ff', '블루', 'FREE', 50),
	(629, '#f5f5dc', '베이지', 'FREE', 50),
	(630, '#ff69b4', '핫핑크', 'FREE', 50),
	(630, '#ffffff', '화이트', 'FREE', 50),
	(631, '#000000', '블랙', 'FREE', 50),
	(631, '#ffc0cb', '핑크', 'FREE', 50),
	(632, '#000000', '블랙', 'FREE', 50),
	(632, '#ff7f50', '코랄', 'FREE', 50),
	(633, '#000000', '블랙', 'FREE', 50),
	(633, '#f5f5dc', '베이지', 'FREE', 50),
	(634, '#000000', '블랙', 'FREE', 50),
	(634, '#f5f5dc', '베이지', 'FREE', 50),
	(634, '#fffff0', '아이보리', 'FREE', 50),
	(635, '#000000', '블랙', 'S', 50),
	(635, '#000000', '블랙', 'M', 50),
	(635, '#000000', '블랙', 'L', 50),
	(635, '#000000', '블랙', 'XL', 50),
	(635, '#f5f5dc', '베이지', 'S', 50),
	(635, '#f5f5dc', '베이지', 'M', 50),
	(635, '#f5f5dc', '베이지', 'L', 50),
	(635, '#f5f5dc', '베이지', 'XL', 50),
	(636, '#000000', '블랙', 'FREE', 50),
	(636, '#f5f5dc', '베이지', 'FREE', 50),
	(636, '#fffff0', '아이보리', 'FREE', 50);

-- 테이블 beauty.reply 구조 내보내기
CREATE TABLE IF NOT EXISTS `reply` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `prodNo` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` varchar(255) NOT NULL,
  `rating` int(11) NOT NULL DEFAULT '0',
  `height` int(11) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `color` varchar(45) NOT NULL,
  `size` varchar(45) NOT NULL,
  `thumb1` varchar(255) NOT NULL,
  `rdate` datetime NOT NULL,
  PRIMARY KEY (`no`),
  KEY `fk_Reply_Product1_idx` (`prodNo`),
  CONSTRAINT `fk_Reply_Product1` FOREIGN KEY (`prodNo`) REFERENCES `product` (`prodNo`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 beauty.reply:~0 rows (대략적) 내보내기

-- 테이블 beauty.terms 구조 내보내기
CREATE TABLE IF NOT EXISTS `terms` (
  `terms` text,
  `privacy` text,
  `location` text,
  `nonmember` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 beauty.terms:~1 rows (대략적) 내보내기
INSERT INTO `terms` (`terms`, `privacy`, `location`, `nonmember`) VALUES
	('제1조(목적)\r\n이 약관은 (전자상거래 사업자)가 운영하는 슬로우앤드(이하 “몰”이라 한다)에서 제공하는 인터넷 관련 서비스(이하 “서비스”라 한다)를 이용함에 있어 사이버 몰과 이용자의 권리․의무 및 책임사항을 규정함을 목적으로 합니다.\r\n※「PC통신, 무선 등을 이용하는 전자상거래에 대해서도 그 성질에 반하지 않는 한 이 약관을 준용합니다.」\r\n\r\n제2조(정의)\r\n① “몰”이란 슬로우앤드가 재화 또는 용역(이하 “재화 등”이라 함)을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 등을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 사이버몰을 운영하는 사업자의 의미로도 사용합니다.\r\n② “이용자”란 “몰”에 접속하여 이 약관에 따라 “몰”이 제공하는 서비스를 받는 회원 및 비회원을 말합니다.\r\n③ ‘회원’이라 함은 “몰”에 (삭제) 회원등록을 한 자로서, 계속적으로 “몰”이 제공하는 서비스를 이용할 수 있는 자를 말합니다.\r\n④ ‘비회원’이라 함은 회원에 가입하지 않고 “몰”이 제공하는 서비스를 이용하는 자를 말합니다.\r\n\r\n제3조 (약관 등의 명시와 설명 및 개정)\r\n① “몰”은 이 약관의 내용과 상호 및 대표자 성명, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 전화번호․모사전송번호․전자우편주소, 사업자등록번호, 통신판매업 신고번호, 개인정보관리책임자등을 이용자가 쉽게 알 수 있도록 00 사이버몰의 초기 서비스화면(전면)에 게시합니다. 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다.\r\n② “몰은 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회․배송책임․환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다.\r\n③ “몰”은 「전자상거래 등에서의 소비자보호에 관한 법률」, 「약관의 규제에 관한 법률」, 「전자문서 및 전자거래기본법」, 「전자금융거래법」, 「전자서명법」, 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」, 「방문판매 등에 관한 법률」, 「소비자기본법」 등 관련 법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.\r\n④ “몰”이 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 몰의 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다. 이 경우 "몰“은 개정 전 내용과 개정 후 내용을 명확하게 비교하여 이용자가 알기 쉽도록 표시합니다.\r\n⑤ “몰”이 약관을 개정할 경우에는 그 개정약관은 그 적용일자 이후에 체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정 전의 약관조항이 그대로 적용됩니다. 다만 이미 계약을 체결한 이용자가 개정약관 조항의 적용을 받기를 원하는 뜻을 제3항에 의한 개정약관의 공지기간 내에 “몰”에 송신하여 “몰”의 동의를 받은 경우에는 개정약관 조항이 적용됩니다.\r\n⑥ 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 전자상거래 등에서의 소비자보호에 관한 법률, 약관의 규제 등에 관한 법률, 공정거래위원회가 정하는 전자상거래 등에서의 소비자 보호지침 및 관계법령 또는 상관례에 따릅니다.\r\n\r\n제4조(서비스의 제공 및 변경)\r\n① “몰”은 다음과 같은 업무를 수행합니다.\r\n  1. 재화 또는 용역에 대한 정보 제공 및 구매계약의 체결\r\n  2. 구매계약이 체결된 재화 또는 용역의 배송\r\n  3. 기타 “몰”이 정하는 업무\r\n② “몰”은 재화 또는 용역의 품절 또는 기술적 사양의 변경 등의 경우에는 장차 체결되는 계약에 의해 제공할 재화 또는 용역의 내용을 변경할 수 있습니다. 이 경우에는 변경된 재화 또는 용역의 내용 및 제공일자를 명시하여 현재의 재화 또는 용역의 내용을 게시한 곳에 즉시 공지합니다.\r\n③ “몰”이 제공하기로 이용자와 계약을 체결한 서비스의 내용을 재화등의 품절 또는 기술적 사양의 변경 등의 사유로 변경할 경우에는 그 사유를 이용자에게 통지 가능한 주소로 즉시 통지합니다.\r\n④ 전항의 경우 “몰”은 이로 인하여 이용자가 입은 손해를 배상합니다. 다만, “몰”이 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.\r\n\r\n제5조(서비스의 중단)\r\n① “몰”은 컴퓨터 등 정보통신설비의 보수점검․교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다.\r\n② “몰”은 제1항의 사유로 서비스의 제공이 일시적으로 중단됨으로 인하여 이용자 또는 제3자가 입은 손해에 대하여 배상합니다. 단, “몰”이 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.\r\n③ 사업종목의 전환, 사업의 포기, 업체 간의 통합 등의 이유로 서비스를 제공할 수 없게 되는 경우에는 “몰”은 제8조에 정한 방법으로 이용자에게 통지하고 당초 “몰”에서 제시한 조건에 따라 소비자에게 보상합니다. 다만, “몰”이 보상기준 등을 고지하지 아니한 경우에는 이용자들의 마일리지 또는 적립금 등을 “몰”에서 통용되는 통화가치에 상응하는 현물 또는 현금으로 이용자에게 지급합니다.\r\n\r\n제6조(회원가입)\r\n① 이용자는 “몰”이 정한 가입 양식에 따라 회원정보를 기입한 후 이 약관에 동의한다는 의사표시를 함으로서 회원가입을 신청합니다.\r\n② “몰”은 제1항과 같이 회원으로 가입할 것을 신청한 이용자 중 다음 각 호에 해당하지 않는 한 회원으로 등록합니다.\r\n  1. 가입신청자가 이 약관 제7조제3항에 의하여 이전에 회원자격을 상실한 적이 있는 경우, 다만 제7조제3항에 의한 회원자격 상실 후 3년이 경과한 자로서 “몰”의 회원재가입 승낙을 얻은 경우에는 예외로 한다.\r\n  2. 등록 내용에 허위, 기재누락, 오기가 있는 경우\r\n  3. 기타 회원으로 등록하는 것이 “몰”의 기술상 현저히 지장이 있다고 판단되는 경우\r\n③ 회원가입계약의 성립 시기는 “몰”의 승낙이 회원에게 도달한 시점으로 합니다.\r\n④ 회원은 회원가입 시 등록한 사항에 변경이 있는 경우, 상당한 기간 이내에 “몰”에 대하여 회원정보 수정 등의 방법으로 그 변경사항을 알려야 합니다.\r\n\r\n제7조(회원 탈퇴 및 자격 상실 등)\r\n① 회원은 “몰”에 언제든지 탈퇴를 요청할 수 있으며 “몰”은 즉시 회원탈퇴를 처리합니다.\r\n② 회원이 다음 각 호의 사유에 해당하는 경우, “몰”은 회원자격을 제한 및 정지시킬 수 있습니다.\r\n  1. 가입 신청 시에 허위 내용을 등록한 경우\r\n  2. “몰”을 이용하여 구입한 재화 등의 대금, 기타 “몰”이용에 관련하여 회원이 부담하는 채무를 기일에 지급하지 않는 경우\r\n  3. 다른 사람의 “몰” 이용을 방해하거나 그 정보를 도용하는 등 전자상거래 질서를 위협하는 경우\r\n  4. “몰”을 이용하여 법령 또는 이 약관이 금지하거나 공서양속에 반하는 행위를 하는 경우\r\n③ “몰”이 회원 자격을 제한․정지 시킨 후, 동일한 행위가 2회 이상 반복되거나 30일 이내에 그 사유가 시정되지 아니하는 경우 “몰”은 회원자격을 상실시킬 수 있습니다.\r\n④ “몰”이 회원자격을 상실시키는 경우에는 회원등록을 말소합니다. 이 경우 회원에게 이를 통지하고, 회원등록 말소 전에 최소한 30일 이상의 기간을 정하여 소명할 기회를 부여합니다.\r\n\r\n제8조(회원에 대한 통지)\r\n① “몰”이 회원에 대한 통지를 하는 경우, 회원이 “몰”과 미리 약정하여 지정한 전자우편 주소로 할 수 있습니다.\r\n② “몰”은 불특정다수 회원에 대한 통지의 경우 1주일이상 “몰” 게시판에 게시함으로서 개별 통지에 갈음할 수 있습니다. 다만, 회원 본인의 거래와 관련하여 중대한 영향을 미치는 사항에 대하여는 개별통지를 합니다.\r\n\r\n제9조(구매신청)\r\n① “몰”이용자는 “몰”상에서 다음 또는 이와 유사한 방법에 의하여 구매를 신청하며, “몰”은 이용자가 구매신청을 함에 있어서 다음의 각 내용을 알기 쉽게 제공하여야 합니다. (삭제)\r\n  1. 재화 등의 검색 및 선택\r\n  2. 받는 사람의 성명, 주소, 전화번호, 전자우편주소(또는 이동전화번호) 등의 입력\r\n  3. 약관내용, 청약철회권이 제한되는 서비스, 배송료․설치비 등의 비용부담과 관련한 내용에 대한 확인\r\n  4. 이 약관에 동의하고 위 3.호의 사항을 확인하거나 거부하는 표시(예, 마우스 클릭)\r\n  5. 재화등의 구매신청 및 이에 관한 확인 또는 “몰”의 확인에 대한 동의\r\n  6. 결제방법의 선택\r\n② “몰”이 제3자에게 구매자 개인정보를 제공•위탁할 필요가 있는 경우 실제 구매신청 시 구매자의 동의를 받아야 하며, 회원가입 시 미리 포괄적으로 동의를 받지 않습니다. 이 때 “몰”은 제공되는 개인정보 항목, 제공받는 자, 제공받는 자의 개인정보 이용 목적 및 보유‧이용 기간 등을 구매자에게 명시하여야 합니다. 다만 「정보통신망이용촉진 및 정보보호 등에 관한 법률」 제25조 제1항에 의한 개인정보 취급위탁의 경우 등 관련 법령에 달리 정함이 있는 경우에는 그에 따릅니다.\r\n\r\n제10조 (계약의 성립)\r\n① “몰”은 제9조와 같은 구매신청에 대하여 다음 각 호에 해당하면 승낙하지 않을 수 있습니다. 다만, 미성년자와 계약을 체결하는 경우에는 법정대리인의 동의를 얻지 못하면 미성년자 본인 또는 법정대리인이 계약을 취소할 수 있다는 내용을 고지하여야 합니다.\r\n  1. 신청 내용에 허위, 기재누락, 오기가 있는 경우\r\n  2. 미성년자가 담배, 주류 등 청소년보호법에서 금지하는 재화 및 용역을 구매하는 경우\r\n  3. 기타 구매신청에 승낙하는 것이 “몰” 기술상 현저히 지장이 있다고 판단하는 경우\r\n② “몰”의 승낙이 제12조제1항의 수신확인통지형태로 이용자에게 도달한 시점에 계약이 성립한 것으로 봅니다.\r\n③ “몰”의 승낙의 의사표시에는 이용자의 구매 신청에 대한 확인 및 판매가능 여부, 구매신청의 정정 취소 등에 관한 정보 등을 포함하여야 합니다.\r\n\r\n제11조(지급방법)\r\n“몰”에서 구매한 재화 또는 용역에 대한 대금지급방법은 다음 각 호의 방법중 가용한 방법으로 할 수 있습니다. 단, “몰”은 이용자의 지급방법에 대하여 재화 등의 대금에 어떠한 명목의 수수료도 추가하여 징수할 수 없습니다.\r\n1. 폰뱅킹, 인터넷뱅킹, 메일 뱅킹 등의 각종 계좌이체\r\n2. 선불카드, 직불카드, 신용카드 등의 각종 카드 결제\r\n3. 온라인무통장입금\r\n4. 전자화폐에 의한 결제\r\n5. 수령 시 대금지급\r\n6. 마일리지 등 “몰”이 지급한 포인트에 의한 결제\r\n7. “몰”과 계약을 맺었거나 “몰”이 인정한 상품권에 의한 결제\r\n8. 기타 전자적 지급 방법에 의한 대금 지급 등\r\n\r\n제12조(수신확인통지․구매신청 변경 및 취소)\r\n① “몰”은 이용자의 구매신청이 있는 경우 이용자에게 수신확인통지를 합니다.\r\n② 수신확인통지를 받은 이용자는 의사표시의 불일치 등이 있는 경우에는 수신확인통지를 받은 후 즉시 구매신청 변경 및 취소를 요청할 수 있고 “몰”은 배송 전에 이용자의 요청이 있는 경우에는 지체 없이 그 요청에 따라 처리하여야 합니다. 다만 이미 대금을 지불한 경우에는 제15조의 청약철회 등에 관한 규정에 따릅니다.\r\n\r\n제13조(재화 등의 공급)\r\n① “몰”은 이용자와 재화 등의 공급시기에 관하여 별도의 약정이 없는 이상, 이용자가 청약을 한 날부터 7일 이내에 재화 등을 배송할 수 있도록 주문제작, 포장 등 기타의 필요한 조치를 취합니다. 다만, “몰”이 이미 재화 등의 대금의 전부 또는 일부를 받은 경우에는 대금의 전부 또는 일부를 받은 날부터 3영업일 이내에 조치를 취합니다. 이때 “몰”은 이용자가 재화 등의 공급 절차 및 진행 사항을 확인할 수 있도록 적절한 조치를 합니다.\r\n② “몰”은 이용자가 구매한 재화에 대해 배송수단, 수단별 배송비용 부담자, 수단별 배송기간 등을 명시합니다. 만약 “몰”이 약정 배송기간을 초과한 경우에는 그로 인한 이용자의 손해를 배상하여야 합니다. 다만 “몰”이 고의․과실이 없음을 입증한 경우에는 그러하지 아니합니다.\r\n\r\n제14조(환급)\r\n“몰”은 이용자가 구매신청한 재화 등이 품절 등의 사유로 인도 또는 제공을 할 수 없을 때에는 지체 없이 그 사유를 이용자에게 통지하고 사전에 재화 등의 대금을 받은 경우에는 대금을 받은 날부터 3영업일 이내에 환급하거나 환급에 필요한 조치를 취합니다.\r\n\r\n제15조(청약철회 등)\r\n① “몰”과 재화등의 구매에 관한 계약을 체결한 이용자는 「전자상거래 등에서의 소비자보호에 관한 법률」 제13조 제2항에 따른 계약내용에 관한 서면을 받은 날(그 서면을 받은 때보다 재화 등의 공급이 늦게 이루어진 경우에는 재화 등을 공급받거나 재화 등의 공급이 시작된 날을 말합니다)부터 7일 이내에는 청약의 철회를 할 수 있습니다. 다만, 청약철회에 관하여 「전자상거래 등에서의 소비자보호에 관한 법률」에 달리 정함이 있는 경우에는 동 법 규정에 따릅니다.\r\n② 이용자는 재화 등을 배송 받은 경우 다음 각 호의 1에 해당하는 경우에는 반품 및 교환을 할 수 없습니다.\r\n  1. 이용자에게 책임 있는 사유로 재화 등이 멸실 또는 훼손된 경우(다만, 재화 등의 내용을 확인하기 위하여 포장 등을 훼손한 경우에는 청약철회를 할 수 있습니다)\r\n  2. 이용자의 사용 또는 일부 소비에 의하여 재화 등의 가치가 현저히 감소한 경우\r\n  3. 시간의 경과에 의하여 재판매가 곤란할 정도로 재화등의 가치가 현저히 감소한 경우\r\n  4. 같은 성능을 지닌 재화 등으로 복제가 가능한 경우 그 원본인 재화 등의 포장을 훼손한 경우\r\n③ 제2항제2호 내지 제4호의 경우에 “몰”이 사전에 청약철회 등이 제한되는 사실을 소비자가 쉽게 알 수 있는 곳에 명기하거나 시용상품을 제공하는 등의 조치를 하지 않았다면 이용자의 청약철회 등이 제한되지 않습니다.\r\n④ 이용자는 제1항 및 제2항의 규정에 불구하고 재화 등의 내용이 표시•광고 내용과 다르거나 계약내용과 다르게 이행된 때에는 당해 재화 등을 공급받은 날부터 3월 이내, 그 사실을 안 날 또는 알 수 있었던 날부터 30일 이내에 청약철회 등을 할 수 있습니다.\r\n\r\n제16조(청약철회 등의 효과)\r\n① “몰”은 이용자로부터 재화 등을 반환받은 경우 3영업일 이내에 이미 지급받은 재화 등의 대금을 환급합니다. 이 경우 “몰”이 이용자에게 재화등의 환급을 지연한때에는 그 지연기간에 대하여 「전자상거래 등에서의 소비자보호에 관한 법률 시행령」제21조의2에서 정하는 지연이자율(괄호 부분 삭제)을 곱하여 산정한 지연이자를 지급합니다.\r\n② “몰”은 위 대금을 환급함에 있어서 이용자가 신용카드 또는 전자화폐 등의 결제수단으로 재화 등의 대금을 지급한 때에는 지체 없이 당해 결제수단을 제공한 사업자로 하여금 재화 등의 대금의 청구를 정지 또는 취소하도록 요청합니다.\r\n③ 청약철회 등의 경우 공급받은 재화 등의 반환에 필요한 비용은 이용자가 부담합니다. “몰”은 이용자에게 청약철회 등을 이유로 위약금 또는 손해배상을 청구하지 않습니다. 다만 재화 등의 내용이 표시•광고 내용과 다르거나 계약내용과 다르게 이행되어 청약철회 등을 하는 경우 재화 등의 반환에 필요한 비용은 “몰”이 부담합니다.\r\n④ 이용자가 재화 등을 제공받을 때 발송비를 부담한 경우에 “몰”은 청약철회 시 그 비용을 누가 부담하는지를 이용자가 알기 쉽도록 명확하게 표시합니다.\r\n\r\n제17조(개인정보보호)\r\n① “몰”은 이용자의 개인정보 수집시 서비스제공을 위하여 필요한 범위에서 최소한의 개인정보를 수집합니다.\r\n② “몰”은 회원가입시 구매계약이행에 필요한 정보를 미리 수집하지 않습니다. 다만, 관련 법령상 의무이행을 위하여 구매계약 이전에 본인확인이 필요한 경우로서 최소한의 특정 개인정보를 수집하는 경우에는 그러하지 아니합니다.\r\n③ “몰”은 이용자의 개인정보를 수집•이용하는 때에는 당해 이용자에게 그 목적을 고지하고 동의를 받습니다.\r\n④ “몰”은 수집된 개인정보를 목적외의 용도로 이용할 수 없으며, 새로운 이용목적이 발생한 경우 또는 제3자에게 제공하는 경우에는 이용•제공단계에서 당해 이용자에게 그 목적을 고지하고 동의를 받습니다. 다만, 관련 법령에 달리 정함이 있는 경우에는 예외로 합니다.\r\n⑤ “몰”이 제2항과 제3항에 의해 이용자의 동의를 받아야 하는 경우에는 개인정보관리 책임자의 신원(소속, 성명 및 전화번호, 기타 연락처), 정보의 수집목적 및 이용목적, 제3자에 대한 정보제공 관련사항(제공받은자, 제공목적 및 제공할 정보의 내용) 등 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」 제22조제2항이 규정한 사항을 미리 명시하거나 고지해야 하며 이용자는 언제든지 이 동의를 철회할 수 있습니다.\r\n⑥ 이용자는 언제든지 “몰”이 가지고 있는 자신의 개인정보에 대해 열람 및 오류정정을 요구할 수 있으며 “몰”은 이에 대해 지체 없이 필요한 조치를 취할 의무를 집니다. 이용자가 오류의 정정을 요구한 경우에는 “몰”은 그 오류를 정정할 때까지 당해 개인정보를 이용하지 않습니다.\r\n⑦ “몰”은 개인정보 보호를 위하여 이용자의 개인정보를 취급하는 자를 최소한으로 제한하여야 하며 신용카드, 은행계좌 등을 포함한 이용자의 개인정보의 분실, 도난, 유출, 동의 없는 제3자 제공, 변조 등으로 인한 이용자의 손해에 대하여 모든 책임을 집니다.\r\n⑧ “몰” 또는 그로부터 개인정보를 제공받은 제3자는 개인정보의 수집목적 또는 제공받은 목적을 달성한 때에는 당해 개인정보를 지체 없이 파기합니다.\r\n⑨ “몰”은 개인정보의 수집•이용•제공에 관한 동의란을 미리 선택한 것으로 설정해두지 않습니다. 또한 개인정보의 수집•이용•제공에 관한 이용자의 동의거절시 제한되는 서비스를 구체적으로 명시하고, 필수수집항목이 아닌 개인정보의 수집•이용•제공에 관한 이용자의 동의 거절을 이유로 회원가입 등 서비스 제공을 제한하거나 거절하지 않습니다.\r\n\r\n제18조(“몰“의 의무)\r\n① “몰”은 법령과 이 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 이 약관이 정하는 바에 따라 지속적이고, 안정적으로 재화․용역을 제공하는데 최선을 다하여야 합니다.\r\n② “몰”은 이용자가 안전하게 인터넷 서비스를 이용할 수 있도록 이용자의 개인정보(신용정보 포함)보호를 위한 보안 시스템을 갖추어야 합니다.\r\n③ “몰”이 상품이나 용역에 대하여 「표시․광고의 공정화에 관한 법률」 제3조 소정의 부당한 표시․광고행위를 함으로써 이용자가 손해를 입은 때에는 이를 배상할 책임을 집니다.\r\n④ “몰”은 이용자가 원하지 않는 영리목적의 광고성 전자우편을 발송하지 않습니다.\r\n\r\n제19조(회원의 ID 및 비밀번호에 대한 의무)\r\n① 제17조의 경우를 제외한 ID와 비밀번호에 관한 관리책임은 회원에게 있습니다.\r\n② 회원은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안됩니다.\r\n③ 회원이 자신의 ID 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 “몰”에 통보하고 “몰”의 안내가 있는 경우에는 그에 따라야 합니다.\r\n\r\n제20조(이용자의 의무)\r\n이용자는 다음 행위를 하여서는 안 됩니다.\r\n1. 신청 또는 변경시 허위 내용의 등록\r\n2. 타인의 정보 도용\r\n3. “몰”에 게시된 정보의 변경\r\n4. “몰”이 정한 정보 이외의 정보(컴퓨터 프로그램 등) 등의 송신 또는 게시\r\n5. “몰” 기타 제3자의 저작권 등 지적재산권에 대한 침해\r\n6. “몰” 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위\r\n7. 외설 또는 폭력적인 메시지, 화상, 음성, 기타 공서양속에 반하는 정보를 몰에 공개 또는 게시하는 행위\r\n\r\n제21조(연결“몰”과 피연결“몰” 간의 관계)\r\n① 상위 “몰”과 하위 “몰”이 하이퍼링크(예: 하이퍼링크의 대상에는 문자, 그림 및 동화상 등이 포함됨)방식 등으로 연결된 경우, 전자를 연결 “몰”(웹 사이트)이라고 하고 후자를 피연결 “몰”(웹사이트)이라고 합니다.\r\n② 연결“몰”은 피연결“몰”이 독자적으로 제공하는 재화 등에 의하여 이용자와 행하는 거래에 대해서 보증 책임을 지지 않는다는 뜻을 연결“몰”의 초기화면 또는 연결되는 시점의 팝업화면으로 명시한 경우에는 그 거래에 대한 보증 책임을 지지 않습니다.\r\n\r\n제22조(저작권의 귀속 및 이용제한)\r\n① “몰“이 작성한 저작물에 대한 저작권 기타 지적재산권은 ”몰“에 귀속합니다.\r\n② 이용자는 “몰”을 이용함으로써 얻은 정보 중 “몰”에게 지적재산권이 귀속된 정보를 “몰”의 사전 승낙 없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안됩니다.\r\n③ “몰”은 약정에 따라 이용자에게 귀속된 저작권을 사용하는 경우 당해 이용자에게 통보하여야 합니다.\r\n\r\n제23조(분쟁해결)\r\n① “몰”은 이용자가 제기하는 정당한 의견이나 불만을 반영하고 그 피해를 보상처리하기 위하여 피해보상처리기구를 설치․운영합니다.\r\n② “몰”은 이용자로부터 제출되는 불만사항 및 의견은 우선적으로 그 사항을 처리합니다. 다만, 신속한 처리가 곤란한 경우에는 이용자에게 그 사유와 처리일정을 즉시 통보해 드립니다.\r\n③ “몰”과 이용자 간에 발생한 전자상거래 분쟁과 관련하여 이용자의 피해구제신청이 있는 경우에는 공정거래위원회 또는 시•도지사가 의뢰하는 분쟁조정기관의 조정에 따를 수 있습니다.\r\n\r\n제24조(재판권 및 준거법)\r\n① “몰”과 이용자 간에 발생한 전자상거래 분쟁에 관한 소송은 제소 당시의 이용자의 주소에 의하고, 주소가 없는 경우에는 거소를 관할하는 지방법원의 전속관할로 합니다. 다만, 제소 당시 이용자의 주소 또는 거소가 분명하지 않거나 외국 거주자의 경우에는 민사소송법상의 관할법원에 제기합니다.\r\n② “몰”과 이용자 간에 제기된 전자상거래 소송에는 한국법을 적용합니다.\r\n\r\n부 칙(시행일) 이 약관은 년 월 일부터 시행합니다.\r\n\r\n제25조(적립금/예치금 제도)\r\n1. 적립금과 예치금은 \'몰\'내에서 현금처럼 사용되는 전자화폐이며, 상품 구매 시에만 사용할 수 있습니다. 단, 적립금의 경우 이용 가능 범위를 몰에서 제한할 수 있습니다.\r\n2. 적립금과 예치금은 본인만 사용 가능하며 타인에게 양도 또는 다른 아이디와 연동할 수 없습니다.\r\n3. 적립금과 예치금은 회원에 한하여 제공되는 서비스이며 현금 환불은 되지 않습니다.\r\n4. 회원에게 적립된 예치금 또는 적립금이 부정한 방법 또는 개인 정보 도용으로 적립된 사실이 인정되는 경우 몰은 해당 포인트를 통보 없이 정정 또는 회수할 수 있습니다.\r\n5. 적립금과 예치금은 타 결제수단(카드 결제,소액 결제,현금)과 함께 사용할 수 있으나 적립금과 예치금의 동시 중복 사용은 불가합니다.\r\n6. 적립금 또는 예치금은 할인 이벤트 등 특정 기간 동안에 지급 및 이용이 제한될 수 있습니다.\r\n7. 회원이 상품 구매나 이벤트 등을 통하여 “몰”로부터 무상 제공받은 적립금의 경우 “몰\'에서 정한 기한에 한해 사용 가능합니다.\r\n8. 유효기간 : “몰”로부터 제공받은 적립금의 경우, 유효기간이 경과한 적립금은 자동 소멸됩니다.\r\n9. 적립금 소멸일 기준으로 1년 이상 경과된 적립금은 회수됩니다. 적립금의 유효기간은 지급 시점을 기준으로 12개월이며, 유효기간 내에 사용되지 않은 적립금은 기간 만료 시 자동 소멸됩니다.\r\n10. 이용자가 탈퇴, 자격상실, 1년 이상 무거래(휴면 계정 전환) 등을 원인으로 적립금이 소멸되는 경우 현금으로 반환되지 않고 소멸되며, 소멸된 적립금은 복구가 불가능합니다.\r\n\r\n제26조(플랫폼)\r\n1. \'몰\'외 타 플랫폼에서 판매하는 상품들은 플랫폼 정책상 \'몰\'과 판매가 기준이 다를 수 있습니다.\r\n\r\n#카카오톡 알림톡 시행에 관한 내용\r\n\r\n“슬로우앤드”는 회원가입, 주문안내, 배송안내 등 비광고성 정보를 카카오톡 알림톡으로 알려드리며, 만약 알림톡 수신이 불가능하거나 수신 차단하신 경우에는 일반 문자메시지로 보내드립니다. 카카오톡 알림톡을 통해 안내되는 정보를 와이파이가 아닌 이동통신망으로 이용할 경우, 알림톡 수신 중 데이터 요금이 발생할 수 있습니다. 카카오톡을 통해 발송되는 알림톡 수신을 원치 않으실 경우 반드시 알림톡을 차단하여 주시기 바랍니다.\r\n\r\n\r\n#네이버 알림 시행에 관한 내용\r\n\r\n“슬로우앤드”는 회원가입, 주문안내, 배송안내 등 비광고성 정보를 네이버 알림으로 알려드립니다. 네이버 알림을 통해 안내되는 정보를 와이파이가 아닌 이동통신망으로 이용할 경우, 네이버 알림 수신 중 데이터 요금이 발생할 수 있습니다. 네이버 알림 수신을 원치 않으실 경우 반드시 알림을 해제하여 주시기 바랍니다.\r\n\r\n\r\n\r\n\r\n\r\n변경이력\r\n\r\n이 약관은 2020 년 11 월 03 일부터 시행하며 종전의 약관은 이 약관으로 대체 합니다.', '1. 개인정보 수집목적 및 이용목적\r\n\r\n가. 서비스 제공에 관한 계약 이행 및 서비스 제공에 따른 요금정산\r\n\r\n콘텐츠 제공 , 구매 및 요금 결제 , 물품배송 또는 청구지 등 발송 , 금융거래 본인 인증 및 금융 서비스\r\n\r\n나. 회원 관리\r\n\r\n회원제 서비스 이용에 따른 본인확인 , 개인 식별 , 불량회원의 부정 이용 방지와 비인가 사용 방지 , 가입 의사 확인 , 연령확인 , 만14세 미만 아동 개인정보 수집 시 법정 대리인 동의여부 확인, 불만처리 등 민원처리 , 고지사항 전달\r\n\r\n2. 수집하는 개인정보 항목 : 이름 , 생년월일 , 성별 , 로그인ID , 비밀번호 , 자택 전화번호 , 휴대전화번호 , 이메일 , 14세미만 가입자의 경우 법정대리인의 정보\r\n\r\n3. 개인정보의 보유기간 및 이용기간\r\n\r\n원칙적으로, 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존합니다.\r\n\r\n가. 회사 내부 방침에 의한 정보 보유 사유\r\n\r\no 부정거래 방지 및 쇼핑몰 운영방침에 따른 보관 : 1년\r\n\r\n나. 관련 법령에 의한 정보보유 사유\r\n\r\no 계약 또는 청약철회 등에 관한 기록\r\n\r\n-보존이유 : 전자상거래등에서의소비자보호에관한법률\r\n\r\n-보존기간 : 5년\r\n\r\no 대금 결제 및 재화 등의 공급에 관한 기록\r\n\r\n-보존이유: 전자상거래등에서의소비자보호에관한법률\r\n\r\n-보존기간 : 5년\r\n\r\no 소비자 불만 또는 분쟁처리에 관한 기록\r\n\r\n-보존이유 : 전자상거래등에서의소비자보호에관한법률\r\n\r\n-보존기간 : 3년\r\n\r\no 로그 기록\r\n\r\n-보존이유: 통신비밀보호법\r\n\r\n-보존기간 : 3개월\r\n\r\n※ 동의를 거부할 수 있으나 거부시 회원 가입이 불가능합니다.\r\n\r\n\r\n\r\n4. 개인정보의 위탁 처리 (2020-09-28)\r\n\r\n“(주)앤드모어”는 서비스 향상을 위해 관계법령에 따라 회원의 동의를 얻거나 관련 사항을 공개 또는 고지 후 회원의 개인정보를 외부에 위탁하여 처리하고 있습니다.\r\n\r\n“(주)앤드모어”의 개인정보처리 수탁자와 그 업무의 내용은 다음과 같습니다.\r\n\r\n\r\n\r\n- 수탁자 : ㈜스냅컴퍼니(알림전송수탁업체 : ㈜엠티에스컴퍼니)\r\n\r\n- 위탁 업무 내용 : 신규 서비스(제품) 개발 및 맞춤 서비스 제공, 이벤트 및 광고성 정보 및 참여기회 제공\r\n\r\n- 수집항목 : 이름, 아이디, 휴대전화번호\r\n\r\n- 보유기간 : 회원 탈퇴 시 혹은 법정 보유기간', '할인쿠폰 및 혜택, 이벤트, 신상품 소식 등 쇼핑몰에서 제공하는 유익한 쇼핑정보를 SMS나 이메일로 받아보실 수 있습니다.\r\n\r\n단, 주문/거래 정보 및 주요 정책과 관련된 내용은 수신동의 여부와 관계없이 발송됩니다.\r\n\r\n선택 약관에 동의하지 않으셔도 회원가입은 가능하며, 회원가입 후 회원정보수정 페이지에서 언제든지 수신여부를 변경하실 수 있습니다.', '1. 개인정보 수집목적 및 이용목적 : 비회원 구매 서비스 제공2. 수집하는 개인정보 항목 : 성명, 주소, 전화번호, 이메일, 결제 정보, 비회원 결제 비밀번호3. 개인정보의 보유기간 및 이용기간원칙적으로, 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존합니다.가. 회사 내부 방침에 의한 정보 보유 사유· 부정거래 방지 및 쇼핑몰 운영방침에 따른 보관 : 1년나. 관련 법령에 의한 정보보유 사유o 계약 또는 청약철회 등에 관한 기록-보존이유 : 전자상거래등에서의소비자보호에관한법률-보존기간 : 5년o 대금 결제 및 재화 등의 공급에 관한 기록-보존이유: 전자상거래등에서의소비자보호에관한법률-보존기간 : 5년 o 소비자 불만 또는 분쟁처리에 관한 기록-보존이유 : 전자상거래등에서의소비자보호에관한법률-보존기간 : 3년 o 로그 기록 -보존이유: 통신비밀보호법-보존기간 : 3개월※ 동의를 거부할 수 있으나 거부시 비회원 구매 서비스 이용이 불가능합니다.												');

-- 테이블 beauty.wish 구조 내보내기
CREATE TABLE IF NOT EXISTS `wish` (
  `wishNo` int(11) NOT NULL AUTO_INCREMENT,
  `prodNo` int(11) NOT NULL,
  `uid` varchar(255) NOT NULL,
  `rdate` datetime NOT NULL,
  PRIMARY KEY (`wishNo`),
  KEY `fk_Wish_Product_idx` (`prodNo`),
  KEY `FK_wish_member` (`uid`),
  CONSTRAINT `fk_Wish_Product` FOREIGN KEY (`prodNo`) REFERENCES `product` (`prodNo`) ON DELETE CASCADE,
  CONSTRAINT `FK_wish_member` FOREIGN KEY (`uid`) REFERENCES `member` (`uid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- 테이블 데이터 beauty.wish:~5 rows (대략적) 내보내기
INSERT INTO `wish` (`wishNo`, `prodNo`, `uid`, `rdate`) VALUES
	(15, 636, 'admin@admin', '2023-03-22 04:08:20'),
	(16, 592, 'admin@admin', '2023-03-22 04:08:24'),
	(17, 593, 'admin@admin', '2023-03-22 04:08:28'),
	(18, 589, 'admin@admin', '2023-03-22 04:08:31'),
	(19, 588, 'admin@admin', '2023-03-22 04:08:34');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
