-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuarios` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `lastname` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `role` ENUM('mod', 'user') NULL,
  `password` VARCHAR(45) NULL,
  `verified` TINYINT NULL,
  `state` TINYINT NULL,
  `phone` VARCHAR(45) NULL,
  `email_verified` TINYINT NULL,
  `verification_token` VARCHAR(45) NULL,
  `reset_password_token` VARCHAR(45) NULL,
  `reset_password_expires` VARCHAR(45) NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE INDEX `email_UNIQUE` (`lastname` ASC),
  UNIQUE INDEX `username_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Eventos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Eventos` (
  `id_event` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `start_date_time` VARCHAR(45) NULL,
  `end_date_time` VARCHAR(45) NULL,
  `authorizated` TINYINT NULL,
  `province` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `venue` VARCHAR(45) NULL,
  `private` TINYINT NULL,
  `total_tickets` INT NULL,
  `available_tickets` INT NULL,
  `sold_tickets` INT NULL,
  `state` VARCHAR(45) NULL,
  `id_user` INT NOT NULL,
  PRIMARY KEY (`id_event`),
  UNIQUE INDEX `id_event_UNIQUE` (`id_event` ASC),
  INDEX `fk_Eventos_Usuarios_idx` (`id_user` ASC),
  CONSTRAINT `fk_Eventos_Usuarios`
    FOREIGN KEY (`id_user`)
    REFERENCES `mydb`.`Usuarios` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tickets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tickets` (
  `id_tickets` INT NOT NULL AUTO_INCREMENT,
  `state` TINYINT NULL,
  `code` VARCHAR(45) NULL,
  `id_event` INT NOT NULL,
  `id_user` INT NOT NULL,
  PRIMARY KEY (`id_tickets`, `id_user`),
  UNIQUE INDEX `tickets_id_UNIQUE` (`id_tickets` ASC),
  INDEX `fk_Tickets_Eventos1_idx` (`id_event` ASC),
  INDEX `fk_Tickets_Usuarios1_idx` (`id_user` ASC),
  CONSTRAINT `fk_Tickets_Eventos1`
    FOREIGN KEY (`id_event`)
    REFERENCES `mydb`.`Eventos` (`id_event`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tickets_Usuarios1`
    FOREIGN KEY (`id_user`)
    REFERENCES `mydb`.`Usuarios` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Compras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Compras` (
  `id_purchase` INT NOT NULL,
  `total_tickets` VARCHAR(45) NULL,
  `total` VARCHAR(45) NULL,
  `state` TINYINT NULL,
  `Eventos_id_event` INT NOT NULL,
  `Usuarios_id_user` INT NOT NULL,
  PRIMARY KEY (`id_purchase`),
  INDEX `fk_Compras_Eventos1_idx` (`Eventos_id_event` ASC),
  INDEX `fk_Compras_Usuarios1_idx` (`Usuarios_id_user` ASC),
  CONSTRAINT `fk_Compras_Eventos1`
    FOREIGN KEY (`Eventos_id_event`)
    REFERENCES `mydb`.`Eventos` (`id_event`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Compras_Usuarios1`
    FOREIGN KEY (`Usuarios_id_user`)
    REFERENCES `mydb`.`Usuarios` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Historial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Historial` (
  `id_history` INT NOT NULL,
  `description` VARCHAR(45) NULL,
  `id_event` INT NOT NULL,
  `id_user` INT NOT NULL,
  PRIMARY KEY (`id_history`),
  INDEX `fk_Historial_Eventos1_idx` (`id_event` ASC),
  INDEX `fk_Historial_Usuarios1_idx` (`id_user` ASC),
  CONSTRAINT `fk_Historial_Eventos1`
    FOREIGN KEY (`id_event`)
    REFERENCES `mydb`.`Eventos` (`id_event`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Historial_Usuarios1`
    FOREIGN KEY (`id_user`)
    REFERENCES `mydb`.`Usuarios` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`view1` (`id` INT);

-- -----------------------------------------------------
-- View `mydb`.`view1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`view1`;
USE `mydb`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
