SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`usuario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`usuario` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(80) NOT NULL ,
  `email` VARCHAR(80) NOT NULL ,
  `senha` VARCHAR(32) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cliente`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`cliente` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(200) NOT NULL ,
  `id_usuario` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_cliente_usuario1_idx` (`id_usuario` ASC) ,
  CONSTRAINT `fk_cliente_usuario1`
    FOREIGN KEY (`id_usuario` )
    REFERENCES `mydb`.`usuario` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`projeto`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`projeto` (
  `id` INT NOT NULL ,
  `nome` VARCHAR(255) NOT NULL ,
  `descricao` TEXT NULL ,
  `data_inicio` DATE NOT NULL ,
  `data_final` DATE NULL ,
  `id_usuario` INT NOT NULL ,
  `id_cliente` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_projeto_usuario1_idx` (`id_usuario` ASC) ,
  INDEX `fk_projeto_cliente1_idx` (`id_cliente` ASC) ,
  CONSTRAINT `fk_projeto_usuario1`
    FOREIGN KEY (`id_usuario` )
    REFERENCES `mydb`.`usuario` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_projeto_cliente1`
    FOREIGN KEY (`id_cliente` )
    REFERENCES `mydb`.`cliente` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cliente_contato`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`cliente_contato` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(80) NOT NULL ,
  `email` VARCHAR(50) NULL ,
  `funcao` VARCHAR(80) NULL ,
  `observacao` TEXT NULL ,
  `id_cliente` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_cliente_contato_cliente1_idx` (`id_cliente` ASC) ,
  CONSTRAINT `fk_cliente_contato_cliente1`
    FOREIGN KEY (`id_cliente` )
    REFERENCES `mydb`.`cliente` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`requisito`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`requisito` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `codigo` VARCHAR(50) NOT NULL ,
  `prioridade` ENUM('baixa','media','alta') NOT NULL ,
  `estabilidade` ENUM('baixa','media','alta') NOT NULL ,
  `tipo_requisito` ENUM('funcional','nao_funcional') NULL ,
  `impacto_arquitetura` ENUM('baixa','media','alta') NOT NULL ,
  `descricao` VARCHAR(45) NULL ,
  `data_inicio` DATE NOT NULL ,
  `data_final` DATE NULL ,
  `id_requisito` INT NULL ,
  `id_projeto` INT NOT NULL ,
  `cliente_contato_id` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_requisito_requisito_idx` (`id_requisito` ASC) ,
  INDEX `fk_requisito_projeto1_idx` (`id_projeto` ASC) ,
  INDEX `fk_requisito_cliente_contato1_idx` (`cliente_contato_id` ASC) ,
  CONSTRAINT `fk_requisito_requisito`
    FOREIGN KEY (`id_requisito` )
    REFERENCES `mydb`.`requisito` (`id` )
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_requisito_projeto1`
    FOREIGN KEY (`id_projeto` )
    REFERENCES `mydb`.`projeto` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_requisito_cliente_contato1`
    FOREIGN KEY (`cliente_contato_id` )
    REFERENCES `mydb`.`cliente_contato` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
