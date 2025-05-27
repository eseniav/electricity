-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema OPK12A
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema OPK12A
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `OPK12A` DEFAULT CHARACTER SET utf8 ;
USE `OPK12A` ;

-- -----------------------------------------------------
-- Table `OPK12A`.`Sklady`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OPK12A`.`Sklady` ;

CREATE TABLE IF NOT EXISTS `OPK12A`.`Sklady` (
  `idSklady` INT NOT NULL AUTO_INCREMENT,
  `Raspolojenie` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idSklady`),
  UNIQUE INDEX `Raspolojenie_UNIQUE` (`Raspolojenie` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OPK12A`.`TipySmejnogoOborudovaniya`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OPK12A`.`TipySmejnogoOborudovaniya` ;

CREATE TABLE IF NOT EXISTS `OPK12A`.`TipySmejnogoOborudovaniya` (
  `idTipySmejnogoOborudovaniya` INT NOT NULL AUTO_INCREMENT,
  `NazvanieTipy` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipySmejnogoOborudovaniya`),
  UNIQUE INDEX `NazvanieTipy_UNIQUE` (`NazvanieTipy` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OPK12A`.`Proekty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OPK12A`.`Proekty` ;

CREATE TABLE IF NOT EXISTS `OPK12A`.`Proekty` (
  `idProekty` INT NOT NULL AUTO_INCREMENT,
  `NomerPr` VARCHAR(45) NOT NULL,
  `NazvaniePr` VARCHAR(45) NULL,
  PRIMARY KEY (`idProekty`),
  UNIQUE INDEX `NomerPr_UNIQUE` (`NomerPr` ASC) VISIBLE,
  UNIQUE INDEX `NazvaniePr_UNIQUE` (`NazvaniePr` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OPK12A`.`SmejnieOborudovaniya`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OPK12A`.`SmejnieOborudovaniya` ;

CREATE TABLE IF NOT EXISTS `OPK12A`.`SmejnieOborudovaniya` (
  `idSmejnieOborudovaniya` INT NOT NULL AUTO_INCREMENT,
  `SeriinyNomerSmejObor` VARCHAR(45) NOT NULL,
  `TemperaturaVozduhaSmejObor` INT NULL,
  `TemperaturaVodySmejObor` INT NULL,
  `TokiSmejObor` INT NULL,
  `NapryajenieSmejObor` INT NULL,
  `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya` INT NOT NULL,
  `Proekty_idProekty` INT NOT NULL,
  PRIMARY KEY (`idSmejnieOborudovaniya`),
  UNIQUE INDEX `SeriinyNomerSmejObor_UNIQUE` (`SeriinyNomerSmejObor` ASC) VISIBLE,
  INDEX `fk_SmejnieOborudovaniya_TipySmejnogoOborudovaniya1_idx` (`TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya` ASC) VISIBLE,
  INDEX `fk_SmejnieOborudovaniya_Proekty1_idx` (`Proekty_idProekty` ASC) VISIBLE,
  CONSTRAINT `fk_SmejnieOborudovaniya_TipySmejnogoOborudovaniya1`
    FOREIGN KEY (`TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`)
    REFERENCES `OPK12A`.`TipySmejnogoOborudovaniya` (`idTipySmejnogoOborudovaniya`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SmejnieOborudovaniya_Proekty1`
    FOREIGN KEY (`Proekty_idProekty`)
    REFERENCES `OPK12A`.`Proekty` (`idProekty`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OPK12A`.`Yacheiki`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OPK12A`.`Yacheiki` ;

CREATE TABLE IF NOT EXISTS `OPK12A`.`Yacheiki` (
  `idYacheiki` INT NOT NULL AUTO_INCREMENT,
  `SeriinyNomerYacheikji` VARCHAR(45) NOT NULL,
  `Stoimost` VARCHAR(45) NULL,
  `Sklady_idSklady` INT NOT NULL,
  `SmejnieOborudovaniya_idSmejnieOborudovaniya` INT NOT NULL,
  PRIMARY KEY (`idYacheiki`),
  UNIQUE INDEX `SeriinyNomerYacheikji_UNIQUE` (`SeriinyNomerYacheikji` ASC) VISIBLE,
  INDEX `fk_Yacheiki_Sklady_idx` (`Sklady_idSklady` ASC) VISIBLE,
  INDEX `fk_Yacheiki_SmejnieOborudovaniya1_idx` (`SmejnieOborudovaniya_idSmejnieOborudovaniya` ASC) VISIBLE,
  CONSTRAINT `fk_Yacheiki_Sklady`
    FOREIGN KEY (`Sklady_idSklady`)
    REFERENCES `OPK12A`.`Sklady` (`idSklady`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Yacheiki_SmejnieOborudovaniya1`
    FOREIGN KEY (`SmejnieOborudovaniya_idSmejnieOborudovaniya`)
    REFERENCES `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OPK12A`.`Zayavki`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OPK12A`.`Zayavki` ;

CREATE TABLE IF NOT EXISTS `OPK12A`.`Zayavki` (
  `idZayavki` INT NOT NULL AUTO_INCREMENT,
  `NomerZayavki` VARCHAR(45) NULL,
  `DataZayavki` DATE NULL,
  PRIMARY KEY (`idZayavki`),
  UNIQUE INDEX `NomerZayavki_UNIQUE` (`NomerZayavki` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OPK12A`.`SostaviZayavok`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OPK12A`.`SostaviZayavok` ;

CREATE TABLE IF NOT EXISTS `OPK12A`.`SostaviZayavok` (
  `idSostaviZayavok` INT NOT NULL AUTO_INCREMENT,
  `Yacheiki_idYacheiki` INT NOT NULL,
  `Zayavki_idZayavki` INT NOT NULL,
  PRIMARY KEY (`idSostaviZayavok`),
  INDEX `fk_SostaviZayavok_Yacheiki1_idx` (`Yacheiki_idYacheiki` ASC) VISIBLE,
  INDEX `fk_SostaviZayavok_Zayavki1_idx` (`Zayavki_idZayavki` ASC) VISIBLE,
  CONSTRAINT `fk_SostaviZayavok_Yacheiki1`
    FOREIGN KEY (`Yacheiki_idYacheiki`)
    REFERENCES `OPK12A`.`Yacheiki` (`idYacheiki`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SostaviZayavok_Zayavki1`
    FOREIGN KEY (`Zayavki_idZayavki`)
    REFERENCES `OPK12A`.`Zayavki` (`idZayavki`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `OPK12A`.`Sklady`
-- -----------------------------------------------------
START TRANSACTION;
USE `OPK12A`;
INSERT INTO `OPK12A`.`Sklady` (`idSklady`, `Raspolojenie`) VALUES (1, 'Ленинградская область');
INSERT INTO `OPK12A`.`Sklady` (`idSklady`, `Raspolojenie`) VALUES (2, 'Санкт-Петербург');

COMMIT;


-- -----------------------------------------------------
-- Data for table `OPK12A`.`TipySmejnogoOborudovaniya`
-- -----------------------------------------------------
START TRANSACTION;
USE `OPK12A`;
INSERT INTO `OPK12A`.`TipySmejnogoOborudovaniya` (`idTipySmejnogoOborudovaniya`, `NazvanieTipy`) VALUES (1, 'Генератор');
INSERT INTO `OPK12A`.`TipySmejnogoOborudovaniya` (`idTipySmejnogoOborudovaniya`, `NazvanieTipy`) VALUES (2, 'Трансформатор');

COMMIT;


-- -----------------------------------------------------
-- Data for table `OPK12A`.`Proekty`
-- -----------------------------------------------------
START TRANSACTION;
USE `OPK12A`;
INSERT INTO `OPK12A`.`Proekty` (`idProekty`, `NomerPr`, `NazvaniePr`) VALUES (1, '52300', 'Арктика');
INSERT INTO `OPK12A`.`Proekty` (`idProekty`, `NomerPr`, `NazvaniePr`) VALUES (2, '53201', 'Ермак');
INSERT INTO `OPK12A`.`Proekty` (`idProekty`, `NomerPr`, `NazvaniePr`) VALUES (3, '5543', 'Ясень');
INSERT INTO `OPK12A`.`Proekty` (`idProekty`, `NomerPr`, `NazvaniePr`) VALUES (4, '5698-б', 'Бальзам');
INSERT INTO `OPK12A`.`Proekty` (`idProekty`, `NomerPr`, `NazvaniePr`) VALUES (5, '2045', 'Клубень');
INSERT INTO `OPK12A`.`Proekty` (`idProekty`, `NomerPr`, `NazvaniePr`) VALUES (6, '21445', 'Крюйс');

COMMIT;


-- -----------------------------------------------------
-- Data for table `OPK12A`.`SmejnieOborudovaniya`
-- -----------------------------------------------------
START TRANSACTION;
USE `OPK12A`;
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (1, '258692', 30, 20, 2000, 5000, 1, 1);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (2, '275641', 100, 80, 3000, 7000, 1, 1);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (3, '552314', 50, 30, 2028, 2000, 1, 1);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (4, '369952', 67, 55, 1055, 10500, 1, 1);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (5, '247892', 89, 75, 1011, 10000, 1, 1);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (6, '235514', 27, 47, 1628, 9000, 1, 3);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (7, '154475', 29, 40, 2456, 8000, 1, 2);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (8, '678955', 31, 28, 2011, 5200, 1, 4);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (9, '121245', 71, 26, 1450, 4800, 1, 4);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (10, '174859', 40, 21, 560, 1000, 1, 5);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (11, '124567', 37, 45, 800, 9000, 1, 5);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (12, '452691', 42, 58, 720, 10200, 1, 6);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (13, '551233', 56, 37, 1500, 10100, 1, 6);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (14, '541567', 77, 61, 1800, 500, 1, 5);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (15, '896523', 78, 70, 2100, 560, 1, 4);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (16, '245631', 100, 60, 2800, 9500, 1, 5);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (17, '771234', 90, 77, 1000, 9800, 1, 4);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (18, '712896', 85, 75, 900, 6000, 1, 6);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (19, '735861', 80, 73, 800, 5500, 1, 6);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (20, '571123', 37, 30, 750, 5400, 1, 4);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (21, '432289', 45, 35, 1750, 3200, 1, 5);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (22, '446788', 40, 47, 1800, 3100, 1, 4);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (23, '215347', 55, 55, 2900, 1200, 1, 4);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (24, '48605', 25, 20, 3000, 5000, 2, 3);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (25, '25963', 120, 90, 1500, 10000, 2, 3);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (26, '24415', 80, 85, 1800, 10500, 2, 3);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (27, '20147', 40, 90, 800, 4000, 2, 3);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (28, '55603', 30, 55, 1000, 1500, 2, 2);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (29, '98710', 27, 20, 2000, 2000, 2, 1);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (30, '65423', 89, 30, 500, 3000, 2, 4);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (31, '89630', 35, 48, 150, 9000, 2, 4);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (32, '89560', 40, 55, 2800, 9800, 2, 5);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (33, '11542', 50, 40, 900, 500, 2, 5);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (34, '23567', 115, 25, 2400, 8000, 2, 6);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (35, '85674', 110, 85, 2200, 7500, 2, 6);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (36, '65479', 56, 37, 1100, 7200, 2, 6);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (37, '51243', 50, 65, 1800, 7100, 2, 5);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (38, '94215', 45, 90, 1400, 6200, 2, 4);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (39, '63215', 30, 85, 2800, 10000, 2, 4);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (40, '66714', 35, 45, 2500, 1500, 2, 4);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (41, '51246', 40, 40, 2500, 2000, 2, 5);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (42, '87623', 48, 30, 2600, 3500, 2, 5);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (43, '96213', 55, 20, 2000, 4500, 2, 6);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (44, '88721', 60, 28, 1200, 6000, 2, 6);
INSERT INTO `OPK12A`.`SmejnieOborudovaniya` (`idSmejnieOborudovaniya`, `SeriinyNomerSmejObor`, `TemperaturaVozduhaSmejObor`, `TemperaturaVodySmejObor`, `TokiSmejObor`, `NapryajenieSmejObor`, `TipySmejnogoOborudovaniya_idTipySmejnogoOborudovaniya`, `Proekty_idProekty`) VALUES (45, '94567', 67, 88, 1000, 6800, 2, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OPK12A`.`Yacheiki`
-- -----------------------------------------------------
START TRANSACTION;
USE `OPK12A`;
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (1, '1256478-1', '500000', 2, 1);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (2, '2356789-2', '500000', 2, 2);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (3, '3467890-3', '500000', 2, 3);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (4, '4567891-4', '500000', 2, 4);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (5, '5678901-5', '500000', 2, 5);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (6, '6789012-6', '500000', 1, 6);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (7, '7890123-7', '500000', 1, 7);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (8, '8901234-8', '500000', 1, 8);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (9, '9012347-9', '500000', 1, 9);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (10, '1234567-0', '500000', 2, 10);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (11, '2345678-1', '1500000', 2, 24);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (12, '3456789-2', '1500000', 2, 25);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (13, '4567890-3', '1500000', 2, 26);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (14, '5678901-1', '1500000', 2, 27);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (15, '6789012-5', '1500000', 2, 28);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (16, '7890123-6', '1500000', 1, 29);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (17, '8901234-7', '1500000', 1, 30);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (18, '9012345-8', '1500000', 1, 31);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (19, '1234557-9', '1500000', 1, 32);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (20, '2345678-0', '1500000', 1, 33);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (21, '3456789-1', '750000', 2, 11);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (22, '4567890-2', '800000', 2, 12);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (23, '5678901-3', '1000000', 2, 13);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (24, '6789012-4', '1200000', 2, 14);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (25, '7890123-5', '700000', 2, 15);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (26, '8901234-6', '650000', 1, 34);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (27, '9012345-7', '550000', 1, 35);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (28, '1234567-8', '600000', 1, 36);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (29, '2345678-9', '750000', 1, 37);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (30, '3456789-0', '950000', 1, 38);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (31, '4567890-1', '900000', 2, 39);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (32, '5678901-2', '910000', 2, 40);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (33, '6789012-3', '900000', 2, 41);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (34, '7890123-4', '550000', 2, 42);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (35, '8901234-5', '1300000', 2, 43);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (36, '9012345-6', '1450000', 1, 44);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (37, '1234567-9', '900000', 1, 45);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (38, '2345678-3', '750000', 1, 16);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (39, '3456789-3', '650000', 1, 17);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (40, '4567890-5', '1400000', 1, 18);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (41, '5678901-4', '1200000', 1, 19);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (42, '6789012-1', '1000000', 1, 20);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (43, '7890123-8', '980000', 1, 21);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (44, '8901234-9', '970000', 1, 22);
INSERT INTO `OPK12A`.`Yacheiki` (`idYacheiki`, `SeriinyNomerYacheikji`, `Stoimost`, `Sklady_idSklady`, `SmejnieOborudovaniya_idSmejnieOborudovaniya`) VALUES (45, '9012345-9', '670000', 1, 23);

COMMIT;


-- -----------------------------------------------------
-- Data for table `OPK12A`.`Zayavki`
-- -----------------------------------------------------
START TRANSACTION;
USE `OPK12A`;
INSERT INTO `OPK12A`.`Zayavki` (`idZayavki`, `NomerZayavki`, `DataZayavki`) VALUES (1, '00004561', '2024-07-23');
INSERT INTO `OPK12A`.`Zayavki` (`idZayavki`, `NomerZayavki`, `DataZayavki`) VALUES (2, '00004562', '2024-07-31');
INSERT INTO `OPK12A`.`Zayavki` (`idZayavki`, `NomerZayavki`, `DataZayavki`) VALUES (3, '00004563', '2024-08-04');
INSERT INTO `OPK12A`.`Zayavki` (`idZayavki`, `NomerZayavki`, `DataZayavki`) VALUES (4, '00004564', '2024-08-18');
INSERT INTO `OPK12A`.`Zayavki` (`idZayavki`, `NomerZayavki`, `DataZayavki`) VALUES (5, '00004565', '2024-08-26');
INSERT INTO `OPK12A`.`Zayavki` (`idZayavki`, `NomerZayavki`, `DataZayavki`) VALUES (6, '00004566', '2024-09-30');
INSERT INTO `OPK12A`.`Zayavki` (`idZayavki`, `NomerZayavki`, `DataZayavki`) VALUES (7, '00004567', '2024-10-10');
INSERT INTO `OPK12A`.`Zayavki` (`idZayavki`, `NomerZayavki`, `DataZayavki`) VALUES (8, '00004568', '2024-10-15');

COMMIT;


-- -----------------------------------------------------
-- Data for table `OPK12A`.`SostaviZayavok`
-- -----------------------------------------------------
START TRANSACTION;
USE `OPK12A`;
INSERT INTO `OPK12A`.`SostaviZayavok` (`idSostaviZayavok`, `Yacheiki_idYacheiki`, `Zayavki_idZayavki`) VALUES (1, 1, 1);
INSERT INTO `OPK12A`.`SostaviZayavok` (`idSostaviZayavok`, `Yacheiki_idYacheiki`, `Zayavki_idZayavki`) VALUES (2, 2, 1);
INSERT INTO `OPK12A`.`SostaviZayavok` (`idSostaviZayavok`, `Yacheiki_idYacheiki`, `Zayavki_idZayavki`) VALUES (3, 3, 1);
INSERT INTO `OPK12A`.`SostaviZayavok` (`idSostaviZayavok`, `Yacheiki_idYacheiki`, `Zayavki_idZayavki`) VALUES (4, 4, 2);
INSERT INTO `OPK12A`.`SostaviZayavok` (`idSostaviZayavok`, `Yacheiki_idYacheiki`, `Zayavki_idZayavki`) VALUES (5, 5, 2);
INSERT INTO `OPK12A`.`SostaviZayavok` (`idSostaviZayavok`, `Yacheiki_idYacheiki`, `Zayavki_idZayavki`) VALUES (6, 10, 3);
INSERT INTO `OPK12A`.`SostaviZayavok` (`idSostaviZayavok`, `Yacheiki_idYacheiki`, `Zayavki_idZayavki`) VALUES (7, 11, 3);
INSERT INTO `OPK12A`.`SostaviZayavok` (`idSostaviZayavok`, `Yacheiki_idYacheiki`, `Zayavki_idZayavki`) VALUES (8, 12, 3);
INSERT INTO `OPK12A`.`SostaviZayavok` (`idSostaviZayavok`, `Yacheiki_idYacheiki`, `Zayavki_idZayavki`) VALUES (9, 13, 4);
INSERT INTO `OPK12A`.`SostaviZayavok` (`idSostaviZayavok`, `Yacheiki_idYacheiki`, `Zayavki_idZayavki`) VALUES (10, 14, 4);
INSERT INTO `OPK12A`.`SostaviZayavok` (`idSostaviZayavok`, `Yacheiki_idYacheiki`, `Zayavki_idZayavki`) VALUES (11, 15, 4);
INSERT INTO `OPK12A`.`SostaviZayavok` (`idSostaviZayavok`, `Yacheiki_idYacheiki`, `Zayavki_idZayavki`) VALUES (12, 21, 4);
INSERT INTO `OPK12A`.`SostaviZayavok` (`idSostaviZayavok`, `Yacheiki_idYacheiki`, `Zayavki_idZayavki`) VALUES (13, 22, 5);
INSERT INTO `OPK12A`.`SostaviZayavok` (`idSostaviZayavok`, `Yacheiki_idYacheiki`, `Zayavki_idZayavki`) VALUES (14, 23, 5);
INSERT INTO `OPK12A`.`SostaviZayavok` (`idSostaviZayavok`, `Yacheiki_idYacheiki`, `Zayavki_idZayavki`) VALUES (15, 24, 5);
INSERT INTO `OPK12A`.`SostaviZayavok` (`idSostaviZayavok`, `Yacheiki_idYacheiki`, `Zayavki_idZayavki`) VALUES (16, 25, 6);
INSERT INTO `OPK12A`.`SostaviZayavok` (`idSostaviZayavok`, `Yacheiki_idYacheiki`, `Zayavki_idZayavki`) VALUES (17, 31, 7);
INSERT INTO `OPK12A`.`SostaviZayavok` (`idSostaviZayavok`, `Yacheiki_idYacheiki`, `Zayavki_idZayavki`) VALUES (18, 32, 7);
INSERT INTO `OPK12A`.`SostaviZayavok` (`idSostaviZayavok`, `Yacheiki_idYacheiki`, `Zayavki_idZayavki`) VALUES (19, 33, 7);
INSERT INTO `OPK12A`.`SostaviZayavok` (`idSostaviZayavok`, `Yacheiki_idYacheiki`, `Zayavki_idZayavki`) VALUES (20, 34, 8);
INSERT INTO `OPK12A`.`SostaviZayavok` (`idSostaviZayavok`, `Yacheiki_idYacheiki`, `Zayavki_idZayavki`) VALUES (21, 35, 8);

COMMIT;

