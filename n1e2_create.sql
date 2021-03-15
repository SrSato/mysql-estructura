-- MySQL Workbench Synchronization
-- Generated: 2021-03-15 12:56
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: sato

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`categorias` (
  `categorias_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'PK autoincrementada. No tocar.',
  `categorias_nombre` VARCHAR(45) NOT NULL COMMENT 'Nombre de la categoria. No puede quedar vacio ni repetirse.',
  `categorias_estado` TINYINT(1) NOT NULL COMMENT 'No requerida por las especificaciones, pero útil al variar las categorías con las temporadas. Informa de si una categoría está activa o no. 0 no activa, 1 activa.',
  PRIMARY KEY (`categorias_id`),
  UNIQUE INDEX `categorias_id_UNIQUE` (`categorias_id` ASC),
  UNIQUE INDEX `categorias_nombre_UNIQUE` (`categorias_nombre` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8
COMMENT = 'En principio, es sólo para pizzas, pero este diseño no restringe el uso.';

CREATE TABLE IF NOT EXISTS `pizzeria`.`clientes` (
  `clientes_id` INT(11) NOT NULL AUTO_INCREMENT,
  `clientes_nombre` VARCHAR(45) NOT NULL,
  `clientes_apellidos` VARCHAR(45) NOT NULL,
  `clientes_tfno` VARCHAR(45) NOT NULL,
  `clientes_calle` VARCHAR(45) NOT NULL,
  `clientes_num` VARCHAR(45) NOT NULL,
  `clientes_piso` VARCHAR(45) NOT NULL,
  `clientes_puerta` VARCHAR(45) NOT NULL,
  `clientes_cp` VARCHAR(45) NOT NULL,
  `localidades_localidades_id` INT(11) NOT NULL,
  PRIMARY KEY (`clientes_id`, `localidades_localidades_id`),
  UNIQUE INDEX `clientes_id_UNIQUE` (`clientes_id` ASC),
  INDEX `fk_clientes_localidades1_idx` (`localidades_localidades_id` ASC),
  CONSTRAINT `fk_clientes_localidades1`
    FOREIGN KEY (`localidades_localidades_id`)
    REFERENCES `pizzeria`.`localidades` (`localidades_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`empleados` (
  `empleados_id` INT(11) NOT NULL AUTO_INCREMENT,
  `tiendas_tiendas_id` INT(11) NOT NULL,
  `empleados_nombre` VARCHAR(45) NULL DEFAULT NULL,
  `empleados_apellidos` VARCHAR(45) NULL DEFAULT NULL,
  `empleados_tfno` VARCHAR(45) NULL DEFAULT NULL,
  `empleados_calle` VARCHAR(45) NULL DEFAULT NULL,
  `empleados_num` VARCHAR(45) NULL DEFAULT NULL,
  `empleados_piso` VARCHAR(45) NULL DEFAULT NULL,
  `empleados_puerta` VARCHAR(45) NULL DEFAULT NULL,
  `empleados_cp` VARCHAR(45) NULL DEFAULT NULL,
  `localidades_localidades_id` INT(11) NOT NULL,
  PRIMARY KEY (`empleados_id`, `localidades_localidades_id`),
  UNIQUE INDEX `empleados_id_UNIQUE` (`empleados_id` ASC),
  INDEX `fk_empleados_tiendas1_idx` (`tiendas_tiendas_id` ASC),
  INDEX `fk_empleados_localidades1_idx` (`localidades_localidades_id` ASC),
  CONSTRAINT `fk_empleados_tiendas1`
    FOREIGN KEY (`tiendas_tiendas_id`)
    REFERENCES `pizzeria`.`tiendas` (`tiendas_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_empleados_localidades1`
    FOREIGN KEY (`localidades_localidades_id`)
    REFERENCES `pizzeria`.`localidades` (`localidades_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT =0
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`localidades` (
  `localidades_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'PK autoincremental. No tocar.',
  `localidades_nombre` VARCHAR(45) NOT NULL COMMENT 'Nombre de la localidad',
  `provincias_provincias_id` INT(11) NOT NULL COMMENT 'FK para provincias\\n',
  PRIMARY KEY (`localidades_id`),
  UNIQUE INDEX `localidades_id_UNIQUE` (`localidades_id` ASC),
  INDEX `fk_localidades_provincias_idx` (`provincias_provincias_id` ASC),
  CONSTRAINT `fk_localidades_provincias`
    FOREIGN KEY (`provincias_provincias_id`)
    REFERENCES `pizzeria`.`provincias` (`provincias_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`pedidos` (
  `pedidos_id` INT(11) NOT NULL AUTO_INCREMENT,
  `pedidos_fecha` DATETIME NOT NULL,
  `pedidos_tipo` VARCHAR(1) NOT NULL COMMENT 'Tipo de pedido. Valores: A- Entrega en domicilio, B-Recogida en tienda.',
  `pedidos_num` INT(11) NOT NULL COMMENT 'Cantidad de productos. Debería ser un campo autocalculado.',
  `pedidos_total` DECIMAL(6,2) NOT NULL COMMENT 'Precio total del pedido. Debería ser un campo autocalculado. Valor max: 9999.99',
  `tiendas_tiendas_id` INT(11) NOT NULL,
  `clientes_clientes_id` INT(11) NOT NULL,
  PRIMARY KEY (`pedidos_id`),
  UNIQUE INDEX `pedidos_id_UNIQUE` (`pedidos_id` ASC),
  INDEX `fk_pedidos_tiendas1_idx` (`tiendas_tiendas_id` ASC),
  INDEX `fk_pedidos_clientes1_idx` (`clientes_clientes_id` ASC),
  CONSTRAINT `fk_pedidos_clientes1`
    FOREIGN KEY (`clientes_clientes_id`)
    REFERENCES `pizzeria`.`clientes` (`clientes_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pedidos_tiendas1`
    FOREIGN KEY (`tiendas_tiendas_id`)
    REFERENCES `pizzeria`.`tiendas` (`tiendas_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`pedidos_has_productos` (
  `productos_productos_id` INT(11) NOT NULL,
  `pedidos_pedidos_id` INT(11) NOT NULL,
  `pedidos_has_productos_num` INT(11) NOT NULL COMMENT 'Número de unidades del producto en este pedido (p.e. 3 x Refresco de cola light)',
  PRIMARY KEY (`productos_productos_id`, `pedidos_pedidos_id`),
  INDEX `fk_productos_has_pedidos_pedidos1_idx` (`pedidos_pedidos_id` ASC),
  INDEX `fk_productos_has_pedidos_productos1_idx` (`productos_productos_id` ASC),
  CONSTRAINT `fk_productos_has_pedidos_pedidos1`
    FOREIGN KEY (`pedidos_pedidos_id`)
    REFERENCES `pizzeria`.`pedidos` (`pedidos_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_productos_has_pedidos_productos1`
    FOREIGN KEY (`productos_productos_id`)
    REFERENCES `pizzeria`.`productos` (`productos_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Listado de productos por pedido.';

CREATE TABLE IF NOT EXISTS `pizzeria`.`productos` (
  `productos_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'PK autoincrementada. Ojo con las manos que van al pan.',
  `productos_tipo` VARCHAR(2) NOT NULL COMMENT 'Tipo de producto. Actualmente: 1-Pizza, 2.-Hamburguesa, 3-Bebida',
  `productos_nom` VARCHAR(45) NOT NULL COMMENT 'Nombre del producto.',
  `productos_des` MEDIUMTEXT NOT NULL COMMENT 'Descripción del producto.',
  `productos_img` VARCHAR(45) NOT NULL COMMENT 'URL de la imagen del producto.',
  `productos_precio` DECIMAL(4,2) NOT NULL COMMENT 'Precio del producto. Valor max: 99.99',
  `categorias_categorias_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`productos_id`),
  UNIQUE INDEX `productos_id_UNIQUE` (`productos_id` ASC),
  INDEX `fk_productos_categorias1_idx` (`categorias_categorias_id` ASC),
  CONSTRAINT `fk_productos_categorias1`
    FOREIGN KEY (`categorias_categorias_id`)
    REFERENCES `pizzeria`.`categorias` (`categorias_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`provincias` (
  `provincias_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'PK autoincremental. No tocar.',
  `provincias_nombre` VARCHAR(45) NOT NULL COMMENT 'Nombre de provincia.',
  PRIMARY KEY (`provincias_id`),
  UNIQUE INDEX `provincias_id_UNIQUE` (`provincias_id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`tiendas` (
  `tiendas_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'PK autoincremental. No tocar.',
  `tiendas_mat` VARCHAR(45) NOT NULL COMMENT 'Identificador de cada tienda según el cliente (su matrícula de negocio). Seguirá los valores que el cliente prefiera.',
  `tiendas_calle` VARCHAR(45) NULL DEFAULT NULL,
  `tiendas_num` VARCHAR(45) NULL DEFAULT NULL,
  `tiendas_piso` VARCHAR(45) NULL DEFAULT NULL,
  `tiendas_puerta` VARCHAR(45) NULL DEFAULT NULL,
  `tiendas_cp` VARCHAR(45) NULL DEFAULT NULL,
  `localidades_localidades_id` INT(11) NOT NULL,
  PRIMARY KEY (`tiendas_id`, `localidades_localidades_id`),
  UNIQUE INDEX `tiendas_id_UNIQUE` (`tiendas_id` ASC),
  UNIQUE INDEX `tiendas_col_UNIQUE` (`tiendas_mat` ASC),
  INDEX `fk_tiendas_localidades1_idx` (`localidades_localidades_id` ASC),
  CONSTRAINT `fk_tiendas_localidades1`
    FOREIGN KEY (`localidades_localidades_id`)
    REFERENCES `pizzeria`.`localidades` (`localidades_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
