-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.7.21-log - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win32
-- HeidiSQL 版本:                  9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- 导出 medicine 的数据库结构
CREATE DATABASE IF NOT EXISTS `medicine` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `medicine`;

-- 导出  表 medicine.medicine 结构
CREATE TABLE IF NOT EXISTS `medicine` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `status` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `number` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `component` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `effect` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `reaction` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `usage` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `manufactor` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `price` double NOT NULL DEFAULT '0',
  `amount` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 正在导出表  medicine.medicine 的数据：~7 rows (大约)
DELETE FROM `medicine`;
/*!40000 ALTER TABLE `medicine` DISABLE KEYS */;
INSERT INTO `medicine` (`id`, `name`, `status`, `number`, `component`, `effect`, `reaction`, `usage`, `manufactor`, `price`, `amount`) VALUES
	(1, '诺氟沙星胶囊', '速溶性胶囊', '国药准字H20013567', '1-乙基-6-氟-1，4-二氢-4-氧代-7-(1-哌嗪基)', '肠道感染和伤寒及其他沙门菌感染', '为腹部不适或疼痛、腹泻、恶心或呕吐', '一次0.4g(4粒)，一日2次', '石药集团欧意药业有限公司', 9.8, 28),
	(2, '新康泰克', '速溶性胶囊', '国药准字H20013063', '氢溴酸右美沙芬，对乙酰氨基酚，盐酸伪麻黄碱', '普通感冒,流行性感冒', '有困倦、精神紧张、入睡困难、专注困难', '口服，一次1片，每6小时服1次', '中美天津史克制药有限公司', 32.5, 56),
	(3, '维C银翘片', '薄膜衣片，内为褐色，味苦', '国药准字Z52020455', '山银花，连翘，荆芥，淡豆豉，淡竹叶，甘草等', '用于外感风热所致的流行性感冒等', '见困倦、嗜睡、口渴、虚弱感', '口服，一次2片，一日3次', '四川奥邦药业有限公司', 12.56, 0),
	(4, '999感冒灵颗粒', '浅棕色至深棕色的颗粒，味甜、微苦', '国药准字Z44021940', '三叉苦、岗梅、金盏银盘、薄荷油、野菊花、马来酸氯苯那敏', '解热镇痛。用于感冒引起的头痛，发热，鼻塞，流涕，咽痛', '可见困倦、嗜睡、口渴、虚弱感', '开水冲服，一次1袋，一日3次', '华润三九医药股份有限公司', 19.9, 0),
	(5, '布洛芬缓释胶囊', '白色球形小丸', '国药准字Z44039098', '布洛芬，糖，淀粉，硬脂酸，聚乙烯吡咯烷酮', '用于缓解轻至中度疼痛如头痛、关节痛、偏头痛、牙痛、肌肉痛、神经痛', '出现恶心、呕吐、胃烧灼感或轻度消化不良', '口服，一次1粒，一日2次', '中美天津史克制药有限公司', 16.5, 0),
	(6, '葡萄糖酸钙锌口服溶液 ', '为黄色澄清液体', '国药准字H20013241', '葡萄糖酸钙，葡萄糖酸锌，阿斯巴甜，安赛蜜', '治疗因缺钙、锌引起的疾病', '可见轻度恶心、呕吐、便秘等', '口服，一次2次，一日一瓶', '澳诺(中国)制药有限公司', 39.9, 0),
	(7, '汤臣倍健液体钙', '淡黄色澄清液体', '国药健字G20100800', '钙，维生素D', '为缺钙人群补充钙营养', '暂无不良反应', '每日一次，一次两粒', '汤臣倍健股份有限公司', 98, 64);
/*!40000 ALTER TABLE `medicine` ENABLE KEYS */;

-- 导出  表 medicine.medicine_sale 结构
CREATE TABLE IF NOT EXISTS `medicine_sale` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `medicine_id` int(11) NOT NULL DEFAULT '0',
  `amount` int(11) NOT NULL DEFAULT '0',
  `record_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sale_user` (`user_id`),
  CONSTRAINT `sale_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 正在导出表  medicine.medicine_sale 的数据：~4 rows (大约)
DELETE FROM `medicine_sale`;
/*!40000 ALTER TABLE `medicine_sale` DISABLE KEYS */;
INSERT INTO `medicine_sale` (`id`, `medicine_id`, `amount`, `record_time`, `user_id`) VALUES
	(4, 1, 2, '2018-03-15 22:03:38', 1),
	(5, 2, 6, '2018-03-15 22:04:11', 1),
	(6, 1, 2, '2018-03-15 23:50:23', 1),
	(7, 7, 2, '2018-03-16 18:18:20', 1);
/*!40000 ALTER TABLE `medicine_sale` ENABLE KEYS */;

-- 导出  表 medicine.purchase 结构
CREATE TABLE IF NOT EXISTS `purchase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `medicine_id` int(11) NOT NULL DEFAULT '0',
  `amount` int(11) NOT NULL DEFAULT '0',
  `start_time` date NOT NULL,
  `end_time` date NOT NULL,
  `record_time` datetime NOT NULL,
  `status` int(11) NOT NULL,
  `process_time` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pruchase_user` (`user_id`),
  CONSTRAINT `pruchase_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 正在导出表  medicine.purchase 的数据：~4 rows (大约)
DELETE FROM `purchase`;
/*!40000 ALTER TABLE `purchase` DISABLE KEYS */;
INSERT INTO `purchase` (`id`, `medicine_id`, `amount`, `start_time`, `end_time`, `record_time`, `status`, `process_time`, `user_id`) VALUES
	(11, 1, 12, '2018-03-05', '2018-03-14', '2018-03-16 16:46:51', 1, '2018-03-16 16:47:14', 1),
	(12, 2, 10, '2018-02-25', '2018-03-01', '2018-03-16 16:46:59', 1, '2018-03-16 16:47:31', 1),
	(13, 7, 66, '2018-02-26', '2018-05-16', '2018-03-16 18:17:53', 0, NULL, NULL),
	(14, 2, 10, '2018-02-25', '2018-03-06', '2018-03-16 18:19:11', 1, '2018-03-16 18:19:30', 1);
/*!40000 ALTER TABLE `purchase` ENABLE KEYS */;

-- 导出  表 medicine.user 结构
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `account` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `password` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `grade_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 正在导出表  medicine.user 的数据：~2 rows (大约)
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `name`, `account`, `password`, `grade_id`) VALUES
	(1, '王木生', 'admin', 'A2B7BB203C511F4ED89D4E9B82A0DE88', 1),
	(8, '宋青莲', 'user', '5C6EA3B4BCCEC5EA97E2BA0E0AD2F71F', 2);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

-- 导出  表 medicine.user_grade 结构
CREATE TABLE IF NOT EXISTS `user_grade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 正在导出表  medicine.user_grade 的数据：~2 rows (大约)
DELETE FROM `user_grade`;
/*!40000 ALTER TABLE `user_grade` DISABLE KEYS */;
INSERT INTO `user_grade` (`id`, `name`) VALUES
	(1, '管理员'),
	(2, '售货员');
/*!40000 ALTER TABLE `user_grade` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
