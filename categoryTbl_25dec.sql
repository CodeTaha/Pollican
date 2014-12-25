-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Dec 25, 2014 at 04:09 PM
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

--
-- Dumping data for table `category_tbl`
--

INSERT INTO `category_tbl` (`cid`, `category_name`, `group_name`) VALUES
(1, 'programming_languages', 'technology'),
(2, 'software', 'technology'),
(3, 'hardware', 'technology'),
(4, 'tech_companies', 'technology'),
(5, 'architecture', 'technology'),
(6, 'operating_systems', 'technology'),
(7, 'databases', 'technology'),
(8, 'mobile', 'technology'),
(9, 'frameworks_engines', 'technology'),
(10, 'opensource', 'technology'),
(11, 'research', 'technology'),
(12, 'networks', 'technology'),
(13, 'security', 'technology'),
(14, 'cloud', 'technology'),
(15, 'bigdata', 'technology'),
(16, 'engineering', 'technology'),
(17, 'graphics', 'technology'),
(18, 'reviews_ratings', 'technology'),
(19, 'blogs', 'writing_and_content'),
(20, 'books', 'writing_and_content'),
(21, 'articles', 'writing_and_content'),
(22, 'news', 'writing_and_content'),
(23, 'content_writing', 'writing_and_content'),
(24, 'presentation', 'writing_and_content'),
(25, 'publishing', 'writing_and_content'),
(26, 'accommodation', 'travel'),
(27, 'transport', 'travel'),
(28, 'places', 'travel'),
(29, 'online_shopping', 'shopping'),
(30, 'stores', 'shopping'),
(31, 'coupons_offers', 'shopping'),
(32, 'about', 'people_and_relations'),
(33, 'age_groups', 'people_and_relations'),
(34, 'living', 'people_and_relations'),
(35, 'ethnicity', 'language_and_culture'),
(36, 'values_traditions', 'language_and_culture'),
(37, 'languages', 'language_and_culture'),
(38, 'society', 'language_and_culture'),
(39, 'renting', 'home_and_living'),
(40, 'commodities', 'home_and_living'),
(41, 'appliances', 'home_and_living'),
(42, 'money', 'home_and_living'),
(43, 'standards', 'home_and_living'),
(44, 'hobbies', 'home_and_living'),
(45, 'habits', 'food'),
(46, 'restaurants_dining', 'food'),
(47, 'cooking', 'food'),
(48, 'drinks_beverages', 'food'),
(49, 'ratings_reviews', 'food'),
(50, 'brands', 'sports'),
(51, 'academy', 'sports'),
(52, 'sportsperson', 'sports'),
(53, 'outdoor', 'sports'),
(54, 'indoor', 'sports'),
(55, 'teams', 'sports'),
(56, 'rankings', 'sports'),
(57, 'institutions', 'jobs_and_education'),
(58, 'qualifications', 'jobs_and_education'),
(59, 'financial_information', 'jobs_and_education'),
(60, 'standards', 'jobs_and_education'),
(61, 'classifieds', 'jobs_and_education'),
(62, 'general_sciences', 'sciences'),
(63, 'research', 'sciences'),
(64, 'branding', 'sales_and_marketing'),
(65, 'online', 'sales_and_marketing'),
(66, 'media', 'sales_and_marketing'),
(67, 'agents', 'sales_and_marketing'),
(68, 'customers', 'sales_and_marketing'),
(69, 'advertisements', 'sales_and_marketing'),
(70, 'movie_music', 'entertainment_and_arts'),
(71, 'institutes', 'entertainment_and_arts'),
(72, 'general_information', 'entertainment_and_arts'),
(73, 'places', 'entertainment_and_arts'),
(74, 'interior', 'design_and_media'),
(75, 'types_of_media', 'design_and_media'),
(76, 'animation_graphics', 'design_and_media'),
(77, 'accounting_audit', 'business_and_finance'),
(78, 'models', 'business_and_finance'),
(79, 'e_business', 'business_and_finance'),
(80, 'funds_revenues', 'business_and_finance'),
(81, 'firms', 'business_and_finance'),
(82, 'legal', 'business_and_finance'),
(83, 'economy', 'business_and_finance'),
(84, 'banking', 'business_and_finance'),
(85, 'real_estate', 'business_and_finance');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
