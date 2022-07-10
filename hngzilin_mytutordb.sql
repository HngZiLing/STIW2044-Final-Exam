-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 10, 2022 at 05:53 PM
-- Server version: 10.3.35-MariaDB-cll-lve
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hngzilin_mytutordb`
--

-- --------------------------------------------------------

--
-- Table structure for table `table_user`
--

CREATE TABLE `table_user` (
  `user_id` int(5) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_password` varchar(40) NOT NULL,
  `user_phone` varchar(12) NOT NULL,
  `user_address` varchar(100) NOT NULL,
  `user_image` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `table_user`
--

INSERT INTO `table_user` (`user_id`, `user_name`, `user_email`, `user_password`, `user_phone`, `user_address`, `user_image`) VALUES
(2, 'H\'ng Zi Ling', 'hngziling@gmail.com', '6014c0de835e3b8cd638a9ee6a0ea2f405251f3a', '012-4413822', 'Nibong Tebal, Penang.', ''),
(5, 'Vin Chew', 'vinchew@gmail.com', '3d4e0c388ca458026e22da267b0a8559732fba1e', '012-1121212', 'Bukit Mertajam, Penang.', ''),
(6, 'Star Ho', 'starho@gmail.com', '257d514379278895a7050ef40436ee60e7fbf519', '012-1212608', 'Sintok, Kedah.', ''),
(7, 'Clara Teoh', 'clarateoh@gmail.com', '69e9896a3581a1dcf84f0381d9107570b65fd9cc', '012-1717112', 'Kulai, Johor.', ''),
(8, 'Lucky Law', 'luckylaw@gmail.com', '4fb89b2b825b3ee6dd1e8312b5944a068f478109', '012-6868688', 'Alor Setar, Kedah.', ''),
(12, 'Amy', 'amy@gmail.com', '05bfed76f14ae414343d7e93cc7c5555159ccf37', '012-6060606', 'Selangor, Malaysia', ''),
(15, 'BoBo', 'bobo@gmail.com', 'ab895517e48201893f8d17692a5a48b83e545f78', '013-3030303', 'Ipoh, Malaysia', ''),
(19, 'Blue', 'blue@gmail.com', '5ec61214566eda7662fe4bd6886d38c2fc80bc8c', '012-1231234', 'Sungai Bakap, Penang.', ''),
(24, '', '', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_carts`
--

CREATE TABLE `tbl_carts` (
  `cart_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `cart_quantity` int(11) NOT NULL,
  `cart_status` varchar(20) DEFAULT NULL,
  `receipt_id` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_carts`
--

INSERT INTO `tbl_carts` (`cart_id`, `subject_id`, `user_email`, `cart_quantity`, `cart_status`, `receipt_id`) VALUES
(2, 6, 'hngziling@gmail.com', 1, 'paid', 'tpteuorl'),
(3, 10, 'hngziling@gmail.com', 1, 'paid', 'fudiiep1'),
(8, 10, 'hngziling@gmail.com', 1, 'paid', '7eimm380'),
(9, 9, 'hngziling@gmail.com', 1, 'paid', '7eimm380'),
(10, 6, 'hngziling@gmail.com', 1, 'paid', '7eimm380'),
(11, 4, 'hngziling@gmail.com', 1, 'paid', '7eimm380'),
(12, 5, 'hngziling@gmail.com', 1, 'paid', '7eimm380'),
(13, 7, 'hngziling@gmail.com', 1, 'paid', '7eimm380'),
(15, 10, 'hngziling@gmail.com', 1, 'paid', 'ool5pcik'),
(17, 4, 'hngziling@gmail.com', 1, 'paid', 'q7tjyray'),
(18, 5, 'hngziling@gmail.com', 1, 'paid', 'zglffy86'),
(19, 3, 'hngziling@gmail.com', 1, 'paid', 'zglffy86'),
(20, 2, 'hngziling@gmail.com', 1, 'paid', 'rzj0fmpl'),
(21, 1, 'hngziling@gmail.com', 1, 'paid', 'cfe3liwn'),
(22, 2, 'hngziling@gmail.com', 1, 'paid', 'xahmodxg'),
(23, 3, 'hngziling@gmail.com', 1, 'paid', 'sdkheco2'),
(24, 1, 'hngziling@gmail.com', 1, 'paid', 'xnxk0duq');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_orders`
--

CREATE TABLE `tbl_orders` (
  `order_id` int(11) NOT NULL,
  `receipt_id` varchar(10) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `order_paid` float NOT NULL,
  `order_status` varchar(15) DEFAULT NULL,
  `order_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_orders`
--

INSERT INTO `tbl_orders` (`order_id`, `receipt_id`, `user_email`, `order_paid`, `order_status`, `order_date`) VALUES
(1, 'tpteuorl', 'hngziling@gmail.com', 180, 'Paid', '2022-07-10 01:26:03'),
(2, 'fudiiep1', 'hngziling@gmail.com', 330, 'Paid', '2022-07-10 03:07:23'),
(3, '7eimm380', 'hngziling@gmail.com', 920, 'Paid', '2022-07-10 14:26:10'),
(4, 'ool5pcik', 'hngziling@gmail.com', 150, 'Paid', '2022-07-10 14:43:25'),
(5, 'q7tjyray', 'hngziling@gmail.com', 150, 'Paid', '2022-07-10 14:47:37'),
(6, 'zglffy86', 'hngziling@gmail.com', 300, 'Paid', '2022-07-10 15:22:06'),
(7, 'rzj0fmpl', 'hngziling@gmail.com', 200, 'Paid', '2022-07-10 15:35:46'),
(8, 'cfe3liwn', 'hngziling@gmail.com', 250, 'Paid', '2022-07-10 15:49:07'),
(9, 'xahmodxg', 'hngziling@gmail.com', 200, 'Paid', '2022-07-10 15:51:56'),
(10, 'sdkheco2', 'hngziling@gmail.com', 180, 'Paid', '2022-07-10 15:53:56'),
(11, 'xnxk0duq', 'hngziling@gmail.com', 250, 'Paid', '2022-07-10 16:58:08');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_subjects`
--

CREATE TABLE `tbl_subjects` (
  `subject_id` int(4) NOT NULL,
  `subject_name` varchar(150) NOT NULL,
  `subject_description` varchar(500) NOT NULL,
  `subject_price` float NOT NULL,
  `tutor_id` varchar(4) NOT NULL,
  `subject_sessions` int(3) NOT NULL,
  `subject_rating` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_subjects`
--

INSERT INTO `tbl_subjects` (`subject_id`, `subject_name`, `subject_description`, `subject_price`, `tutor_id`, `subject_sessions`, `subject_rating`) VALUES
(1, 'Programming 101', 'Basic programming for new student with no background in programming.', 250, '1', 15, 4.5),
(2, 'Programming 201', 'Intermediate programming course that aim for those who has basic programming knowledge.', 200, '2', 10, 4),
(3, 'Introduction to Web programming ', 'Basic introduction to HTML, CSS, JavaScript, PHP and MySQL.', 180, '5', 15, 3.8),
(4, 'Web programming advanced', 'Course aim for those who are familiar with basic web programming.', 150, '3', 15, 4.2),
(5, 'Python for Everybody', 'This Specialization builds on the success of the Python for Everybody course and will introduce fundamental programming concepts including data structures, networked application program interfaces, and databases, using the Python programming language.', 120, '6', 5, 4.5),
(6, 'Introduction to Computer Science', 'This specialisation covers topics ranging from basic computing principles to the mathematical foundations required for computer science. ', 180, '3', 10, 4.2),
(7, 'Code Yourself! An Introduction to Programming', 'This course will teach you how to program in Scratch, an easy to use visual programming language. More importantly, it will introduce you to the fundamental principles of computing and it will help you think like a software engineer.', 120, '4', 5, 4),
(8, 'IBM Full Stack Software Developer Professional Certificate', 'ickstart your career in application development. Master Cloud Native and Full Stack Development using hands-on projects involving HTML, JavaScript, Node.js, Python, Django, Containers, Microservices and more. No prior experience required.', 230, '8', 8, 4.3),
(9, 'Graphic Design Specialization', 'his four-course sequence exposes students to the fundamental skills required to make sophisticated graphic design: process, historical context, and communication through image-making and typography. T', 200, '1', 5, 4.2),
(10, 'Fundamentals of Graphic Design', 'At the end of this course you will have learned how to explore and investigate visual representation through a range of image-making techniques; understand basic principles of working with shape, color and pattern; been exposed to the language and skills of typography; and understand and have applied the principles of composition and visual contrast. ', 150, '2', 5, 3.8),
(11, 'Fundamentals of Graphic Design', 'Project centered courses are designed specifically to help you complete a personally meaningful real-world project, with your instructor and a community of like-minded learners providing guidance and suggestions along the way.', 150, '5', 5, 4.8),
(12, 'Full-Stack Web Development with React', 'Learners will work on hands-on exercises, culminating in development of a full-fledged application at the end of each course. Each course also includes a mini-Capstone Project as part of the Honors Track where you’ll apply your skills to build a fully functional project.', 250, '7', 10, 4.2),
(13, 'Software Design and Architecture', 'In the Software Design and Architecture Specialization, you will learn how to apply design principles, patterns, and architectures to create reusable and flexible software applications and systems. You will learn how to express and document the design and architecture of a software system using a visual notation.', 170, '8', 3, 4.2),
(14, 'Software Testing and Automation', 'Learners will build test plans, test suites, and test analysis reports. Learners will develop properties and assertions in code to facilitate automated test generation. Learners will also create pre-conditions for methods to facilitate formal proofs of correctness.', 170, '9', 5, 4.1),
(15, 'Introduction to Cyber Security', 'The learning outcome is simple: We hope learners will develop a lifelong passion and appreciation for cyber security, which we are certain will help in future endeavors. ', 200, '9', 5, 4.2),
(16, 'Programming for Everybody', 'This course aims to teach everyone the basics of programming computers using Python. We cover the basics of how one constructs a program from a series of simple instructions in Python.  The course has no pre-requisites and avoids all but the simplest mathematics. Anyone with moderate computer experience should be able to master the materials in this course. This course will cover Chapters 1-5 of the textbook “Python for Everybody”.  Once a student completes this course, they will be ready to tak', 150, '6', 10, 4.8),
(17, 'Python Basics', 'This course introduces the basics of Python 3, including conditional execution and iteration as control structures, and strings and lists as data structures. You\'ll program an on-screen Turtle to draw pretty pictures. You\'ll also learn to draw reference diagrams as a way to reason about program executions, which will help to build up your debugging skills. The course has no prerequisites. It will cover Chapters 1-9 of the textbook \"Fundamentals of Python Programming,\" which is the accompanying t', 120, '2', 15, 4.8),
(18, 'Java Programming and Software Engineering Fundamentals Specialization', 'Take your first step towards a career in software development with this introduction to Java—one of the most in-demand programming languages and the foundation of the Android operating system. Designed for beginners, this Specialization will teach you core programming concepts and equip you to write programs to solve complex problems. In addition, you will gain the foundational skills a software engineer needs to solve real-world problems, from designing algorithms to testing and debugging your ', 135, '4', 5, 4.6),
(19, 'Programming Languages, Part A', 'This course is an introduction to the basic concepts of programming languages, with a strong emphasis on functional programming. The course uses the languages ML, Racket, and Ruby as vehicles for teaching the concepts, but the real intent is to teach enough about how any language “fits together” to make you more effective programming in any language -- and in learning new ones.', 200, '9', 10, 4.9),
(20, 'Programming Languages, Part B', '[As described below, this is Part B of a 3-part course.  Participants should complete Part A first -- Part B \"dives right in\" and refers often to material from Part A.]\r\nThis course is an introduction to the basic concepts of programming languages, with a strong emphasis on functional programming. The course uses the languages ML, Racket, and Ruby as vehicles for teaching the concepts, but the real intent is to teach enough about how any language “fits together” to make you more effective progra', 200, '9', 10, 4.9),
(21, 'Programming Languages, Part C', '[As described below, this is Part C of a 3-part course.  Participants should complete Parts A and B first -- Part C \"dives right in\" and refers often to material from Part A and Part B.]\r\nThis course is an introduction to the basic concepts of programming languages, with a strong emphasis on functional programming. The course uses the languages ML, Racket, and Ruby as vehicles for teaching the concepts, but the real intent is to teach enough about how any language “fits together” to make you mor', 200, '9', 10, 4.9),
(22, 'JavaScript, jQuery, and JSON', 'In this course, we\'ll look at the JavaScript language, and how it supports the Object-Oriented pattern, with a focus on the unique aspect of how JavaScript approaches OO. We\'ll explore a brief introduction to the jQuery library, which is widely used to do in-browser manipulation of the Document Object Model (DOM) and event handling. You\'ll also learn more about JavaScript Object Notation (JSON), which is commonly used as a syntax to exchange data between code running on the server (i.e. in PHP) ', 100, '5', 5, 4.6),
(23, 'Using JavaScript, JQuery, and JSON in Django', 'In this final course, we\'ll look at the JavaScript language and how it supports the Object-Oriented pattern, with a focus on the unique aspects of JavaScript\'s approach to OO. We\'ll provide an introduction to the jQuery library, which is widely used for in-browser manipulation of the Document Object Model (DOM) and event handling. You\'ll also learn about JavaScript Object Notation (JSON), which is commonly used as a syntax to exchange data between code running on the server (i.e., in Django) and', 180, '1', 5, 4.8);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_tutors`
--

CREATE TABLE `tbl_tutors` (
  `tutor_id` int(5) NOT NULL,
  `tutor_email` varchar(50) NOT NULL,
  `tutor_phone` varchar(15) NOT NULL,
  `tutor_name` varchar(50) NOT NULL,
  `tutor_password` varchar(40) NOT NULL,
  `tutor_description` varchar(300) NOT NULL,
  `tutor_datereg` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_tutors`
--

INSERT INTO `tbl_tutors` (`tutor_id`, `tutor_email`, `tutor_phone`, `tutor_name`, `tutor_password`, `tutor_description`, `tutor_datereg`) VALUES
(1, 'prashanthini@mytutor.com.my', '+60188816970', 'Prashanthini a/l Manjit Ramasamy', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 'Nunc venenatis bibendum odio, in fermentum sem ultrices sed. Integer in quam turpis. Curabitur sed euismod sem, sed fringilla arcu. Sed justo felis, hendrerit eget elit ac, consequat sodales nibh.', '2022-06-02 10:29:14.000000'),
(2, 'sinnathuray.bakzi@yang.com', '+601132339126', 'Chai Tan Hiu', '86e40acfd92d4c5f44de76963ab68208ef0ab389', 'Integer nulla dui, blandit eu sollicitudin vitae, malesuada at est. Curabitur varius nisl vitae felis sagittis, sit amet porta urna mollis. Proin venenatis justo lorem, vitae tincidunt dui pharetra vel.', '2022-05-24 15:21:25.000000'),
(3, 'huzir42@bakry.org', '+6095798898', 'Nur Maya binti Aidil Hafizee ', '02dd38ccd56a4efbe22f4599f4717a8cf3eb9281', 'Maecenas vitae leo in ipsum pulvinar hendrerit vitae ac urna. Maecenas consequat aliquet leo pulvinar tincidunt. Vivamus placerat neque sit amet hendrerit feugiat.', '2022-03-03 15:21:25.000000'),
(4, 'dkok@majid.biz', '+60377236036', 'Ling Liang Thok', '76b241504f3904db725c01fcc532c2bdfae609ae', 'Aliquam dignissim ut libero non aliquet. Etiam eu ultricies enim. Phasellus gravida ac libero in porta. Phasellus tincidunt feugiat est, quis pellentesque risus eleifend vitae.', '2022-06-09 21:47:05.000000'),
(5, 'melissa57@hotmail.com', '+6069427992', 'Teoh Chum Liek', '86e40acfd92d4c5f44de76963ab68208ef0ab389', 'Morbi at turpis in quam gravida facilisis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ac nisl lorem. ', '2022-06-27 21:48:25.000000'),
(6, 'azizy.kavita@foong.info', '+60152045292', 'Amirah binti Che Aznizam', '02dd38ccd56a4efbe22f4599f4717a8cf3eb9281', 'Nullam sed fringilla nisl. Proin aliquet metus quis ornare faucibus. Proin non mauris maximus, mollis enim non, bibendum nibh. Morbi feugiat fermentum imperdiet. ', '2022-03-03 15:21:25.000000'),
(7, 'teoki57@hotmail.com', '+6069427992', 'Teoh Chum Liek', '86e40acfd92d4c5f44de76963ab68208ef0ab389', 'Morbi at turpis in quam gravida facilisis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ac nisl lorem. ', '2022-06-27 21:48:25.000000'),
(8, 'nelson.jaini@parthiban.info', '+60102727980', 'Muhammet Firdaus Miskoulan bin Jamal', 'b4b9c99d312bf05bfb05341d981d6a17ace24b51', 'Duis at iaculis ante. Praesent in risus blandit, tempus nibh eu, imperdiet nunc. Ut quis lobortis quam. Nullam sed purus eros. Donec ac viverra orci. Pellentesque non neque et tellus gravida interdum', '2022-05-29 22:10:53.000000'),
(9, 'vetils@veerasamy.com', '+6089-64 4857', 'P. Veetil a/l Ramadas', '49bd6349e19baa02a3adb1d770cb873fcca2cf38', 'Proin venenatis justo lorem, vitae tincidunt dui pharetra vel. Duis ultricies gravida condimentum. Phasellus pellentesque sodales dolor, dictum pulvinar felis convallis ut.', '2022-06-15 22:11:49.000000');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `table_user`
--
ALTER TABLE `table_user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_email` (`user_email`);

--
-- Indexes for table `tbl_carts`
--
ALTER TABLE `tbl_carts`
  ADD PRIMARY KEY (`cart_id`);

--
-- Indexes for table `tbl_orders`
--
ALTER TABLE `tbl_orders`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `tbl_subjects`
--
ALTER TABLE `tbl_subjects`
  ADD PRIMARY KEY (`subject_id`);

--
-- Indexes for table `tbl_tutors`
--
ALTER TABLE `tbl_tutors`
  ADD PRIMARY KEY (`tutor_id`),
  ADD UNIQUE KEY `tutor_email` (`tutor_email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `table_user`
--
ALTER TABLE `table_user`
  MODIFY `user_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `tbl_carts`
--
ALTER TABLE `tbl_carts`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `tbl_orders`
--
ALTER TABLE `tbl_orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `tbl_subjects`
--
ALTER TABLE `tbl_subjects`
  MODIFY `subject_id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `tbl_tutors`
--
ALTER TABLE `tbl_tutors`
  MODIFY `tutor_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
