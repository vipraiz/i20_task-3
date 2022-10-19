START TRANSACTION;

CREATE TABLE `image` (
  `id` int(11) NOT NULL,
  `url` varchar(100) NOT NULL,
  `alt` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

CREATE TABLE `product_image` (
  `id_product` int(11) NOT NULL,
  `id_image` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `section` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `section_product` (
  `id_section` int(11) NOT NULL,
  `id_product` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


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
