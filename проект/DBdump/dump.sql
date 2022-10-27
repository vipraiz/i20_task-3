SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+07:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `i20_task3` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `i20_task3`;

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `title` varchar(80) NOT NULL,
  `description` varchar(365) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `category` (`id`, `title`, `description`) VALUES
(1, 'Рубашки', 'Рубашка, как правило, состоит из воротника, полочек, спинки, кокетки, рукавов, ластовицы (треугольный кусок ткани, вшитый у основания рукава, между полочкой и спинкой). Различают рубашки с коротким (до локтя) и длинным (до запястья) рукавом.'),
(2, 'Пальто', 'Пальто — разновидность мужского и женского верхнего платья для прохладной и холодной погоды. Традиционно длинное и шьётся из шерстяного сукна, в современности популярны также полупальто, которые как правило немногим длиннее пиджака.'),
(3, 'Джинсы', 'Джинсы — брюки из плотной хлопчатобумажной ткани с проклёпанными стыками швов на карманах. Впервые массово изготовлены в XVII веке моряками из отходов прорвавшихся парусов почти одновременно во всех странах, ходивших под парусами. Изначально были некрашенными, в основном белыми, а после того, как самым дешёвым красителем стал цвет «индиго» — стали синими.'),
(4, 'Кошки', 'Секретная категория');

CREATE TABLE `category_product` (
  `id_category` int(11) NOT NULL,
  `id_product` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `category_product` (`id_category`, `id_product`) VALUES
(1, 11),
(1, 13),
(2, 12),
(2, 14);

CREATE TABLE `image` (
  `id` int(11) NOT NULL,
  `src` varchar(100) NOT NULL,
  `alt` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `image` (`id`, `src`, `alt`) VALUES
(1, '1.jpg', 'Рубашка medicine'),
(2, '2.jpg', 'Рубашка O\'Stin'),
(3, '3.jpg', 'Рубашка Befree'),
(4, '4.jpg', 'Рубашка Zarina'),
(5, '5.jpg', 'Рубашка Zarina'),
(6, '6.jpg', 'Рубашка Colin\'s'),
(7, '7.jpg', 'Рубашка Colin\'s'),
(8, '8.jpg', 'Рубашка Zarina'),
(9, '9.jpg', 'Рубашка Mark O\'Polo'),
(10, '10.jpg', 'Рубашка Envylab'),
(11, '11.jpg', 'Рубашка-пальто Slim Fit'),
(12, '12.jpg', 'Рубашка-пальто Slim Fit'),
(13, '13.jpg', 'Рубашка-пальто Swand'),
(14, '14.jpg', 'Рубашка-пальто Esmara'),
(15, '15.jpg', 'Пальто Unique Fabric'),
(16, '16.jpg', 'Пальто Louren Wilton'),
(17, '1-2.jpg', 'Рубашка medicine'),
(18, '1-3.jpg', 'Рубашка medicine'),
(19, '3-2.jpg', 'Рубашка Befree'),
(20, '7-2.jpg', 'Рубашка Colin\'s'),
(21, 'cat.jpg', 'Кошечка');

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `id_main_category` int(11) NOT NULL,
  `id_announcement_image` int(11) NOT NULL,
  `title` varchar(80) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `price_without_discount` decimal(8,2) DEFAULT NULL,
  `price_promocode` decimal(8,2) DEFAULT NULL,
  `description` text NOT NULL,
  `active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `product` (`id`, `id_main_category`, `id_announcement_image`, `title`, `price`, `price_without_discount`, `price_promocode`, `description`, `active`) VALUES
(1, 1, 1, 'Рубашка Medicine', '2499.00', '2699.00', '2227.00', 'Рубашка Medicine выполнена из вискозной ткани с клетчатым узором.<br>Детали: прямой крой; отложной воротник; планка и манжеты на пуговицах; карман на груди.', 1),
(2, 1, 2, 'Рубашка O\'Stin', '3000.00', '3800.00', '2500.00', 'descr2', 1),
(3, 1, 3, 'Рубашка Befree', '1500.00', '2400.00', '1337.00', 'descr3', 1),
(4, 1, 4, 'Рубашка Zarina', '1600.00', '2500.00', '1500.00', 'descr4', 0),
(5, 1, 5, 'Рубашка Zarina', '1800.00', '3000.00', '1500.00', 'descr5', 1),
(6, 1, 6, 'Рубашка Colin\'s', '1300.00', '1990.00', '1000.00', 'descr6', 1),
(7, 1, 7, 'Рубашка Colin\'s', '1770.00', '2000.00', '1600.00', 'descr7', 1),
(8, 1, 8, 'Рубашка Zarina', '2100.00', '4000.00', '1800.00', 'descr8', 1),
(9, 1, 9, 'Рубашка Mark O\'Polo', '5000.00', '9990.00', '3800.00', 'descr9', 1),
(10, 1, 10, 'Рубашка Envylab', '1300.00', '2000.00', '1000.00', 'descr10', 1),
(11, 2, 11, 'Рубашка-пальто Slim Fit', '8000.00', '12000.00', '7000.00', 'descr11', 1),
(12, 1, 12, 'Рубашка-пальто Slim Fit', '7400.00', '12000.00', '7000.00', 'descr12', 1),
(13, 2, 13, 'Рубашка-пальто Swand', '14990.00', '20000.00', '12000.00', 'descr13', 1),
(14, 1, 14, 'Рубашка-пальто Esmara', '13000.00', '20000.00', '10000.00', 'descr14', 1),
(15, 2, 15, 'Пальто Unique Fabric', '16000.00', '30000.00', '12370.00', 'descr15', 1),
(16, 2, 16, 'Пальто Louren Wilton', '10000.00', '22000.00', '8800.00', 'descr16', 1),
(21, 4, 21, 'Кошка', '1.11', '1000000.00', '0.01', 'мур-мур', 0);

CREATE TABLE `product_image` (
  `id_product` int(11) NOT NULL,
  `id_image` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `product_image` (`id_product`, `id_image`) VALUES
(1, 1),
(1, 17),
(1, 18),
(1, 21),
(2, 2),
(3, 3),
(3, 19),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(7, 20),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(21, 21);

ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `category_product`
  ADD PRIMARY KEY (`id_category`,`id_product`),
  ADD KEY `category_product_ibfk_2` (`id_product`);

ALTER TABLE `image`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_ibfk_1` (`id_main_category`),
  ADD KEY `id_announcement_image` (`id_announcement_image`);

ALTER TABLE `product_image`
  ADD PRIMARY KEY (`id_product`,`id_image`),
  ADD KEY `product_image_ibfk_2` (`id_image`);


ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

ALTER TABLE `image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;


ALTER TABLE `category_product`
  ADD CONSTRAINT `category_product_ibfk_1` FOREIGN KEY (`id_category`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `category_product_ibfk_2` FOREIGN KEY (`id_product`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`id_main_category`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `product_ibfk_2` FOREIGN KEY (`id_announcement_image`) REFERENCES `image` (`id`);

ALTER TABLE `product_image`
  ADD CONSTRAINT `product_image_ibfk_1` FOREIGN KEY (`id_product`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `product_image_ibfk_2` FOREIGN KEY (`id_image`) REFERENCES `image` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;