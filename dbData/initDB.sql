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
-- Table `mydb`.`klasa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`klasa` (
  `klasa_id` INT NOT NULL AUTO_INCREMENT,
  `nazwa` VARCHAR(45) NOT NULL,
  `rokSzkolny` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`klasa_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`nauczyciel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`nauczyciel` (
  `nauczyciel_id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`nauczyciel_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`przedmiot`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`przedmiot` (
  `przedmiot_id` INT NOT NULL AUTO_INCREMENT,
  `nazwa` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`przedmiot_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`uczen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`uczen` (
  `uczen_id` INT NOT NULL AUTO_INCREMENT,
  `klasa_id` INT NOT NULL,
  PRIMARY KEY (`uczen_id`, `klasa_id`),
  CONSTRAINT `fk_uczen_klasa1`
    FOREIGN KEY (`klasa_id`)
    REFERENCES `mydb`.`klasa` (`klasa_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`dziennik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`dziennik` (
  `dziennik_id` INT NOT NULL,
  `klasa_id` INT NOT NULL,
  `przedmiot_id` INT NOT NULL,
  `nauczyciel_id` INT NOT NULL,
  `czyWychowawca` TINYINT NOT NULL,
  PRIMARY KEY (`dziennik_id`, `klasa_id`, `przedmiot_id`, `nauczyciel_id`),
  CONSTRAINT `fk_dziennik_klasa1`
    FOREIGN KEY (`klasa_id`)
    REFERENCES `mydb`.`klasa` (`klasa_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dziennik_przedmiot1`
    FOREIGN KEY (`przedmiot_id`)
    REFERENCES `mydb`.`przedmiot` (`przedmiot_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dziennik_nauczyciel1`
    FOREIGN KEY (`nauczyciel_id`)
    REFERENCES `mydb`.`nauczyciel` (`nauczyciel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ocena`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ocena` (
  `ocena_id` INT NOT NULL AUTO_INCREMENT,
  `ocena` VARCHAR(45) NOT NULL,
  `waga` VARCHAR(45) NOT NULL,
  `komentarz` VARCHAR(45) NULL,
  `uczen_id` INT NOT NULL,
  `date` DATE NOT NULL,
  `kategoria` VARCHAR(45) NOT NULL,
  `dziennik_id` INT NOT NULL,
  PRIMARY KEY (`ocena_id`, `uczen_id`, `dziennik_id`),
  CONSTRAINT `uczen_id`
    FOREIGN KEY (`uczen_id`)
    REFERENCES `mydb`.`uczen` (`uczen_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ocena_dziennik1`
    FOREIGN KEY (`dziennik_id`)
    REFERENCES `mydb`.`dziennik` (`dziennik_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`opiekun`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`opiekun` (
  `opiekun_id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`opiekun_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`frekwencja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`frekwencja` (
  `frekwencja_id` INT NOT NULL AUTO_INCREMENT,
  `data` VARCHAR(45) NOT NULL,
  `typ` VARCHAR(45) NOT NULL,
  `uczen_id` INT NOT NULL,
  `dziennik_id` INT NOT NULL,
  PRIMARY KEY (`frekwencja_id`, `uczen_id`, `dziennik_id`),
  CONSTRAINT `fk_uczen_frekwencja_id`
    FOREIGN KEY (`uczen_id`)
    REFERENCES `mydb`.`uczen` (`uczen_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_frekwencja_dziennik1`
    FOREIGN KEY (`dziennik_id`)
    REFERENCES `mydb`.`dziennik` (`dziennik_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`opiekun_has_uczen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`opiekun_has_uczen` (
  `opiekun_id` INT NOT NULL,
  `uczen_id` INT NOT NULL,
  PRIMARY KEY (`opiekun_id`, `uczen_id`),
  CONSTRAINT `fk_opiekun_has_uczen_opiekun1`
    FOREIGN KEY (`opiekun_id`)
    REFERENCES `mydb`.`opiekun` (`opiekun_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_opiekun_has_uczen_uczen1`
    FOREIGN KEY (`uczen_id`)
    REFERENCES `mydb`.`uczen` (`uczen_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`uzytkownik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`uzytkownik` (
  `uzytkownik_id` INT NOT NULL,
  `imie` VARCHAR(45) NOT NULL,
  `nazwisko` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `nauczyciel_id` INT NOT NULL,
  `opiekun_id` INT NOT NULL,
  `uczen_id` INT NOT NULL,
  PRIMARY KEY (`uzytkownik_id`),
  CONSTRAINT `fk_uzytkownik_nauczyciel1`
    FOREIGN KEY (`nauczyciel_id`)
    REFERENCES `mydb`.`nauczyciel` (`nauczyciel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_uzytkownik_opiekun1`
    FOREIGN KEY (`opiekun_id`)
    REFERENCES `mydb`.`opiekun` (`opiekun_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_uzytkownik_uczen1`
    FOREIGN KEY (`uczen_id`)
    REFERENCES `mydb`.`uczen` (`uczen_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`rola`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rola` (
  `rola_id` INT NOT NULL,
  `nazwa` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`rola_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`uzytkownik_has_rola`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`uzytkownik_has_rola` (
  `uzytkownik_id` INT NOT NULL,
  `rola_id` INT NOT NULL,
  PRIMARY KEY (`uzytkownik_id`, `rola_id`),
  CONSTRAINT `fk_uzytkownik_has_rola_uzytkownik1`
    FOREIGN KEY (`uzytkownik_id`)
    REFERENCES `mydb`.`uzytkownik` (`uzytkownik_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_uzytkownik_has_rola_rola1`
    FOREIGN KEY (`rola_id`)
    REFERENCES `mydb`.`rola` (`rola_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Data for table `mydb`.`klasa`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`klasa` (`klasa_id`, `nazwa`, `rokSzkolny`) VALUES (1, 'Ia', '2020');
INSERT INTO `mydb`.`klasa` (`klasa_id`, `nazwa`, `rokSzkolny`) VALUES (2, 'Ib', '2020');
INSERT INTO `mydb`.`klasa` (`klasa_id`, `nazwa`, `rokSzkolny`) VALUES (3, 'IIa', '2020');
INSERT INTO `mydb`.`klasa` (`klasa_id`, `nazwa`, `rokSzkolny`) VALUES (4, 'IIb', '2020');
INSERT INTO `mydb`.`klasa` (`klasa_id`, `nazwa`, `rokSzkolny`) VALUES (5, 'IIIa', '2019');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`nauczyciel`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`nauczyciel` (`nauczyciel_id`) VALUES (1);
INSERT INTO `mydb`.`nauczyciel` (`nauczyciel_id`) VALUES (2);
INSERT INTO `mydb`.`nauczyciel` (`nauczyciel_id`) VALUES (3);
INSERT INTO `mydb`.`nauczyciel` (`nauczyciel_id`) VALUES (4);
INSERT INTO `mydb`.`nauczyciel` (`nauczyciel_id`) VALUES (5);
INSERT INTO `mydb`.`nauczyciel` (`nauczyciel_id`) VALUES (6);
INSERT INTO `mydb`.`nauczyciel` (`nauczyciel_id`) VALUES (7);
INSERT INTO `mydb`.`nauczyciel` (`nauczyciel_id`) VALUES (8);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`przedmiot`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`przedmiot` (`przedmiot_id`, `nazwa`) VALUES (1, 'Przyroda');
INSERT INTO `mydb`.`przedmiot` (`przedmiot_id`, `nazwa`) VALUES (2, 'Fizyka');
INSERT INTO `mydb`.`przedmiot` (`przedmiot_id`, `nazwa`) VALUES (3, 'Matematyka');
INSERT INTO `mydb`.`przedmiot` (`przedmiot_id`, `nazwa`) VALUES (4, 'Historia');
INSERT INTO `mydb`.`przedmiot` (`przedmiot_id`, `nazwa`) VALUES (5, 'Język Angielski');
INSERT INTO `mydb`.`przedmiot` (`przedmiot_id`, `nazwa`) VALUES (6, 'Język Polski');
INSERT INTO `mydb`.`przedmiot` (`przedmiot_id`, `nazwa`) VALUES (7, 'Wychowanie Fizyczne');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`uczen`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`uczen` (`uczen_id`, `klasa_id`) VALUES (1, 1);
INSERT INTO `mydb`.`uczen` (`uczen_id`, `klasa_id`) VALUES (2, 1);
INSERT INTO `mydb`.`uczen` (`uczen_id`, `klasa_id`) VALUES (3, 2);
INSERT INTO `mydb`.`uczen` (`uczen_id`, `klasa_id`) VALUES (4, 1);
INSERT INTO `mydb`.`uczen` (`uczen_id`, `klasa_id`) VALUES (5, 3);
INSERT INTO `mydb`.`uczen` (`uczen_id`, `klasa_id`) VALUES (6, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`ocena`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`ocena` (`ocena_id`, `ocena`, `waga`, `komentarz`, `uczen_id`, `date`, `kategoria`, `dziennik_id`) VALUES (1, '5', '3', 'brak', 1, '2022-03-19', 'sprawdzian', 1);
INSERT INTO `mydb`.`ocena` (`ocena_id`, `ocena`, `waga`, `komentarz`, `uczen_id`, `date`, `kategoria`, `dziennik_id`) VALUES (2, '4', '3', 'brak', 2, '2022-03-19', 'sprawdzian', 1);
INSERT INTO `mydb`.`ocena` (`ocena_id`, `ocena`, `waga`, `komentarz`, `uczen_id`, `date`, `kategoria`, `dziennik_id`) VALUES (3, '4', '3', 'brak', 3, '2022-03-19', 'sprawdzian', 1);
INSERT INTO `mydb`.`ocena` (`ocena_id`, `ocena`, `waga`, `komentarz`, `uczen_id`, `date`, `kategoria`, `dziennik_id`) VALUES (4, '1', '3', 'plagiat', 4, '2022-04-05', 'praca domowa', 1);
INSERT INTO `mydb`.`ocena` (`ocena_id`, `ocena`, `waga`, `komentarz`, `uczen_id`, `date`, `kategoria`, `dziennik_id`) VALUES (5, '2-', '2', 'brak', 4, '2022-04-23', 'kartkówka', 1);
INSERT INTO `mydb`.`ocena` (`ocena_id`, `ocena`, `waga`, `komentarz`, `uczen_id`, `date`, `kategoria`, `dziennik_id`) VALUES (6, '3+', '5', 'brak', 5, '2022-04-30', 'odpowiedź ustna', 1);
INSERT INTO `mydb`.`ocena` (`ocena_id`, `ocena`, `waga`, `komentarz`, `uczen_id`, `date`, `kategoria`, `dziennik_id`) VALUES (7, '4-', '1', 'brak', 6, '2022-05-4', 'aktywność', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`opiekun`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`opiekun` (`opiekun_id`) VALUES (1);
INSERT INTO `mydb`.`opiekun` (`opiekun_id`) VALUES (2);
INSERT INTO `mydb`.`opiekun` (`opiekun_id`) VALUES (3);
INSERT INTO `mydb`.`opiekun` (`opiekun_id`) VALUES (4);
INSERT INTO `mydb`.`opiekun` (`opiekun_id`) VALUES (5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`frekwencja`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`frekwencja` (`frekwencja_id`, `data`, `typ`, `uczen_id`, `dziennik_id`) VALUES (1, '2022-03-23', 'nieobecność', 1, 1);
INSERT INTO `mydb`.`frekwencja` (`frekwencja_id`, `data`, `typ`, `uczen_id`, `dziennik_id`) VALUES (2, '2022-04-14', 'spóźnienie', 5, 1);
INSERT INTO `mydb`.`frekwencja` (`frekwencja_id`, `data`, `typ`, `uczen_id`, `dziennik_id`) VALUES (3, '2022-03-10', 'nieobecność', 2, 1);
INSERT INTO `mydb`.`frekwencja` (`frekwencja_id`, `data`, `typ`, `uczen_id`, `dziennik_id`) VALUES (4, '2022-03-20', 'zwolnienie', 3, 1);
INSERT INTO `mydb`.`frekwencja` (`frekwencja_id`, `data`, `typ`, `uczen_id`, `dziennik_id`) VALUES (5, '2022-03-23', 'obecność', 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`opiekun_has_uczen`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`opiekun_has_uczen` (`opiekun_id`, `uczen_id`) VALUES (1, 1);
INSERT INTO `mydb`.`opiekun_has_uczen` (`opiekun_id`, `uczen_id`) VALUES (1, 2);
INSERT INTO `mydb`.`opiekun_has_uczen` (`opiekun_id`, `uczen_id`) VALUES (2, 3);
INSERT INTO `mydb`.`opiekun_has_uczen` (`opiekun_id`, `uczen_id`) VALUES (3, 4);
INSERT INTO `mydb`.`opiekun_has_uczen` (`opiekun_id`, `uczen_id`) VALUES (4, 5);
INSERT INTO `mydb`.`opiekun_has_uczen` (`opiekun_id`, `uczen_id`) VALUES (5, 6);

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
