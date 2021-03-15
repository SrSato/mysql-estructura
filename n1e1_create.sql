-- MySQL Workbench Synchronization
-- Generated: 2021-03-15 12:14
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
  `clientes_calle` VARCHAR(45) NOT NULL,
  `clientes_num` VARCHAR(45) NOT NULL,
  `clientes_piso` VARCHAR(45) NOT NULL,
  `clientes_puerta` VARCHAR(45) NOT NULL,
  `clientes_ciudad` VARCHAR(45) NOT NULL,
  `clientes_cp` VARCHAR(45) NOT NULL,
  `clientes_pais` VARCHAR(45) NOT NULL,
  `clientes_tel` VARCHAR(45) NOT NULL,
  `clientes_fax` VARCHAR(45) NOT NULL,
  `clientes_email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`clientes_id`),
  UNIQUE INDEX `clientes_id_UNIQUE` (`clientes_id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `cull_dampolla`.`gafas` (
  `gafas_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'PK de la tabla. Esas manoooos!!!. Es automático.',
  `gafas_grad_izda` VARCHAR(5) NOT NULL COMMENT 'Graduación cristal izquierdo. Tipo \"00,00\"',
  `gafas_color_izda` VARCHAR(15) NOT NULL COMMENT 'Color cristal izquierdo',
  `gafas_grad_dcha` VARCHAR(5) NOT NULL COMMENT 'Graduación cristal derecho. Tipo \"00,00\"',
  `gafas_color_dcha` VARCHAR(15) NOT NULL COMMENT 'Color cristal derecho.',
  `gafas_montura` VARCHAR(3) NOT NULL COMMENT 'Valores:\\\\n\\\\n1.-Flotante\\\\n2.-Pasta\\\\n3.-Metálica\\\\n----------------',
  `gafas_color_montura` VARCHAR(15) NOT NULL COMMENT 'Color de la montura',
  `gafas_vendedor` VARCHAR(3) NOT NULL COMMENT 'Los vendedores (empleados) no están reflejados en la BBDD más que por este campo.\\\\n\\\\nValores:\\\\n\\\\nTres carácteres para el ID del vendedor de la gafa (p.e. 007). ',
  `marcas_marcas_id` INT(11) NOT NULL COMMENT 'FK a marcas',
  PRIMARY KEY (`gafas_id`),
  UNIQUE INDEX `gafas_id_UNIQUE` (`gafas_id` ASC),
  INDEX `fk_gafas_marcas1_idx` (`marcas_marcas_id` ASC),
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

CREATE TABLE IF NOT EXISTS `cull_dampolla`.`proveedores` (
  `proveedores_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'PK de la tabla. NO es el NIF. Es automático.',
  `proveedores_nif` VARCHAR(9) NOT NULL COMMENT 'NIF de cada proveedor. 9 posiciones. Tipo 00000000Z',
  `proveedores_nombre` VARCHAR(45) NOT NULL,
  `proveedores_calle` VARCHAR(45) NOT NULL,
  `proveedores_num` VARCHAR(45) NOT NULL,
  `proveedores_piso` VARCHAR(45) NOT NULL,
  `proveedores_puerta` VARCHAR(45) NOT NULL,
  `proveedores_ciudad` VARCHAR(45) NOT NULL,
  `proveedores_cp` VARCHAR(45) NOT NULL,
  `proveedores_pais` VARCHAR(45) NOT NULL,
  `proveedores_tel` VARCHAR(45) NOT NULL,
  `proveedores_fax` VARCHAR(45) NOT NULL,
  `proveedores_email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`proveedores_id`),
  UNIQUE INDEX `proveedores_id_UNIQUE` (`proveedores_id` ASC),
  UNIQUE INDEX `proveedores_nif_UNIQUE` (`proveedores_nif` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `cull_dampolla`.`compra` (
  `compra_id` INT(11) NOT NULL AUTO_INCREMENT,
  `compra_cantidad` INT(11) NOT NULL,
  `gafas_gafas_id` INT(11) NOT NULL,
  `factura_factura_id` INT(11) NOT NULL,
  PRIMARY KEY (`compra_id`),
  UNIQUE INDEX `compra_id_UNIQUE` (`compra_id` ASC),
  INDEX `fk_compra_gafas1_idx` (`gafas_gafas_id` ASC),
  INDEX `fk_compra_factura1_idx` (`factura_factura_id` ASC),
  CONSTRAINT `fk_compra_gafas1`
    FOREIGN KEY (`gafas_gafas_id`)
    REFERENCES `cull_dampolla`.`gafas` (`gafas_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_compra_factura1`
    FOREIGN KEY (`factura_factura_id`)
    REFERENCES `cull_dampolla`.`factura` (`factura_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `cull_dampolla`.`factura` (
  `factura_id` INT(11) NOT NULL AUTO_INCREMENT,
  `factura_total` INT(11) NOT NULL,
  `clientes_clientes_id` INT(11) NOT NULL,
  PRIMARY KEY (`factura_id`),
  UNIQUE INDEX `factura_id_UNIQUE` (`factura_id` ASC),
  INDEX `fk_factura_clientes1_idx` (`clientes_clientes_id` ASC),
  CONSTRAINT `fk_factura_clientes1`
    FOREIGN KEY (`clientes_clientes_id`)
    REFERENCES `cull_dampolla`.`clientes` (`clientes_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
