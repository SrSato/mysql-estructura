-- MySQL Workbench Synchronization
-- Generated: 2021-02-04 13:09
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: sato

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `yoestuve` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `yoestuve`.`usuario` (
  `usuario_id` INT(11) NOT NULL AUTO_INCREMENT,
  `usuario_email` VARCHAR(25) NOT NULL,
  `usuario_pwd` VARCHAR(25) NOT NULL,
  `usuario_nick` VARCHAR(25) NOT NULL,
  `usuario_dob` DATE NOT NULL,
  `usuario_genero` VARCHAR(1) NULL DEFAULT NULL COMMENT 'Género del usuario (para la personalización de las interpelaciones automáticas) Valores: F-Femenino, M-Masculino, N-No binario. Por defecto asumimos N.',
  `usuario_pais` VARCHAR(2) NOT NULL COMMENT 'País del usuario en codificación internacional (p.e. \"ES\", \"UK\"...)',
  `usuario_cp` VARCHAR(5) NOT NULL COMMENT 'Codigo postal. 5 posiciones.',
  PRIMARY KEY (`usuario_id`),
  UNIQUE INDEX `usuario_id_UNIQUE` (`usuario_id` ASC),
  UNIQUE INDEX `usuario_email_UNIQUE` (`usuario_email` ASC),
  UNIQUE INDEX `usuario_nick_UNIQUE` (`usuario_nick` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `yoestuve`.`video` (
  `video_id` INT(11) NOT NULL AUTO_INCREMENT,
  `video_titulo` VARCHAR(45) NOT NULL,
  `video_desc` VARCHAR(45) NOT NULL,
  `video_peso` INT(11) NOT NULL,
  `video_file` VARCHAR(45) NOT NULL,
  `video_dur` VARCHAR(45) NOT NULL,
  `video_thumb` VARCHAR(45) NOT NULL,
  `video_views` INT(11) NULL DEFAULT 0,
  `video_likes` INT(11) NULL DEFAULT 0,
  `video_dislikes` INT(11) NULL DEFAULT 0,
  PRIMARY KEY (`video_id`),
  UNIQUE INDEX `video_id_UNIQUE` (`video_id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `yoestuve`.`etiqueta` (
  `etiqueta_id` INT(11) NOT NULL AUTO_INCREMENT,
  `etiqueta_nombre` VARCHAR(45) NOT NULL,
  `video_video_id` INT(11) NOT NULL,
  PRIMARY KEY (`etiqueta_id`),
  UNIQUE INDEX `etiqueta_id_UNIQUE` (`etiqueta_id` ASC),
  UNIQUE INDEX `etiqueta_nombre_UNIQUE` (`etiqueta_nombre` ASC),
  INDEX `fk_etiqueta_video1_idx` (`video_video_id` ASC),
  CONSTRAINT `fk_etiqueta_video1`
    FOREIGN KEY (`video_video_id`)
    REFERENCES `yoestuve`.`video` (`video_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `yoestuve`.`canal` (
  `canal_id` INT(11) NOT NULL AUTO_INCREMENT,
  `canal_nombre` VARCHAR(45) NOT NULL,
  `canal_desc` VARCHAR(45) NOT NULL,
  `canal_doc` DATETIME NOT NULL,
  `usuario_usuario_id` INT(11) NOT NULL,
  PRIMARY KEY (`canal_id`),
  INDEX `fk_canal_usuario1_idx` (`usuario_usuario_id` ASC),
  CONSTRAINT `fk_canal_usuario1`
    FOREIGN KEY (`usuario_usuario_id`)
    REFERENCES `yoestuve`.`usuario` (`usuario_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `yoestuve`.`comentario` (
  `usuario_usuario_id` INT(11) NOT NULL,
  `video_video_id` INT(11) NOT NULL,
  `comentario_text` LONGTEXT NOT NULL,
  `comentario_fecha` DATETIME NOT NULL,
  `comentario_likes` INT(11) NULL DEFAULT 0,
  `comentario_dislikes` INT(11) NULL DEFAULT 0,
  PRIMARY KEY (`usuario_usuario_id`, `video_video_id`),
  INDEX `fk_comentario_usuario1_idx` (`usuario_usuario_id` ASC),
  INDEX `fk_comentario_video1_idx` (`video_video_id` ASC),
  CONSTRAINT `fk_comentario_usuario1`
    FOREIGN KEY (`usuario_usuario_id`)
    REFERENCES `yoestuve`.`usuario` (`usuario_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comentario_video1`
    FOREIGN KEY (`video_video_id`)
    REFERENCES `yoestuve`.`video` (`video_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `yoestuve`.`suscripcion` (
  `canal_canal_id` INT(11) NOT NULL,
  `usuario_usuario_id` INT(11) NOT NULL,
  PRIMARY KEY (`canal_canal_id`, `usuario_usuario_id`),
  INDEX `fk_canal_has_usuario_usuario1_idx` (`usuario_usuario_id` ASC),
  INDEX `fk_canal_has_usuario_canal_idx` (`canal_canal_id` ASC),
  CONSTRAINT `fk_canal_has_usuario_canal`
    FOREIGN KEY (`canal_canal_id`)
    REFERENCES `yoestuve`.`canal` (`canal_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_canal_has_usuario_usuario1`
    FOREIGN KEY (`usuario_usuario_id`)
    REFERENCES `yoestuve`.`usuario` (`usuario_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `yoestuve`.`usuario_valora_video` (
  `video_video_id` INT(11) NOT NULL,
  `usuario_usuario_id` INT(11) NOT NULL,
  `usuario_valora_video_tipo` VARCHAR(1) NOT NULL COMMENT 'Valores: L- Like (valoración positiva) D-Dislike (valoración negativa)',
  `usuario_valora_video_fecha` DATETIME NOT NULL,
  PRIMARY KEY (`video_video_id`, `usuario_usuario_id`),
  INDEX `fk_video_has_usuario_usuario1_idx` (`usuario_usuario_id` ASC),
  INDEX `fk_video_has_usuario_video1_idx` (`video_video_id` ASC),
  CONSTRAINT `fk_video_has_usuario_video1`
    FOREIGN KEY (`video_video_id`)
    REFERENCES `yoestuve`.`video` (`video_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_video_has_usuario_usuario1`
    FOREIGN KEY (`usuario_usuario_id`)
    REFERENCES `yoestuve`.`usuario` (`usuario_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `yoestuve`.`playlist` (
  `video_video_id` INT(11) NOT NULL,
  `usuario_usuario_id` INT(11) NOT NULL,
  `playlist_nombre` VARCHAR(45) NOT NULL,
  `playlist_fecha` DATETIME NULL DEFAULT NULL,
  `playlist_estado` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Valores: P-Publico, R-Restringido (privado)',
  PRIMARY KEY (`video_video_id`, `usuario_usuario_id`),
  INDEX `fk_video_has_usuario_usuario2_idx` (`usuario_usuario_id` ASC),
  INDEX `fk_video_has_usuario_video2_idx` (`video_video_id` ASC),
  CONSTRAINT `fk_video_has_usuario_video2`
    FOREIGN KEY (`video_video_id`)
    REFERENCES `yoestuve`.`video` (`video_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_video_has_usuario_usuario2`
    FOREIGN KEY (`usuario_usuario_id`)
    REFERENCES `yoestuve`.`usuario` (`usuario_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `yoestuve`.`usuario_actualiza_video` (
  `video_video_id` INT(11) NOT NULL,
  `usuario_usuario_id` INT(11) NOT NULL,
  `usuario_actualiza_video_fecha` DATETIME NOT NULL,
  `usuario_actualiza_video_estado` VARCHAR(1) NOT NULL,
  PRIMARY KEY (`video_video_id`, `usuario_usuario_id`, `usuario_actualiza_video_fecha`),
  INDEX `fk_video_has_usuario_usuario3_idx` (`usuario_usuario_id` ASC),
  INDEX `fk_video_has_usuario_video3_idx` (`video_video_id` ASC),
  CONSTRAINT `fk_video_has_usuario_video3`
    FOREIGN KEY (`video_video_id`)
    REFERENCES `yoestuve`.`video` (`video_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_video_has_usuario_usuario3`
    FOREIGN KEY (`usuario_usuario_id`)
    REFERENCES `yoestuve`.`usuario` (`usuario_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
