START TRANSACTION;

INSERT INTO `image` (`id`, `url`, `alt`) VALUES
(1, 'url1', 'alt1'),
(2, 'url2', 'alt2'),
(3, 'url3', 'alt3'),
(4, 'url4', 'alt4');

INSERT INTO `section` (`id`, `title`, `description`) VALUES
(1, 'title1', 'descr1'),
(2, 'title2', 'descr2'),
(3, 'title3', 'descr3');

INSERT INTO `product` (`id`, `id_main_section`, `id_announcement_image`, `title`, `price`, `price_WOdiscount`, `price_promocode`, `description`) VALUES
(1, 1, 1, 'title1', '100.00', '120.00', '90.00', 'descr1'),
(2, 1, 2, 'title2', '999.00', '1200.00', '900.00', 'descr2'),
(3, 2, 3, 'title3', '200.00', '210.00', '199.00', 'descr3'),
(4, 2, 4, 'title4', '300.00', '333.00', '150.00', 'descr4');

INSERT INTO `product_image` (`id_product`, `id_image`) VALUES
(1, 1),
(2, 2),
(4, 2),
(3, 3),
(1, 4),
(4, 4);

INSERT INTO `section_product` (`id_section`, `id_product`) VALUES
(1, 1),
(2, 1),
(2, 2),
(2, 3),
(2, 4);

COMMIT;