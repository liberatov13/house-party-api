-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema house_party
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema house_party
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `house_party` ;
USE `house_party` ;

-- -----------------------------------------------------
-- Table `house_party`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `house_party`.`endereco` (
  `id_endereco` INT NOT NULL,
  `cep` INT(8) NOT NULL,
  `logradouro` VARCHAR(75) NOT NULL,
  `numero` INT NOT NULL,
  `complemento` VARCHAR(45) NULL,
  `bairro` VARCHAR(75) NOT NULL,
  `cidade` VARCHAR(75) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_endereco`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `house_party`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `house_party`.`usuario` (
  `id_usuario` INT NOT NULL,
  `nome` VARCHAR(75) NOT NULL,
  `email` VARCHAR(75) NOT NULL,
  `nome_usuario` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(75) NOT NULL,
  `telefone` INT(11) NOT NULL,
  `cpf` INT(11) NOT NULL,
  `dt_nascimento` DATE NULL,
  `dt_cadastro` DATETIME NULL,
  `dt_alteracao` DATETIME NULL,
  `id_endereco` INT NOT NULL,
  PRIMARY KEY (`id_usuario`, `id_endereco`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `nome_usuario_UNIQUE` (`nome_usuario` ASC) VISIBLE,
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE,
  INDEX `fk_usuario_endereco1_idx` (`id_endereco` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_endereco1`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `house_party`.`endereco` (`id_endereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `house_party`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `house_party`.`categoria` (
  `id_categoria` INT NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `house_party`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `house_party`.`produto` (
  `id_produto` INT NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `ean` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_produto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `house_party`.`fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `house_party`.`fornecedor` (
  `id_fornecedor` INT NOT NULL,
  `cnpj` INT(14) NOT NULL,
  `razao_social` VARCHAR(75) NOT NULL,
  `nome_fantasia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_fornecedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `house_party`.`entregador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `house_party`.`entregador` (
  `id_entregador` INT NOT NULL,
  `nome` VARCHAR(75) NOT NULL,
  `cpf` INT(11) NOT NULL,
  `telefone` INT(11) NOT NULL,
  `senha` VARCHAR(75) NOT NULL,
  `dt_cadastro` DATETIME NULL,
  PRIMARY KEY (`id_entregador`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `house_party`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `house_party`.`pedido` (
  `id_pedido` INT NOT NULL,
  `nf` INT(44) NOT NULL,
  `id_usuario` INT NOT NULL,
  `id_entregador` INT NOT NULL,
  `id_endereco` INT NOT NULL,
  `tipo_entrega` VARCHAR(45) NULL,
  `dt_solicitacao` DATETIME NOT NULL,
  `dt_entrega` DATETIME NULL,
  `dt_devolucao` DATETIME NULL,
  PRIMARY KEY (`id_pedido`),
  INDEX `fk_pedido_usuario1_idx` (`id_usuario` ASC, `id_endereco` ASC) VISIBLE,
  INDEX `fk_pedido_entregador1_idx` (`id_entregador` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_usuario1`
    FOREIGN KEY (`id_usuario` , `id_endereco`)
    REFERENCES `house_party`.`usuario` (`id_usuario` , `id_endereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_entregador1`
    FOREIGN KEY (`id_entregador`)
    REFERENCES `house_party`.`entregador` (`id_entregador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `house_party`.`produto_fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `house_party`.`produto_fornecedor` (
  `id_produto_fornecedor` INT NOT NULL,
  `id_fornecedor` INT NOT NULL,
  `id_produto` INT NOT NULL,
  PRIMARY KEY (`id_produto_fornecedor`, `id_fornecedor`, `id_produto`),
  INDEX `fk_fornecedor_has_produto_produto1_idx` (`id_produto` ASC) VISIBLE,
  INDEX `fk_fornecedor_has_produto_fornecedor_idx` (`id_fornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_fornecedor_has_produto_fornecedor`
    FOREIGN KEY (`id_fornecedor`)
    REFERENCES `house_party`.`fornecedor` (`id_fornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fornecedor_has_produto_produto1`
    FOREIGN KEY (`id_produto`)
    REFERENCES `house_party`.`produto` (`id_produto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `house_party`.`produto_categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `house_party`.`produto_categoria` (
  `id_categoria_produto` INT NOT NULL,
  `id_categoria` INT NOT NULL,
  `id_produto` INT NOT NULL,
  PRIMARY KEY (`id_categoria`, `id_produto`, `id_categoria_produto`),
  INDEX `fk_categoria_has_produto_produto1_idx` (`id_produto` ASC) VISIBLE,
  INDEX `fk_categoria_has_produto_categoria1_idx` (`id_categoria` ASC) VISIBLE,
  CONSTRAINT `fk_categoria_has_produto_categoria1`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `house_party`.`categoria` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_categoria_has_produto_produto1`
    FOREIGN KEY (`id_produto`)
    REFERENCES `house_party`.`produto` (`id_produto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `house_party`.`pedido_produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `house_party`.`pedido_produto` (
  `id_pedido_produto` INT NOT NULL,
  `id_pedido` INT NOT NULL,
  `id_produto` INT NOT NULL,
  `qtd_produto` INT NOT NULL,
  PRIMARY KEY (`id_pedido_produto`, `id_pedido`, `id_produto`),
  INDEX `fk_pedido_has_produto_produto1_idx` (`id_produto` ASC) VISIBLE,
  INDEX `fk_pedido_has_produto_pedido1_idx` (`id_pedido` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_has_produto_pedido1`
    FOREIGN KEY (`id_pedido`)
    REFERENCES `house_party`.`pedido` (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_has_produto_produto1`
    FOREIGN KEY (`id_produto`)
    REFERENCES `house_party`.`produto` (`id_produto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
