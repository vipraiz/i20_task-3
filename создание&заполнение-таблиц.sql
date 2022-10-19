START TRANSACTION;

CREATE TABLE `image` (
  `id` int(11) NOT NULL,
  `url` varchar(100) NOT NULL,
  `alt` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `image` (`id`, `url`, `alt`) VALUES
(1, 'url1', 'alt1'),
(2, 'url2', 'alt2'),
(3, 'url3', 'alt3'),
(4, 'url4', 'alt4');

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `id_main_section` int(11) NOT NULL,
  `id_announcement_image` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `price_WOdiscount` decimal(8,2) DEFAULT NULL,
  `price_promocode` decimal(8,2) DEFAULT NULL,
  `description` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `product` (`id`, `id_main_section`, `id_announcement_image`, `title`, `price`, `price_WOdiscount`, `price_promocode`, `description`) VALUES
(1, 1, 1, 'title1', '100.00', '120.00', '90.00', 'descr1'),
(2, 1, 2, 'title2', '999.00', '1200.00', '900.00', 'descr2'),
(3, 2, 3, 'title3', '200.00', '210.00', '199.00', 'descr3'),
(4, 2, 4, 'title4', '300.00', '333.00', '150.00', 'descr4');

CREATE TABLE `product_image` (
  `id_product` int(11) NOT NULL,
  `id_image` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `product_image` (`id_product`, `id_image`) VALUES
(1, 1),
(2, 2),
(4, 2),
(3, 3),
(1, 4),
(4, 4);

CREATE TABLE `section` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `section` (`id`, `title`, `description`) VALUES
(1, 'title1', 'descr1'),
(2, 'title2', 'descr2'),
(3, 'title3', 'descr3');

CREATE TABLE `section_product` (
  `id_section` int(11) NOT NULL,
  `id_product` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `section_product` (`id_section`, `id_product`) VALUES
(1, 1),
(2, 1),
(2, 2),
(2, 3),
(2, 4);


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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `section`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;


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
