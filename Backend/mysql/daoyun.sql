-- MySQL dump 10.13  Distrib 8.0.23, for Linux (x86_64)
--
-- Host: localhost    Database: daoyun
-- ------------------------------------------------------
-- Server version	8.0.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `daoyun`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `daoyun` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `daoyun`;

--
-- Table structure for table `hibernate_sequence`
--

DROP TABLE IF EXISTS `hibernate_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hibernate_sequence` (
  `next_val` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hibernate_sequence`
--

LOCK TABLES `hibernate_sequence` WRITE;
/*!40000 ALTER TABLE `hibernate_sequence` DISABLE KEYS */;
INSERT INTO `hibernate_sequence` VALUES (5115);
/*!40000 ALTER TABLE `hibernate_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_check_in_task`
--

DROP TABLE IF EXISTS `tbl_check_in_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_check_in_task` (
  `pk_checkin_task_id` bigint NOT NULL,
  `course` tinyblob,
  `check_in_json_data` varchar(255) DEFAULT NULL,
  `gmt_created` datetime DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `course_check_in_pk_course_check_in_id` bigint DEFAULT NULL,
  `student_pk_user_id` int DEFAULT NULL,
  `checkin_json_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `course_checkin_pk_course_check_in_id` bigint DEFAULT NULL,
  PRIMARY KEY (`pk_checkin_task_id`),
  KEY `FKpkkpo5snkn79e7dwfn45ip53n` (`course_check_in_pk_course_check_in_id`),
  KEY `FK3na1frcdci9tmkkhqmp54w8wn` (`student_pk_user_id`),
  KEY `FKt2s0rx3xbipc883vsn4bi3fv` (`course_checkin_pk_course_check_in_id`),
  CONSTRAINT `FK3na1frcdci9tmkkhqmp54w8wn` FOREIGN KEY (`student_pk_user_id`) REFERENCES `tbl_user` (`pk_user_id`),
  CONSTRAINT `FKpkkpo5snkn79e7dwfn45ip53n` FOREIGN KEY (`course_check_in_pk_course_check_in_id`) REFERENCES `tbl_course_check_in` (`pk_course_check_in_id`),
  CONSTRAINT `FKt2s0rx3xbipc883vsn4bi3fv` FOREIGN KEY (`course_checkin_pk_course_check_in_id`) REFERENCES `tbl_course_check_in` (`pk_course_check_in_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_check_in_task`
--

LOCK TABLES `tbl_check_in_task` WRITE;
/*!40000 ALTER TABLE `tbl_check_in_task` DISABLE KEYS */;
INSERT INTO `tbl_check_in_task` VALUES (5094,NULL,NULL,'2021-06-27 05:49:33','2021-06-27 05:49:33',NULL,5034,'{}',5090),(5095,NULL,NULL,'2021-06-27 05:50:10','2021-06-27 05:50:10',NULL,5034,'{\"key\": \"4444\"}',5091),(5096,NULL,NULL,'2021-06-27 05:50:53','2021-06-27 05:50:53',NULL,5034,'{\"gesture\": \"123\"}',5092),(5097,NULL,NULL,'2021-06-27 05:51:27','2021-06-27 05:51:27',NULL,5034,'{\"location\": \"200 300\"}',5093),(5109,NULL,NULL,'2021-06-27 07:28:19','2021-06-27 07:28:19',NULL,5038,'{\"gesture\": \"123\"}',5092),(5110,NULL,NULL,'2021-06-27 07:28:45','2021-06-27 07:28:45',NULL,5038,'{}',5090),(5111,NULL,NULL,'2021-06-27 07:29:24','2021-06-27 07:29:24',NULL,5038,'{\"key\": \"4444\"}',5091),(5113,NULL,NULL,'2021-06-27 07:36:53','2021-06-27 07:36:53',NULL,5038,'{\"location\": \"fzu\"}',5093);
/*!40000 ALTER TABLE `tbl_check_in_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_check_in_task_checked_students`
--

DROP TABLE IF EXISTS `tbl_check_in_task_checked_students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_check_in_task_checked_students` (
  `check_in_task_pk_checkin_task_id` bigint NOT NULL,
  `checked_students_pk_user_id` int NOT NULL,
  KEY `FKn8s3ijs85vhbaeocwqq7at62s` (`checked_students_pk_user_id`),
  KEY `FKnqv5k8xi6n8bn9ch7x6gvm4st` (`check_in_task_pk_checkin_task_id`),
  CONSTRAINT `FKn8s3ijs85vhbaeocwqq7at62s` FOREIGN KEY (`checked_students_pk_user_id`) REFERENCES `tbl_user` (`pk_user_id`),
  CONSTRAINT `FKnqv5k8xi6n8bn9ch7x6gvm4st` FOREIGN KEY (`check_in_task_pk_checkin_task_id`) REFERENCES `tbl_check_in_task` (`pk_checkin_task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_check_in_task_checked_students`
--

LOCK TABLES `tbl_check_in_task_checked_students` WRITE;
/*!40000 ALTER TABLE `tbl_check_in_task_checked_students` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_check_in_task_checked_students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_commit_task`
--

DROP TABLE IF EXISTS `tbl_commit_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_commit_task` (
  `pk_commit_task_id` bigint NOT NULL,
  `commit_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `gmt_created` datetime DEFAULT CURRENT_TIMESTAMP,
  `grade` bigint DEFAULT NULL,
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `teacher_do_this` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `course_task_pk_course_task_id` bigint DEFAULT NULL,
  `student_pk_user_id` int DEFAULT NULL,
  PRIMARY KEY (`pk_commit_task_id`),
  KEY `FKqk2guek7313q4s2i0ji8siu7b` (`course_task_pk_course_task_id`),
  KEY `FKkbhyhnspluvurf0fxyg1c6548` (`student_pk_user_id`),
  CONSTRAINT `FKkbhyhnspluvurf0fxyg1c6548` FOREIGN KEY (`student_pk_user_id`) REFERENCES `tbl_user` (`pk_user_id`),
  CONSTRAINT `FKqk2guek7313q4s2i0ji8siu7b` FOREIGN KEY (`course_task_pk_course_task_id`) REFERENCES `tbl_course_task` (`pk_course_task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_commit_task`
--

LOCK TABLES `tbl_commit_task` WRITE;
/*!40000 ALTER TABLE `tbl_commit_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_commit_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_course`
--

DROP TABLE IF EXISTS `tbl_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_course` (
  `pk_course_id` bigint NOT NULL,
  `brief_description` varchar(255) DEFAULT NULL,
  `course_ex_id` varchar(255) DEFAULT NULL,
  `course_name` varchar(255) DEFAULT NULL,
  `teacher_pk_user_id` int DEFAULT NULL,
  PRIMARY KEY (`pk_course_id`),
  UNIQUE KEY `UK_1aavskmjsu6bwo66wl1p9t7ar` (`course_ex_id`),
  KEY `FKc1kwfso0s5g5on4dycajhi83n` (`teacher_pk_user_id`),
  CONSTRAINT `FKc1kwfso0s5g5on4dycajhi83n` FOREIGN KEY (`teacher_pk_user_id`) REFERENCES `tbl_user` (`pk_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_course`
--

LOCK TABLES `tbl_course` WRITE;
/*!40000 ALTER TABLE `tbl_course` DISABLE KEYS */;
INSERT INTO `tbl_course` VALUES (5047,'{\n    \"description\": \"计算机工程实践\"\n}','1674484157','工程实践',5033);
/*!40000 ALTER TABLE `tbl_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_course_check_in`
--

DROP TABLE IF EXISTS `tbl_course_check_in`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_course_check_in` (
  `pk_course_check_in_id` bigint NOT NULL,
  `gmt_created` datetime DEFAULT CURRENT_TIMESTAMP,
  `deadline` datetime(6) DEFAULT NULL,
  `json_data` varchar(255) DEFAULT NULL,
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `course_pk_course_id` bigint DEFAULT NULL,
  PRIMARY KEY (`pk_course_check_in_id`),
  KEY `FKrwm51g8qu0q0qg3ygxg4f19rl` (`course_pk_course_id`),
  CONSTRAINT `FKrwm51g8qu0q0qg3ygxg4f19rl` FOREIGN KEY (`course_pk_course_id`) REFERENCES `tbl_course` (`pk_course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_course_check_in`
--

LOCK TABLES `tbl_course_check_in` WRITE;
/*!40000 ALTER TABLE `tbl_course_check_in` DISABLE KEYS */;
INSERT INTO `tbl_course_check_in` VALUES (5090,'2021-06-27 05:46:23','2021-06-27 08:00:00.000000','{\"type\":\"simple\"}','2021-06-27 05:46:23',5047),(5091,'2021-06-27 05:46:48','2021-06-28 06:00:00.000000','{\"type\":\"key\",\"key\":\"4444\"}','2021-06-27 05:46:48',5047),(5092,'2021-06-27 05:47:22','2021-06-27 08:47:01.000000','{\"type\":\"gesture\",\"gesture\":\"123\"}','2021-06-27 05:47:22',5047),(5093,'2021-06-27 05:47:35','2021-06-27 09:59:00.000000','{\"type\":\"location\"}','2021-06-27 05:47:35',5047);
/*!40000 ALTER TABLE `tbl_course_check_in` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_course_student`
--

DROP TABLE IF EXISTS `tbl_course_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_course_student` (
  `course_id` bigint NOT NULL,
  `student_id` int NOT NULL,
  `grade` bigint DEFAULT NULL,
  PRIMARY KEY (`course_id`,`student_id`),
  KEY `FK3gtc92odscd102by46c7g3ulx` (`student_id`),
  CONSTRAINT `FK3gtc92odscd102by46c7g3ulx` FOREIGN KEY (`student_id`) REFERENCES `tbl_user` (`pk_user_id`),
  CONSTRAINT `FKme7doxh7e7dpwduwvmmlu0kd9` FOREIGN KEY (`course_id`) REFERENCES `tbl_course` (`pk_course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_course_student`
--

LOCK TABLES `tbl_course_student` WRITE;
/*!40000 ALTER TABLE `tbl_course_student` DISABLE KEYS */;
INSERT INTO `tbl_course_student` VALUES (5047,5034,8),(5047,5038,8);
/*!40000 ALTER TABLE `tbl_course_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_course_task`
--

DROP TABLE IF EXISTS `tbl_course_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_course_task` (
  `pk_course_task_id` bigint NOT NULL,
  `committable` bit(1) DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `gmt_created` datetime DEFAULT CURRENT_TIMESTAMP,
  `deadline` datetime(6) DEFAULT NULL,
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `task_title` varchar(255) DEFAULT NULL,
  `course_pk_course_id` bigint DEFAULT NULL,
  PRIMARY KEY (`pk_course_task_id`),
  KEY `FKpknletbgm65wdu4dajj3w4lls` (`course_pk_course_id`),
  CONSTRAINT `FKpknletbgm65wdu4dajj3w4lls` FOREIGN KEY (`course_pk_course_id`) REFERENCES `tbl_course` (`pk_course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_course_task`
--

LOCK TABLES `tbl_course_task` WRITE;
/*!40000 ALTER TABLE `tbl_course_task` DISABLE KEYS */;
INSERT INTO `tbl_course_task` VALUES (5086,_binary '','没有任务的任务','2021-06-27 05:45:09','2021-06-28 05:00:00.000000','2021-06-27 05:45:09','任务1',5047),(5087,_binary '','又是一个任务','2021-06-27 05:45:42','2021-06-29 05:00:00.000000','2021-06-27 05:45:42','任务2',5047),(5088,_binary '\0','我不是一个通知','2021-06-27 05:45:59','2021-06-27 05:45:46.000000','2021-06-27 05:45:59','通知1',5047),(5089,_binary '\0','我就是一个通知','2021-06-27 05:46:08','2021-06-27 05:46:02.000000','2021-06-27 05:46:08','通知2',5047);
/*!40000 ALTER TABLE `tbl_course_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_dictionary_data`
--

DROP TABLE IF EXISTS `tbl_dictionary_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_dictionary_data` (
  `pk_dict_data_id` int NOT NULL,
  `gmt_created` datetime DEFAULT CURRENT_TIMESTAMP,
  `is_default` bit(1) DEFAULT NULL,
  `keyword` varchar(255) NOT NULL,
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `data_order` int DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `data_value` varchar(255) NOT NULL,
  `dictionary_type_pk_dict_type_id` int DEFAULT NULL,
  PRIMARY KEY (`pk_dict_data_id`),
  KEY `FK6h3rr0et1bs79c250ix11s3dm` (`dictionary_type_pk_dict_type_id`),
  CONSTRAINT `FK6h3rr0et1bs79c250ix11s3dm` FOREIGN KEY (`dictionary_type_pk_dict_type_id`) REFERENCES `tbl_dictionary_type` (`pk_dict_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_dictionary_data`
--

LOCK TABLES `tbl_dictionary_data` WRITE;
/*!40000 ALTER TABLE `tbl_dictionary_data` DISABLE KEYS */;
INSERT INTO `tbl_dictionary_data` VALUES (142,'2021-06-08 08:35:41',_binary '\0','男','2021-06-08 08:37:02',3,'','0',141),(143,'2021-06-08 08:35:48',_binary '\0','女','2021-06-08 08:35:48',2,'','1',141),(144,'2021-06-08 08:35:54',_binary '','未知','2021-06-08 08:37:02',1,'','2',141);
/*!40000 ALTER TABLE `tbl_dictionary_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_dictionary_type`
--

DROP TABLE IF EXISTS `tbl_dictionary_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_dictionary_type` (
  `pk_dict_type_id` int NOT NULL,
  `gmt_created` datetime DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `remark` varchar(255) DEFAULT NULL,
  `type_code` varchar(255) NOT NULL,
  `uk_dict_type_name` varchar(255) NOT NULL,
  PRIMARY KEY (`pk_dict_type_id`),
  UNIQUE KEY `UK_r27mpa9su6bgukrblwxd5agro` (`type_code`),
  UNIQUE KEY `UK_gu8cdyhhtcwc9jgvvjfx2bug9` (`uk_dict_type_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_dictionary_type`
--

LOCK TABLES `tbl_dictionary_type` WRITE;
/*!40000 ALTER TABLE `tbl_dictionary_type` DISABLE KEYS */;
INSERT INTO `tbl_dictionary_type` VALUES (141,'2021-06-08 08:35:31','2021-06-08 08:35:31','','sex','性别');
/*!40000 ALTER TABLE `tbl_dictionary_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_perm_entry`
--

DROP TABLE IF EXISTS `tbl_perm_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_perm_entry` (
  `pk_perm_entry_id` bigint NOT NULL,
  `entry_type` enum('menu','page','button') DEFAULT 'menu',
  `perm_entry_name` varchar(255) DEFAULT NULL,
  `parent_pk_perm_entry_id` bigint DEFAULT NULL,
  `descriptor` varchar(255) NOT NULL,
  `link` varchar(255) DEFAULT NULL,
  `method` enum('ALL','POST','PUT','GET','DELETE') DEFAULT 'ALL',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `sort_order` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`pk_perm_entry_id`),
  UNIQUE KEY `UK_aaerqujqadu1q7nwtao9mmvu3` (`descriptor`),
  UNIQUE KEY `UKon2e6qqvn19itoac9n97hf61c` (`link`,`method`),
  KEY `FKllw75v5e0fnsegqom56ab00nr` (`parent_pk_perm_entry_id`),
  CONSTRAINT `FKllw75v5e0fnsegqom56ab00nr` FOREIGN KEY (`parent_pk_perm_entry_id`) REFERENCES `tbl_perm_entry` (`pk_perm_entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_perm_entry`
--

LOCK TABLES `tbl_perm_entry` WRITE;
/*!40000 ALTER TABLE `tbl_perm_entry` DISABLE KEYS */;
INSERT INTO `tbl_perm_entry` VALUES (101,'menu','数据字典',NULL,'datadict','/apis/datadict','ALL',NULL,NULL),(102,'page','类型',101,'datadict.type','/apis/datadict/type','ALL',NULL,NULL),(103,'page','数据',101,'datadict.data','/apis/sysparam/data','ALL',NULL,NULL),(104,'button','Get',102,'datadict.type.get','/apis/datadict/type','GET',NULL,NULL),(105,'button','Post',102,'datadict.type.post','/apis/datadict/type','POST',NULL,NULL),(106,'button','Delete',102,'datadict.type.delete','/apis/datadict/type','DELETE',NULL,NULL),(107,'button','Put',102,'datadict.type.put','/apis/datadict/type','PUT',NULL,NULL),(108,'button','get page',102,'datadict.type.page','/apis/datadict/type/page','GET',NULL,NULL),(109,'button','Get',103,'datadict.data.get','/apis/datadict/data','GET',NULL,NULL),(110,'button','Put',103,'datadict.data.put','/apis/datadict/data','PUT',NULL,NULL),(111,'button','Post',103,'datadict.data.post','/apis/datadict/data','POST',NULL,NULL),(112,'button','Delete',103,'datadict.data.delete','/apis/datadict/data','DELETE',NULL,NULL),(113,'button','Get page',103,'datadict.data.page','/apis/datadict/data/page','GET',NULL,NULL),(114,'menu','系统参数',NULL,'sysparam','/apis/sysparam','ALL',NULL,NULL),(115,'button','Get',114,'sysparam.get','/apis/sysparam','GET',NULL,NULL),(116,'button','Put',114,'sysparam.put','/apis/sysparam','PUT',NULL,NULL),(117,'button','Post',114,'sysparam.post','/apis/sysparam','POST',NULL,NULL),(118,'button','Delete',114,'sysparam.delete','/apis/sysparam','DELETE',NULL,NULL),(119,'button','Get page',114,'sysparam.page','/apis/sysparam/page','GET',NULL,NULL),(120,'menu','认证授权',NULL,'auth','/apis/auth','ALL',NULL,NULL),(121,'menu','用户管理',NULL,'adminuser','/apis/admin/user','ALL',NULL,NULL),(122,'button','Get',121,'adminuser.get','/apis/admin/user','GET',NULL,NULL),(123,'button','Put',121,'adminuser.put','/apis/admin/user','PUT',NULL,NULL),(124,'button','Post',121,'adminuser.post','/apis/admin/user','POST',NULL,NULL),(125,'button','Delete',121,'adminuser.delete','/apis/admin/user','DELETE',NULL,NULL),(126,'button','Get page',121,'adminuser.page','/apis/admin/user/page','GET',NULL,NULL),(127,'menu','角色管理',NULL,'role','/apis/role','ALL',NULL,NULL),(128,'button','Get List',127,'role.list','/apis/role/list','GET',NULL,NULL),(129,'button','Post',127,'role.post','/apis/role','POST',NULL,NULL),(130,'button','Delete',127,'role.delete','/apis/role','DELETE',NULL,NULL),(131,'menu','角色菜单',NULL,'roleperm','/apis/role/perm','ALL',NULL,NULL),(132,'button','Get',131,'roleperm.get','/apis/role/perm','GET',NULL,NULL),(133,'button','Post',131,'roleperm.post','/apis/role/perm','POST',NULL,NULL),(134,'button','Delete',131,'roleperm.delete','/apis/role/perm','DELETE',NULL,NULL),(135,'button','Get List',131,'roleperm.list','/apis/role/perm/list','GET',NULL,NULL),(136,'menu','菜单管理',NULL,'perm','/apis/perm','ALL',NULL,NULL),(137,'button','Get',136,'perm.get','/apis/perm','GET',NULL,NULL),(138,'button','Delete',136,'perm.delete','/apis/perm','DELETE',NULL,NULL),(139,'button','Post',136,'perm.post','/apis/perm','POST',NULL,NULL),(140,'button','Put',136,'perm.put','/apis/perm','PUT',NULL,NULL),(141,'button','Tree',136,'perm.tree','/apis/perm/tree','GET',NULL,NULL),(142,'button','Role',136,'perm.role','/apis/perm/role','GET',NULL,NULL),(143,'menu','用户信息',NULL,'user','/apis/user','ALL',NULL,NULL),(144,'button','Get',143,'user.get','/apis/user','GET',NULL,NULL),(145,'button','Put 不需要密码',143,'user.put','/apis/user','PUT',NULL,NULL),(146,'button','Put 需要密码',143,'user.pt','/apis/user/privileged','PUT',NULL,NULL),(147,'menu','班课管理',NULL,'course','/apis/course','ALL',NULL,NULL),(148,'button','Get',147,'course.get','/apis/course','GET',NULL,NULL),(149,'button','Put',147,'course.put','/apis/course','PUT',NULL,NULL),(150,'button','Post',147,'course.post','/apis/course','POST',NULL,NULL),(151,'button','Delete',147,'course.delete','/apis/course','DELETE',NULL,NULL),(152,'page','Get page',147,'course.page','/apis/course/page','GET','获取的班课列表中该用户是学生或者老师',NULL),(153,'page','学生',147,'course.student','/apis/course/student','ALL',NULL,NULL),(154,'button','邀请',153,'course.student.post','/apis/course/student','POST',NULL,NULL),(155,'button','踢出',153,'course.student.delete','/apis/course/student','DELETE',NULL,NULL),(156,'button','加入',153,'course.student.postme','/apis/course/student/me','POST',NULL,NULL),(157,'button','退出',153,'course.student.deleteme','/apis/course/student/me','DELETE',NULL,NULL),(158,'page','任务通知',147,'course.task','/apis/course/task','ALL',NULL,NULL),(159,'button','Post',158,'course.task.post','/apis/course/task','POST',NULL,NULL),(160,'button','Put',158,'course.task.put','/apis/course/task','PUT',NULL,NULL),(161,'button','Get',158,'course.task.get','/apis/course/task','GET',NULL,NULL),(162,'button','Delete',158,'course.task.delete','/apis/course/task','DELETE',NULL,NULL),(163,'button','答案列表',158,'course.task.anwserlist','/apis/course/task/anwser-list','GET',NULL,NULL),(164,'button','我的答案',158,'course.task.anwserme','/apis/course/task/anwser/me','GET',NULL,NULL),(165,'page','签到',147,'course.checkin','/apis/course/check-in','ALL',NULL,NULL),(166,'menu','任务答案',158,'course.task.anwser','/apis/course/task/anwser','ALL',NULL,NULL),(167,'button','提交',166,'course.task.anwser.post','/apis/course/task/anwser','POST',NULL,NULL),(168,'button','获取',166,'course.task.anwser.get','/apis/course/task/anwser','GET',NULL,NULL),(169,'button','修改',166,'course.task.anwser.put','/apis/course/task/anwser','PUT',NULL,NULL),(170,'button','删除',166,'course.task.anwser.delete','/apis/course/task/anwser','DELETE',NULL,NULL),(171,'button','Post',165,'course.checkin.post','/apis/course/check-in','POST',NULL,NULL),(172,'button','Get',165,'course.checkin.get','/apis/course/check-in','GET',NULL,NULL),(173,'button','Put',165,'course.checkin.put','/apis/course/check-in','PUT',NULL,NULL),(174,'button','Delete',165,'course.checkin.delete','/apis/course/check-in','DELETE',NULL,NULL),(175,'button','已签到列表',165,'course.checkin.anwserlist','/apis/course/check-in/anwser-list','GET',NULL,NULL),(176,'button','我的签到',165,'course.checkin.anwser','/apis/course/check-in/anwser/me','GET',NULL,NULL),(177,'page','学生签到',165,'course.checkin.student','/apis/course/check-in/anwser','ALL',NULL,NULL),(178,'button','进行签到',177,'course.checkin.student.post','/apis/course/check-in/anwser','POST',NULL,NULL),(179,'button','获取签到',177,'course.checkin.student.get','/apis/course/check-in/anwser','GET',NULL,NULL),(180,'menu','班课管理(管理员)',NULL,'coursesuper','/apis/course/super','ALL',NULL,NULL),(181,'button','Get',180,'coursesuper.get','/apis/course/super','GET',NULL,NULL),(182,'button','Post',180,'coursesuper.post','/apis/course/super','POST',NULL,NULL),(183,'button','Put',180,'coursesuper.put','/apis/course/super','PUT',NULL,NULL),(184,'button','Delete',180,'coursesuper.delete','/apis/course/super','DELETE',NULL,NULL),(185,'page','签到',180,'coursesuper.checkin','/apis/course/check-in/super','ALL',NULL,NULL),(186,'button','Post',185,'coursesuper.checkin.post','/apis/course/check-in/super','POST',NULL,NULL),(187,'button','Get',185,'coursesuper.checkin.get','/apis/course/check-in/super','GET',NULL,NULL),(188,'button','Put',185,'coursesuper.checkin.put','/apis/course/check-in/super','PUT',NULL,NULL),(189,'button','Delete',185,'coursesuper.checkin.delete','/apis/course/check-in/super','DELETE',NULL,NULL),(190,'button','已签到列表',185,'coursesuper.checkin.anwserlist','/apis/course/check-in/anwser-list/super','GET',NULL,NULL),(191,'page','任务通知',180,'coursesuper.task','/apis/course/task/super','ALL',NULL,NULL),(192,'button','Post',191,'coursesuper.task.post','/apis/course/task/super','POST',NULL,NULL),(193,'button','Put',191,'coursesuper.task.put','/apis/course/task/super','PUT',NULL,NULL),(194,'button','Get',191,'coursesuper.task.get','/apis/course/task/super','GET',NULL,NULL),(195,'button','Delete',191,'coursesuper.task.delete','/apis/course/task/super','DELETE',NULL,NULL),(196,'button','答案列表',191,'coursesuper.task.anwserlist','/apis/course/task/anwser-list/super','GET',NULL,NULL),(220,'button','JWT',120,'auth.jwt','/apis/auth/jwt','GET',NULL,NULL),(246,'button','获取用户权限列表',143,'user.descriptor','/apis/user/descriptor','GET',NULL,NULL),(5029,'page','当老师的班课列表',147,'course.teacherpage','/apis/course/teacher/page','GET','班课列表中, 用户都是老师',NULL),(5030,'page','当学生的班课列表',147,'course.studentpage','/apis/user/student/page','GET','班课列表中, 用户都是学生',NULL),(5031,'page','Get Page',180,'coursesuper.page','/apis/course/page/super','GET',NULL,NULL),(5050,'page','学生管理',180,'coursesuper.student','/apis/course/student/super','ALL',NULL,NULL),(5051,'button','邀请',5050,'coursesuper.student.post','/apis/course/student/super','POST',NULL,NULL),(5052,'button','踢出',5050,'coursesuper.student.delete','/apis/course/student/super','DELETE',NULL,NULL);
/*!40000 ALTER TABLE `tbl_perm_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_perm_entry_roles`
--

DROP TABLE IF EXISTS `tbl_perm_entry_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_perm_entry_roles` (
  `perm_entries_pk_perm_entry_id` bigint NOT NULL,
  `roles_pk_role_id` bigint NOT NULL,
  KEY `FK33cyvo1e9bll5yl6pl5q860gi` (`roles_pk_role_id`),
  KEY `FKghgdie7ybpoblkuj389hjicch` (`perm_entries_pk_perm_entry_id`),
  CONSTRAINT `FK33cyvo1e9bll5yl6pl5q860gi` FOREIGN KEY (`roles_pk_role_id`) REFERENCES `tbl_role` (`pk_role_id`),
  CONSTRAINT `FKghgdie7ybpoblkuj389hjicch` FOREIGN KEY (`perm_entries_pk_perm_entry_id`) REFERENCES `tbl_perm_entry` (`pk_perm_entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_perm_entry_roles`
--

LOCK TABLES `tbl_perm_entry_roles` WRITE;
/*!40000 ALTER TABLE `tbl_perm_entry_roles` DISABLE KEYS */;
INSERT INTO `tbl_perm_entry_roles` VALUES (101,270),(102,270),(103,270),(104,270),(105,270),(106,270),(107,270),(108,270),(110,270),(111,270),(112,270),(114,270),(116,270),(117,270),(118,270),(119,270),(121,270),(122,270),(123,270),(124,270),(125,270),(126,270),(127,270),(128,270),(129,270),(130,270),(131,270),(132,270),(133,270),(134,270),(135,270),(136,270),(137,270),(138,270),(139,270),(140,270),(141,270),(142,270),(180,270),(181,270),(182,270),(183,270),(184,270),(185,270),(191,270),(186,270),(187,270),(188,270),(189,270),(190,270),(192,270),(193,270),(194,270),(195,270),(196,270),(120,270),(120,272),(220,270),(220,272),(115,270),(115,272),(109,270),(109,272),(113,270),(113,272),(5031,270),(5050,270),(5051,270),(5052,270),(147,270),(147,271),(147,273),(148,270),(148,271),(148,273),(152,270),(152,271),(152,273),(153,270),(153,271),(153,273),(158,270),(158,271),(158,273),(165,270),(165,271),(165,273),(5029,270),(5029,271),(5029,273),(5030,270),(5030,271),(5030,273),(154,270),(154,271),(154,273),(155,270),(155,271),(155,273),(156,270),(156,271),(156,273),(157,270),(157,271),(157,273),(159,270),(159,271),(159,273),(160,270),(160,271),(160,273),(161,270),(161,271),(161,273),(162,270),(162,271),(162,273),(163,270),(163,271),(163,273),(164,270),(164,271),(164,273),(166,270),(166,271),(166,273),(167,270),(167,271),(167,273),(168,270),(168,271),(168,273),(169,270),(169,271),(169,273),(170,270),(170,271),(170,273),(171,270),(171,271),(171,273),(172,270),(172,271),(172,273),(173,270),(173,271),(173,273),(174,270),(174,271),(174,273),(175,270),(175,271),(175,273),(176,270),(176,271),(176,273),(177,270),(177,271),(177,273),(178,270),(178,271),(178,273),(179,270),(179,271),(179,273),(143,270),(143,272),(144,270),(144,272),(145,270),(145,272),(146,270),(146,272),(246,270),(246,272),(151,270),(151,271),(150,270),(150,271),(149,270),(149,271);
/*!40000 ALTER TABLE `tbl_perm_entry_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_refresh_token`
--

DROP TABLE IF EXISTS `tbl_refresh_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_refresh_token` (
  `token_id` bigint NOT NULL,
  `gmt_created` datetime DEFAULT CURRENT_TIMESTAMP,
  `expired_date` datetime(6) DEFAULT NULL,
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `uk_token` varchar(48) NOT NULL,
  `user_pk_user_id` int DEFAULT NULL,
  PRIMARY KEY (`token_id`),
  UNIQUE KEY `uk_token` (`uk_token`),
  KEY `user_pk_user_id` (`user_pk_user_id`),
  CONSTRAINT `tbl_refresh_token_ibfk_1` FOREIGN KEY (`user_pk_user_id`) REFERENCES `tbl_user` (`pk_user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_role`
--

DROP TABLE IF EXISTS `tbl_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_role` (
  `pk_role_id` bigint NOT NULL,
  `gmt_created` datetime DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `uk_role_name` varchar(32) NOT NULL,
  PRIMARY KEY (`pk_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_role`
--

LOCK TABLES `tbl_role` WRITE;
/*!40000 ALTER TABLE `tbl_role` DISABLE KEYS */;
INSERT INTO `tbl_role` VALUES (270,'2021-01-01 00:00:00','2021-01-01 00:00:00','administrator'),(271,'2021-01-01 00:00:00','2021-01-01 00:00:00','teacher'),(272,'2021-01-01 00:00:00','2021-01-01 00:00:00','basic'),(273,'2021-01-01 00:00:00','2021-01-01 00:00:00','student');
/*!40000 ALTER TABLE `tbl_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_system_parameter`
--

DROP TABLE IF EXISTS `tbl_system_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_system_parameter` (
  `pk_id` bigint NOT NULL,
  `gmt_created` datetime DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `uk_key` varchar(48) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`pk_id`),
  UNIQUE KEY `uk_key` (`uk_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_system_parameter`
--

LOCK TABLES `tbl_system_parameter` WRITE;
/*!40000 ALTER TABLE `tbl_system_parameter` DISABLE KEYS */;
INSERT INTO `tbl_system_parameter` VALUES (3,'2021-06-21 17:35:52','2021-06-21 17:36:36','initRoles','basic,student','注册初始角色'),(132,'2021-06-08 08:26:00','2021-06-08 08:26:00','experience','2','签到经验值');
/*!40000 ALTER TABLE `tbl_system_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_user`
--

DROP TABLE IF EXISTS `tbl_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_user` (
  `pk_user_id` int NOT NULL,
  `birthday` date DEFAULT NULL,
  `college` varchar(48) DEFAULT NULL,
  `gmt_created` datetime DEFAULT CURRENT_TIMESTAMP,
  `email` varchar(255) DEFAULT NULL,
  `gender` enum('unknown','male','female') DEFAULT 'unknown',
  `major` varchar(48) DEFAULT NULL,
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name` varchar(32) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `idx_phone` varchar(20) DEFAULT NULL,
  `profile_photo` longblob,
  `shcool` varchar(48) DEFAULT NULL,
  `student_teacher_id` varchar(48) DEFAULT NULL,
  `third_party_accout` varchar(256) DEFAULT NULL,
  `third_party_account_type` enum('none','wechat','qq') NOT NULL DEFAULT 'none',
  `uk_user_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`pk_user_id`),
  UNIQUE KEY `idx_phone` (`idx_phone`),
  UNIQUE KEY `UK_fru8p10qvby4klixs652v3s9t` (`uk_user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_user`
--

LOCK TABLES `tbl_user` WRITE;
/*!40000 ALTER TABLE `tbl_user` DISABLE KEYS */;
INSERT INTO `tbl_user` VALUES (1,'2021-04-24','College of Computer Science','2021-04-23 05:03:15','admin@daoyun.six','unknown','Computer Science','2021-06-26 06:31:50','Administrator','$2a$10$SnB/ynns7uyyRZKcDWE1jOLJyg/bVy9rRaDOSMwwXrfKMT5Ka/Tqq','15900000001',_binary 'data:image/png;base64,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','FZU','00000000',NULL,'none','admin'),(5033,'1994-03-09',NULL,'2021-06-25 14:18:09',NULL,'male','','2021-06-26 07:04:04','我是老师','$2a$10$FGSseX1WAExviGtmTzMCwuIrWrdTgDBm4HMFNzvEI/lBemtdeRn2K','15900000002',_binary 'data:image/png;base64,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','FZU',NULL,NULL,'none','teacher'),(5034,'2004-02-02',NULL,'2021-06-25 14:19:07',NULL,NULL,NULL,'2021-06-25 14:19:07','学生1','$2a$10$vCEc.FPVA0B8IdFHKsik..f3bx1u7Z0JDmnvQkJALAmQPtWfhXN2W','15900000003',NULL,'FZU',NULL,NULL,'none','student1'),(5038,'2000-01-01',NULL,'2021-06-25 14:24:44',NULL,NULL,NULL,'2021-06-25 14:25:13','学生2','$2a$10$f/Ys8VnlnDUJFJ1rXmm7N.1pxd.iYvQxSDqmyvQwVq93DUh5mgBem','15900000004',NULL,NULL,NULL,NULL,'none','student2');
/*!40000 ALTER TABLE `tbl_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_user_roles`
--

DROP TABLE IF EXISTS `tbl_user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_user_roles` (
  `user_pk_user_id` int NOT NULL,
  `roles_pk_role_id` bigint NOT NULL,
  KEY `FKh7ntavp1wtd1tgqjlfimal3va` (`roles_pk_role_id`),
  KEY `FKo7qp3kq176xm4eea3gst0ub4r` (`user_pk_user_id`),
  CONSTRAINT `FKh7ntavp1wtd1tgqjlfimal3va` FOREIGN KEY (`roles_pk_role_id`) REFERENCES `tbl_role` (`pk_role_id`),
  CONSTRAINT `FKo7qp3kq176xm4eea3gst0ub4r` FOREIGN KEY (`user_pk_user_id`) REFERENCES `tbl_user` (`pk_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_user_roles`
--

LOCK TABLES `tbl_user_roles` WRITE;
/*!40000 ALTER TABLE `tbl_user_roles` DISABLE KEYS */;
INSERT INTO `tbl_user_roles` VALUES (1,270),(5034,272),(5034,273),(5038,272),(5038,273),(5033,271),(5033,272);
/*!40000 ALTER TABLE `tbl_user_roles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

