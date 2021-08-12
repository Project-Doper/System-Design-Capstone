-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'Products'
--
-- ---

DROP TABLE IF EXISTS `Products`;

CREATE TABLE `Products` (
  `product_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `name` VARCHAR NULL DEFAULT NULL,
  `slogan` VARCHAR NULL DEFAULT NULL,
  `description` VARCHAR NULL DEFAULT NULL,
  `category` VARCHAR NULL DEFAULT NULL,
  `default_price` VARCHAR NULL DEFAULT NULL,
  PRIMARY KEY (`product_id`)
);

-- ---
-- Table 'Styles'
--
-- ---

DROP TABLE IF EXISTS `Styles`;

CREATE TABLE `Styles` (
  `style_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `name` VARCHAR NULL DEFAULT NULL,
  `original_price` VARCHAR NULL DEFAULT NULL,
  `sale_price` VARCHAR NULL DEFAULT NULL,
  `default?` TINYINT NULL DEFAULT NULL,
  `product_id` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`style_id`)
);

-- ---
-- Table 'Photos'
--
-- ---

DROP TABLE IF EXISTS `Photos`;

CREATE TABLE `Photos` (
  `photos_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `url` VARCHAR NULL DEFAULT NULL,
  `thumbnail_url` VARCHAR NULL DEFAULT NULL,
  `style_id` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`photos_id`)
);

-- ---
-- Table 'Sku'
--
-- ---

DROP TABLE IF EXISTS `Sku`;

CREATE TABLE `Sku` (
  `id` INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
  `quantity` INTEGER NOT NULL,
  `size` VARCHAR(255) NOT NULL,
  `styleid` INTEGER NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE skus (
   id INT PRIMARY KEY,
   quantity INT,
   size TEXT,
   styleid INT
);

-- ---
-- Table 'Features'
--
-- ---

DROP TABLE IF EXISTS `Features`;

CREATE TABLE `Features` (
  `feature_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `feature` VARCHAR NULL DEFAULT NULL,
  `value` VARCHAR NULL DEFAULT NULL,
  `product_id` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`feature_id`)
);

-- ---
-- Foreign Keys
-- ---

ALTER TABLE `Styles` ADD FOREIGN KEY (product_id) REFERENCES `Products` (`product_id`);
ALTER TABLE `Photos` ADD FOREIGN KEY (style_id) REFERENCES `Styles` (`style_id`);
ALTER TABLE `Sku` ADD FOREIGN KEY (style_id) REFERENCES `Styles` (`style_id`);
ALTER TABLE `Features` ADD FOREIGN KEY (product_id) REFERENCES `Products` (`product_id`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `Products` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Styles` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Photos` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Sku` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Features` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `Products` (`product_id`,`name`,`slogan`,`description`,`category`,`default_price`) VALUES
-- ('','','','','','');
-- INSERT INTO `Styles` (`style_id`,`name`,`original_price`,`sale_price`,`default?`,`product_id`) VALUES
-- ('','','','','','');
-- INSERT INTO `Photos` (`photos_id`,`url`,`thumbnail_url`,`style_id`) VALUES
-- ('','','','');
-- INSERT INTO `Sku` (`id`,`quantity`,`size`,`style_id`) VALUES
-- ('','','','');
-- INSERT INTO `Features` (`feature_id`,`feature`,`value`,`product_id`) VALUES
-- ('','','','');