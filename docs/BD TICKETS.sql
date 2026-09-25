-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

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
  PRIMARY KEY (`id_user`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `email_UNIQUE` ON `mydb`.`Usuarios` (`lastname` ASC) VISIBLE;

CREATE UNIQUE INDEX `username_UNIQUE` ON `mydb`.`Usuarios` (`name` ASC) VISIBLE;


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
  CONSTRAINT `fk_Eventos_Usuarios`
    FOREIGN KEY (`id_user`)
    REFERENCES `mydb`.`Usuarios` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_event_UNIQUE` ON `mydb`.`Eventos` (`id_event` ASC) VISIBLE;

CREATE INDEX `fk_Eventos_Usuarios_idx` ON `mydb`.`Eventos` (`id_user` ASC) VISIBLE;


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

CREATE UNIQUE INDEX `tickets_id_UNIQUE` ON `mydb`.`Tickets` (`id_tickets` ASC) VISIBLE;

CREATE INDEX `fk_Tickets_Eventos1_idx` ON `mydb`.`Tickets` (`id_event` ASC) VISIBLE;

CREATE INDEX `fk_Tickets_Usuarios1_idx` ON `mydb`.`Tickets` (`id_user` ASC) VISIBLE;


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

CREATE INDEX `fk_Compras_Eventos1_idx` ON `mydb`.`Compras` (`Eventos_id_event` ASC) VISIBLE;

CREATE INDEX `fk_Compras_Usuarios1_idx` ON `mydb`.`Compras` (`Usuarios_id_user` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Historial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Historial` (
  `id_history` INT NOT NULL,
  `description` VARCHAR(45) NULL,
  `id_event` INT NOT NULL,
  `id_user` INT NOT NULL,
  PRIMARY KEY (`id_history`),
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

CREATE INDEX `fk_Historial_Eventos1_idx` ON `mydb`.`Historial` (`id_event` ASC) VISIBLE;

CREATE INDEX `fk_Historial_Usuarios1_idx` ON `mydb`.`Historial` (`id_user` ASC) VISIBLE;

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
