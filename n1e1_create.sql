-- MySQL Workbench Synchronization
-- Generated: 2021-02-20 15:52
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: sato

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `cull_dampolla` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `cull_dampolla`.`clientes` (
  `clientes_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'PK de la tabla. NO es el DNI. Es automático.',
  `clientes_nombre` VARCHAR(45) NOT NULL,
  `clientes_reg` DATE NOT NULL COMMENT 'Fecha de registro como nuevo cliente.',
  `clientes_recomendador` INT(11) NULL DEFAULT NULL,
  `direcciones_direcciones_id` INT(11) NOT NULL,
  PRIMARY KEY (`clientes_id`),
  UNIQUE INDEX `clientes_id_UNIQUE` (`clientes_id` ASC),
  INDEX `fk_clientes_direcciones1_idx` (`direcciones_direcciones_id` ASC),
  CONSTRAINT `fk_clientes_direcciones1`
    FOREIGN KEY (`direcciones_direcciones_id`)
    REFERENCES `cull_dampolla`.`direcciones` (`direcciones_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `cull_dampolla`.`gafas` (
  `gafas_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'PK de la tabla. Esas manoooos!!!. Es automático.',
  `gafas_grad_izda` VARCHAR(5) NOT NULL COMMENT 'Graduación cristal izquierdo. Tipo \"00,00\"',
  `gafas_color_izda` VARCHAR(15) NOT NULL COMMENT 'Color cristal izquierdo',
  `gafas_grad_dcha` VARCHAR(5) NOT NULL COMMENT 'Graduación cristal derecho. Tipo \"00,00\"',
  `gafas_color_dcha` VARCHAR(15) NOT NULL COMMENT 'Color cristal derecho.',
  `gafas_montura` VARCHAR(3) NOT NULL COMMENT 'Valores:\\n\\n1.-Flotante\\n2.-Pasta\\n3.-Metálica\\n----------------',
  `gafas_color_montura` VARCHAR(15) NOT NULL COMMENT 'Color de la montura',
  `gafas_vendedor` VARCHAR(3) NOT NULL COMMENT 'Los vendedores (empleados) no están reflejados en la BBDD más que por este campo.\\n\\nValores:\\n\\nTres carácteres para el ID del vendedor de la gafa (p.e. 007). ',
  `marcas_marcas_id` INT(11) NOT NULL COMMENT 'FK a marcas',
  `clientes_clientes_id` INT(11) NOT NULL COMMENT 'FK para clientes',
  PRIMARY KEY (`gafas_id`),
  UNIQUE INDEX `gafas_id_UNIQUE` (`gafas_id` ASC),
  INDEX `fk_gafas_marcas1_idx` (`marcas_marcas_id` ASC),
  INDEX `fk_gafas_clientes1_idx` (`clientes_clientes_id` ASC),
  CONSTRAINT `fk_gafas_clientes1`
    FOREIGN KEY (`clientes_clientes_id`)
    REFERENCES `cull_dampolla`.`clientes` (`clientes_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_gafas_marcas1`
    FOREIGN KEY (`marcas_marcas_id`)
    REFERENCES `cull_dampolla`.`marcas` (`marcas_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `cull_dampolla`.`marcas` (
  `marcas_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'PK de la tabla. En serio, no toques, es automático.',
  `marcas_nombre` VARCHAR(45) NOT NULL COMMENT 'Nombre comercial de la marca.',
  `proveedores_proveedores_id` INT(11) NOT NULL COMMENT 'FK con proveedores.',
  PRIMARY KEY (`marcas_id`),
  UNIQUE INDEX `marcas_id_UNIQUE` (`marcas_id` ASC),
  INDEX `fk_marcas_proveedores1_idx` (`proveedores_proveedores_id` ASC),
  CONSTRAINT `fk_marcas_proveedores1`
    FOREIGN KEY (`proveedores_proveedores_id`)
    REFERENCES `cull_dampolla`.`proveedores` (`proveedores_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `cull_dampolla`.`direcciones` (
  `direcciones_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador propio y automático de cada item en la tabla. Es nuestra PK, NO es el DNI. ',
  `direcciones_calle` VARCHAR(45) NOT NULL COMMENT 'Parte de la dirección de cada persona. Recomedado el valor \"C/ xxxxxxxxxxxx\". Podemos no tener este dato.',
  `direcciones_num` INT(11) NOT NULL COMMENT 'Parte de la dirección de cada persona. Recomedado valores tipo \"000\". Podemos no tener este dato.',
  `direcciones_piso` INT(11) NOT NULL COMMENT 'Parte de la dirección de cada persona. Recomedado valores tipo \"000\". Podemos no tener este dato.',
  `direcciones_puerta` VARCHAR(2) NOT NULL COMMENT 'Parte de la dirección de cada persona. Recomedado valores tipo \"00\" o \"AA\". Podemos no tener este dato.',
  `direcciones_ciudad` VARCHAR(45) NOT NULL COMMENT 'Parte de la dirección de cada persona. Podemos no tener este dato.',
  `direcciones_cp` VARCHAR(5) NOT NULL COMMENT 'Parte de la dirección de cada persona. Recomedado valores tipo \"00000\". Podemos no tener este dato.',
  `direcciones_pais` VARCHAR(2) NOT NULL COMMENT 'Parte de la dirección de cada persona. Código internacional de país. Recomedado valores tipo \"ES\". Podemos no tener este dato.',
  `direcciones_tel` VARCHAR(9) NULL DEFAULT NULL COMMENT 'Parte de la dirección de cada persona. Nueve posiciones para el número de telefono. Podemos no tener este dato.',
  `direcciones_fax` VARCHAR(9) NULL DEFAULT NULL COMMENT 'Parte de la dirección de cada persona. Nueve posiciones para el número de fax. Podemos no tener este dato.',
  `direcciones_email` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Parte de la dirección de cada persona. Podemos no tener este dato.',
  PRIMARY KEY (`direcciones_id`),
  UNIQUE INDEX `personas_id_UNIQUE` (`direcciones_id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8
COMMENT = 'Direcciones y formas de contacto de personas y entidades';

CREATE TABLE IF NOT EXISTS `cull_dampolla`.`proveedores` (
  `proveedores_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'PK de la tabla. NO es el NIF. Es automático.',
  `proveedores_nif` VARCHAR(9) NOT NULL COMMENT 'NIF de cada proveedor. 9 posiciones. Tipo 00000000Z',
  `proveedores_nombre` VARCHAR(45) NOT NULL,
  `direcciones_direcciones_id` INT(11) NOT NULL,
  PRIMARY KEY (`proveedores_id`),
  UNIQUE INDEX `proveedores_id_UNIQUE` (`proveedores_id` ASC),
  UNIQUE INDEX `proveedores_nif_UNIQUE` (`proveedores_nif` ASC),
  INDEX `fk_proveedores_direcciones1_idx` (`direcciones_direcciones_id` ASC),
  CONSTRAINT `fk_proveedores_direcciones1`
    FOREIGN KEY (`direcciones_direcciones_id`)
    REFERENCES `cull_dampolla`.`direcciones` (`direcciones_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
