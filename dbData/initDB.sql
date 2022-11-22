-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema registerAppDb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema registerAppDb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `registerAppDb` DEFAULT CHARACTER SET utf8mb3 ;
USE `registerAppDb` ;

-- -----------------------------------------------------
-- Table `registerAppDb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `registerAppDb`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `second_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `registerAppDb`.`teacher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `registerAppDb`.`teacher` (
  `teacher_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`teacher_id`, `user_id`),
  INDEX `fk_teacher_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_teacher_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `registerAppDb`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `registerAppDb`.`class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `registerAppDb`.`class` (
  `class_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `school_year` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`class_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `registerAppDb`.`subject`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `registerAppDb`.`subject` (
  `subject_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`subject_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `registerAppDb`.`register`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `registerAppDb`.`register` (
  `register_id` INT NOT NULL,
  `teacher_id` INT NOT NULL,
  `subject_id` INT NOT NULL,
  `class_id` INT NOT NULL,
  `is_supervising_teacher` TINYINT NOT NULL,
  PRIMARY KEY (`register_id`),
  INDEX `fk_dziennik_nauczyciel1` (`teacher_id` ASC) VISIBLE,
  INDEX `fk_register_class1_idx` (`class_id` ASC) VISIBLE,
  INDEX `fk_register_subject1_idx` (`subject_id` ASC) VISIBLE,
  CONSTRAINT `fk_dziennik_nauczyciel1`
    FOREIGN KEY (`teacher_id`)
    REFERENCES `registerAppDb`.`teacher` (`teacher_id`),
  CONSTRAINT `fk_register_class1`
    FOREIGN KEY (`class_id`)
    REFERENCES `registerAppDb`.`class` (`class_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_register_subject1`
    FOREIGN KEY (`subject_id`)
    REFERENCES `registerAppDb`.`subject` (`subject_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `registerAppDb`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `registerAppDb`.`student` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `class_id` INT NOT NULL,
  PRIMARY KEY (`student_id`, `user_id`),
  INDEX `fk_student_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_student_class1_idx` (`class_id` ASC) VISIBLE,
  CONSTRAINT `fk_student_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `registerAppDb`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_class1`
    FOREIGN KEY (`class_id`)
    REFERENCES `registerAppDb`.`class` (`class_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `registerAppDb`.`attendance_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `registerAppDb`.`attendance_type` (
  `attendance_type_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`attendance_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `registerAppDb`.`attendance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `registerAppDb`.`attendance` (
  `attendance_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `student_id` INT NOT NULL,
  `register_id` INT NOT NULL,
  `attendance_type_id` INT NOT NULL,
  PRIMARY KEY (`attendance_id`, `student_id`, `register_id`, `attendance_type_id`),
  INDEX `fk_uczen_frekwencja_id` (`student_id` ASC) VISIBLE,
  INDEX `fk_frekwencja_dziennik1` (`register_id` ASC) VISIBLE,
  INDEX `fk_attendance_attendance_type1_idx` (`attendance_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_frekwencja_dziennik1`
    FOREIGN KEY (`register_id`)
    REFERENCES `registerAppDb`.`register` (`register_id`),
  CONSTRAINT `fk_uczen_frekwencja_id`
    FOREIGN KEY (`student_id`)
    REFERENCES `registerAppDb`.`student` (`student_id`),
  CONSTRAINT `fk_attendance_attendance_type1`
    FOREIGN KEY (`attendance_type_id`)
    REFERENCES `registerAppDb`.`attendance_type` (`attendance_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `registerAppDb`.`grade_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `registerAppDb`.`grade_type` (
  `grade_type_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`grade_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `registerAppDb`.`grade_value`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `registerAppDb`.`grade_value` (
  `grade_value_id` INT NOT NULL,
  `value` DECIMAL(4,2) NOT NULL,
  `text` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`grade_value_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `registerAppDb`.`grade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `registerAppDb`.`grade` (
  `grade_id` INT NOT NULL AUTO_INCREMENT,
  `weight` DECIMAL NOT NULL,
  `comment` VARCHAR(45) NULL DEFAULT NULL,
  `date` DATETIME NOT NULL,
  `student_id` INT NOT NULL,
  `register_id` INT NOT NULL,
  `grade_type_id` INT NOT NULL,
  `grade_value_id` INT NOT NULL,
  PRIMARY KEY (`grade_id`, `student_id`, `register_id`, `grade_type_id`, `grade_value_id`),
  INDEX `uczen_id` (`student_id` ASC) VISIBLE,
  INDEX `fk_ocena_dziennik1` (`register_id` ASC) VISIBLE,
  INDEX `fk_grade_grade_type1_idx` (`grade_type_id` ASC) VISIBLE,
  INDEX `fk_grade_grade_value1_idx` (`grade_value_id` ASC) VISIBLE,
  CONSTRAINT `fk_ocena_dziennik1`
    FOREIGN KEY (`register_id`)
    REFERENCES `registerAppDb`.`register` (`register_id`),
  CONSTRAINT `uczen_id`
    FOREIGN KEY (`student_id`)
    REFERENCES `registerAppDb`.`student` (`student_id`),
  CONSTRAINT `fk_grade_grade_type1`
    FOREIGN KEY (`grade_type_id`)
    REFERENCES `registerAppDb`.`grade_type` (`grade_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grade_grade_value1`
    FOREIGN KEY (`grade_value_id`)
    REFERENCES `registerAppDb`.`grade_value` (`grade_value_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `registerAppDb`.`guardian`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `registerAppDb`.`guardian` (
  `guardian_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`guardian_id`, `user_id`),
  INDEX `fk_guardian_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_guardian_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `registerAppDb`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `registerAppDb`.`guardian_has_student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `registerAppDb`.`guardian_has_student` (
  `guardian_id` INT NOT NULL,
  `student_id` INT NOT NULL,
  PRIMARY KEY (`guardian_id`, `student_id`),
  INDEX `fk_opiekun_has_uczen_uczen1` (`student_id` ASC) VISIBLE,
  CONSTRAINT `fk_opiekun_has_uczen_opiekun1`
    FOREIGN KEY (`guardian_id`)
    REFERENCES `registerAppDb`.`guardian` (`guardian_id`),
  CONSTRAINT `fk_opiekun_has_uczen_uczen1`
    FOREIGN KEY (`student_id`)
    REFERENCES `registerAppDb`.`student` (`student_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `registerAppDb`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `registerAppDb`.`role` (
  `role_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE INDEX `role_id_UNIQUE` (`role_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `registerAppDb`.`user_has_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `registerAppDb`.`user_has_role` (
  `user_id` INT NOT NULL,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `role_id`),
  INDEX `fk_uzytkownik_has_rola_rola1` (`role_id` ASC) VISIBLE,
  CONSTRAINT `fk_uzytkownik_has_rola_rola1`
    FOREIGN KEY (`role_id`)
    REFERENCES `registerAppDb`.`role` (`role_id`),
  CONSTRAINT `fk_uzytkownik_has_rola_uzytkownik1`
    FOREIGN KEY (`user_id`)
    REFERENCES `registerAppDb`.`user` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `registerAppDb`.`message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `registerAppDb`.`message` (
  `message_id` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(255) NOT NULL,
  `time` TIME NOT NULL,
  `date` DATETIME NOT NULL,
  `receiver_id` INT NOT NULL,
  `sender_id` INT NOT NULL,
  PRIMARY KEY (`message_id`, `sender_id`),
  INDEX `fk_message_user1_idx` (`sender_id` ASC) VISIBLE,
  CONSTRAINT `fk_message_user1`
    FOREIGN KEY (`sender_id`)
    REFERENCES `registerAppDb`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `registerAppDb`.`schedule_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `registerAppDb`.`schedule_type` (
  `schedule_type_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`schedule_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `registerAppDb`.`schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `registerAppDb`.`schedule` (
  `schedule_id` INT NOT NULL,
  `date` DATETIME NOT NULL,
  `comment` VARCHAR(255) NULL,
  `register_id` INT NOT NULL,
  `schedule_type_id` INT NOT NULL,
  PRIMARY KEY (`schedule_id`, `schedule_type_id`, `register_id`),
  INDEX `fk_schedule_register1_idx` (`register_id` ASC) VISIBLE,
  INDEX `fk_schedule_schedule_type1_idx` (`schedule_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_schedule_register1`
    FOREIGN KEY (`register_id`)
    REFERENCES `registerAppDb`.`register` (`register_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_schedule_schedule_type1`
    FOREIGN KEY (`schedule_type_id`)
    REFERENCES `registerAppDb`.`schedule_type` (`schedule_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Data for table `registerAppDb`.`user`
-- -----------------------------------------------------
START TRANSACTION;
USE `registerAppDb`;
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (1, 'Alicja', 'Grabarz', 'alicja@grabarz.pl', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (2, 'Damian', 'Pawelec', 'mchevis1@unblog.fr', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (3, 'Ada', 'Wojcik', 'rmcalees2@ca.gov', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (4, 'Karolina', 'Tatara', 'eattarge3@psu.edu', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (5, 'Adam', 'Ogorzalek', 'rfishly4@g.co', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (6, 'Ewa', 'Danilczuk', 'estorks5@ca.gov', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (7, 'Alicja', 'Warszawski', 'smccerery6@de.vu', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (8, 'Ada', 'Pacek', 'nambler7@youtu.be', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (9, 'Konrad', 'Panagal', 'lpolland8@cisco.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (10, 'Karolina', 'Bogusz', 'nilsley9@geocities.jp', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (11, 'Ewa', 'Mydlak', 'dgibsona@shinystat.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (12, 'Dominika', 'Markiewicz', 'jlilleymanb@washington.edu', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (13, 'Eunika', 'Danilczuk', 'vbondesenc@clickbank.net', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (14, 'Ewa', 'Pawelec', 'florrained@irs.gov', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (15, 'Magdalena', 'Oleszko', 'wstilgoee@ustream.tv', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (16, 'Ewa', 'Tatara', 'hmacmychemf@github.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (17, 'Malgorzata', 'Strzelecki', 'ncollmang@yahoo.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (18, 'Maciej', 'Kisielewski', 'mvodenh@miibeian.gov.cn', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (19, 'Tomasz', 'Grzejszczyk', 'gmcilwaini@mac.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (20, 'Tomasz', 'Olszewski', 'mvalasekj@webmd.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (21, 'Sebastian', 'Marek', 'pgelsthorpek@mapquest.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (22, 'Damian', 'Konradowicz', 'elondonl@myspace.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (23, 'Adam', 'Koc', 'twarrickm@berkeley.edu', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (24, 'Kacper', 'Warszawski', 'jcusickn@chicagotribune.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (25, 'Damian', 'Olszewski', 'usayero@ucsd.edu', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (26, 'Adam', 'Szumny', 'ibirneyp@time.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (27, 'Maciej', 'Nowicki', 'mtilmouthq@mapquest.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (28, 'Konrad', 'Kot', 'byoxallr@craigslist.org', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (29, 'Alicja', 'Kaczorowska', 'kellss@uol.com.br', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (30, 'Maciej', 'Kowal', 'respaderot@google.de', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (31, 'Pawel', 'Pawelec', 'rconyeru@constantcontact.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (32, 'Tomasz', 'Kowal', 'dbrackpoolv@unicef.org', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (33, 'Karolina', 'Marek', 'nfabbriw@google.es', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (34, 'Eunika', 'Duma', 'rbartakx@google.it', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (35, 'Magdalena', 'Duma', 'aconochiey@omniture.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (36, 'Filip', 'Wojcik', 'gmathiotz@over-blog.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (37, 'Ewa', 'Niczyporuk', 'econnikie10@discuz.net', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (38, 'Malgorzata', 'Urban', 'rkleen11@google.it', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (39, 'Janina', 'Borowski', 'cclemmens12@go.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (40, 'Mateusz', 'Siedlecki', 'cmcelree13@adobe.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (41, 'Malgorzata', 'Danilczuk', 'dstambridge14@unblog.fr', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (42, 'Konrad', 'Szumny', 'hmcgeady15@51.la', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (43, 'Konrad', 'Rachon', 'triddle16@vimeo.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (44, 'Magdalena', 'Michalak', 'bruck17@soundcloud.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (45, 'Konrad', 'Bojanowski', 'zjesson18@facebook.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (46, 'Ada', 'Polak', 'ada@polak.pl', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (47, 'Tatiana', 'Szumny', 'rwhightman1a@hibu.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (48, 'Pawel', 'Walacz', 'cjerosch1b@nydailynews.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (49, 'Konrad', 'Pacek', 'gaizikovitz1c@woothemes.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (50, 'Kordian', 'Urban', 'pdisdel1d@princeton.edu', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (51, 'Adam', 'Wojcicki', 'lsplevin1e@hexun.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (52, 'Adam', 'Filipiuk', 'agodthaab1f@qq.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (53, 'Eunika', 'Grzejszczyk', 'ephilliphs1g@moonfruit.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (54, 'Maciej', 'Wojcik', 'jkubat1h@multiply.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (55, 'Dominika', 'Sawa', 'cwoffenden1i@constantcontact.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (56, 'Alicja', 'Breja', 'dsowood1j@springer.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (57, 'Karolina', 'Piszcz', 'bmacleod1k@mayoclinic.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (58, 'Damian', 'Tatara', 'tkepling1l@pcworld.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (59, 'Ewa', 'Pawelec', 'kbasso1m@etsy.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (60, 'Konrad', 'Zgon', 'snewis1n@vk.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (61, 'Sebastian', 'Szczepanik', 'japark1o@webnode.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (62, 'Konrad', 'Grodzicki', 'seim1p@com.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (63, 'Mateusz', 'Marek', 'wpleming1q@theglobeandmail.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (64, 'Dominika', 'Szumny', 'vbunstone1r@va.gov', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (65, 'Janina', 'Kusy', 'kvanhove1s@craigslist.org', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (66, 'Ada', 'Matraszek', 'mcuree1t@npr.org', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (67, 'Grazyna', 'Oleszko', 'knewart1u@time.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (68, 'Sebastian', 'Oleszko', 'zcoath1v@answers.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (69, 'Malgorzata', 'Dejnek', 'tmcreidy1w@umn.edu', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (70, 'Damian', 'Torba', 'mshatford1x@stumbleupon.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (71, 'Elzbieta', 'Kaczmarek', 'phanmer1y@youtube.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (72, 'Dominika', 'Bogusz', 'atungate1z@nbcnews.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (73, 'Pawel', 'Kaczanowski', 'grolph20@umich.edu', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (74, 'Alicja', 'Fornal', 'mdyke21@xinhuanet.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (75, 'Damian', 'Sawa', 'bvalente22@virginia.edu', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (76, 'Adam', 'Machon', 'jwatkinson23@princeton.edu', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (77, 'Maciej', 'Kalman', 'tleavey24@nytimes.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (78, 'Malgorzata', 'Traczuk', 'acuppitt25@google.co.jp', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (79, 'Adam', 'Walaszek', 'jschachter26@symantec.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (80, 'Magdalena', 'Rachon', 'sgarritley27@craigslist.org', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (81, 'Eunika', 'Machon', 'gwoolward28@de.vu', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (82, 'Tomasz', 'Pawlik', 'opeascod29@ebay.co.uk', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (83, 'Tatiana', 'Niemiec', 'skrysztowczyk2a@ovh.net', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (84, 'Filip', 'Niemiec', 'lhaw2b@cdbaby.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (85, 'Grazyna', 'Kalman', 'grazyna@kalman.pl', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (86, 'Eunika', 'Dejnek', 'szute2d@fastcompany.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (87, 'Alicja', 'Kuc', 'ckeyser2e@wikimedia.org', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (88, 'Dominika', 'Kowal', 'eetchingham2f@nbcnews.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (89, 'Ewa', 'Rachon', 'hsambell2g@skyrock.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (90, 'Filip', 'Fornal', 'hlewty2h@indiatimes.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (91, 'Ada', 'Kaczmarek', 'tmctrustam2i@mapy.cz', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (92, 'Ewa', 'Piechowiak', 'fdudgeon2j@pinterest.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (93, 'Tomasz', 'Piechowiak', 'vmatusevich2k@mediafire.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (94, 'Grazyna', 'Kowalski', 'lwollers2l@yelp.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (95, 'Grazyna', 'Bareja', 'mrickcord2m@psu.edu', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (96, 'Janina', 'Karabowicz', 'anickols2n@xing.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (97, 'Damian', 'Boruc', 'cmarcombe2o@weebly.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (98, 'Filip', 'Borowski', 'gleele2p@noaa.gov', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (99, 'Kacper', 'Breja', 'mpressman2q@admin.ch', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (100, 'Dominika', 'Michalak', 'kschrir2r@eventbrite.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (101, 'Grazyna', 'Koc', 'bsnaddin2s@myspace.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (102, 'Jan', 'Turban', 'hsprasen2t@latimes.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (103, 'Grazyna', 'Dziewul', 'jdeacon2u@unicef.org', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (104, 'Ada', 'Walacz', 'lumbert2v@exblog.jp', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (105, 'Eunika', 'Urban', 'anutbean2w@abc.net.au', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (106, 'Ewa', 'Piechowiak', 'farnal2x@google.com.br', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (107, 'Janina', 'Markiewicz', 'amole2y@github.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (108, 'Magdalena', 'Kowalski', 'sbuckenhill2z@salon.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (109, 'Grazyna', 'Nalepa', 'aneem30@comsenz.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (110, 'Kacper', 'Mazurkiewicz', 'jgossage31@usa.gov', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (111, 'Dominika', 'Ogorzalek', 'olorkins32@delicious.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (112, 'Ada', 'Oleszko', 'ierie33@bloglines.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (113, 'Damian', 'Walaszek', 'ewoodvine34@github.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (114, 'Adam', 'Grodzicki', 'jgoodbanne35@ezinearticles.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (115, 'Grazyna', 'Kleszko', 'gzieme36@jugem.jp', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (116, 'Pawel', 'Kleszko', 'vdadley37@altervista.org', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (117, 'Maciej', 'Nowak', 'ngrisedale38@ask.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (118, 'Konrad', 'Kowal', 'twhitwood39@themeforest.net', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (119, 'Magdalena', 'Breja', 'isutcliff3a@timesonline.co.uk', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (120, 'Damian', 'Polak', 'smountain3b@bandcamp.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (121, 'Adam', 'Breja', 'kmcelwee3c@blogspot.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (122, 'Dominika', 'Kaczmarek', 'reayres3d@noaa.gov', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (123, 'Pawel', 'Urban', 'dchillingsworth3e@ovh.net', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (124, 'Alicja', 'Knap', 'hklehyn3f@sina.com.cn', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (125, 'Filip', 'Karabowicz', 'etatershall3g@uiuc.edu', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (126, 'Filip', 'Pietryka', 'amaynell3h@4shared.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (127, 'Ada', 'Nowicki', 'pmiltonwhite3i@issuu.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (128, 'Dominika', 'Pawlik', 'ffilgate3j@t-online.de', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (129, 'Mateusz', 'Michalak', 'bfelce3k@desdev.cn', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (130, 'Sebastian', 'Moroz', 'kbennett3l@joomla.org', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (131, 'Ada', 'Danilczuk', 'ksommerlie3m@1688.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (132, 'Dominika', 'Michalak', 'mkeslake3n@princeton.edu', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (133, 'Adam', 'Markiewicz', 'lcoppenhall3o@lycos.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (134, 'Karolina', 'Sawa', 'lpratten3p@japanpost.jp', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (135, 'Tatiana', 'Olszewski', 'brebichon3q@fotki.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (136, 'Filip', 'Borowski', 'pcadore3r@seattletimes.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (137, 'Ewelina', 'Koziol', 'sscantlebury3s@vkontakte.ru', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (138, 'Dominika', 'Konradowicz', 'nplenty3t@patch.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (139, 'Tomasz', 'Borawski', 'hroy3u@nsw.gov.au', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (140, 'Jan', 'Koziol', 'oleehane3v@sourceforge.net', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (141, 'Filip', 'Bohosiewicz', 'hhewson3w@ning.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (142, 'Kacper', 'Polak', 'aroobottom3x@1688.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (143, 'Janina', 'Kisielewski', 'jjellybrand3y@opensource.org', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (144, 'Mateusz', 'Rachon', 'mhandrik3z@shareasale.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (145, 'Ada', 'Szczepanik', 'cbisp40@berkeley.edu', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (146, 'Filip', 'Panagal', 'icausby41@multiply.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (147, 'Pawel', 'Koc', 'atocque42@prlog.org', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (148, 'Grazyna', 'Wojtal', 'cottiwill43@tripadvisor.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (149, 'Elzbieta', 'Wojcik', 'cmuriel44@topsy.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (150, 'Kordian', 'Pawluk', 'rwilloway45@gnu.org', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (151, 'Kordian', 'Ogorzalek', 'sdufour46@netlog.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (152, 'Konrad', 'Mydlak', 'mcoombes47@foxnews.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (153, 'Kordian', 'Pawelec', 'sbiddlecombe48@auda.org.au', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (154, 'Tomasz', 'Wojtal', 'sfuller49@princeton.edu', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (155, 'Janina', 'Kleszko', 'bmockett4a@ebay.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (156, 'Pawel', 'Matraszek', 'bhillen4b@google.ru', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (157, 'Ewelina', 'Fornal', 'csandercock4c@goo.ne.jp', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (158, 'Adam', 'Danilczuk', 'fvanyard4d@multiply.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (159, 'Elzbieta', 'Dziewul', 'oshippard4e@house.gov', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (160, 'Ewelina', 'Grzejszczyk', 'mgreated4f@wisc.edu', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (161, 'Ada', 'Mazurkiewicz', 'mblessed4g@ocn.ne.jp', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (162, 'Filip', 'Machon', 'ahardypiggin4h@hhs.gov', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (163, 'Tomasz', 'Dejnek', 'dlunnon4i@ucla.edu', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (164, 'Adam', 'Pawelec', 'cwillgoose4j@csmonitor.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (165, 'Jan', 'Bogusz', 'ahamon4k@yahoo.co.jp', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (166, 'Grazyna', 'Milosz', 'tmockford4l@zimbio.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (167, 'Mateusz', 'Turban', 'scroom4m@cdbaby.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (168, 'Kacper', 'Panagal', 'llethcoe4n@surveymonkey.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (169, 'Filip', 'Piszcz', 'efavill4o@epa.gov', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (170, 'Jan', 'Wojcicki', 'gburds4p@meetup.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (171, 'Malgorzata', 'Bareja', 'cstrute4q@ucoz.ru', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (172, 'Tatiana', 'Polak', 'fbeams4r@vimeo.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (173, 'Kordian', 'Grodzki', 'hgayton4s@4shared.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (174, 'Tomasz', 'Filipiuk', 'wmantripp4t@goodreads.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (175, 'Sebastian', 'Kleszko', 'tgartsyde4u@i2i.jp', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (176, 'Kordian', 'Bareja', 'clenard4v@merriam-webster.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (177, 'Ewa', 'Pacek', 'jcasali4w@1und1.de', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (178, 'Adam', 'Bareja', 'alepere4x@youtu.be', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (179, 'Jan', 'Dejnek', 'msurgood4y@moonfruit.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (180, 'Elzbieta', 'Marek', 'kreape4z@google.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (181, 'Malgorzata', 'Pacek', 'sparfitt50@w3.org', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (182, 'Eunika', 'Kot', 'ipirozzi51@naver.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (183, 'Ewelina', 'Kisielewski', 'smillea52@mail.ru', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (184, 'Janina', 'Szczepanik', 'kleipnik53@china.com.cn', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (185, 'Jan', 'Urban', 'gdepka54@adobe.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (186, 'Maciej', 'Sawa', 'rrome55@fda.gov', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (187, 'Karolina', 'Torba', 'gcoppins56@scientificamerican.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (188, 'Karolina', 'Ogorzalek', 'bdwyr57@cpanel.net', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (189, 'Ada', 'Pacek', 'lsainthill58@craigslist.org', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (190, 'Kordian', 'Skolimowski', 'ccastells59@craigslist.org', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (191, 'Janina', 'Borawski', 'ctroppmann5a@w3.org', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (192, 'Jan', 'Kuc', 'jofihily5b@ow.ly', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (193, 'Jan', 'Koc', 'bwigley5c@netvibes.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (194, 'Eunika', 'Kisielewski', 'aruppele5d@mozilla.org', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (195, 'Konrad', 'Milosz', 'rprine5e@seattletimes.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (196, 'Eunika', 'Polak', 'crudledge5f@icio.us', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (197, 'Adam', 'Kaczmarek', 'esones5g@eepurl.com', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (198, 'Mateusz', 'Warszawski', 'mateusz@warszawski.pl', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (199, 'Malgorzata', 'Grodzki', 'meblein5i@dailymail.co.uk', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');
INSERT INTO `registerAppDb`.`user` (`user_id`, `name`, `second_name`, `email`, `password`) VALUES (200, 'Damian', 'Konradowicz', 'eschneidau5j@ucla.edu', '$2a$10$H7Ativ1gvH3/2AKueril1e/wKkWIhnWJGYXD/fwmLEw9c.Op.C5Ku');

COMMIT;


-- -----------------------------------------------------
-- Data for table `registerAppDb`.`teacher`
-- -----------------------------------------------------
START TRANSACTION;
USE `registerAppDb`;
INSERT INTO `registerAppDb`.`teacher` (`teacher_id`, `user_id`) VALUES (1, 71);
INSERT INTO `registerAppDb`.`teacher` (`teacher_id`, `user_id`) VALUES (2, 72);
INSERT INTO `registerAppDb`.`teacher` (`teacher_id`, `user_id`) VALUES (3, 73);
INSERT INTO `registerAppDb`.`teacher` (`teacher_id`, `user_id`) VALUES (4, 74);
INSERT INTO `registerAppDb`.`teacher` (`teacher_id`, `user_id`) VALUES (5, 75);
INSERT INTO `registerAppDb`.`teacher` (`teacher_id`, `user_id`) VALUES (6, 76);
INSERT INTO `registerAppDb`.`teacher` (`teacher_id`, `user_id`) VALUES (7, 77);
INSERT INTO `registerAppDb`.`teacher` (`teacher_id`, `user_id`) VALUES (8, 78);
INSERT INTO `registerAppDb`.`teacher` (`teacher_id`, `user_id`) VALUES (9, 79);
INSERT INTO `registerAppDb`.`teacher` (`teacher_id`, `user_id`) VALUES (10, 80);
INSERT INTO `registerAppDb`.`teacher` (`teacher_id`, `user_id`) VALUES (11, 81);
INSERT INTO `registerAppDb`.`teacher` (`teacher_id`, `user_id`) VALUES (12, 82);
INSERT INTO `registerAppDb`.`teacher` (`teacher_id`, `user_id`) VALUES (13, 83);
INSERT INTO `registerAppDb`.`teacher` (`teacher_id`, `user_id`) VALUES (14, 84);
INSERT INTO `registerAppDb`.`teacher` (`teacher_id`, `user_id`) VALUES (15, 85);
INSERT INTO `registerAppDb`.`teacher` (`teacher_id`, `user_id`) VALUES (16, 86);
INSERT INTO `registerAppDb`.`teacher` (`teacher_id`, `user_id`) VALUES (17, 87);
INSERT INTO `registerAppDb`.`teacher` (`teacher_id`, `user_id`) VALUES (18, 88);
INSERT INTO `registerAppDb`.`teacher` (`teacher_id`, `user_id`) VALUES (19, 89);
INSERT INTO `registerAppDb`.`teacher` (`teacher_id`, `user_id`) VALUES (20, 90);
INSERT INTO `registerAppDb`.`teacher` (`teacher_id`, `user_id`) VALUES (21, 91);
INSERT INTO `registerAppDb`.`teacher` (`teacher_id`, `user_id`) VALUES (22, 92);
INSERT INTO `registerAppDb`.`teacher` (`teacher_id`, `user_id`) VALUES (23, 93);
INSERT INTO `registerAppDb`.`teacher` (`teacher_id`, `user_id`) VALUES (24, 94);
INSERT INTO `registerAppDb`.`teacher` (`teacher_id`, `user_id`) VALUES (25, 95);

COMMIT;


-- -----------------------------------------------------
-- Data for table `registerAppDb`.`class`
-- -----------------------------------------------------
START TRANSACTION;
USE `registerAppDb`;
INSERT INTO `registerAppDb`.`class` (`class_id`, `name`, `school_year`) VALUES (1, 'IV A', '2022/2023');
INSERT INTO `registerAppDb`.`class` (`class_id`, `name`, `school_year`) VALUES (2, 'IV B', '2022/2023');
INSERT INTO `registerAppDb`.`class` (`class_id`, `name`, `school_year`) VALUES (3, 'IV C', '2022/2023');
INSERT INTO `registerAppDb`.`class` (`class_id`, `name`, `school_year`) VALUES (4, 'V A', '2022/2023');
INSERT INTO `registerAppDb`.`class` (`class_id`, `name`, `school_year`) VALUES (5, 'V B', '2022/2023');
INSERT INTO `registerAppDb`.`class` (`class_id`, `name`, `school_year`) VALUES (6, 'V C', '2022/2023');
INSERT INTO `registerAppDb`.`class` (`class_id`, `name`, `school_year`) VALUES (7, 'VI A', '2022/2023');
INSERT INTO `registerAppDb`.`class` (`class_id`, `name`, `school_year`) VALUES (8, 'VI B', '2022/2023');
INSERT INTO `registerAppDb`.`class` (`class_id`, `name`, `school_year`) VALUES (9, 'VI C', '2022/2023');
INSERT INTO `registerAppDb`.`class` (`class_id`, `name`, `school_year`) VALUES (10, 'VII A', '2022/2023');

COMMIT;


-- -----------------------------------------------------
-- Data for table `registerAppDb`.`subject`
-- -----------------------------------------------------
START TRANSACTION;
USE `registerAppDb`;
INSERT INTO `registerAppDb`.`subject` (`subject_id`, `name`) VALUES (1, 'Przyroda');
INSERT INTO `registerAppDb`.`subject` (`subject_id`, `name`) VALUES (2, 'Matematyka');
INSERT INTO `registerAppDb`.`subject` (`subject_id`, `name`) VALUES (3, 'Wychowanie Fizyczne');
INSERT INTO `registerAppDb`.`subject` (`subject_id`, `name`) VALUES (4, 'Jezyk Angielski');
INSERT INTO `registerAppDb`.`subject` (`subject_id`, `name`) VALUES (5, 'Jezyk Polski');
INSERT INTO `registerAppDb`.`subject` (`subject_id`, `name`) VALUES (6, 'Jezyk Niemiecki');
INSERT INTO `registerAppDb`.`subject` (`subject_id`, `name`) VALUES (7, 'Fizyka');
INSERT INTO `registerAppDb`.`subject` (`subject_id`, `name`) VALUES (8, 'Chemia');
INSERT INTO `registerAppDb`.`subject` (`subject_id`, `name`) VALUES (9, 'Informatyka');
INSERT INTO `registerAppDb`.`subject` (`subject_id`, `name`) VALUES (10, 'EDB');
INSERT INTO `registerAppDb`.`subject` (`subject_id`, `name`) VALUES (11, 'Religia');
INSERT INTO `registerAppDb`.`subject` (`subject_id`, `name`) VALUES (12, 'Plastyka');
INSERT INTO `registerAppDb`.`subject` (`subject_id`, `name`) VALUES (13, 'Muzyka');
INSERT INTO `registerAppDb`.`subject` (`subject_id`, `name`) VALUES (14, 'Biologia');
INSERT INTO `registerAppDb`.`subject` (`subject_id`, `name`) VALUES (15, 'Historia');
INSERT INTO `registerAppDb`.`subject` (`subject_id`, `name`) VALUES (16, 'WOS');

COMMIT;


-- -----------------------------------------------------
-- Data for table `registerAppDb`.`register`
-- -----------------------------------------------------
START TRANSACTION;
USE `registerAppDb`;
INSERT INTO `registerAppDb`.`register` (`register_id`, `teacher_id`, `subject_id`, `class_id`, `is_supervising_teacher`) VALUES (1, 15, 1, 1, 0);
INSERT INTO `registerAppDb`.`register` (`register_id`, `teacher_id`, `subject_id`, `class_id`, `is_supervising_teacher`) VALUES (2, 15, 2, 1, 0);
INSERT INTO `registerAppDb`.`register` (`register_id`, `teacher_id`, `subject_id`, `class_id`, `is_supervising_teacher`) VALUES (3, 2, 1, 2, 1);
INSERT INTO `registerAppDb`.`register` (`register_id`, `teacher_id`, `subject_id`, `class_id`, `is_supervising_teacher`) VALUES (4, 2, 3, 2, 1);
INSERT INTO `registerAppDb`.`register` (`register_id`, `teacher_id`, `subject_id`, `class_id`, `is_supervising_teacher`) VALUES (5, 2, 3, 1, 0);
INSERT INTO `registerAppDb`.`register` (`register_id`, `teacher_id`, `subject_id`, `class_id`, `is_supervising_teacher`) VALUES (6, 3, 4, 1, 0);
INSERT INTO `registerAppDb`.`register` (`register_id`, `teacher_id`, `subject_id`, `class_id`, `is_supervising_teacher`) VALUES (7, 3, 4, 1, 0);
INSERT INTO `registerAppDb`.`register` (`register_id`, `teacher_id`, `subject_id`, `class_id`, `is_supervising_teacher`) VALUES (8, 4, 5, 1, 1);
INSERT INTO `registerAppDb`.`register` (`register_id`, `teacher_id`, `subject_id`, `class_id`, `is_supervising_teacher`) VALUES (9, 5, 6, 1, 0);
INSERT INTO `registerAppDb`.`register` (`register_id`, `teacher_id`, `subject_id`, `class_id`, `is_supervising_teacher`) VALUES (10, 5, 7, 1, 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `registerAppDb`.`student`
-- -----------------------------------------------------
START TRANSACTION;
USE `registerAppDb`;
INSERT INTO `registerAppDb`.`student` (`student_id`, `user_id`, `class_id`) VALUES (1, 1, 1);
INSERT INTO `registerAppDb`.`student` (`student_id`, `user_id`, `class_id`) VALUES (2, 2, 1);
INSERT INTO `registerAppDb`.`student` (`student_id`, `user_id`, `class_id`) VALUES (3, 3, 1);
INSERT INTO `registerAppDb`.`student` (`student_id`, `user_id`, `class_id`) VALUES (4, 4, 1);
INSERT INTO `registerAppDb`.`student` (`student_id`, `user_id`, `class_id`) VALUES (5, 5, 1);
INSERT INTO `registerAppDb`.`student` (`student_id`, `user_id`, `class_id`) VALUES (6, 7, 1);
INSERT INTO `registerAppDb`.`student` (`student_id`, `user_id`, `class_id`) VALUES (7, 7, 1);
INSERT INTO `registerAppDb`.`student` (`student_id`, `user_id`, `class_id`) VALUES (8, 8, 1);
INSERT INTO `registerAppDb`.`student` (`student_id`, `user_id`, `class_id`) VALUES (9, 9, 1);
INSERT INTO `registerAppDb`.`student` (`student_id`, `user_id`, `class_id`) VALUES (10, 10, 1);
INSERT INTO `registerAppDb`.`student` (`student_id`, `user_id`, `class_id`) VALUES (11, 11, 2);
INSERT INTO `registerAppDb`.`student` (`student_id`, `user_id`, `class_id`) VALUES (12, 12, 2);
INSERT INTO `registerAppDb`.`student` (`student_id`, `user_id`, `class_id`) VALUES (13, 13, 2);
INSERT INTO `registerAppDb`.`student` (`student_id`, `user_id`, `class_id`) VALUES (14, 14, 2);
INSERT INTO `registerAppDb`.`student` (`student_id`, `user_id`, `class_id`) VALUES (15, 15, 2);
INSERT INTO `registerAppDb`.`student` (`student_id`, `user_id`, `class_id`) VALUES (16, 16, 2);
INSERT INTO `registerAppDb`.`student` (`student_id`, `user_id`, `class_id`) VALUES (17, 17, 2);
INSERT INTO `registerAppDb`.`student` (`student_id`, `user_id`, `class_id`) VALUES (18, 18, 2);
INSERT INTO `registerAppDb`.`student` (`student_id`, `user_id`, `class_id`) VALUES (19, 19, 2);
INSERT INTO `registerAppDb`.`student` (`student_id`, `user_id`, `class_id`) VALUES (20, 20, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `registerAppDb`.`attendance_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `registerAppDb`;
INSERT INTO `registerAppDb`.`attendance_type` (`attendance_type_id`, `name`) VALUES (1, 'obecny');
INSERT INTO `registerAppDb`.`attendance_type` (`attendance_type_id`, `name`) VALUES (2, 'nieobecny');
INSERT INTO `registerAppDb`.`attendance_type` (`attendance_type_id`, `name`) VALUES (3, 'zwolniony');
INSERT INTO `registerAppDb`.`attendance_type` (`attendance_type_id`, `name`) VALUES (4, 'spóźniony');
INSERT INTO `registerAppDb`.`attendance_type` (`attendance_type_id`, `name`) VALUES (5, 'nieobecność usprawiedliwiona');

COMMIT;


-- -----------------------------------------------------
-- Data for table `registerAppDb`.`attendance`
-- -----------------------------------------------------
START TRANSACTION;
USE `registerAppDb`;
INSERT INTO `registerAppDb`.`attendance` (`attendance_id`, `date`, `student_id`, `register_id`, `attendance_type_id`) VALUES (1, '2022-01-19 08:00:00', 1, 1, 1);
INSERT INTO `registerAppDb`.`attendance` (`attendance_id`, `date`, `student_id`, `register_id`, `attendance_type_id`) VALUES (2, '2022-01-19 08:50:00', 1, 2, 1);
INSERT INTO `registerAppDb`.`attendance` (`attendance_id`, `date`, `student_id`, `register_id`, `attendance_type_id`) VALUES (3, '2022-01-19 09:40:00', 11, 3, 2);
INSERT INTO `registerAppDb`.`attendance` (`attendance_id`, `date`, `student_id`, `register_id`, `attendance_type_id`) VALUES (4, '2022-01-19 10:30:00', 1, 4, 1);
INSERT INTO `registerAppDb`.`attendance` (`attendance_id`, `date`, `student_id`, `register_id`, `attendance_type_id`) VALUES (5, '2022-01-19 11:20:00', 1, 5, 1);
INSERT INTO `registerAppDb`.`attendance` (`attendance_id`, `date`, `student_id`, `register_id`, `attendance_type_id`) VALUES (6, '2022-01-19 12:20:00', 1, 6, 4);
INSERT INTO `registerAppDb`.`attendance` (`attendance_id`, `date`, `student_id`, `register_id`, `attendance_type_id`) VALUES (7, '2022-01-20 08:50:00', 1, 7, 2);
INSERT INTO `registerAppDb`.`attendance` (`attendance_id`, `date`, `student_id`, `register_id`, `attendance_type_id`) VALUES (8, '2022-01-20 09:40:00', 1, 8, 4);
INSERT INTO `registerAppDb`.`attendance` (`attendance_id`, `date`, `student_id`, `register_id`, `attendance_type_id`) VALUES (9, '2022-01-20 10:30:00', 1, 9, 1);
INSERT INTO `registerAppDb`.`attendance` (`attendance_id`, `date`, `student_id`, `register_id`, `attendance_type_id`) VALUES (10, '2022-01-20 11:20:00', 1, 10, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `registerAppDb`.`grade_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `registerAppDb`;
INSERT INTO `registerAppDb`.`grade_type` (`grade_type_id`, `name`) VALUES (1, 'sprawdzian');
INSERT INTO `registerAppDb`.`grade_type` (`grade_type_id`, `name`) VALUES (2, 'kartkówka');
INSERT INTO `registerAppDb`.`grade_type` (`grade_type_id`, `name`) VALUES (3, 'aktywność');
INSERT INTO `registerAppDb`.`grade_type` (`grade_type_id`, `name`) VALUES (4, 'odpowiedź ustna');
INSERT INTO `registerAppDb`.`grade_type` (`grade_type_id`, `name`) VALUES (5, 'inne');
INSERT INTO `registerAppDb`.`grade_type` (`grade_type_id`, `name`) VALUES (6, 'proponowana');
INSERT INTO `registerAppDb`.`grade_type` (`grade_type_id`, `name`) VALUES (7, 'końcowa');

COMMIT;


-- -----------------------------------------------------
-- Data for table `registerAppDb`.`grade_value`
-- -----------------------------------------------------
START TRANSACTION;
USE `registerAppDb`;
INSERT INTO `registerAppDb`.`grade_value` (`grade_value_id`, `value`, `text`) VALUES (1, 5.75, '6-');
INSERT INTO `registerAppDb`.`grade_value` (`grade_value_id`, `value`, `text`) VALUES (2, 6, '6');
INSERT INTO `registerAppDb`.`grade_value` (`grade_value_id`, `value`, `text`) VALUES (3, 0, '+');
INSERT INTO `registerAppDb`.`grade_value` (`grade_value_id`, `value`, `text`) VALUES (4, 4.75, '5-');
INSERT INTO `registerAppDb`.`grade_value` (`grade_value_id`, `value`, `text`) VALUES (5, 5, '5');
INSERT INTO `registerAppDb`.`grade_value` (`grade_value_id`, `value`, `text`) VALUES (6, 5.5, '5+');
INSERT INTO `registerAppDb`.`grade_value` (`grade_value_id`, `value`, `text`) VALUES (7, 3.75, '4-');
INSERT INTO `registerAppDb`.`grade_value` (`grade_value_id`, `value`, `text`) VALUES (8, 4, '4');
INSERT INTO `registerAppDb`.`grade_value` (`grade_value_id`, `value`, `text`) VALUES (9, 4.5, '4+');
INSERT INTO `registerAppDb`.`grade_value` (`grade_value_id`, `value`, `text`) VALUES (10, 2.75, '3-');
INSERT INTO `registerAppDb`.`grade_value` (`grade_value_id`, `value`, `text`) VALUES (11, 3, '3');
INSERT INTO `registerAppDb`.`grade_value` (`grade_value_id`, `value`, `text`) VALUES (12, 3.5, '3+');
INSERT INTO `registerAppDb`.`grade_value` (`grade_value_id`, `value`, `text`) VALUES (13, 1.75, '2-');
INSERT INTO `registerAppDb`.`grade_value` (`grade_value_id`, `value`, `text`) VALUES (14, 2, '2');
INSERT INTO `registerAppDb`.`grade_value` (`grade_value_id`, `value`, `text`) VALUES (15, 2.5, '2+');
INSERT INTO `registerAppDb`.`grade_value` (`grade_value_id`, `value`, `text`) VALUES (16, 0, '-');
INSERT INTO `registerAppDb`.`grade_value` (`grade_value_id`, `value`, `text`) VALUES (17, 1, '1');
INSERT INTO `registerAppDb`.`grade_value` (`grade_value_id`, `value`, `text`) VALUES (18, 1.5, '1+');

COMMIT;


-- -----------------------------------------------------
-- Data for table `registerAppDb`.`grade`
-- -----------------------------------------------------
START TRANSACTION;
USE `registerAppDb`;
INSERT INTO `registerAppDb`.`grade` (`grade_id`, `weight`, `comment`, `date`, `student_id`, `register_id`, `grade_type_id`, `grade_value_id`) VALUES (1, 2, NULL, '2022-01-19 08:05:00', 1, 1, 1, 5);
INSERT INTO `registerAppDb`.`grade` (`grade_id`, `weight`, `comment`, `date`, `student_id`, `register_id`, `grade_type_id`, `grade_value_id`) VALUES (2, 1, NULL, '2022-01-19 08:08:00', 1, 1, 2, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `registerAppDb`.`guardian`
-- -----------------------------------------------------
START TRANSACTION;
USE `registerAppDb`;
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (1, 35);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (2, 36);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (3, 37);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (4, 38);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (5, 39);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (6, 40);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (7, 41);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (8, 42);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (9, 43);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (10, 44);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (11, 45);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (12, 46);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (13, 47);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (14, 48);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (15, 49);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (16, 50);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (17, 51);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (18, 52);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (19, 53);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (20, 54);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (21, 55);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (22, 56);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (23, 57);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (24, 58);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (25, 59);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (26, 60);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (27, 61);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (28, 62);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (29, 63);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (30, 64);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (31, 65);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (32, 66);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (33, 67);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (34, 68);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (35, 69);
INSERT INTO `registerAppDb`.`guardian` (`guardian_id`, `user_id`) VALUES (36, 70);

COMMIT;


-- -----------------------------------------------------
-- Data for table `registerAppDb`.`guardian_has_student`
-- -----------------------------------------------------
START TRANSACTION;
USE `registerAppDb`;
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (1, 1);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (1, 2);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (1, 3);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (2, 4);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (3, 5);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (4, 6);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (4, 7);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (5, 8);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (6, 9);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (7, 10);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (8, 11);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (9, 12);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (10, 13);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (11, 14);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (12, 15);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (13, 16);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (14, 17);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (15, 18);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (15, 19);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (16, 20);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (17, 21);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (18, 22);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (19, 23);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (20, 24);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (21, 25);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (22, 26);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (23, 27);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (24, 28);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (25, 29);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (26, 30);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (27, 31);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (28, 32);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (29, 33);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (30, 34);
INSERT INTO `registerAppDb`.`guardian_has_student` (`guardian_id`, `student_id`) VALUES (31, 35);

COMMIT;


-- -----------------------------------------------------
-- Data for table `registerAppDb`.`role`
-- -----------------------------------------------------
START TRANSACTION;
USE `registerAppDb`;
INSERT INTO `registerAppDb`.`role` (`role_id`, `name`) VALUES (1, 'STUDENT');
INSERT INTO `registerAppDb`.`role` (`role_id`, `name`) VALUES (2, 'TEACHER');
INSERT INTO `registerAppDb`.`role` (`role_id`, `name`) VALUES (3, 'ADMIN');
INSERT INTO `registerAppDb`.`role` (`role_id`, `name`) VALUES (4, 'GUARDIAN');
INSERT INTO `registerAppDb`.`role` (`role_id`, `name`) VALUES (5, 'USER');

COMMIT;


-- -----------------------------------------------------
-- Data for table `registerAppDb`.`user_has_role`
-- -----------------------------------------------------
START TRANSACTION;
USE `registerAppDb`;
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (1, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (2, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (3, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (4, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (5, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (6, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (7, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (8, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (9, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (10, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (11, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (12, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (13, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (14, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (15, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (16, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (17, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (18, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (19, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (20, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (21, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (22, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (23, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (24, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (25, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (26, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (27, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (28, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (29, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (30, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (31, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (32, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (33, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (34, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (35, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (36, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (37, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (38, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (39, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (40, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (41, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (42, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (43, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (44, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (45, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (46, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (47, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (48, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (49, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (50, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (51, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (52, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (53, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (54, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (55, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (56, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (57, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (58, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (59, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (60, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (61, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (62, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (63, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (64, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (65, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (66, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (67, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (68, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (69, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (70, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (71, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (72, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (73, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (74, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (75, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (76, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (77, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (78, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (79, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (80, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (81, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (82, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (83, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (84, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (85, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (86, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (87, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (88, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (89, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (90, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (91, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (92, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (93, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (94, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (95, 5);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (1, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (2, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (3, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (4, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (5, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (6, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (7, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (8, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (9, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (10, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (11, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (12, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (13, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (14, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (15, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (16, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (17, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (18, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (19, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (20, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (21, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (22, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (23, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (24, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (25, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (26, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (27, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (28, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (29, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (30, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (31, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (32, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (33, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (34, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (35, 1);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (35, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (36, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (37, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (38, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (39, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (40, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (41, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (42, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (43, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (44, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (45, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (46, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (47, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (48, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (49, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (50, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (51, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (52, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (53, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (54, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (55, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (56, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (57, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (58, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (59, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (60, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (61, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (62, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (63, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (64, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (65, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (66, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (67, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (68, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (69, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (70, 4);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (71, 2);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (72, 2);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (73, 2);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (74, 2);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (75, 2);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (76, 2);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (77, 2);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (78, 2);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (79, 2);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (80, 2);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (81, 2);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (82, 2);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (83, 2);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (84, 2);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (85, 2);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (86, 2);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (87, 2);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (88, 2);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (89, 2);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (90, 2);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (91, 2);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (92, 2);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (93, 2);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (94, 2);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (95, 2);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (96, 3);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (97, 3);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (98, 3);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (99, 3);
INSERT INTO `registerAppDb`.`user_has_role` (`user_id`, `role_id`) VALUES (100, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `registerAppDb`.`schedule_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `registerAppDb`;
INSERT INTO `registerAppDb`.`schedule_type` (`schedule_type_id`, `name`) VALUES (1, 'lekcja');
INSERT INTO `registerAppDb`.`schedule_type` (`schedule_type_id`, `name`) VALUES (2, 'sprawdzian');
INSERT INTO `registerAppDb`.`schedule_type` (`schedule_type_id`, `name`) VALUES (3, 'kartkówka');

COMMIT;


-- -----------------------------------------------------
-- Data for table `registerAppDb`.`schedule`
-- -----------------------------------------------------
START TRANSACTION;
USE `registerAppDb`;
INSERT INTO `registerAppDb`.`schedule` (`schedule_id`, `date`, `comment`, `register_id`, `schedule_type_id`) VALUES (1, '2022-01-19 12:20:00', NULL, 6, 2);

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
