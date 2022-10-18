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
  `imie` VARCHAR(45) NOT NULL,
  `nazwisko` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `numerTelefonu` VARCHAR(45) NOT NULL,
  `czyAdministrator` TINYINT NOT NULL,
  `czyWychowawca` TINYINT NOT NULL,
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
  `imie` VARCHAR(45) NOT NULL,
  `nazwisko` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `klasa_id` INT NOT NULL,
  PRIMARY KEY (`uczen_id`),
  CONSTRAINT `fk_uczen_klasa1`
    FOREIGN KEY (`klasa_id`)
    REFERENCES `mydb`.`klasa` (`klasa_id`)
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
  `nauczyciel_id` INT NOT NULL,
  `kategoria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ocena_id`),
  CONSTRAINT `uczen_id`
    FOREIGN KEY (`uczen_id`)
    REFERENCES `mydb`.`uczen` (`uczen_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ocena_nauczyciel1`
    FOREIGN KEY (`nauczyciel_id`)
    REFERENCES `mydb`.`nauczyciel` (`nauczyciel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`opiekun`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`opiekun` (
  `opiekun_id` INT NOT NULL AUTO_INCREMENT,
  `imie` VARCHAR(45) NOT NULL,
  `nazwisko` VARCHAR(45) NOT NULL,
  `numerTelefonu` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
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
  `przedmiot_id` INT NOT NULL,
  PRIMARY KEY (`frekwencja_id`),
  CONSTRAINT `fk_uczen_frekwencja_id`
    FOREIGN KEY (`uczen_id`)
    REFERENCES `mydb`.`uczen` (`uczen_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_frekwencja_przedmiot_id`
    FOREIGN KEY (`przedmiot_id`)
    REFERENCES `mydb`.`przedmiot` (`przedmiot_id`)
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
-- Table `mydb`.`nauczyciel_has_przedmiot`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`nauczyciel_has_przedmiot` (
  `nauczyciel_nauczyciel_id` INT NOT NULL,
  `przedmiot_przedmiot_id` INT NOT NULL,
  PRIMARY KEY (`nauczyciel_nauczyciel_id`, `przedmiot_przedmiot_id`),
  CONSTRAINT `fk_nauczyciel_has_przedmiot_nauczyciel1`
    FOREIGN KEY (`nauczyciel_nauczyciel_id`)
    REFERENCES `mydb`.`nauczyciel` (`nauczyciel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nauczyciel_has_przedmiot_przedmiot1`
    FOREIGN KEY (`przedmiot_przedmiot_id`)
    REFERENCES `mydb`.`przedmiot` (`przedmiot_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`nauczyciel_has_klasa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`nauczyciel_has_klasa` (
  `nauczyciel_nauczyciel_id` INT NOT NULL,
  `klasa_klasa_id` INT NOT NULL,
  PRIMARY KEY (`nauczyciel_nauczyciel_id`, `klasa_klasa_id`),
  CONSTRAINT `fk_nauczyciel_has_klasa_nauczyciel1`
    FOREIGN KEY (`nauczyciel_nauczyciel_id`)
    REFERENCES `mydb`.`nauczyciel` (`nauczyciel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nauczyciel_has_klasa_klasa1`
    FOREIGN KEY (`klasa_klasa_id`)
    REFERENCES `mydb`.`klasa` (`klasa_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`uzytkownik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`uzytkownik` (
  `uzytkownik_id` INT NOT NULL,
  `nauczyciel_nauczyciel_id` INT NOT NULL,
  `opiekun_opiekun_id` INT NOT NULL,
  `uczen_uczen_id` INT NOT NULL,
  PRIMARY KEY (`uzytkownik_id`),
  CONSTRAINT `fk_uzytkownik_nauczyciel1`
    FOREIGN KEY (`nauczyciel_nauczyciel_id`)
    REFERENCES `mydb`.`nauczyciel` (`nauczyciel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_uzytkownik_opiekun1`
    FOREIGN KEY (`opiekun_opiekun_id`)
    REFERENCES `mydb`.`opiekun` (`opiekun_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_uzytkownik_uczen1`
    FOREIGN KEY (`uczen_uczen_id`)
    REFERENCES `mydb`.`uczen` (`uczen_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`rola`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rola` (
  `rola_id` INT NOT NULL,
  PRIMARY KEY (`rola_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`uzytkownik_has_rola`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`uzytkownik_has_rola` (
  `uzytkownik_uzytkownik_id` INT NOT NULL,
  `rola_rola_id` INT NOT NULL,
  PRIMARY KEY (`uzytkownik_uzytkownik_id`, `rola_rola_id`),
  CONSTRAINT `fk_uzytkownik_has_rola_uzytkownik1`
    FOREIGN KEY (`uzytkownik_uzytkownik_id`)
    REFERENCES `mydb`.`uzytkownik` (`uzytkownik_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_uzytkownik_has_rola_rola1`
    FOREIGN KEY (`rola_rola_id`)
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
INSERT INTO `mydb`.`nauczyciel` (`nauczyciel_id`, `imie`, `nazwisko`, `email`, `numerTelefonu`, `czyAdministrator`, `czyWychowawca`) VALUES (1, 'Ewa', 'Kowal', 'ewa_ewunia@buziaczek.pl', '567234123', 0, 0);
INSERT INTO `mydb`.`nauczyciel` (`nauczyciel_id`, `imie`, `nazwisko`, `email`, `numerTelefonu`, `czyAdministrator`, `czyWychowawca`) VALUES (2, 'Anna', 'Kobyłka', 'kobyla123@wp.pl', '745923121', 0, 1);
INSERT INTO `mydb`.`nauczyciel` (`nauczyciel_id`, `imie`, `nazwisko`, `email`, `numerTelefonu`, `czyAdministrator`, `czyWychowawca`) VALUES (3, 'Maciej', 'Polot', 'polotmaciej@gmail.com', '657123457', 1, 0);
INSERT INTO `mydb`.`nauczyciel` (`nauczyciel_id`, `imie`, `nazwisko`, `email`, `numerTelefonu`, `czyAdministrator`, `czyWychowawca`) VALUES (4, 'Błażej', 'Kot', 'koteczek200@gmail.com', '123242341', 1, 1);
INSERT INTO `mydb`.`nauczyciel` (`nauczyciel_id`, `imie`, `nazwisko`, `email`, `numerTelefonu`, `czyAdministrator`, `czyWychowawca`) VALUES (5, 'Marzena', 'Nieczaus', 'czausowa12@wp.pl', '445241459', 0, 1);
INSERT INTO `mydb`.`nauczyciel` (`nauczyciel_id`, `imie`, `nazwisko`, `email`, `numerTelefonu`, `czyAdministrator`, `czyWychowawca`) VALUES (6, 'Janina', 'Pawluk', 'pawlukjanina@gmail.com', '763494255', 0, 0);
INSERT INTO `mydb`.`nauczyciel` (`nauczyciel_id`, `imie`, `nazwisko`, `email`, `numerTelefonu`, `czyAdministrator`, `czyWychowawca`) VALUES (7, 'Anna', 'Kisielinska', 'kisielanna@wp.pl', '387532355', 0, 1);
INSERT INTO `mydb`.`nauczyciel` (`nauczyciel_id`, `imie`, `nazwisko`, `email`, `numerTelefonu`, `czyAdministrator`, `czyWychowawca`) VALUES (8, 'Kacper', 'Filipiak', 'filipiakkacper@wp.pl', '875498086', 0, 1);

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
INSERT INTO `mydb`.`uczen` (`uczen_id`, `imie`, `nazwisko`, `email`, `klasa_id`) VALUES (1, 'Jan', 'Kowal', 'jankowal@gmail.com', 1);
INSERT INTO `mydb`.`uczen` (`uczen_id`, `imie`, `nazwisko`, `email`, `klasa_id`) VALUES (2, 'Pawel', 'Nowak', 'pawelek@gmail.com', 1);
INSERT INTO `mydb`.`uczen` (`uczen_id`, `imie`, `nazwisko`, `email`, `klasa_id`) VALUES (3, 'Anna', 'Pawlak', 'anusialalausia@wp.pl', 2);
INSERT INTO `mydb`.`uczen` (`uczen_id`, `imie`, `nazwisko`, `email`, `klasa_id`) VALUES (4, 'Kordian', 'Kalmano', 'kordian123@gmail.com', 1);
INSERT INTO `mydb`.`uczen` (`uczen_id`, `imie`, `nazwisko`, `email`, `klasa_id`) VALUES (5, 'Janina', 'Kos', 'janikos@interia.pl', 3);
INSERT INTO `mydb`.`uczen` (`uczen_id`, `imie`, `nazwisko`, `email`, `klasa_id`) VALUES (6, 'Kacper', 'Foka', 'fokadoka@gmail.com', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`ocena`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`ocena` (`ocena_id`, `ocena`, `waga`, `komentarz`, `uczen_id`, `date`, `nauczyciel_id`, `kategoria`) VALUES (1, '5', '3', 'brak', 1, '2022-03-19', 1, 'sprawdzian');
INSERT INTO `mydb`.`ocena` (`ocena_id`, `ocena`, `waga`, `komentarz`, `uczen_id`, `date`, `nauczyciel_id`, `kategoria`) VALUES (2, '4', '3', 'brak', 2, '2022-03-19', 1, 'sprawdzian');
INSERT INTO `mydb`.`ocena` (`ocena_id`, `ocena`, `waga`, `komentarz`, `uczen_id`, `date`, `nauczyciel_id`, `kategoria`) VALUES (3, '4', '3', 'brak', 3, '2022-03-19', 1, 'sprawdzian');
INSERT INTO `mydb`.`ocena` (`ocena_id`, `ocena`, `waga`, `komentarz`, `uczen_id`, `date`, `nauczyciel_id`, `kategoria`) VALUES (4, '1', '3', 'plagiat', 4, '2022-04-05', 2, 'praca domowa');
INSERT INTO `mydb`.`ocena` (`ocena_id`, `ocena`, `waga`, `komentarz`, `uczen_id`, `date`, `nauczyciel_id`, `kategoria`) VALUES (5, '2-', '2', 'brak', 4, '2022-04-23', 2, 'kartkówka');
INSERT INTO `mydb`.`ocena` (`ocena_id`, `ocena`, `waga`, `komentarz`, `uczen_id`, `date`, `nauczyciel_id`, `kategoria`) VALUES (6, '3+', '5', 'brak', 5, '2022-04-30', 3, 'odpowiedź ustna');
INSERT INTO `mydb`.`ocena` (`ocena_id`, `ocena`, `waga`, `komentarz`, `uczen_id`, `date`, `nauczyciel_id`, `kategoria`) VALUES (7, '4-', '1', 'brak', 6, '2022-05-4', 4, 'aktywność');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`opiekun`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`opiekun` (`opiekun_id`, `imie`, `nazwisko`, `numerTelefonu`, `email`) VALUES (1, 'Aleksandra', 'Kot', '123456789', 'kocica@wp.pl');
INSERT INTO `mydb`.`opiekun` (`opiekun_id`, `imie`, `nazwisko`, `numerTelefonu`, `email`) VALUES (2, 'Grazyna', 'Kisielinska', '456789123', 'grazkagrazka@buziaczek.pl');
INSERT INTO `mydb`.`opiekun` (`opiekun_id`, `imie`, `nazwisko`, `numerTelefonu`, `email`) VALUES (3, 'Pawel', 'Nowak', '505342123', 'pawelnowak@wp.pl');
INSERT INTO `mydb`.`opiekun` (`opiekun_id`, `imie`, `nazwisko`, `numerTelefonu`, `email`) VALUES (4, 'Maciej', 'Burak', '123789456', 'zdroweburaki@gmail.com');
INSERT INTO `mydb`.`opiekun` (`opiekun_id`, `imie`, `nazwisko`, `numerTelefonu`, `email`) VALUES (5, 'Katarzyna', 'Kaczor', '888456222', 'kaczordonald@interia.pl');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`frekwencja`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`frekwencja` (`frekwencja_id`, `data`, `typ`, `uczen_id`, `przedmiot_id`) VALUES (1, '2022-03-23', 'nieobecność', 1, 1);
INSERT INTO `mydb`.`frekwencja` (`frekwencja_id`, `data`, `typ`, `uczen_id`, `przedmiot_id`) VALUES (2, '2022-04-14', 'spóźnienie', 5, 1);
INSERT INTO `mydb`.`frekwencja` (`frekwencja_id`, `data`, `typ`, `uczen_id`, `przedmiot_id`) VALUES (3, '2022-03-10', 'nieobecność', 2, 1);
INSERT INTO `mydb`.`frekwencja` (`frekwencja_id`, `data`, `typ`, `uczen_id`, `przedmiot_id`) VALUES (4, '2022-03-20', 'zwolnienie', 3, 2);
INSERT INTO `mydb`.`frekwencja` (`frekwencja_id`, `data`, `typ`, `uczen_id`, `przedmiot_id`) VALUES (5, '2022-03-23', 'obecność', 1, 2);

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


-- -----------------------------------------------------
-- Data for table `mydb`.`nauczyciel_has_przedmiot`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`nauczyciel_has_przedmiot` (`nauczyciel_nauczyciel_id`, `przedmiot_przedmiot_id`) VALUES (1, 1);
INSERT INTO `mydb`.`nauczyciel_has_przedmiot` (`nauczyciel_nauczyciel_id`, `przedmiot_przedmiot_id`) VALUES (2, 1);
INSERT INTO `mydb`.`nauczyciel_has_przedmiot` (`nauczyciel_nauczyciel_id`, `przedmiot_przedmiot_id`) VALUES (3, 3);
INSERT INTO `mydb`.`nauczyciel_has_przedmiot` (`nauczyciel_nauczyciel_id`, `przedmiot_przedmiot_id`) VALUES (4, 2);
INSERT INTO `mydb`.`nauczyciel_has_przedmiot` (`nauczyciel_nauczyciel_id`, `przedmiot_przedmiot_id`) VALUES (5, 5);
INSERT INTO `mydb`.`nauczyciel_has_przedmiot` (`nauczyciel_nauczyciel_id`, `przedmiot_przedmiot_id`) VALUES (6, 4);
INSERT INTO `mydb`.`nauczyciel_has_przedmiot` (`nauczyciel_nauczyciel_id`, `przedmiot_przedmiot_id`) VALUES (7, 6);
INSERT INTO `mydb`.`nauczyciel_has_przedmiot` (`nauczyciel_nauczyciel_id`, `przedmiot_przedmiot_id`) VALUES (8, 1);
INSERT INTO `mydb`.`nauczyciel_has_przedmiot` (`nauczyciel_nauczyciel_id`, `przedmiot_przedmiot_id`) VALUES (8, 7);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`nauczyciel_has_klasa`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`nauczyciel_has_klasa` (`nauczyciel_nauczyciel_id`, `klasa_klasa_id`) VALUES (2, 1);
INSERT INTO `mydb`.`nauczyciel_has_klasa` (`nauczyciel_nauczyciel_id`, `klasa_klasa_id`) VALUES (4, 2);
INSERT INTO `mydb`.`nauczyciel_has_klasa` (`nauczyciel_nauczyciel_id`, `klasa_klasa_id`) VALUES (5, 3);
INSERT INTO `mydb`.`nauczyciel_has_klasa` (`nauczyciel_nauczyciel_id`, `klasa_klasa_id`) VALUES (7, 4);
INSERT INTO `mydb`.`nauczyciel_has_klasa` (`nauczyciel_nauczyciel_id`, `klasa_klasa_id`) VALUES (8, 5);

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
