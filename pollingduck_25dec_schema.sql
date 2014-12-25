-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Dec 25, 2014 at 04:05 PM
-- Server version: 5.6.16
-- PHP Version: 5.5.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `pollican`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `createPoll`(IN `uid_i` INT(11), IN `cid_json_i` VARCHAR(30), IN `title_i` VARCHAR(100), IN `description_i` VARCHAR(500), IN `qtn_json_i` VARCHAR(1000), IN `ans_json_i` VARCHAR(1000), IN `poll_link_i` VARCHAR(100), IN `start_ts_i` TIMESTAMP, IN `end_ts_i` TIMESTAMP, IN `reward_i` INT(11), IN `poll_type_i` VARCHAR(30))
BEGIN
Declare pid_d int;
 DECLARE x  INT;
    DECLARE stri VARCHAR(3);
 DECLARE C  INT;
	DECLARE wobr  VARCHAR(100);
    
insert into poll_tbl(uid,cid_json,title,description,qtn_json,ans_json,poll_link,start_ts,end_ts,reward,poll_type) values(uid_i,cid_json_i,title_i,description_i,qtn_json_i,ans_json_i,poll_link_i,start_ts_i,end_ts_i,reward_i,poll_type_i);

SET pid_d = LAST_INSERT_ID();

 
SET x = 1;
    SET stri="";
    SET C =(LENGTH(cid_json_i)-LENGTH(REPLACE(cid_json_i ,',', '')));
    SET C = C+1;
    SET wobr=(substring(cid_json_i,2,LENGTH(cid_json_i)-2));
    WHILE x <= C DO
    SET stri = replace(substring(substring_index(wobr, ',',x),length(substring_index(wobr, ',' , x - 1)) + 1), ',', '');
    if length(stri) > 0 then
    INSERT INTO pid_cid_mapper (pid, cid) VALUES (pid_d, stri);
    end if;
    SET  x = x + 1;
    END WHILE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `createPoll2`(IN `uid_i` INT(11), IN `cid_json_i` VARCHAR(30), IN `title_i` VARCHAR(100), IN `description_i` VARCHAR(500), IN `qtn_json_i` VARCHAR(1000), IN `ans_json_i` VARCHAR(1000), IN `poll_link_i` VARCHAR(100), IN `start_ts_i` TIMESTAMP, IN `end_ts_i` TIMESTAMP, IN `reward_i` INT(11), IN `poll_type_i` VARCHAR(30), OUT `pid_o` INT(11))
BEGIN
Declare pid_d int;
 DECLARE x  INT;
    DECLARE stri VARCHAR(3);
 DECLARE C  INT;
	DECLARE wobr  VARCHAR(100);
    
insert into poll_tbl(uid,cid_json,title,description,qtn_json,ans_json,poll_link,start_ts,end_ts,reward,poll_type) values(uid_i,cid_json_i,title_i,description_i,qtn_json_i,ans_json_i,poll_link_i,start_ts_i,end_ts_i,reward_i,poll_type_i);

SET pid_d = LAST_INSERT_ID();

 
SET x = 1;
    SET stri="";
    SET C =(LENGTH(cid_json_i)-LENGTH(REPLACE(cid_json_i ,',', '')));
    SET C = C+1;
    SET wobr=(substring(cid_json_i,2,LENGTH(cid_json_i)-2));
    WHILE x <= C DO
    SET stri = replace(substring(substring_index(wobr, ',',x),length(substring_index(wobr, ',' , x - 1)) + 1), ',', '');
    if length(stri) > 0 then
    INSERT INTO pid_cid_mapper (pid, cid) VALUES (pid_d, stri);
    end if;
    SET  x = x + 1;
    END WHILE;
 
set pid_o = pid_d ; 

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `createUser`(IN `handle_i` VARCHAR(45), IN `username_i` VARCHAR(45), IN `email_i` VARCHAR(45), IN `country_i` VARCHAR(45), IN `state_i` VARCHAR(45), IN `city_i` VARCHAR(45), IN `zip_i` VARCHAR(45), IN `religion_i` VARCHAR(45), IN `sex_i` VARCHAR(45), IN `dob_i` VARCHAR(45), IN `phone_i` VARCHAR(45), IN `profile_pic_i` VARCHAR(1000), IN `fb_i` VARCHAR(100), IN `category_list_json_i` VARCHAR(1000), IN `exp_json_i` VARCHAR(1000), IN `fish_i` INT, IN `hashed_password_i` VARCHAR(1000))
BEGIN
Declare uid_d int DEFAULT 0;
insert into login_tbl(fb,email,handle,hashed_password) values(fb_i,email_i,handle_i,hashed_password_i);
select uid into uid_d from login_tbl where email=email_i;
 insert into user_detail(uid,handle,username,country,state,city,zip,religion,sex,dob,phone,profile_pic) values(uid_d,handle_i,username_i,country_i,state_i,city_i,zip_i,religion_i,sex_i,dob_i,phone_i,profile_pic_i); 
 insert into user_store(uid,category_list_json,exp_json,fish) values(uid_d,category_list_json_i,exp_json_i,fish_i);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `createUser2`(IN `handle_i` VARCHAR(45), IN `username_i` VARCHAR(45), IN `email_i` VARCHAR(45), IN `country_i` VARCHAR(45), IN `state_i` VARCHAR(45), IN `city_i` VARCHAR(45), IN `zip_i` VARCHAR(45), IN `religion_i` VARCHAR(45), IN `sex_i` VARCHAR(45), IN `dob_i` VARCHAR(45), IN `phone_i` VARCHAR(45), IN `profile_pic_i` VARCHAR(1000), IN `fb_i` VARCHAR(100), IN `category_list_json_i` VARCHAR(1000), IN `exp_json_i` VARCHAR(1000), IN `fish_i` INT, IN `hashed_password_i` VARCHAR(1000))
BEGIN
Declare uid_d int DEFAULT 0;
 DECLARE x  INT;
    DECLARE stri VARCHAR(3);
 DECLARE C  INT;
	DECLARE wobr  VARCHAR(100);
    
insert into login_tbl(fb,email,handle,hashed_password) values(fb_i,email_i,handle_i,hashed_password_i);
select uid into uid_d from login_tbl where email=email_i;
 insert into user_detail(uid,handle,username,country,state,city,zip,religion,sex,dob,phone,profile_pic) values(uid_d,handle_i,username_i,country_i,state_i,city_i,zip_i,religion_i,sex_i,dob_i,phone_i,profile_pic_i); 
 insert into user_store(uid,category_list_json,exp_json,fish) values(uid_d,category_list_json_i,exp_json_i,fish_i);
 
SET x = 1;
    SET stri="";
    SET C =(LENGTH(category_list_json_i)-LENGTH(REPLACE(category_list_json_i ,',', '')));
    SET C = C+1;
    SET wobr=(substring(category_list_json_i,2,LENGTH(category_list_json_i)-2));
    WHILE x <= C DO
    SET stri = replace(substring(substring_index(wobr, ',',x),length(substring_index(wobr, ',' , x - 1)) + 1), ',', '');   
    INSERT INTO uid_cid_mapper (uid, cid) VALUES (uid_d, stri);
    SET  x = x + 1;
    END WHILE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `myProc`()
BEGIN
    DECLARE x  INT;
    DECLARE stri VARCHAR(3);
    SET x = 1;
    SET stri="";
    WHILE x <= 20 DO
    SET stri = replace(substring(substring_index('1,2,3,4,5,6,7,8', ',',x),length(substring_index('1,2,3,4,5,6,7,8' , ',' , x - 1)) + 1), ',', '');
    if length(stri) > 0 then   
    INSERT INTO `pollican`.`uid_cid_mapper` (`uid`, `cid`) VALUES (21, stri);
    SET  x = x + 1;
    end if;
    END WHILE;
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `myProc1`()
BEGIN
    DECLARE x  INT;
    DECLARE stri VARCHAR(2);
    SET x = 1;
    WHILE x <= 5 DO
    SET stri = replace(substring(substring_index('34,35,36,37,38,39', ',',x),length(substring_index('34,35,36,37,38,39' , ',' , x - 1)) + 1), ',', '');
    SET  x = x + 1;
    INSERT INTO `pollican`.`uid_cid_mapper` (`uid`, `cid`) VALUES ('44', stri);
    END WHILE;
    END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `category_tbl`
--

CREATE TABLE IF NOT EXISTS `category_tbl` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) NOT NULL,
  `group_name` varchar(100) NOT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=86 ;

-- --------------------------------------------------------

--
-- Table structure for table `login_tbl`
--

CREATE TABLE IF NOT EXISTS `login_tbl` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `fb` varchar(50) DEFAULT NULL,
  `twitter` varchar(50) DEFAULT NULL,
  `gmail` varchar(50) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `followers` varchar(1000) DEFAULT '[]',
  `following` varchar(1000) DEFAULT '[]',
  `handle` varchar(45) NOT NULL,
  `hashed_password` varchar(1000) NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=42 ;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE IF NOT EXISTS `notifications` (
  `nid` bigint(20) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `notification` varchar(100) DEFAULT NULL,
  `link` varchar(100) DEFAULT NULL,
  `checked` tinyint(4) DEFAULT '0',
  `ts` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`nid`),
  KEY `uid_idx` (`uid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=32 ;

-- --------------------------------------------------------

--
-- Table structure for table `pid_cid_mapper`
--

CREATE TABLE IF NOT EXISTS `pid_cid_mapper` (
  `pid` int(11) NOT NULL,
  `cid` varchar(4) NOT NULL,
  KEY `pid_cid_mapper_ibfk_1` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `poll_ans_tbl`
--

CREATE TABLE IF NOT EXISTS `poll_ans_tbl` (
  `poll_ans_key` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `ans_json` varchar(1000) NOT NULL,
  `solve_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `anonymous` int(11) DEFAULT '0',
  PRIMARY KEY (`poll_ans_key`),
  KEY `pid` (`pid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=78 ;

-- --------------------------------------------------------

--
-- Table structure for table `poll_tbl`
--

CREATE TABLE IF NOT EXISTS `poll_tbl` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `cid_json` varchar(30) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` varchar(500) NOT NULL,
  `qtn_json` varchar(1000) NOT NULL,
  `ans_json` varchar(1000) NOT NULL,
  `poll_link` varchar(100) NOT NULL,
  `start_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `end_ts` timestamp NULL DEFAULT NULL,
  `reward` int(11) NOT NULL,
  `poll_type` varchar(30) NOT NULL,
  PRIMARY KEY (`pid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=101 ;

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE IF NOT EXISTS `student` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(20) NOT NULL,
  `AGE` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Table structure for table `uid_cid_mapper`
--

CREATE TABLE IF NOT EXISTS `uid_cid_mapper` (
  `uid` int(11) NOT NULL,
  `cid` varchar(45) NOT NULL,
  KEY `uid_cid_mapper_ibfk_1` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_detail`
--

CREATE TABLE IF NOT EXISTS `user_detail` (
  `uid` int(11) NOT NULL,
  `handle` varchar(45) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `country` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `zip` varchar(10) NOT NULL,
  `religion` varchar(30) NOT NULL,
  `sex` varchar(10) NOT NULL,
  `dob` varchar(20) NOT NULL,
  `phone` varchar(30) NOT NULL,
  `profile_pic` varchar(500) DEFAULT NULL,
  UNIQUE KEY `idx_user_detail_handle` (`handle`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_store`
--

CREATE TABLE IF NOT EXISTS `user_store` (
  `uid` int(11) NOT NULL,
  `category_list_json` varchar(1000) NOT NULL,
  `exp_json` varchar(5000) NOT NULL,
  `fish` int(11) NOT NULL,
  `lc` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `idx_user_store_uid` (`uid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `uid` FOREIGN KEY (`uid`) REFERENCES `login_tbl` (`uid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `pid_cid_mapper`
--
ALTER TABLE `pid_cid_mapper`
  ADD CONSTRAINT `pid_cid_mapper_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `poll_tbl` (`pid`);

--
-- Constraints for table `poll_ans_tbl`
--
ALTER TABLE `poll_ans_tbl`
  ADD CONSTRAINT `poll_ans_tbl_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `poll_tbl` (`pid`),
  ADD CONSTRAINT `poll_ans_tbl_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `login_tbl` (`uid`);

--
-- Constraints for table `poll_tbl`
--
ALTER TABLE `poll_tbl`
  ADD CONSTRAINT `poll_tbl_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `login_tbl` (`uid`);

--
-- Constraints for table `uid_cid_mapper`
--
ALTER TABLE `uid_cid_mapper`
  ADD CONSTRAINT `uid_cid_mapper_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `login_tbl` (`uid`);

--
-- Constraints for table `user_detail`
--
ALTER TABLE `user_detail`
  ADD CONSTRAINT `user_detail_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `login_tbl` (`uid`);

--
-- Constraints for table `user_store`
--
ALTER TABLE `user_store`
  ADD CONSTRAINT `user_store_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `login_tbl` (`uid`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
