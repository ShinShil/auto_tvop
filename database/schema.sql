-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema auto_tvop
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema auto_tvop
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `auto_tvop` DEFAULT CHARACTER SET utf8 ;
USE `auto_tvop` ;

-- -----------------------------------------------------
-- Table `auto_tvop`.`application`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auto_tvop`.`application` ;

CREATE TABLE IF NOT EXISTS `auto_tvop`.`application` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `archive` VARCHAR(45) NULL,
  `version` VARCHAR(45) NULL,
  `releaseDate` DATETIME NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `auto_tvop`.`user_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auto_tvop`.`user_role` ;

CREATE TABLE IF NOT EXISTS `auto_tvop`.`user_role` (
  `id` INT NOT NULL,
  `description` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `auto_tvop`.`user_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auto_tvop`.`user_group` ;

CREATE TABLE IF NOT EXISTS `auto_tvop`.`user_group` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `groupName_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `auto_tvop`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auto_tvop`.`user` ;

CREATE TABLE IF NOT EXISTS `auto_tvop`.`user` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `surname` VARCHAR(45) NULL,
  `user_role_id` INT NOT NULL,
  `user_group_id` INT UNSIGNED NULL,
  PRIMARY KEY (`id`, `user_role_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_User_user_role_idx` (`user_role_id` ASC),
  INDEX `fk_User_user_group1_idx` (`user_group_id` ASC),
  CONSTRAINT `fk_User_user_role`
    FOREIGN KEY (`user_role_id`)
    REFERENCES `auto_tvop`.`user_role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_user_group1`
    FOREIGN KEY (`user_group_id`)
    REFERENCES `auto_tvop`.`user_group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `auto_tvop`.`error_importance`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auto_tvop`.`error_importance` ;

CREATE TABLE IF NOT EXISTS `auto_tvop`.`error_importance` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `description_UNIQUE` (`description` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `auto_tvop`.`error_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auto_tvop`.`error_group` ;

CREATE TABLE IF NOT EXISTS `auto_tvop`.`error_group` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `auto_tvop`.`error_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auto_tvop`.`error_type` ;

CREATE TABLE IF NOT EXISTS `auto_tvop`.`error_type` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `error_typecol_UNIQUE` (`description` ASC),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `auto_tvop`.`error`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auto_tvop`.`error` ;

CREATE TABLE IF NOT EXISTS `auto_tvop`.`error` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `application_id` INT UNSIGNED NOT NULL,
  `error_importance_id` INT UNSIGNED NOT NULL,
  `error_group_id` INT UNSIGNED NOT NULL,
  `error_type_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `createdAt` DATETIME NULL,
  `name` VARCHAR(255) NULL,
  `description` TEXT NULL,
  `fix` TEXT NULL,
  PRIMARY KEY (`id`, `application_id`, `user_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_error_application1_idx` (`application_id` ASC),
  INDEX `fk_error_error_importance1_idx` (`error_importance_id` ASC),
  INDEX `fk_error_error_group1_idx` (`error_group_id` ASC),
  INDEX `fk_error_error_type1_idx` (`error_type_id` ASC),
  INDEX `fk_error_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_error_application1`
    FOREIGN KEY (`application_id`)
    REFERENCES `auto_tvop`.`application` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_error_error_importance1`
    FOREIGN KEY (`error_importance_id`)
    REFERENCES `auto_tvop`.`error_importance` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_error_error_group1`
    FOREIGN KEY (`error_group_id`)
    REFERENCES `auto_tvop`.`error_group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_error_error_type1`
    FOREIGN KEY (`error_type_id`)
    REFERENCES `auto_tvop`.`error_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_error_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `auto_tvop`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `auto_tvop`.`error_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auto_tvop`.`error_comment` ;

CREATE TABLE IF NOT EXISTS `auto_tvop`.`error_comment` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `text` TEXT NULL,
  `createdAt` DATETIME NULL,
  `error_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `error_id`, `user_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_error_comment_error1_idx` (`error_id` ASC),
  INDEX `fk_error_comment_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_error_comment_error1`
    FOREIGN KEY (`error_id`)
    REFERENCES `auto_tvop`.`error` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_error_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `auto_tvop`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `auto_tvop`.`user_role`
-- -----------------------------------------------------
START TRANSACTION;
USE `auto_tvop`;
INSERT INTO `auto_tvop`.`user_role` (`id`, `description`) VALUES (1, 'Администратор');
INSERT INTO `auto_tvop`.`user_role` (`id`, `description`) VALUES (2, 'Тестировщик');
INSERT INTO `auto_tvop`.`user_role` (`id`, `description`) VALUES (3, 'Проверяющий');

COMMIT;


-- -----------------------------------------------------
-- Data for table `auto_tvop`.`error_importance`
-- -----------------------------------------------------
START TRANSACTION;
USE `auto_tvop`;
INSERT INTO `auto_tvop`.`error_importance` (`id`, `description`) VALUES (1, 'Фатальная');
INSERT INTO `auto_tvop`.`error_importance` (`id`, `description`) VALUES (2, 'Серьёзная');
INSERT INTO `auto_tvop`.`error_importance` (`id`, `description`) VALUES (3, 'Незначительная');

COMMIT;


-- -----------------------------------------------------
-- Data for table `auto_tvop`.`error_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `auto_tvop`;
INSERT INTO `auto_tvop`.`error_type` (`id`, `description`) VALUES (1, 'Кодирование');
INSERT INTO `auto_tvop`.`error_type` (`id`, `description`) VALUES (2, 'Проектирование');
INSERT INTO `auto_tvop`.`error_type` (`id`, `description`) VALUES (3, 'Предложение');
INSERT INTO `auto_tvop`.`error_type` (`id`, `description`) VALUES (4, 'Расхождение с документацией');
INSERT INTO `auto_tvop`.`error_type` (`id`, `description`) VALUES (5, 'Взаимодействие с аппаратурой');
INSERT INTO `auto_tvop`.`error_type` (`id`, `description`) VALUES (6, 'Вопрос');

COMMIT;

