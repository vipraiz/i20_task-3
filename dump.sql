SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+07:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `i20_task3` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `i20_task3`;

CREATE TABLE `image` (
  `id` int(11) NOT NULL,
  `url` varchar(100) NOT NULL,
  `alt` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `image` (`id`, `url`, `alt`) VALUES
(1, 'images/01.jpg', 'alt01'),
(2, 'images/02.jpg', 'alt02'),
(3, 'images/03.jpg', 'alt03'),
(4, 'images/04.jpg', 'alt04'),
(5, 'images/05.jpg', 'alt05'),
(6, 'images/06.jpg', 'alt06'),
(7, 'images/07.jpg', 'alt07'),
(8, 'images/08.jpg', 'alt08');

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `id_main_section` int(11) NOT NULL,
  `id_announcement_image` int(11) NOT NULL,
  `title` varchar(80) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `price_without_discount` decimal(8,2) DEFAULT NULL,
  `price_promocode` decimal(8,2) DEFAULT NULL,
  `description` text NOT NULL,
  `active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `product` (`id`, `id_main_section`, `id_announcement_image`, `title`, `price`, `price_without_discount`, `price_promocode`, `description`, `active`) VALUES
(1, 1, 1, 'product1', '100.00', '120.00', '90.00', 'descr1', 1),
(2, 1, 2, 'product2', '999.00', '1200.00', '900.00', 'descr2', 1),
(3, 1, 3, 'product3', '200.00', '210.00', '199.00', 'descr3', 1),
(4, 1, 4, 'product4', '300.00', '333.00', '150.00', 'descr4', 1),
(5, 1, 5, 'product5', '100.00', '120.00', '90.00', 'descr5', 1),
(6, 1, 6, 'product6', '999.00', '1200.00', '900.00', 'descr6', 1),
(7, 1, 7, 'product7', '200.00', '210.00', '199.00', 'descr7', 1),
(8, 2, 8, 'product8', '300.00', '333.00', '150.00', 'descr8', 1),
(9, 2, 5, 'product9', '100.00', '120.00', '90.00', 'descr9', 1),
(10, 2, 6, 'product10', '999.00', '1200.00', '900.00', 'descr10', 1),
(11, 2, 7, 'product11', '200.00', '210.00', '199.00', 'descr11', 1),
(12, 2, 8, 'product12', '300.00', '333.00', '150.00', 'descr12', 1),
(13, 2, 3, 'product13', '200.00', '210.00', '199.00', 'descr13', 1),
(14, 2, 4, 'product14', '999.00', '1200.00', '900.00', 'descr14', 0);

CREATE TABLE `product_image` (
  `id_product` int(11) NOT NULL,
  `id_image` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `product_image` (`id_product`, `id_image`) VALUES
(1, 1),
(2, 2),
(4, 2),
(3, 3),
(13, 3),
(1, 4),
(4, 4),
(14, 4),
(5, 5),
(9, 5),
(12, 5),
(14, 5),
(6, 6),
(10, 6),
(11, 6),
(7, 7),
(10, 7),
(11, 7),
(8, 8),
(9, 8),
(12, 8);

CREATE TABLE `section` (
  `id` int(11) NOT NULL,
  `title` varchar(80) NOT NULL,
  `description` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `section` (`id`, `title`, `description`) VALUES
(1, 'section1', 'descr1'),
(2, 'section2', 'descr2'),
(3, 'section3', 'descr3');

CREATE TABLE `section_product` (
  `id_section` int(11) NOT NULL,
  `id_product` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `section_product` (`id_section`, `id_product`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(2, 5),
(1, 6),
(2, 6),
(1, 7),
(2, 7),
(1, 8),
(2, 8),
(2, 9),
(2, 10),
(2, 11),
(2, 12),
(2, 13);


ALTER TABLE `image`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_ibfk_1` (`id_main_section`),
  ADD KEY `id_announcement_image` (`id_announcement_image`);

ALTER TABLE `product_image`
  ADD PRIMARY KEY (`id_product`,`id_image`),
  ADD KEY `product_image_ibfk_2` (`id_image`);

ALTER TABLE `section`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `section_product`
  ADD PRIMARY KEY (`id_section`,`id_product`),
  ADD KEY `section_product_ibfk_2` (`id_product`);


ALTER TABLE `image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

ALTER TABLE `section`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;


ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`id_main_section`) REFERENCES `section` (`id`),
  ADD CONSTRAINT `product_ibfk_2` FOREIGN KEY (`id_announcement_image`) REFERENCES `image` (`id`);

ALTER TABLE `product_image`
  ADD CONSTRAINT `product_image_ibfk_1` FOREIGN KEY (`id_product`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `product_image_ibfk_2` FOREIGN KEY (`id_image`) REFERENCES `image` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `section_product`
  ADD CONSTRAINT `section_product_ibfk_1` FOREIGN KEY (`id_section`) REFERENCES `section` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `section_product_ibfk_2` FOREIGN KEY (`id_product`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;