-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema stomato
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema stomato
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `stomato` DEFAULT CHARACTER SET utf8 ;
USE `stomato` ;

-- -----------------------------------------------------
-- Table `stomato`.`doctors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stomato`.`doctors` (
  `doctorId` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `surname` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`doctorId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `stomato`.`calendar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stomato`.`calendar` (
  `calendarId` INT(11) NOT NULL AUTO_INCREMENT,
  `doctorId` INT(11) NOT NULL,
  PRIMARY KEY (`calendarId`),
  INDEX `Calendar_utilizatori` (`doctorId` ASC),
  CONSTRAINT `Calendar_utilizatori`
    FOREIGN KEY (`doctorId`)
    REFERENCES `stomato`.`doctors` (`doctorId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `stomato`.`pacients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stomato`.`pacients` (
  `pacientId` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `surname` VARCHAR(20) NOT NULL,
  `doctorId` INT(11) NOT NULL,
  PRIMARY KEY (`pacientId`),
  INDEX `fk_pacienti_doctori1_idx` (`doctorId` ASC),
  CONSTRAINT `fk_pacienti_doctori1`
    FOREIGN KEY (`doctorId`)
    REFERENCES `stomato`.`doctors` (`doctorId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `stomato`.`consultations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stomato`.`consultations` (
  `consultationId` INT(11) NOT NULL AUTO_INCREMENT,
  `pacientId` INT(11) NOT NULL,
  `doctorId` INT(11) NOT NULL,
  `diagnostic` VARCHAR(300) NULL DEFAULT NULL,
  `observations` VARCHAR(500) NULL,
  `price` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`consultationId`),
  INDEX `Vizite_clienti` (`pacientId` ASC),
  INDEX `doctori_Vizite` (`doctorId` ASC),
  CONSTRAINT `Vizite_clienti`
    FOREIGN KEY (`pacientId`)
    REFERENCES `stomato`.`pacients` (`pacientId`),
  CONSTRAINT `doctori_Vizite`
    FOREIGN KEY (`doctorId`)
    REFERENCES `stomato`.`doctors` (`doctorId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `stomato`.`events`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stomato`.`events` (
  `eventId` INT(11) NOT NULL AUTO_INCREMENT,
  `calendarId` INT(11) NOT NULL,
  `color` VARCHAR(50) NULL,
  `observation` VARCHAR(300) NULL DEFAULT NULL,
  `startDate` TIMESTAMP NULL DEFAULT NULL,
  `endDate` TIMESTAMP NULL DEFAULT NULL,
  `allDay` TINYINT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`eventId`),
  INDEX `Events_Calendar` (`calendarId` ASC),
  CONSTRAINT `Events_Calendar`
    FOREIGN KEY (`calendarId`)
    REFERENCES `stomato`.`calendar` (`calendarId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `stomato`.`pacientsDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stomato`.`pacientsDetails` (
  `pacientDetailsId` INT(11) NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(300) NOT NULL,
  `pacientId` INT(11) NOT NULL,
  PRIMARY KEY (`pacientDetailsId`),
  INDEX `fk_detalii_pacient_pacienti1_idx` (`pacientId` ASC),
  CONSTRAINT `fk_detalii_pacient_pacienti1`
    FOREIGN KEY (`pacientId`)
    REFERENCES `stomato`.`pacients` (`pacientId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `stomato`.`questionnaire`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stomato`.`questionnaire` (
  `questionnaireId` INT(11) NOT NULL,
  `questionId` INT(11) NOT NULL,
  `question` VARCHAR(301) NOT NULL,
  PRIMARY KEY (`questionnaireId`, `questionId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `stomato`.`questionnaireAnswers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stomato`.`questionnaireAnswers` (
  `questionnaireAnswerId` INT(3) NOT NULL AUTO_INCREMENT,
  `pacientId` INT(11) NOT NULL,
  `questionnaireId` INT(11) NOT NULL,
  `questionId` INT(11) NOT NULL,
  `answer` VARCHAR(500) NULL,
  PRIMARY KEY (`questionnaireAnswerId`),
  INDEX `raspuns_chestionar_chestionare` (`questionnaireId` ASC, `questionId` ASC),
  INDEX `raspuns_chestionar_clienti` (`pacientId` ASC),
  CONSTRAINT `raspuns_chestionar_chestionare`
    FOREIGN KEY (`questionnaireId` , `questionId`)
    REFERENCES `stomato`.`questionnaire` (`questionnaireId` , `questionId`),
  CONSTRAINT `raspuns_chestionar_clienti`
    FOREIGN KEY (`pacientId`)
    REFERENCES `stomato`.`pacients` (`pacientId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
