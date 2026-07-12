-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 21, 2025 at 08:34 AM
-- Server version: 10.11.10-MariaDB-log
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u732316139_ludoshop`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `email` varchar(250) NOT NULL,
  `password` text NOT NULL,
  `full_name` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `email`, `password`, `full_name`) VALUES
(1, 'admin@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', 'Admin');

-- --------------------------------------------------------

--
-- Table structure for table `admin_access`
--

CREATE TABLE `admin_access` (
  `id` int(11) NOT NULL,
  `admin_email` varchar(250) NOT NULL,
  `can_access_r` int(11) NOT NULL,
  `can_access_rd` int(11) NOT NULL,
  `can_access_cr` int(11) NOT NULL,
  `can_access_mc` int(11) NOT NULL,
  `can_access_mp` int(11) NOT NULL,
  `can_access_kycr` int(11) NOT NULL,
  `can_access_m` int(11) NOT NULL,
  `can_access_mg` int(11) NOT NULL,
  `can_access_wr` int(11) NOT NULL,
  `can_access_rab` int(11) NOT NULL,
  `can_access_nam` int(11) NOT NULL,
  `can_access_ps` int(11) NOT NULL,
  `can_access_th` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `apis`
--

CREATE TABLE `apis` (
  `id` int(11) NOT NULL,
  `tag` varchar(100) DEFAULT NULL,
  `apikey` text DEFAULT NULL,
  `secretkey` text DEFAULT NULL,
  `authtoken` text DEFAULT NULL,
  `updated_at` int(20) DEFAULT NULL,
  `created_at` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `apis`
--

INSERT INTO `apis` (`id`, `tag`, `apikey`, `secretkey`, `authtoken`, `updated_at`, `created_at`) VALUES
(1, 'FAST2SMS', 'NOT_WORKING', '', '', 1721064218, 0),
(2, 'AADHAR', 'AADHAR_API', 'KEY', NULL, 1721064240, 1721064240),
(3, 'PAYMENT', 'PayTM', '9876543210', NULL, 1721064267, 0),
(4, 'UPIGATEWAY', '463da4f7-ca3d-449b-999b-5d3c8891c625', NULL, NULL, 1737190100, 0),
(5, 'PHONEPE', '123', '9876543210', NULL, 1721064279, 0),
(6, 'CASHFREE', '123', '9876543210', NULL, 1722958759, 0);

-- --------------------------------------------------------

--
-- Table structure for table `cancel_reqs`
--

CREATE TABLE `cancel_reqs` (
  `id` int(11) NOT NULL,
  `req_by` int(11) NOT NULL,
  `match_id` int(11) NOT NULL,
  `reason` varchar(250) NOT NULL,
  `created_at` int(100) NOT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `conflicts`
--

CREATE TABLE `conflicts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `match_id` int(11) NOT NULL,
  `created_at` int(100) NOT NULL,
  `screenshot` text NOT NULL,
  `status` int(11) NOT NULL,
  `looser_screenshot` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `conflicts`
--

INSERT INTO `conflicts` (`id`, `user_id`, `match_id`, `created_at`, `screenshot`, `status`, `looser_screenshot`) VALUES
(1, 25, 52, 1738420775, '39d53fb34c762ffaaf569703e18e258e.jpeg', 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `games`
--

CREATE TABLE `games` (
  `id` int(11) NOT NULL,
  `game_name` varchar(250) NOT NULL,
  `logo` text NOT NULL DEFAULT 'no-img.png',
  `instructions` text NOT NULL,
  `soft_delete` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `games`
--

INSERT INTO `games` (`id`, `game_name`, `logo`, `instructions`, `soft_delete`, `status`) VALUES
(1, 'Snake', '97f10850a3483953a097eb20702a447f.png', '', 1, 0),
(2, '1 GOTI', '66974451afec06fe594324609903fb9d.png', '', 1, 0),
(3, 'Quick Game', 'b88bb8fbf94adbd6544a50b6e5569f2f.png', '', 1, 0),
(4, '2 Goti Ulta (Loser Wins)', 'no-img.png', '', 1, 0),
(5, '3 Goti Ulta (Loser Wins)', 'no-img.png', '', 1, 0),
(6, '1 Goti Ulta', 'no-img.png', '', 1, 0),
(7, 'Popular Full', '6946084368e5acab0d11e1f7397be970.png', '', 1, 0),
(8, '1 Goti Classic', 'no-img.png', '', 1, 0),
(9, '2 Goti Classic', 'no-img.png', '', 1, 0),
(10, '3 Goti Classic', 'no-img.png', '', 1, 0),
(11, '1 Goti Popular', 'no-img.png', '', 1, 0),
(12, '2 Goti Popular', 'no-img.png', '', 1, 0),
(13, '3 Goti Popular', 'no-img.png', '', 1, 0),
(14, 'Snake & Ladder Ulta (Loser Wins)', 'no-img.png', '', 1, 0),
(15, 'Ludo Ulta (Loser Wins)', 'no-img.png', '', 1, 0),
(16, '1 Goti', 'a0b9955ccb977032c3e41b9f78161157.png', '', 1, 0),
(17, 'Single Goti', '9e6195c128bb23e360fd1c934708d615.png', 'अगर कोई फ्रॉड स्क्रीनशॉट या किसी भी तरह का फ्रॉड करता है तो ₹100 पलेंटी', 0, 1),
(18, '1 GOTI', '4eb15a3644837879670a02c68691c07a.png', 'यह गेम सिंगल 1 गोटी का है', 1, 0),
(19, 'Popular game', '683d93c7df97a6caa5043b0064fbdee1.jpg', 'PLAY AND WIN', 1, 0),
(20, 'Snake', 'b942013dede9c23e73e936e5e75cab77.png', '', 1, 0),
(21, '1 GOTI', '4ec643e45fdad209b5ef0fefd0d114ab.jpg', '', 1, 0),
(22, 'Popular Game', 'e6e86851798d6c098e31b5af347ae8ce.jpg', '', 1, 0),
(23, 'Ludo Classic', '0e4c05a8aa1f4b74bd153e7bbeae81f4.png', 'अगर कोई फ्रॉड स्क्रीनशॉट या किसी भी तरह का फ्रॉड करता है तो ₹100 पलेंटी', 0, 1),
(24, 'single goti', '07fdfcd1f2f5f2dc7f45e81cf2a26d19.png', '', 1, 0),
(25, 'test', 'no-img.png', 'test', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `kycs`
--

CREATE TABLE `kycs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `aadhar_no` varchar(20) NOT NULL,
  `kycdata` text NOT NULL,
  `aadhar_front` text NOT NULL,
  `aadhar_back` text NOT NULL,
  `created_at` int(20) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `matches`
--

CREATE TABLE `matches` (
  `id` int(11) NOT NULL,
  `host_id` int(11) NOT NULL,
  `joiner_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `game` int(11) NOT NULL,
  `room_code` varchar(50) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL,
  `winner` int(11) NOT NULL,
  `winner_time` int(20) NOT NULL,
  `looser` int(11) NOT NULL,
  `looser_time` int(11) NOT NULL,
  `winner_screenshot` text NOT NULL,
  `looser_screenshot` text NOT NULL,
  `created_at` int(20) NOT NULL,
  `joiner_time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `on_homepage_top` text NOT NULL,
  `on_homepage_bottom` text NOT NULL,
  `on_dashboard_top` text NOT NULL,
  `on_dashboard_top_marque` text NOT NULL,
  `on_header_top_strip` text NOT NULL,
  `on_match_screen_top` text NOT NULL,
  `on_match_screen_middle` text NOT NULL,
  `on_match_screen_bottom` text NOT NULL,
  `on_under_maintenance` text NOT NULL,
  `on_win_pop_up` text NOT NULL,
  `on_lose_pop_up` text NOT NULL,
  `on_conflict_pop_up` text NOT NULL,
  `on_add_money` text NOT NULL,
  `on_withdraw_money` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `on_homepage_top`, `on_homepage_bottom`, `on_dashboard_top`, `on_dashboard_top_marque`, `on_header_top_strip`, `on_match_screen_top`, `on_match_screen_middle`, `on_match_screen_bottom`, `on_under_maintenance`, `on_win_pop_up`, `on_lose_pop_up`, `on_conflict_pop_up`, `on_add_money`, `on_withdraw_money`) VALUES
(1, 'LudoAdda', 'This Game involves an element of financial risk and may be addictive. Please Play responsibly and at your own risk', 'पेमेंट करने के बाद स्क्रीनशॉट ले और सपोर्ट पर जाकर एडमिन को सेंड करें पैसे आपके 3 से 5 मिनट में ऐड हो जाएंगे', 'Withdrawal only 1 minutes ', '', 'Script Download', '₹ 50 fine for wrong update & 25 Rs fine for not updating lost', 'King', 'we are updating the website for you, we will come back online soon. Thanks for waiting !', 'if you submit a false result , you will be charged 25rs penalty', 'if you submit a false result , you will be charged 25rs penalty', 'do not submit false result', 'if money not added to your wallet after paying ,contact admin & share screenshot.', 'Take your reply ID and instant withdraw ');

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` int(11) NOT NULL,
  `placement` int(11) NOT NULL,
  `page_name` varchar(250) NOT NULL,
  `page_slug` text NOT NULL,
  `page_content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `placement`, `page_name`, `page_slug`, `page_content`) VALUES
(4, 2, 'Legal Terms', 'terms', '<p>this is a demo content for legal terms page it is mention in login and signup both pages</p>'),
(5, 2, 'Privacy Policy', 'privacy-policy', '<p>this is a example of privacy policy page you can update it from admin panel</p>'),
(6, 2, 'Terms & Conditions', 'terms-and-conditions', '<p>this is example of terms and condition page you can change it from admin panel</p>'),
(7, 1, 'Disclaimer', 'disclaimer', '<p>this is example of disclaimer page, you can change it from admin panel</p>'),
(8, 2, 'Contact Us', 'contact-us', '<p>this is example of contact us page, you can update it from admin panel</p>'),
(9, 1, 'Refund & Cancellation', 'refund-and-cancellation', '<p>We don\'t have refund policy.</p>');
INSERT INTO `pages` (`id`, `placement`, `page_name`, `page_slug`, `page_content`) VALUES
(10, 1, 'T12', 'Such dhudjd hxjdvd bchdhvx dbhx dbhcj jdike bdhdjc  dcn', '<p><img src=\"data:image/jpeg;base64,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Xs7x8a5UpCOPAXs7x8acBezvHxrlSkI48BezvHxpwF7O8fGuVKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKjY8D2GIXHEdohSlKhC44jtEKUpSIkEbwR54UpSoXHEdoiNjwPYYUpSowseB7DClKUhY8D2GFKUqFxxHaIjkX8VX5p9kKUpS44jtEQseB7DClKUuOI7RCx4HsMKUpUYWPA9hhSlKhccR2iFjwPYYUpSoZ0fGT+cPbCx4HsMKUpTOj4yfzh7YWPA9hhSlKmhY8D2GFKUqFxxHaIjkX8VX5p9kKUpS44jtEQseB7DClKUuOI7REci/iq/NPshSlKjEsKUpSEKUpSEKUpSEKUpSEKUpSEKUpSIEgbyB5zaFKUpEbE7gTClKVGx4HsMRbBd+1Auf9GCv/ALN4UpX3YewfYNQin0jf3xH5yfbHylK+b+oR+8UR/cAaRVKFjehQ86SP2R9pX3btEoffMUv7ohXHfcdgAR9YFEQ/CABL30iPRufe1/mq9kfaV92N0Bwm6erzTfu7bB8tfKRAIWdyFHzJJ/ZClB6OsB9g0pEiFJc+1qDn5BCv+zeFKUqNjwPYYmCVK3JUfMCfmhSlKhEUoWv4CFL/ACUlXzAwpSlIlhSlKQhSlKQhSlKQhSlKQhSlKQhSlKRJ0iLKOdFkfDOYWT+Ub2T6bQpSlImJACiSAEfDJIAT+UdyfTaFKUpEpcbCFLK0BCPhrKk5E/lKvZPpIhSlKRHMnIpzMnIj4a7jIn8pV7J9JEcuA3Z3h41xqYr7wE7Q/BqFxxHaInKVBCnCCEI+GsghCPylbk+kiJalTPATtD8GuXNB6vwQ8aXHEdoiW4KFLBBQj4a7+Qj8pW5PpIiUpXZcyX/ffxpzJf8AffxqkXyN6refMPniqW2wFKJSEo+GSpACPyjuT6bR1tK7Tyb1f7/hVM+SE7A9vzVQ8YHxh+eIqCVUdzaj5gD8wjoq48ZPjkH7xiiHtAdq7/yQnYHt+aqhW5FxS8eIHjWZzFPzYnEgiIHD0bCG/wDdAAl6Ovtl91GfiD1RXlqW698JfV1m178vNx9fXSABKPUcg/8AWE/hVx4yfoif64T+FVwpLdhC9cQ1+UAER+/XMLbgh6olp7P/AEatzVWRvQkecgRlBhecOgWSeAN/mEW8cRP0RL9dT/hV84yfoif64T+FVxgW7Aj1Q7Dt+AcP3QqJ71oH/ieP6lB/Ozf1P4YD0dAh6AHpN9iA092G/vZ/NTFcYTmCnMH7p+MFAp7Rp64tw4ifoiX66n/Cr5xk/RE/1wn8Krnfevb3/E0d+tG8K5hbcCPVCR3b+dCH7o1L7tsfFH6ntiIwjNHc8T5iD80Wv8ZP0RP9cJ/Cr7xE/REv11P+FV04Wvbo9UJHfgG8Kjhadrj1QUf+tj4Vb/XLK/ej+aYuvrGqH4YO0RajxE/REv11P+FTiJ+iJfrqf8Krr/elbH/EMf8AgD4VMBZ9sD1QEd+t/NVv9dbH4OfzVROMAzh3Tl/MoH5otL4DdneHjXGrvAsy1R6reiv7xJ/GKie8a1Ptdif7wT/jNQ+uyX+8fqmJve9n/wAJV2xaBsPYPsGvnR8Yv4RfGrxfeLaH2twX94n/ANdU57x7U+1iE/F5P4zUn16S/wB5Hf0RX97ic/CR+d9EWYcI9pfwyfwq49Hxi/hF8avM941o/a5B/i4P4xUX3iWb9qsJ+Ly/xqrf69Jf7yO/oiHvczf4Un86LLuj4xfwi+NOj4xfwi+NXohYtmiPCFqwvF9c833ODiAUvzwBL5VuAl7BABH7EBp7xbN32960GA8QEEBYkASHFXmOBQBdgKZgV80xVOESdZwKXpqIxvIkrAklEo+GAlRKPyxbyfTaCtnE2hxTK5lKHUJYUtpSsriEzX+rKUg2UlMx/uCQA9/uyqLLuj4xfwi+NOj4xfwi+NXn+8ey/tWhPxeH8ap7xbO+12E/Fv8A/wB6h9fNP/Az2GHvczf4Un86LMRAwdZTfgj4V86PjF/CL41egexrTHqtaB6tg/MZ/b0uPCoHvEtL7XIb8Xl/jNXH16S/3kd/REPe6mvwtH54izjgN2d4eNOA3Z3h41eF7yLS+12L/vEn8bqXGzLVDrt6K/vEn8YqYYulTuZB8wJ+aIe97P8A4Snti0ETph1qJfrqf8KvvET9ES/XU/4VXcKWfa//ABDH7f2g7h8u3+/TXz3pWx/xDH/gD4VN9dbH4OfzVRR+sCd/C/1hFowqJh1qJh/dk8a5cRP0RL9dT/hVdce1LbN1QkeP30T9/m9Pd8tQBtC3Q64aO/WjVcfXLK/ej+aYp/WRP/hqfzk+2LWaUpWwxpcKUpSEKUpSEKUpSEKUpSIIIdTnbIcR8ZHlp/OTceuFK+CJQ23OQph6kzHIVb5URMCofKQK+j0GFMdyqh1omASuP73EAWHq9CdILUltWVxQbV8VZCVdirH1Qr6IbdIiBQ+MYQAg/eOIgQ39yYa+pEO4WK2apqu3Rvgs2aSjx6P3mbYqrnf1c1vV0GNtFmqXLYtz2dhe8TMHHQEtcUelakSy9I7++xxCGV2D9CKp+6FQuOI7Yz1GwzXa7b3MolXqZO7xCmTk5/8AmzDkWvFDi2EokMUepQDkFL5VeLmw+UwensriIlAekxNvSbjJwF3+MpxcBP7owVmGsnkYNR86CTq+ryxzYxF9/KGbN/K3fKIbB0AH5mSiD9n1t0bpHcRq8CzORGxowIktfOYsgT7k2/lbe32MNbDJYenqBJR4YoD19BfZUpcbGvSI9Ckn1Akj0x1ml+DdtcrQBewdIUoHT/TJ5UqdD1h4oVz1A6yLxreGTVIG6iDlIOxZsuib8FVMhu6oBV2xjgkV00MobqTK6bicf7kFRH2hW3DaXJNaObRATjjla71thDnLwuObd9e/V5K5RDo6Osno9NXZWnphwNYqZSWnhzHkLt/VGdtRZXIb9jhVNZX09O6u3ZUnjA0+yDW27NcX/KKRp16x0ym+Bxi2csa1X6fJjrEm6FK46AZRw3qSN+saTsXYN/zZ0yQ9g33KGV/OxYWZczspv7tCLOQP7owVViL0p6m5kCiw0+5dOBvgmcWbMsCj/dP2zUvfW7m3iGrIgJsGjdomUNgI3TRbF+QqCQAAf77dAVMeRqAUpCKCmmUA2IUVAEO0OIq4fvhv21SDwvqTb8ux7cqvmjocj4G9DY/1jGlSdFuqmAG/nVfiTe37Y01Y3k6taEsnzrTBU6QnZIXDZEQf9alrnZK/tK9MlyYGtg/XiJu3/tr3x6IftbwN9/5a3CxRN1gG5vuxMcv4AqbdX/qa+mIob0D98Dh094DTpxz/AEg/s9+cZ+X8EDZuzbpahWnL6aZzw1Nk9+uNQlHkrtaig9GOYFD/ANuMhWsr/wDepw+3+4BUypyVGtMiXH7w7VXH9Kt8hW+kP64rMJk/ber11t3AmbbpD2GHxr4KRh7faA+zcQCnTp5/pB/Zi7/5JGzP8LrXV1q5X0y3767jGnSPJka2+cXJ9Jr6yH5yr7+cd+d98vvw4g6PjAHfXUv+Tk1pxqfOucGSxif+R3VYEif9ajrsdK/tK3LAIpv1GD18YfvV85tUekdhMH2W3CUen0lKoO/b0/u06cc/0g5fJ8/qizf8EHZu99qn600bbznHC/3F9Ln9lrWjRqufTXqKshIzm7MIZNimpB2M7Gzpt8zKIhvsLuOZu2vV0/nvd01SGShJ2GAx5qCnYRMvWtNQ0nEIB/70SLVsj7FK36/JDKAYFwE/GGxwMYTJ7dnMGVUSDqDqDYa6eUtGCnW5m07Dx002H/xOUYx8g2+RN00MX8IB27qF4XOpA6vLufmT80azUPA2pb1zT8cVKWHUFUzW2h+5tfrO4cLEg20FyHIqAiici/D1g3OVcQ/uUROb2BXIoGU/O01VP+bSUU/0CmrdHujQjpOvYDe+PAON1VBDbnWMCnD79n/gdy0HftEwDvVCbg5JHR1PhslYcpbI9ts3fPIB7Hrhcfl6+v79VfGB98T2q+cXHrjns74HeMWBeVrkg71eQ6SerQC2luemm/jqWEOVQQKmPOGHqKnuob8EnEb2hXIdi8XEIBw9YCIAPyAPSPyANbDuS+RKtt2gq4xLmS5YlwP53DX+wZXDFh1dbxkLd2AD1h5m4edv6BGwDIHJR6xLEIorF2bbl/M0Q3bvbDuxqkusIgAiAsbidR74ogA7CJm4BuHWNT9I2RfpEcPhJB7Cb+ndHKMQeDxtSoIvN4KVVb/wA+/UO0SaXiAdLXsOqMcNKqbeuFsv45UUSvnF9/WwKYbnUlbSnEGwB17g7BiZqYP7VYapckqiuoCLdZFy4HqbNlk3Lr5WqBlHAfKkFTXHEdojlk/R6vSv9qUqpU3/AO/yM1J//nDTcRKUKAmHYgCf1kATh+EXcO+g9AD1eb1gAgJvkKG5h+QBqMY8JUVZQCVfFAJV2b4UpSkSZ0HctJ/lD2wpSlImhSlKQhSlKQj7sYREAKc2xik3IQxwMc3UUgkAwHN8YCCYSfZbV8DzgAQ9PBt6NwU+AOw7DsPpHqL9kIVfhoi0+YDz26yclnPJx7HNbEXHr200Ccjbf573RTVNKTpFXpyJKBHqkSRBoc6bg/O86kQyZDGGx2VaN4+VlY5i8CRZtHUozjZMqaiZXMcUdo55zKxE10hV/Q1k010/6qmnUbGwPUb29G/542Obw3PUui0DEa5mmutV0keIJmGFvrKSL2YSsuG19PIueokXvI9O4l2NuCpkDbFMIEVJ8MihgDZMS+kTiUA7a+CIAIAO4CJ1E9th3AyP55xBtuUC/GNsQfsTDV/einTtp/zswyk7zVlYtgOLZYFCCYoSzOIFRrKpqGkLldKynNoPzMlCkSKyQVF0fjE5CCBSlPYY8Ik1ePUGjny9FFd42bvubURCQZq7827KkuRNZATfEXTSVDoESUsQAeo3tu6t/m9MQqWFqpTKLQMRrnKY63XSf9BTMsKfXbQ/YQsuHf1pF+qIIAYdtin6TcG3AYBA3xTAIblH+2ANq477AJh3AChuICAgb5C7cQ/IA1kB0V6c9POcYHK8rmrKw2LJWgkVtbzJOaZQpkI8ySpxud0aU5tKTMByEKDFsoLnzvPKmYUyqWDOE0knSpEXPliSLv8AM7sCKJlXb7fCFJUpFS9nCoQpvudqWIAPUb29G+I1LDc9S6PQK4uYpz0tXL/6GmYYU8uxIOVoLKzrponnEAAE22xTjxDw/APuBvinDbzDfcn4TequQkMUwlEA3ANx2EBDb1CAiA/eARGr/wDRdpx0+ZytjLstmbKvvAfWuoRGBaknGEMozSMmqc08590xIWVApyEKDVoYxzcY7nIfgKawpdNJBdUjZUXCKDsPJ1RAxBXbh9kJVClOT0eacpTdHwe2FxYG4sb21HV6YuJzDc9SqRh2tOTNNcZr98kkmYYU+7bQ9GyFlxYvwSeXVEPp3EOE+5TJkMAEOPCZU/AmU3m+aJjdHTtsHnG2L019EBAQDo87q2EB7wEQD5dqv90aadNPWb7Uy3L5qyqOP5G0k2LK3GyU4xiTos04cTK3M7B+AFlDEkSmTBk2MZwYxQMIFA6QnsFMkmU66aSnOIh+cq7CAj6uE5QMH90AVQIIAPUb21HUbG43j02iSpYcqtNpFBrapumvsVq+eRRMsOPGxsbspWXBruugHhodeAFMIGEpTGKQvEYxSiYoBx8G3EACAm4ujgARP6eHbpqPV/Gj3TpgHM9iZbuLLuVk8fz9oHBvazJCYaRibJEYYxxnXrV+UFZchZEopeTteJQTAA9HOJApYlsTtH2D4VBVkgFRACr2uRrY23XuNR17+qLucw1P0ukUatOP051mqXMzIpmGVvNBJselZCi41qDbpEpvziCByiAiAjwlKYxjCUxSFAp+bEDHMAFKbi6CkEQOYPOKUS9Ncx6NxH0dfp7g6R+Sr/dK+nLAOXMNZcvjKOV1LPu+0hkEbegAloyK5hGOhuciZt02keEZQJKRA6Qtmx+dTMUvlAJCqkB7FztN00FALuqP58lt0F6/sh80f7kTfu1bPqSQkhSSDqLKSdxUNQCSNeNr9UV6lhqfpsjQK4p+mvS9eBPiaJhhbyrEgkMpWpzeCPg67xcRKcBuzvDxqLuHr9g+Ffaj8yPr9oVjipI3qSPOQPnMYVnS99N+/ThxiGCZx6i94eNe3tVXhdHZnHYqhOMgdqw+jo3ANuviEQD115UqZwDpD09oer11PR7kzV0muAiHCPnD2dYdIbCI9HYHTv09tWJ036efT54vpJKkHyklOn3QI6udoq1UNN03F8rHgqUXyLdByo1DcViN3CiqSS4kAN+a51BRJRQNyoKgVNcUzqJlPFKAnAol6QN1D0bD8o9Xy7VbbqGvdzh+bxhloCKKwba431iX62bgcHDq2bqQSfEW6A3UUjJ1knJJigVVTm3hkSFE4KEDD1WqM0mnrnHkZkt/DWdEo/LVuT/Kt80egNjOy+e2v42pmz6lzFqvWppqRozTN3JqrTr+rEnTGG8z0/NPXuzLyqHXXLeQgxc4kQB6g9v7o+Hd011LeV2uaSgVdiqGYRdwMCDuIrJmV5mRTIYNyFFJTzebMYqinWkU5emu6ZuGkgzayEa4RdsXzRs+ZvEFCnbOGrz84VSW3BMwH+yJvziX9WImO1UayjIuLauyzbhZ7iZs3UM4Lvtz6CT/AJ9RA2/WUqXn7D0G+CXc3RUyZlCxmQ4lafjJcCh2i4jWHKLMyE9PUidlJiTnKZ/tGTmmHZeakOs+PS7qUPSu7/fpRw81cAKY3UG/sqaTS9XZ1j3j2/e+/wBHTXFiu2etUXzVUqzVynziCxdwBUn3JTAU4G+4EoHHo82uzTTKO3r9Qj/6n1iPQG3qqzLyhvFvPYfOItWWAk5VCyt2Uiyuw/t8/mhkR26+j723cHSAVETTKO3r9Qj/AOp9Yj0Bt6qiAUR6gqbTQEfsd9+rpDp6/X0bfJvVj0/L1fTF4EqO5JPmBPzRB5r1G9nzVNkR26+j723cHSAVG5kfX7QqLzSnxe8vjVh4wefr/tRfMtJG8gec29nq9t4REdusADv/AH+kfv8AydVReaU+L3l8ajcBuzvDxqY4DdneHjVv4yPjjtPti6seB7DEvzZf9yDUXcPX7B8KjcAdo93hTgDtHu8KtOmV3t7IuLHgewxC5r7nv+euXAbs7w8ajV9EOEiihxKmmkChlFFTFSTKml+eLcaglKKBf0cBFEfsTjVsXyEdISA398JAR+dbL64uWZNyYdlGJdlx96of6gyyjpXZ3/7o2gKXM/8A4kLinOU8jW7iGxLkv67VyljLebnclaFWAj2WlZH+k45qoXiKsqr08QJCYqA/n5kq6rCD+4Z7FNmXPdZ0zXDeUUa9ZxIQA3k6tzOvLWLNMUxOmIEbfXC82cwI78CnNqeZWHLWXn5bPmSYzHdrv1lMd2tOt4SKIkThLcNxOnYMF5tUhwTVFuydDzRE10ycfw0QOn51Z3IeJTg4yMg2yRU0YWOjoVBIBIBSpRzDmkSgYDc2IAr5u5TCX078PnBrNJrqqzUqmJdafFr/AG5KklnXX7YDlO/TyuvWPoP4Rvgqt+C74Mux5vGsq83tU2x4gfxJMCpS7knV8P4Yog/0Bupyc0hqckJaY/8AZ3Jlppt7/dqVHIE9wEQLuAKc10CO4n7ADfcxfuwASfdV84C9PQAgBePco8QcI+kBKIgP3gER9VeOvq7S200aR7AQcXFNlQZxbcAMVRAHX5wuqBylKic/xVjJqE6OcAlezZNVGbRBpuKwt2/N86YQ4lTdhuIQH2htv6a2kgjeLefT54+e65Rbacy2loT8Zacqe0gD1wqBsPYPsGpngN2d4eNc+AO0e7wqr4weI7R7ItvFeXq/yx1nAbs7w8a4HR36gAe79/oH73y9ddjzX3Pf89QBAQ6wqsy+RvNuvU2+f19nmoWPA9hjrlEy92/Vv7Q9Pq9P78Hmy/7kGuzOgI9RfYIB8obj3fe6OioPMj6/aFX3jB5+v+1Fv0I5dpjpRIUvXuH+/wB6oChTdHR2j6P9/RXaHSAeoO/q9tQVEvV29Q94dn3vvdHRV+H77hfzC/zGLAsAb9POCPnMWR0pSuwR51hSlKQhSlfBEQ+xP1b7gmcQH7wgUQH5BqJBG8EecEfPA6b9PPpH2uIGKIgG/X1dAh7RENg+XavoCUeMAOQRTPzaoAcgmSP8VUoG3T++cCh66rLiHT3mbPL9JhinHVx3kgsHE4l41qmhbzcO0blkFmdv7essmapbjiO0RkaXR6tXHOiolLqNYd3dHS5GZqDl+GSUaeV6oo6JDFABMGxR6jDsBPwt+Hvr4kU665WqCarh4b4LJuko4fD/AO8SJTug+VGs8mE+RVmVzNpHP2QkY5ECbq2tjIAFyU/SIEPd8qPlPQIBuKceoUdw2N1iGXnD+izTtgtuRPH2MLdZvih0z0k392J8/ZvISBlVSbdHSiql09IgPVUpdbFruI110UFaacDa+u699DpHpLCHgoY4xCoT+JX26FLm3+glCpd+3/QrShYOm5QSb8I1asQaCdVmaDILW5jORteEdfntwX8q4sNgn6iRjxMt1KbbD+dxJ+gB6B2rKjh3kT7YYESe5vyhLXCOw85bNhNy23DAPSUB91VTqy59h2ES7E3KOwGAdwDPV5MBSkKUpBAA2EpiiYv4JlNtvbUUUujfYTGH1gHzD0dm1W3Tiwte995V1eawt6SeAB6/U+C/Bk2e4ST0s2y7Xnbf+3J6XWw3JIJ33BCswI32i1vFOj/T1hdAiePcUWpDrti7JSx2nunOqiO/nHkJIVViG2Ho4HBS7gG5d+mrlSNTJpEKkmBAANjcQgYB6fSnxmTHpEdwERDpHYNtq7QxR22Dq7O3p7RqEKQiO4l7/nqn0xIAJFgb5SCRpbqFhrbXQ369Y7tT6JR6Kkpo9Dp0ikm9mWW209Wtkp36C+6+++giJwB2j3eFc6Uq3jMQpSlIQpSlIQpSlIQpSlIQpSlIQpSlIR82DsD2BX2lKQjhwB2j3eFQBSMO/mhsIdI8XCoI/eL5n7YPGaDf0ht6uuoZgMYer7wbhUb2P7j388UejC7lQOvKx431+YiOieRDORSM3fM03KBw89FcE1kDbdPnpqgoBuoA2229PbvaBl/k+tLOaGyqNzYvg4l4sGwztnoBbMynsHocxpkSmAR3HcxDm3Hb11e2BR36S7+rcA/fqIAiPWG3y71XL6rWBJHDeAd1xmvr83bGHqeGsO1pITVcP0ybA3dMw0sjS2nkjq566xreZj5Fq8o3yuSwnkdnOs+bAyNr5BIRsuocRAoppSkcYjfcBEdjri3KIAI9A7AOKnK+l/PWEXCyeR8W3bb7dv0IThGJJyCXHbfYZu3lpaIKOwgI8b0vQICIdNbxhWwBsIJ82Ib7edxde/abb972VJuodq/QUavmyLlsoQCGbKpIqNDlDYQKZsqVYgl6A2KPmhsGxQqsX03OpHNKtOwqN+fl+jdHnbGHgoYAxEkvUZ6doz19wKwNLWsF5FEm/WQBwNo0BynKdMVSjumHWbYQAPvgIAIfKAV9ESl34jFJt6VDAmA/eE4lAfk3rcFzFybOl/NBHD6Sx62si41iFKFyY9cDbMmUwdAfmRuZaIMAAAmMY7YTmER3OI9eHTOvI95xsIH81iOZYZZgky8YQi3kFrXk2IBQEx0FTOxinJSjuGya4qjtuCW3TVx0jetnEafLTf59eeW4HHQx5axl4Me0vDIz0xEtXEmxBpzK5tVje122ULWCLEkWNr66RiGpXeXPbNw2TOL2zeUJK2pcTdTmlIK42LmFljH7G8fIptnTsPu2qSxPuq6Po84REpSk+GoYxSJE/t1TCCRf7o4VG44jtEeeJxh6nu9BPsuyL/3mcbXLO/o3ghf6sKUpU1jwPYYpqSpKcygUp+MoEJ7Tp64UpXHiL2/u1CJQQdxB8xB+aPvEAm4hTIooUhUBOZsKnlAG6mihi7Art09ACYCfZiHommzY7jcCCKZicAuDmHiAAVV5kglEN+cAVdiiKfEAdZhAvTV8+iDAGn/Oq+Ty5zyQewjWvHx5raatZ5hBEXNIpqmlJxNxJhzSoRyhE0gaiJFVOd5xIBIXps+lWrKOlH0bGq+VRzV1Js456UigC/jivwXjnhkzlIqkKqW5gScESWT6lE0zdFRsQAbaG9jxtvjaJzDdRkqBI1R6rS89KVK4pUozNNPOUrKbHp2m1qXLWvvdCAeq5EdaTmQJwpIoimbZqArIAYCD+lHnSXcvrU+t/dVLOGwCY5ki7lTBQTb+aP1rpU2AwlE3CPoKA7/Y71f9oxwFp5zOwya5zflY9iPbZZECEi05WOh+NiYpxNdDhw/ILaQUKIFKEegr5WPEInInsAGsZeJJpPXSDVwD1om6eeSyAJnSBw3V/OziisVNcnF8VRIpw+yKFLGwPUb29EXFWw1Uadh+m1OaqsvNytXuKJJomWnHKfb4zSVlTXnKU336x484JG4gVKiYSDxGOoVI5TIbhug7TBQplPWmYoj1+bUQAEREoAO5Q3HcBANvUI7AI+oBEfVWQ/Rzpz055rgsoymb8rL2LKWsUgwLBG5G8SdNgZNUwz7o0i1IlJmKcpC+QtVFHAgYeIhDcIGx+qkSQVVBNz5Wgg7/ADOrzaiYrt/jCRQhFCh9yoQp/V6KW0B4/si3q2HahTsP0qpzVXlpqUrV/cGURNNOOyIBsfsSXCtHLyRfqiV4Sm2AUSuA5lNMd0QWIZNX4APCJm3OY36GcvOB9kQKiiHCYSjtuAbjsICG3qENwH7wCI1f1ow08abM3W1lmTzplVSxpK1k2QwbMku1hFGrJNNUys85FyAJyokOQpQZNDqOB4x3KU/ARSwtdEiC6pGyguEUHYeTqiAkFduH2QlUApyejzTlKbo+D229iAD1G9vRvivVcOVGn0nD9VmKtLzcnUQfcuVbmW3F0mxAJfbSsqlhe4u4E6g26wJUUgOfcUAMJSpKimqiCqZiqn4E2zspT7KCY/RwmAwh8IwFL01MF80dh+y229ID1+kNw9o1f/ox09acsz2ll+WzdlI2Ppa0CMBttinNsotZNiSIMZefdkff+ExSkCimDFsJnBzbCAFKYhj2DnKmRRdNIecS6eZU2MAm6+optjB2+cAVC4sDcWN7ajq9MQnsOz9OpWFKnM1eXmpXFZ/8lyiJltblMta/StJWVMi+nlpTfcLwBLfcypSiUqIpimVvzjgyXHzYA7HcE1DcXRzZjCcA87h4dhrs0Wx1vhl4fXuHb6jdX+/RV8+j/T3p6zJY2W57MWTDWLM2icEbfZpzrCHUQbhDgYZ117pgVOX/AKIgZIrRooZUxigYeAp0zGswKUhdwIO/r2EP3QDs8atnymySFJIVqLKSdxUDcAkjXjbjujIT+HKjTqVRKnNVeXmpWcBMrKNzLTjkwAbfYmkuKW5qLeSkki28GOPMJm3LzaQCVEyZlzIFMBkiG5sQecRipKGE3QVMwmOYOkpRL01NilsIgO+5evpDo+UOj2VfVphwPp7yhiHLl65SyopZ942iSQ979vhLR0WCLePh+OKm3CEgUAlxkpIpkxZtlBXRMUouCpAqmJrHUSmFJATgIKf1Yu+/D8oCID6fgiPVVgfJAKiACLi6huBI1F7jUEC9r9UZWfoM1TqVSqnNVKXmpWtXNCk25hpxyRsbH7ElZW2LjS6BfWxMSDhnv+dF4vvCBdun1iHUH++2+8sAgPV+4NehBLi6i77+vxGpNVkIfnZAH5Sh1+sRDq7f9wsnyNdes/OI14S5O6581z8yYkgEB6hqMmmUdvX6hH/1PrEegNvVRNMoF3HoD7wj1+rrER9fydXTOJkL0+rv/wB/VWOffPfv6OoeYb7nIv4qvzT7IqLba4OY8qKo/Xkvzz0mD1bh8L0fB4vl6KoXrAtk9zaecgk4QO4hWbO5WXwQEVYWS56TU4jCUCeTRA8/ucQFb85bgqv9aGqcA79z3pFFBEEzb86XYTAHyF33+QB+WvRZDgyXFj++beOTnU5qzbohx6S9HlTDmG6pREQKIqK+YPSIk+Epwl86sDXWU1CjVGTWQS58BN7qXzSm91W+SDHpjwYMWzGAtt+x3GUuFJdw7tGw5PPLGglpFi3Tzj6rfYZVne7MOFLTf3SwIx9aEc7eVpDg26nnDJRyYSFgOnihzpyDM2wu4JMAA5jrMQ6UwUEvPAIA250Q6Lv86Nii3tpTq3XlW5TjsBFAR/PCpqiIJqGD7EhDGFT+pgetfyFlJGEeMZ6IerRk3FLpPYp8iJwesXrEwgKrNYhgIkkuAbmTMG5gHYxSmARHMVBZ3ic84stKWMVJjd0JJLRt4QgCPNs3zf8ApeVjS8IEOg+26ToHVITf66JK5Ts6xcZxH1vVB1HjybBUw4sIGbKk6FRGhuNbkC5F7g2+2H1XPwD3dnuOZfwqdldJI2c4tbDuJ6FS5J59mlN5UqL1TEs2tuSZIIPSTJbb+5KswIivuFroBVNS035uI6P5uiDmMJjl/wDJyiXcDduwD1dI9tXGkTABAOgREdg6QEBH1mAdi/KIeisf8a+dwr9pJMTGbPGa/PNFh3ApFvS1P2lH45vrQ/H9NX12tMtbohW8w24UgdJeTrNQHzm739DOYdgIXq+uiPM/8p011J55RFwDbiBp+0ee/st8Kp+khqZbKEqWHvtJSkq6Xh0ZAIcO/wCDfdbhHeER26+j723cHSAVNppKF23Lttv6S+vsGuPAbs7w8anqxBmQN6wPOSPnMWMu0g7iD5iD83Zp6OsxB4DdneHjUXcPX7B8K58BuzvDxqLzI+v2hVn4weI7R7IuPFxy9X9mIXAbs7w8ajB53V01E5pT4veXxqMRIA6w7+v2VY9Kv4p7P8sXvRI4eoeyIPNKfF7y+NReAnaH4NTPAbs7w8a4gjv08PRxcO++xRH1GEdhD1gIh66dKsjMEkp+NbTty2iuJe6lIAJWj4aAFFSPykg3T6QIgcJOEx9/NIZIphEghsZf87L0huJh+yKG4p/1QCVjS156mTWrGOsIWG/OldtyMXCN7S7VQxXFsQroonQhGRhAoN3pgAeISmEUttleARCrjtV2o+K09WSVRgo2eZIuJB17yYZwYyibXn/6YnJhFMpimaMQDzTHMXj/AKiCnVWvLLzUlNy724JqTXl7hmXzh/Lyj3nFHbp28EAMq7VMJiqptiGExE0gHYCiBCmMIVzjF+JVMtGSkXEBw3CUIUFEGxIKkoJOUWud3AG5F/vJ9SN+p9zO1DEtO8JLavRHDs7o1xQMO1anTDCKkbaGntTDTYnEpI1MvnG4XBUL1M0+QBbizhhqFFAp0ZHIkCg5AnnCmgE2Z/IOTnMIlWFFq3cLGApjHUAnAmVRQSFHZJvG6mdoxZ5R6BTrqE42DAwiKrtbs3KBgT6d/OWMmX11rv6SnjGO1FYukX5VjsoaVnZMU0B2EyjS0ptw1EQ2AwiLzhKGwCJRHiHhIG4ZXrquiTvCUWkpNQxUg/pFkBvMadfXwiJDfII7eiqmzhkeJ1FROjhORR3LFz8A/daW1SbHlvi++rrPLqG3jYzhqXBFMoezVTAlBcqQ9mOVlTfwkuWt9jIz23JtpHsbB90b1yY0mpdYXK7QDzbkwj9ZApQ/oakRMw7lBX0Bw7p/1QCddXa7D2D7BqgmAooEkrimVCbmUO3YJnESjzaTTbnwKADvsn6OEAAw/B4quH4A7R7vCuhPvnT6O/z7+u+nwhqYKl+LpBUnqy6jtAI4iw526oleaD1fgh41A5pT4veXxqe4DdneHjTgN2d4eNUen5er6YxNjwPYY62uB0yj1bD7Q/8AUD975eup3my/7kGoApnDrDvDxquHVncCfNr8wiTxf5Cvzf8ALEtwG7O8PGpfgN2d4eNT1QeA3Z3h41feMHiO0eyLboU8u1MSnMj6/aFS50d+oAHu/f6B+98vXXYbh6/YPhUCr1h89+/o6x5xusn2B37+jXhr1EWD0pSu7R5eBBNgQTwGp7BClfTAJB4TAPEHwiAHEoT/AJxMu6if/WFLVRMYYlyTmi5krPxdZ8xeVwKAIqtYxFMjVgAdYy8u9Vaw8IAbdPuu/Y7VAkDeQPOQIu5CQnqpM+JUyTm6jOfgkhLvTkz+gl0OO/qRTkwgQpjH8whE+dMcwCUnB2gcdiGN9wURP9zVyuAdIudtSUk3SxvZKgQfle0pfVyFXjLXjENh85m4dnaJzXRuIEhfdBTYBHh6Kzb6WuSCs6yTx126hXjfIN0Nj+Us7OYKCjY0WY6ZhBB8UTi5lDJqcJDCTdEo+cTnyb1migrcibbjW0TBQ7CGi2ZOBtGxSDdgwbEATGAjVo3KVFMvEYREuwF3Hoqm9MJOuYK4hKkkkEjS9+HAHdYgdfsjZz4JdRnSmrY8nFSyVbqc0lSH7aHym1gKRodLpvcEFIsQMSGnXkgsJ468gncvvnOXboblEwsnyYx9iM1NjF2bW22VId4IGEogo/XUKPSApbdNZZ4C1bftyOTiYGIjoaMR3AjCLaJMGaYH4gHhbNQRTLxdQ8AdIdYCGwB6MSHAvmk870huXt9nV+7XPY3CIcHSPX5wegfZ1VaF5ZBAOUEgEAjjvvYE+k2B3AC8e1MOYGwrhZoMUeiScq/Y5plLCU5uALoGoHAq0N7WBsOXAHaPd4VzpSreNyhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQiGJOjYOkd+nv9frqVM3MYwG4dxAdgMJxKfh2AB3EgiBukNwARABAdx6Qqeribi36A+Xo6fbUQba9+/ffFJxpLls3VFBMr6dsQ5sh14jJuO7butuqgVskvKtgPJMyhsAnYTqAkmGol6iikqmYTdJgEBNvhe1FcjMugQ1w6brscquECcQWRfMrtzogBAEsRdPDxpqGMY+xJdEiZSl3FwJjAFbC6ZBKAhzewDt9lv1bj2j20FIB6ibf3W/s7P3PVVfplDQnOBpckZrdWpzHT0i9zaOe4r2V4Hxk0RWaBJNzfVNyrKQ4DqB9kQnUW3A3AvuNtdDDI2Mr/AMRXGraeS7Sm7MnkzAQrSaZnbouhMACAx0iQVIyTIICAgpHPHSYgO4G2rw4kOUBExTAUqfOnOJRAiZP+UOIcCZvuDiU4/FrewybhvHGZbdd2nk6yIK8IF2nzJmsw3K75sDbcSyBzCm4ZKeaHntXQKiAdYCJgHBJqX5HGbihkLr00zHuw2bm8pPju8HrdB8JwAgeTwl4Lu0QKBjCYQJLlTSIUvS4MIhxXXjAIJCwLdRNj6PK19GvXa0eHNongnYkw4o1HBcxMV2XtrINtOzb44gMsocWd+9KbnfYWIGCgOn5+j93aoyCAuA3EOEOvfcP3AH/f2V6C47Mu2zLgfWpeluTNq3GwX8mXhpyPcxr5Rb0FYouE0xky/wDKRouk+n4dSqSfNkAChxbp87uUeIvD2icvEQo7/YCIH6fg1VBB3EHzEH5o8vLps1Iv+KzsrMScz+DTTLku+P8A8S8lDnP4JPnO74BG4AmUE2zggGKZAokSVMKB+puuoU4AsO/wiAYxi/ZAA1GA5gECkASnExCAc/T5yv53sbYQ6dvhfBL9kYvpvn0W4V08ZodZORztktSzlLejmCttsy3ZHwBVEJBJU0pOJOXaRED+QKkTSK1McFzc5ziaZiFEasplmrNrJybSOfBJRKElJtot/wA0sgLqML/4Oeii5TRcIirv0JLpJOEx/PEidVTFJACtLKuBqL6WvcbxvFuMbRUqHMUzD1Mqy6pKvyYzBUqiaZW4jKbHpG0rUtG/TOkX3gbzHW8BVRSDydNbci6QcTcHAcDb8+bLGTEQcFJ1hwCcp/sBMFR+IOLg387bfp6A29Qj0D8g1fRorwbplzIxya4zzlsljPLbZNiW/HFnGEIJ2Dgphe3MiuuIoLCQwFKLEFAem4t+Y6AA1jbxFBJ08QaqeWM0He7FyBTpC4b9Hn8CxU1U+r4KpCG6+gKhbr4/siFVw9P06hYaqMzV5aal8RX8WkUTTTj1Eta/jrKVlyT87yG77gNNJcUkDn50QbKqIDxEA5E3BFkOPm/J1ikP+ahE39TJzh9ukC8O5qlnTYocaqYb8AbmTDoEA6O0fOH1F3EfvDWQXRtg7TZmK2soyOdcrDZ0ra5Ej28zLdcfBCgwNF/XZ5M7pNNN2Yj/AIiFZJGM5MYOIyJUzFObH6/coJKum7E/lKKTvdq+Ep0wcN/jikqUipP7VRMp/VtS4sDca3tqOqKdWw/N0+gUuqTNSZmpWtX9wpND7bjkiRxaSorbF+Q67Gw16MASUMUxgbnMK/MAJiJuSHL+lXpEVDcZR7VPN9e21TxTAYRKUekobjv0ewTbAP3gERq/bRfgTTPme3cvP87ZZPY0nbDQpLcZhc7WFOizFNQxrlVO4bglKqAcqYeRMzrOxKJgFIpuADWHKooEVVBNTylug6HydYCmTFdv0gJ+BQpVC9IdJVCgf7mrc2ABuLG9tR1Gx7/TEJ/DdSp9Ao1SmqqzNSuLL+5koiYQtymWNj0rQWVMfywm+7qMQTEbn3+ttlkyimcFDcw5WWQVOJE26yiaopOuIwbc2Qyhg6BEpS9NT7ZLzTHVLwlL1iPRsO3VtvuPsHbrq/bRhgbTTmW0stTWeMonsaYtXyElsIFuyPhmpWqcOYy860RXSA0iCUiUUwaNwUcHEAEqexyGNZUs3QE6iG/PNzdSpQEm/T8UwFP1dpQDsqgoFDQeV5LJv9lVo3ccVmyfXF1O4TqchS8N1KYqjM5LVa5o0k0+269TbGx6RlKlLZ5FaU3toeEMUmm4gZNusUqPNHTWRIoUqfHwbSKQmKYDcXRza5Sn26eHh6amyJlDr2D2j/6kfv8AydVXKaZ8cYGlbOyncOeclSMJGW8mBLXOwuaOZSdrphEgPuw5RkCouLjD3T+s+TIpOnIfnooc19cq12Llo6bQK4inaTxI/wAHm+IFB/6lQpFg+VMKxgWhWiVJJ4BQPzGMxUcM1KlUuVqM7NdNLTl/c6SuS5R//vLXwpXkXUoA1jtuaQOYpx8lWTEp1QMKJFTmAh+AWr3cwJGHiDzSqD54ecUBL01MkKICBRDpNtwhuA79fZ1fLtV8+mbCunHJeIsv3jlzLBrUvi1fdBO34U90s4ZFsjHQpjxUyum6bkSlQkZMBIZBmosqnw8KxCGWSEbHmwCKSQnAQUDrDffbp6ekNwH7++33qpPkJAJUkZkgjyk9SiN17jXjFzOUCbkaXI1F+osTktUgTSpJmYbedpQCiPs7La1LlhcH7alH7BGTIYu24bbb+kPX2DUwCZR6hD8GvgAI9QVOJplHb1+oR/8AU+sR6A29VYh9+4zDUa+UNR29nAeYb7FhgZEuWPRr+Au3kL1+5VeyvQSNNdLW65RmnxcaYbj6CdAB8u/R6O8fv1BTR2KAiHQPy93WP3xDYPkr0QICPUA+0tQlWvTziYAI/E6AD2iIB6qxTr5V8E5vNrbs7jz3MXHix+Kr81XtjrEyjxibbo6encPT1VU+FcjLRotlSgKxCvGx0x23UBb87AR6C+d6zbF387aqepkKAdPR98B/c9P3+rs6q76Idni5BBUBAEvKCnXKY5SiBDfAMJBEBMU3TwmKUwGHq36axM3MdEVJcIbUj4aV+QU81BVinj5Xp6hG04WemqTX6W40ol/KF9EL9Lk+NkvmCR8a1uca3cogDGYmmYhwlYysmzAOgdhQXWQOXzd9wKsiqQBDcB4eIBEpiiPorFvSWx9cjO44c4GKUooyMaImBu+ah/U+Ew82Coj/AFQ223TuI11FxFFzct0il5wK3FNqp/YiYi0nILpm2PwiHEismfYwAIcXCYAMUwB0nETbfi6ezYf3a8iiafkZ8VGSdSl0nRKFAqVcaWSm6vMoaWFucf0fTg/C20nY3JYSxZS5Cu4er2HegCKiGnGHniLBpCnLoW7e/kJOaw3brZf7SuOHvaAZXJCOPKGL/wA1RFQ/nNXf6A4IcCKNld/sFyJG9VV1xjefvWlzIPTnCEklOZeoGA6gER9LohUinMA/ckKKm/2I1hmxRlZ9i6eOo25yRtmRIDeciDGMBXKQgAi8a84O6UoUREpVzbFEAARNWT6AnYi54iPnIR+g+jnhOcQeIicqYB1824BQqZ2a/QH5mdkQcb/1LoCvRWGcWsYip6RdDU458CVWtKZhf5LJIcVbiEkHquDH47/qgHgE4n8E7GFYVLNVCq7IaikGl4rlpGbelKTe2kxVW2lScqR1hyYTY84yTFKQ4FEglOU3wTFOBiH/ALQ5REpv7kRqNzSnxe8vjVveH8gCJULVmzgU3HzcM9cGHhOfo6FVh8xIOj4Tg6ZenpGrkDDw8XF0cHWHWP8AcgHSf+4A1ZCYISGyohIctkKiAF7/AIBOivRePmeunGXWlsIVnWfJTlOdfV5Kd6uGgPHnEPmlPi95fGooAI9QVMgQxuoN9/WH741FIjt1gAd/7/SP3/k6qsFvFtSUuDo1L+AlYyqX+SFEFXovAsAC50HEggdpMQuA3Z3h41y5pT4veXxqNwG7O8PGogHKJhJvscB2AggJTqB8dEggBl0v+WRBRL7urZcwGxmcshPFfkjtUoCKwQ0rLlWlWf4FlA5/ybK8r0XiGJDgUxuAwgXoMBSmOcB7BTKAqb+rh3qiufM4WjgKxnV13QqV48UaeRWpbzY5xdzsv8RAiRFBI3/9qK/Mx22/5rHqqZzlnWx8CWg4u28HpXDp0Xjt62WTgCT1yS/6SbIEAyiSX/ljkqDL/wApCtdTM+Z7xzlez2+bzemUcmDySAhWxzpw1tQ24h7nsWw7lFcOgTL8IAO/CBvsg1LEWI10xkMS6wt7702oKc/MSSoDiSALG+7d9Y/qdX1OTEvhTYsZxxjuXqVD2N0T4c47ITcqrERPVT5l9lDE/wD/AOO46OvQR0+SskXPlu95i/72kDSEzJLOTlDdTyOMZrCIEiYdHf8AMsaA7CCZiFNv1gUAEBp8QorKgA9Zt+4oj6uyvhAIICBj8O+32Im2237KFMJD+YO/YO22/QPoHfbbca44664ZhcxMTCFui4IKxdPUAQTffv3knSw3D9iOFsK4YwNhuh4awpTJCg4WpQPi8jT0tobII0yJbsFDQkkXOumgiu2m0QLmuzyCIAcffEABv18NtTCQ9PV8MQKHT09YbhuNZXOAvZ3j41iIwW/Sj8x4/cGVAgKXCMecwgYQ2fRz9soA7AboFVdIm47F2NuJuEphLl7AhhECgAGMKnN8JRAxuL1lARMBP+UEAT6/O6Brs2zltxVLultw2+FZCjl3/C009Mfl/wDq4dOdlvCIwDWFOZJV/DYZZmlHLLOv/eW3iQ047/FpWV8tYvAw2xK1sVqucAKrJv3i2w7CJk1fgH3ARAOLp6DCAh9kUKqvwE7Q/Brx+OGnMWJbQbbCaNI5DpAdxV/Ox6x24unr6Q+y29PteAvZ3j41sb0wFKyBQUv4gN1W3HyQcxBHL5rR8IHgS+FgEo08sC6d5+63dY6+uOHNB6vwQ8aluA3Z3h41PVB4DdneHjVwdBc6DidB2nSLQsAanQcSCP2xKcyPr9oVLnTOO2wdvpD1euuxqDwG7O8PGjL5G/Tz6d+Ono6xEsdeKZQ6xD8GoPNKfF7y+NdmdHfqAB7v3+gfvfL11CEhi77htt6w/eGrkuqT8JBHnSR85iy8X1y2Vm4WVfsveOq4A7R7vCoXNfc9/wA9dgIJh1iH4A1BEhwDiEhwDtEhg/dCr1h4nd6te/7d28AxRmWAlWVQKVbsihZX5uh738+PQo8QiBQE3CfmzCBREpDdhzgHCQPujCBfXXMpDqHSTTIZVRwfm2pEiiqd2fsZlTAwvPvtgVL66rfgrThl7Udc7W28W2qvMEKpzMncb0gs7ZtloAb8/OyS6jZg7c9A7Mmbhy9N6G9bLGkrkzsS6eUWt0XUglk7KgJbrXJOt0TRMWsYTFOFtxHGKEeBQ2MCpi86ICPCKRylMPojpG7XLiLXt8JNz5hcXt16gDS5FxHMtnGwnGm0KcL5QaXThqZyZYdYluYQ6tCW1nkk7yBcXEYl9InJWZKzP7m3hmNSSxhjpdQHCMCBUUL0upkYpzJrrAuqd3DEMJOESSbZq6DiAwNjl3ENjvD2B8X4MtdlaOLbSjbXh24FBdRgmASL05ROIKycgsKjuSVHjEoqOVDn2KAFEodAVkBuZMCmKlzh+ASCIqhxFDiAfN4tiAJh6READcA2H1xUyKCQ3GnwjuAgXjKO/T09IDsGwAA+vfb0VZOPkglJPA2OpHXoOondawAO8kEx9FdnWx/BmziWEvTaaidqtvslWmmCtStNQl5ScqQbnROp+Cb21jETAvWH+/aPh1dfR01FpSraOtwpSlIQpSlIQpSlIQpSlIQpSlIQpSlIQpSlIQpSlIQpSlIQpSlIQpSlIQpSlIQpSlIQpSlIQpSlIQpSlIQpSlIR82DsD2BUIyZh4hJwgB/hlMG4dQ9I9I7j6Oz79RqUhFseeNKmHNRdvKweSrUaSTkiIIxtxtylbXRFG3KHOsJhIU1kDFAoiBQ3S3MI81xCJq1vtWfJzZa06LO7lt8znJeL0VRcoTcezA91W6bYNkJWFYKKu5RMwCAgaOZuy7CHFwiHCG2yJBDq6d/T1bd/TvUo4YIOklUXJAcIrhwqIKETUSEBAOIDEU3KYoiUBEB3DfpAKrtTBF81+qxN77hx3g8FXKbfCOkce2h7F8H4/YLkzIt06pW8mck2whwm+5ZRYK8+hsNCLWOg3sm8ApzFTdJqpcCZgcA4I2L0fmN45TQ5nj7UVFAP9zvtUQ4EHbZQR3MQgbAYQEyvwNxABDYfjfBL1GMFbUuS+Sr0zZDu6XvQWd02stNNgI6t20ZhOMtpKW3393EmJk9wPsIEMgQCAJw4ipkIPCGsVf1oSmPL2umypqLkoiRtuVlGYMZli5jH54wv/g6RTaPkkF1kVfQdBNQE/wCqc30VfdI3a+dG8jVQBuLX0NuMfPfaVscxjs1kxN1CclqlR7kZWl9I0bWO8adYtf8AYY8dziCu/HwK80imCfGog5AUlfgNlRSRHyri3+AmKgh9kAVMgG5TnDYSkBQTdIbgCX55sXfiES9hQER+xAavq0W4a0v5aYZNV1DZRVsV5bqbI1sx57lbwRSs0iHFSbbunLYGzxQhgKUGCSpnggYd0A6BGxCVUaoOnLaKXF21TdvPJn/AoiC7dX87MKK5Uligbo81VMpi9PEUKnuNDca8+Ec8q2H52nYdkK5NVmVmpfEF+gk0TTTjtAt+HtJcKpHXd4wGzwESjpU65hIVNVU24mKZQgLFMhx8Hk6pAbALvz+jgSBQ23Tw8I711oCAgI77AAbiI+aG3qEdt/vBuNX+6M8IaWsuwGWH+oTKKNmy1rlRNbTI1xtrfFGPNFfXp9E7oxE3R03+6ZGBD+VHMAGMkQhinNYOum28oVIkt5U0Qd/mdYCHSFduP2YkVKRQoBv8E5Sm6uiqFjYHje3oiNVw7PU+gyFRmaxKzkvVL+5Ei3NMuvUy331lLhWxyKkpva8ceEyqqQKIHV5pbmmZzmUcF5sP/F3JE2oi7T7TFKomO3wt+rtGaAqCbiKHNFDcTDt1dXQG/EPV1AAj6Kvs0W4O0wZct7K8pqBySlZUjbyBDW41NcbSBM2ihTVMaTZi6MUkkqQxCF8maiosbj4RKUwl3sxOiRBVVFt9dbIO/wAzq/A59v8AHEpuA5P7U4FN9zVuQUgFWgVe19Nxt+zvrFxO4cqMjQabUZirS85LVi5osk1MtOvU4AkHOwhanGtfjJHVa9o8/J3DDQyrJKaetmaC5k/J3Uioj7m8Sp+bTa+Wi3BkzAxuj+iKzcoAAGEQKHFXpAHcCjsJSqBukc4CQiof8ic4FIt95Ixxq+DSZgXSpm2x8zfVI5AY20rCJMWtvQr25WsazIyThxFW4yg9blGWOnJgCYMmHPuj7CIIgU5FBwm35EZY07unFyY0mnN4YpTdGGQs+fK5m3EGgBREpo5wpvKKgYwAUQbpKmKAiYSCAcI6tWalOUQicWw9PSNifFWGlvqsN9m2gpXVusb7t+71rsd8Gmg7b5GjYepu0SiYT2o4gCvrNwviiuyFIwpWcpsfdmt1Cal5ah9dg+4112vF6SzNGQRWavGoOUFUOAyLhQqqTlH0icqjcoLfeDiNv6OsKtxuG35fHkuV5DunCMcf+lnCXECBvvpj56fTv0KEJ+7V02iXUhoHy2wuuA1UX9dGC78fJiWwni3lquPRS5o47Em2MdItEHPO8yHMyTxjxJioIDxABR6Z4wh7phDoAulLQy24pyTJdF21THbp2eIHOiHT2KeFUabiCj1eXBp87IvTO/oGJph17S+9ptxS7jePJsb6Rgtr/gt7d/BfeTLbW9nlUwzSHPgVB9mpTMgs2vZE3My6ZdzQg3Q4oX0uVJUBTG2MtNn5kWtytDN1zomTaSbRPy9oVIh+bEHaB2pjOTcW2yfNmOfrKUwdNVxZLtHiQLtF0nSJvgqN1CrFHf1pibb2B3V0+G8F4ClrFy29zBkUlu31byD41rwaUs3jVXKLCIAYmZjWK5yLyfujJ/WjM2BHDxER51w3RS8+rRrfnp2C5p1FPVWapOtnxiZkH3iCI7+nq39PyXUyQElRNk/G+5+5693rjn9QwelcpT6pJ1mSmZRv4cpLzbDy0flNtLUU+kAfPF8aZScO5hAhfjKbkKHyn4QH74jt2dVTxCFKJgNsUxQATFMIFOBR6jCURAwE7DbAUe3oqhdt5gaOBFC4mXuer/xgzKZ0x/vUSnc/f+s+oB9NeczDcFrTF26WrQufJExYOE8oZ8ty1cy3vZ04pCz8fjxUoi7VjnDRnJOiG4ti8w2bOHxwERRaKiAAOQwzh9eI62imoUpKXASyhCVLW/YEkMNoBU8o9SWgtSlWAFzGOw/g+cq+IqTh5TipYOEZEPXaUofJSsAka62B0veLpSoLgPSgt1foSnq+5qYKgobfhScCIKESAARV3Mc5+ApSF5vdTzugRIBilDzjCBemro8W8m/yNma7uaWFjDXtqJuq8ZApDMIBHPVxRj58JwESEaBNW3HJuVjAHQgiodYR2LwbiAVTfXfyePJpaKLJvJpcerXV3aucFcO5CvnFENJZAyXcENNSkaxVZw5Xc3btjTFswqZ58qLQVZ+ZjEm5FRkHB0o5Mzut6b2WUKoVWXoctWMZCszZCZalow1NqqL1+tqSQ2qadSL69GyqwB32vHoNXgy1BAdUuty6Esfbit1tAa/6QqUAj+Vbd5r0dcMTpFEwEEADjEQ3DiAE/hiJN+IAD0CIbGH4Ijt02c6vcgZqxvZdvzuI4Z2o1ayiju7p1Jo3kBiYuIb+VR7AzBVT3RdFeoeeouyaOUkR8xc6Z/Nq4zBczO3LhjGNwXOqVzck7Y1vycy4KYihVnUilzywgKZjl6UvOE4Dw7+bvxdFeB1Z3gSxMG3y650UHdzx6Fow6ZFhAVH824FB8uimoG5VWLHzhMcCgPwEzCp5tcok65LbKMVTU1V5GUxFJYPfEtWJWbyOqnpn8HCFEqW//EgFz5MYDYLs6r+ONuuz3Zth+UTUqpWMY+4LiHGVvv8AiJ/3xZQlbnQfxuXJf7qMBLS5vdF25O8UIhIulXjgQOYCicxt+ARAQHhIbceFQ2xB26xruimMQwHMQxR233UAUw6QEOnjACl6O3aridJWhXNOu/LMpiXT6xgiTcHY7q87knbtlHsFaMJFtXJWkJHO30Y3duE3swucOYaF4niiIHdcx5MUywUoz5gDUDpEyDIYsz3j+Wx7crB4cEyy3NvIqfQTDc5rfuhm4fWxPDt0gWFmX5zfYFHo33bFfgp4O2xUmWxjsLqzOHMS4kaE3U9lWInmZBxuX0ImKIqbU3MTTGgIXLocaGpFio3/AFn7Pfqi52CY2qmxDwkaucQuYRTZnaXhCmCoUogaaIk0uSl7b/LvYgdUeRIUQ8w4BwH4uE5jAQo83uJuEwiAH6dg80w7jsAb77VVPF+VLixXKAdmckhbj0/DNW+uumDN03HbdZsCioAlJgI7Av5iY+kwb7VXPQtoOz3yid05AtTA8zjqGc45gbcuS418iyMxEs1yyiwtjljSwjGQOUgrFEhhHfYAAw7EADVky/K2HKJgAj7/ADTN0AA7e+/Ie48QjsAb2x5xh2HzCiJuoNtxKA+c2fBt2kUGZkhUcSYew1VWzZ2mVioy9Mn2SbKCXZaccZmEqyFJIU0CQUqsAQqOq7ZvDw8BzaLTans6x/LVrHVDNrzdPoZq0kSSP/aZZD7NzyUevhFDbEv+07+ikZa2pVNYxiKHdxXlRU5Risl+eEIyV5p8oJf+QQU3+x3q9vGGUEpNNtAXIugjIpH5tjKrqARF8fYPNOr+dpesXBkg9fZQeY5APlGcM2/dWVEMnYDjWtiWzcN3yZrdvDIHl7xtER68k/8Ara9rk4wbsWqy4pkIZZYUxTSIquYEzY8MX6zEpiJjDX/ALIGctE3oStucx5MmCoCKZitljFdiJwAegqHEG3nAHRWz4gwtPYWw9T6xiCs0eryjTgZdnKNPS07LNum4S2t+XcW0lZKSAgqCiUkAXSQPz2468CykbVcWVyX8ENjEO0Si0hkTDNBqtPnWsWFi1y+mkMtLqXQ/xgl8nVfqjYGIAkMmQwCU59xKQQEDm336ifCH5AqYABEdigJjcPEUhQEyigdiSZd1Fj/cJFOf7msc2ONbeM2jVNGTvyLkoo/SQ8md0ynGP9s5fNkElf8Aqzn9fVVW32sGz7wlbWxxpzhZbUDnnIkoa37KxhbzKQj2yr4pOM0vck7JtIyLh2BS77vDSiDQB80VuLorW8NyP11z8jQ8MvtzUywz0782+tK0MMffnVglLbX8YspRbeqPI+IvBt274QbM/ibZjjujUZLvQLqtYwViOmU1L+/oVT07TGJVLo+9l3Pu8k3i78pTmNwFIcx+Pg5sCGE4j8YCbcQp/wDKgApfd1aVqT1eY/08MloYoNrsySs3D3Mshu5AxGaw/wDsQutxtzsXG/8AtLTULJDt/SnXV7jLkkOVJynbLh1fWqvT7gQ80z5s1nY0sSYvdxbgcQlGPLcMwDVF8chtt3Me5dNzb7prH87bEhrG5C3XBpMs2580sJqxdSFkW+k4mr0lsfoTbDJ0dEIICqvNStrzQG98RCpDuDC2V5eRMYQBNoY+1brVdkOJglErhvE2GpuYddLDLc3Py4Dz6bgNNuKVkcWoghKUKWpX3CVbo9TeB/sX2CObRabV/ClxPXWsOAG0jSqS62jMRdIVZo5Re1yEKIBuEnS+KPJmTr0zHd769sgTCsvNuD8aZS/W4yKQNuBWlvNSm3ZcIjuZRQie4AIAbpAapwIquDiBElBASAoIFTOYqZdutRQCAVMdw34VDFMG4dHSG/qca2Jf2bL3tHFuH7Tlb/v6+5EYu2bcgyIKLvnRXCzcxnbxwo3jYVkmu3WIpJzj2NjUxIIndlIJRNsI47+hjtW90W+zl8k6g8LY6mnSHlKtsQVuzeRRj3m4lFo+kZI0WwflAdt1o905bm381U3nbcro/g+Y3qyU1DFNQZw2+6206yzWi7IPrYfBLLyWppDLqmXwLtvJa6NWgStWkfpqxn4bvgseDTS8P4Dws8J2jMaOyuAqexVkMJ6+kTSQ/wBGVHeVi+7SwIjXDAxwHhTAwjxcAlKUTmA33RAATEDcduIwAUR6N965cQk6VCce/Ybr26PsAHtCsxus7kLNZGjzHk9mJKZx5nnF1ptvLbmkrGSlIK9LVhAMQhpSRtCa9zWk4IGVIU7WAdSb4onJxNgAxRHCkEq/l3zCIgWLuTlJVy3ZRjGPaOHsjIO3SgpIt2TFqko6cKicNjkQROKJdjr82QQMOzULwTNrGIapKUvCKaXWqa6yXqrX2yHqZS0Xv0lUng04xJs2IOaaeYFilWbKoE16b9U08GGewjUsYTeKZ+nzMpYyGFJyWal63OcPFKU4tE6+Tr9pZcA4R6ULlCBl4yYaHKk6jpFk+QKVTnBTVR2AwKmAPzOcu2/CsKRxDoAB6KvWxTqIzDl3L0b7kWptjMqiUbOxjRNNKKjYpcB5uTWuBc6RBXH7Jomsd8n/AFRuTar6tMn0OFrGz5YrTImYLys7TohPJIu4K072j3N1X4u0cEKdtMTqLFU7FkouU5RJHvFEH5AMUy7ZEpgEblshcjZygei3G8pcGNZHEGqnGVooSk5L2baEVL2FmEjFJqq8fykOmqmnCXMdg2QUUQi2zt5KOzFBJiycLHImb2Lh7Y/sS2T4InsOUit4U2mbQq4sStXqNSTOSlDlXEgqDNGnlOeKrVqbJZeUSSQPKMfAbw6fCWqvheYolcSs4ZlqZK4YFqbLPslDkxuF2ErGd47vg3PzRW3H485YlrnLuJfcRoTcQEvnJB9cAeIAEOHtHoH0CNes5s25gAAESAURADFETFN8E6YAP11M3oUT40x+NVDdMWR4HKmG7auq3TmFuJJGHkGbgxk1o6ViXSLKQjniC5Ul2r1u5XRTFuukmqqB+cRKokU6gRU4XUbqR1VwmkjTHdlkY6m4nEcxl3J2Q73tY15R0BDpSBIy0rZbMxWauAXmHSnQCKSqiKJDLLkImACbyhTMAYjrOJqlhl1tFNmaPLuzdWfmWlsmmyzSmkuPzwWkKlWkKfYQVvBCekeZRfO62FfJyQw/M1jEK6IwFpca6UOMhKi410P27pGwMzYZH23MB0f3eXqrYJFC7AZJUBMnzhSikoBjF4Oc80vDxCfg6ebABU9HDv0U4DdneHjVvhIPURgbWFeek3NeUMa5ufwGGoPKs3c2PbAd2MNlzNzT4toCFcpPVwM6Wk2AAug3j/K1E0TFFyRAdyhcVt09PR6zeaX8Idi99WWLMFTmCqxKU92cFQan5YTcl0ZKzNSqrETDCLZ3GddVpBSk3SohWkWVZpJoVWVS5x5CJpHw5ZxaUPp87Sj0g14p+mU4C9nePjULYewfYNTRU1DlMcqagpl61ATPzQf9ZtwD8hqp3eWXMU4+SUVvLItmwIpfnjd3ccUd8X/53NnK78f7lsNao5NSzQu7MMNji482gdqlCMlh3BOLMYKSjCWGMRYpWv4CMO0WpVtS/wAlNMlJoq9AMe4ExAMYnOJCcvwkyqpmUD/qymE4/IWoS5TEMchw5tQNt01BBNX0f1I4lU9HoLVgF+cpRgS3AVb2gxu/IT03wSR8cEDFfK4uNCJeB6Osvd12V31yk+abjBVrZUZa+M2R/guWTdxPS/UIjxOX4AQOnhANhNvuIjsAedgXsWUKWFy69MdZDR6S/KyCo2PWLHr3R7z2TfUovDK2qPdOnZ2zgRnf0mNWZ/DqB5l1eXlAbHhfUcYzfSTyOimij+Vfsolml+eOpV23jUS7egTvlG5Tf3O4/v2eZJ11aecdHUZsrmNkGZSD65FWUxRdNi7/APtXXUJDj0D9i/GsFN45DvzIjozq/r5uq7lFPzwJmUcPG3yMCqtGoj6R3DwrzLVdRIoFbtRA7hUECIlP5Pz6/SIItUWzZZVwqIG6UmyZz7iO5emtaqOP38/Rycu50t7dHbIq51Fwqyh+aeBAj6q7HPqEGzjDcs5P7c9rdUrPR3zKo0p0raDp9scbCwgX3nKog9UfqvYlw3YuE7OibEx3bbK3rdiG5UkGzTYqyogBwFd4uJjHfyJ+IOdcuRHiDYOcMBQKWq5NkiiY/SYdtw7dh26w3DqEB6tvR21NlAQ6w29e++/X7KhmIG+/Nb79fn7fv17dCs2itQLW3CwHULmwHmFzvMfIaTkJemSaZClSsvKMJASlKQEJA3bhYHju6yTe5iNSlKki/hSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQhSlKQiWHcQ4i77B97cfR1iH3/RVl+qrRLinVRBc3c7EYG9o9Pe3sgw6aQXBELgUhSImUOYhZCMDYQOzelHf4ROAeIVL0gKcQDcnCPp84B39nVtXw5D8I7F3Ho6NwD0h6RGqhOUEC1joUmx53vc7uojUXtffGErNBpmI5NVKrchLTsqsC4dQlSBYbwSLJPVcEEHdYG8aSmpXTRlXTFdhbXyHDmGPdKAaDvOPIm8t642+wCZwxcuiC3aOSCIAaIkFG0kO3mtDFEBG3DiAA3NuQOHi+uFMn5vxtjgUeH7rq9db1eUsQWPmW05GyMjW3G3Tbcqnza7GUT50yKmwfm5ksXhOwfph0JqtTkEogPAcCqKFPq4a1eTyvzTI8fXxZxZK9sM88AoS5UQf3LY6Oxd2VxERHhXYbiIFlvJysuHYVVETG4AugtBuQoDrIKhprbebX39WvEdcfPrbH4PVdwu4atg9M1WaLoTSUMuzTouBuYaQ4o2JsCE3Gl7XBON05kjnAFCgZVRU5UzGMi8KdNI/AdsqVdAouSgfqAnOAYB4i8QdIzbRsdwcTGLwIl6RMIgHR0dQCO5vvAHb0BWQLRNhLS5li3cryGoXIby0ZaDZRJbRQUuA8SkaPNDmNJXBHOVWhW0m5Tki837mMlnEiYQ4gaCRRMxrJVE2yKqqKBgctkXf5nVKUyfPtw+yEqgEUKHT8E5Sm+5DqqY2ABJFlXtrwNj6487TWF5+VoVPqrtXlp9OILmXprEy0/M0KxI/06XbUpyS3f79DfPSIRUA3E4JnWMB+o6YOikR6PrDRN01TMdP1mAS9HXUyBimMBQEBEQ3Ds2+/1B94R3q/PRlhXS7lm2csvM/ZAVtSYt1AgwKZ5kkMLOEMRQwyiHPF4HihTFKHk6ZjLDvwmKQxiAaxBZFBNZcjdXnEQd/WVeE5eJv8bhOUpy9nCYoG+5Crd4ghJBBB4G+694yc9RJimU3D9QcqktPsVzN0UixMtPvYftofdFhtanJDW2sylq/HSw+kTFQAASHMohxnKU6YPSnBM4kO3ZkXbF50hTdRjAZMwecUxigA1McwVQqiIlIsk560jlIZJf8AtiqdBRDf7IA6Kvt0b4T0w5WtbMEhnnICtoTdtNYo9qI+7BI5aPhjQqhpKQRTHcXiiUoAI8ymCi6g+cmmcpyHGxoUk+cMmmoIpE/O1AAwb9f2IgBg+UoeGLdaQohmYUlxs6573Tv6lbjw0uNOojS+NIqFApuE6/JzaZZh+5lFUvETa8QUEA2/06WZf8akQddX0o1BEYydSOmcbT8uyDjuLWcWr+f3RajLyg4Qa/Fzfl0bHA2cGIlx9AptwMp6eHh6atmsrJ1746cIOrJu6Ui2pi8YMTLHfxfB0AU5GTo5kFQPsI7kAdtvWFbX2kjDWlzKNhZkkc65AG2Za3kuGCajONI4jSCCHEwyUcRYRJPKe6ICmDUwqOTHKUOaKVVNQNcHVLp4DHUipkGzEBNYss4TWlGJExAtqzDgBAhW5TbKtYIwdZVEilRMIGV4AARrzhtCwBOUNxOJcITU+w0oG0jLpcU6QCQQWWwVpNxpdIPEER+qL6mj4fWEttmEsMeDT4ZKMBY6ncQvmW2fYuxQ1SPHpqYuQZafdn1pWJgEeS3mDp32Um4jti6uSXXGN43JNoJllGvntrhtldESnAenyaSiHyKRSF6etg8WJ6/QHvIC+bSucnHETzFZx+lljnYK+v61IEam6un4PTvt01jvEVEzAG+4DwfF32OIABhL0mKUDGADmMAFJ0CcSgO9QSpcGzkifMgIj+akVjkcCG/AIeaJRDY3R0iPWI77BWo0Ha9iKnr8XqQl51tRACklKrk3uNFKFxY38o2sb2j2Nt7+oleDBtHfdnNnM5WNlFcYZ8YfkpNtybpbLGv2Z4gdGyzofsizkuCCqMppSmAoiICBN/zwQEEvR/Vh2S/b10KcxkW2M46Vbgw9ANr0zDEah7KkMWWNMuHUXbt83q1KIJwNzSDeRh4BvEvSiIgSRFmkUQATnKIdFgUDky+LaNwRU+9M36Nm0gcX7XoAOsi5jH6R6+sPb0VGYaksjW7eGLcmWshAxGS8NZHt/KFjXCEWm7ji3BbxRKQkzEOHIIukXZREpikKcuwiB+HevQOynbJhSWxdRH6mtEhLttOIdeqjqZSTQVIUAiZedUhDbaibLOYHKTlvpHyxxb9RY8KLZRXl1bCVRom0vD9NsZVOGctNrrttfsUvNJW+sj5CFa+rdawHnrlx8iZYsO2svaK9MOI8ZDKlWvG+3t8LSUnCWu3KJF07ZhYrIM/MuJkRECJKhzqBjGAxVAKB1At85YrlI7utDIstoYwBBYlvqbvjBV+Nc6XNez2Yfu8Vtr2ZmteJiYteJYyK7adVbqDOFjASWkCKlRUUZouiJFLcLp21yW3yxWlC8McYuzXeuj3VxExLZ1djPH80Q0/bFxN0wBGbt9OWbOffviaVOYwHIgo2mE0gKm4ZIKgAu9TTJ1r39oTyPe+FtS+Prlj8xuJ409L3wwlVLlhc1tfLufjb6hL8lnLl+/dqJeeNuvnKE0h8FxFJG82vSzxprTFZxVMUGhon8NySp+m4Vpa6i8upyi7KFRlKih+admJNIsenl31tEqSta8pTn8uVPDeOZ2py+BMLUOdmcVVSY8Udp78hNKqrcyLXl1U9LPjSXyf90pgOW6rk2v5xTIWVjvGliWWe7W78bKtW27cdSKiL1MH3kDDmXahhVbE4BSV3LufbnPhJicvnBi71o6gYzJt2N4i3HgLWLYJXB2jwefIjMzDpfyVZ/wAwokRyJmq26aKR2/OLh57dNVPzqp1f2dLivZsrERTElrW8fYHnAcFZFYTCIF2WQUMBdz7F6BHoERENg6bwOR50Tq63NZlrwU9CjI4TwMSGynllBQqXkk4');

-- --------------------------------------------------------

--
-- Table structure for table `system`
--

CREATE TABLE `system` (
  `id` int(11) NOT NULL,
  `brand_name` varchar(250) NOT NULL,
  `brand_logo` text NOT NULL,
  `meta_title` text NOT NULL,
  `meta_desc` text NOT NULL,
  `meta_keywords` text NOT NULL,
  `ref_commission` int(11) NOT NULL,
  `wining_reward` int(11) NOT NULL,
  `minimum_withdraw` int(11) NOT NULL,
  `instagram` varchar(250) NOT NULL,
  `whatsapp` varchar(250) NOT NULL,
  `email` varchar(250) NOT NULL,
  `instruction` varchar(250) NOT NULL,
  `homepage_banner` text NOT NULL,
  `homepage_text` text NOT NULL,
  `kyc_type` int(11) NOT NULL,
  `site_mode` int(11) NOT NULL,
  `signup_allowed` int(11) NOT NULL,
  `joining_bonus` int(11) NOT NULL,
  `payment_gateway` varchar(100) NOT NULL,
  `theme` varchar(50) NOT NULL,
  `background` text NOT NULL,
  `font` varchar(200) NOT NULL,
  `game_amount` int(11) NOT NULL,
  `app_download_link` text NOT NULL,
  `app_download_image` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system`
--

INSERT INTO `system` (`id`, `brand_name`, `brand_logo`, `meta_title`, `meta_desc`, `meta_keywords`, `ref_commission`, `wining_reward`, `minimum_withdraw`, `instagram`, `whatsapp`, `email`, `instruction`, `homepage_banner`, `homepage_text`, `kyc_type`, `site_mode`, `signup_allowed`, `joining_bonus`, `payment_gateway`, `theme`, `background`, `font`, `game_amount`, `app_download_link`, `app_download_image`) VALUES
(1, '.', 'e408faacd1bf6f8b65469aa2c5a71fff.png', 'Ludo - Play Ludo & Earn Money', 'this is a website where you can play ludo game in ludo king app and earn lots of money by playing just game', 'ludo,earn money,ludo king,online satta', 5, 95, 0, 'https://wpclasses.in', '9876543210', 'admin@gmail.com', '', 'ead5d61af03a5850763ecba69401f6e4.jpg', 'This Game involves an element of financial risk and may be addictive. Please Play responsibly and at your own risk', 0, 1, 1, 10, 'D', 'theme/blackgrid/', '', '\'Questrial\', sans-serif;', 5, '', '80e1d85bbc8575ee875a36d6daa70cc0.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `transections`
--

CREATE TABLE `transections` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `order_id` varchar(250) NOT NULL,
  `utr` varchar(250) NOT NULL,
  `amount` int(11) NOT NULL,
  `type` varchar(10) NOT NULL,
  `reason` varchar(250) NOT NULL,
  `created_at` int(50) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `ctg` varchar(100) NOT NULL DEFAULT 'DEPOSIT',
  `match_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `avatar` varchar(250) NOT NULL,
  `username` varchar(250) DEFAULT NULL,
  `full_name` varchar(250) NOT NULL,
  `mobile_no` varchar(15) NOT NULL,
  `refer_code` varchar(20) NOT NULL,
  `code` varchar(20) NOT NULL,
  `created_at` int(50) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `withdraw_reqs`
--

CREATE TABLE `withdraw_reqs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `txn_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `upi_mobile` varchar(250) NOT NULL,
  `upi_app` varchar(100) NOT NULL,
  `name` text NOT NULL,
  `bank_ac_no` varchar(250) NOT NULL,
  `bank_ifsc_code` varchar(250) NOT NULL,
  `created_at` int(20) NOT NULL,
  `status` int(11) NOT NULL,
  `req_id` varchar(250) NOT NULL,
  `reason` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wr_params`
--

CREATE TABLE `wr_params` (
  `id` int(11) NOT NULL,
  `price_limit` int(11) NOT NULL,
  `reward` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_access`
--
ALTER TABLE `admin_access`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `apis`
--
ALTER TABLE `apis`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cancel_reqs`
--
ALTER TABLE `cancel_reqs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `conflicts`
--
ALTER TABLE `conflicts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `games`
--
ALTER TABLE `games`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kycs`
--
ALTER TABLE `kycs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `matches`
--
ALTER TABLE `matches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `system`
--
ALTER TABLE `system`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transections`
--
ALTER TABLE `transections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mobile_no` (`mobile_no`),
  ADD UNIQUE KEY `code` (`code`),
  ADD UNIQUE KEY `userid` (`username`);

--
-- Indexes for table `withdraw_reqs`
--
ALTER TABLE `withdraw_reqs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wr_params`
--
ALTER TABLE `wr_params`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `admin_access`
--
ALTER TABLE `admin_access`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `apis`
--
ALTER TABLE `apis`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `cancel_reqs`
--
ALTER TABLE `cancel_reqs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `conflicts`
--
ALTER TABLE `conflicts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `games`
--
ALTER TABLE `games`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `kycs`
--
ALTER TABLE `kycs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `matches`
--
ALTER TABLE `matches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `system`
--
ALTER TABLE `system`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `transections`
--
ALTER TABLE `transections`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `withdraw_reqs`
--
ALTER TABLE `withdraw_reqs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wr_params`
--
ALTER TABLE `wr_params`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
