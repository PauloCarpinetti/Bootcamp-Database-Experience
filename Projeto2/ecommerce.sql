CREATE DATABASE IF NOT EXISTS `e-commerce` DEFAULT CHARACTER SET utf8mb4 ;
USE `e-commerce` ;

CREATE TABLE IF NOT EXISTS `e-commerce`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Identificação` CHAR(11) NOT NULL,
  `Telefone` VARCHAR(45) NULL,
  `Pnome` VARCHAR(45) NOT NULL,
  `NomeMeioInicial` VARCHAR(3) NULL,
  `NomeFinal` VARCHAR(45) NULL,
  `Endereço` VARCHAR(45) NULL,
  `Data de nascimento` DATE NOT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `Documento_UNIQUE` (`Identificação` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `e-commerce`.`Produto` (
  `idProduto` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Preço` VARCHAR(45) NULL,
  `Fabricante` VARCHAR(45) NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `e-commerce`.`Entrega` (
  `idEntrega` INT NOT NULL,
  `Status` ENUM("Pendente", "Confirmado", "Encaminhado", "Entregue") NOT NULL,
  `Codigo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEntrega`),
  UNIQUE INDEX `idEntrega_UNIQUE` (`idEntrega` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `e-commerce`.`Pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `Descrição` VARCHAR(45) NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Status` ENUM("Em andamento", "processando", "Enviado", "Entregue") NULL,
  `Frete` FLOAT NULL,
  `Entrega_idEntrega` INT NOT NULL,
  `Data pedido` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPedido`, `Cliente_idCliente`, `Entrega_idEntrega`),
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Pedido_Entrega1_idx` (`Entrega_idEntrega` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `e-commerce`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Entrega1`
    FOREIGN KEY (`Entrega_idEntrega`)
    REFERENCES `e-commerce`.`Entrega` (`idEntrega`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `e-commerce`.`Pedido_tem_Produtos` (
  `Produto_idProduto` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Quantidade` VARCHAR(45) NOT NULL,
  `Status` ENUM("Em andamento", "processando", "Enviado", "Entregue") NULL,
  PRIMARY KEY (`Produto_idProduto`, `Pedido_idPedido`),
  INDEX `fk_Produto_has_Pedido_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  INDEX `fk_Produto_has_Pedido_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Pedido_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `e-commerce`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Pedido_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `e-commerce`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `e-commerce`.`Fornecedor` (
  `idFornecedor` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Telefone` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  PRIMARY KEY (`idFornecedor`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `e-commerce`.`Produto_has_Fornecedor` (
  `Produto_idProduto` INT NOT NULL,
  `Fornecedor_idFornecedor` INT NOT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Fornecedor_idFornecedor`),
  INDEX `fk_Produto_has_Fornecedor_Fornecedor1_idx` (`Fornecedor_idFornecedor` ASC) VISIBLE,
  INDEX `fk_Produto_has_Fornecedor_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Fornecedor_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `e-commerce`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Fornecedor_Fornecedor1`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `e-commerce`.`Fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `e-commerce`.`Terceiro - vendedor` (
  `idTerceiro - vendedor` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Telefone` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  PRIMARY KEY (`idTerceiro - vendedor`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `e-commerce`.`Terceiro - vendedor_has_Produto` (
  `Terceiro - vendedor_idTerceiro - vendedor` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  PRIMARY KEY (`Terceiro - vendedor_idTerceiro - vendedor`, `Produto_idProduto`),
  INDEX `fk_Terceiro - vendedor_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Terceiro - vendedor_has_Produto_Terceiro - vendedor1_idx` (`Terceiro - vendedor_idTerceiro - vendedor` ASC) VISIBLE,
  CONSTRAINT `fk_Terceiro - vendedor_has_Produto_Terceiro - vendedor1`
    FOREIGN KEY (`Terceiro - vendedor_idTerceiro - vendedor`)
    REFERENCES `e-commerce`.`Terceiro - vendedor` (`idTerceiro - vendedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Terceiro - vendedor_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `e-commerce`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `e-commerce`.`Estoque` (
  `idEstoque` INT NOT NULL,
  `Local` VARCHAR(45) NULL,
  PRIMARY KEY (`idEstoque`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `e-commerce`.`Em estoque` (
  `Produto_idProduto` INT NOT NULL,
  `Estoque_idEstoque` INT NOT NULL,
  `Quantidade` VARCHAR(45) NULL,
  PRIMARY KEY (`Produto_idProduto`, `Estoque_idEstoque`),
  INDEX `fk_Produto_has_Estoque_Estoque1_idx` (`Estoque_idEstoque` ASC) VISIBLE,
  INDEX `fk_Produto_has_Estoque_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Estoque_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `e-commerce`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Estoque_Estoque1`
    FOREIGN KEY (`Estoque_idEstoque`)
    REFERENCES `e-commerce`.`Estoque` (`idEstoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `e-commerce`.`Forma de pagamento` (
  `idForma de pagamento` INT NOT NULL,
  `Descrição` VARCHAR(45) NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Pedido_Cliente_idCliente` INT NOT NULL,
  `Pedido_Entrega_idEntrega` INT NOT NULL,
  PRIMARY KEY (`idForma de pagamento`, `Pedido_idPedido`, `Pedido_Cliente_idCliente`, `Pedido_Entrega_idEntrega`),
  INDEX `fk_Forma de pagamento_Pedido1_idx` (`Pedido_idPedido` ASC, `Pedido_Cliente_idCliente` ASC, `Pedido_Entrega_idEntrega` ASC) VISIBLE,
  CONSTRAINT `fk_Forma de pagamento_Pedido1`
    FOREIGN KEY (`Pedido_idPedido` , `Pedido_Cliente_idCliente` , `Pedido_Entrega_idEntrega`)
    REFERENCES `e-commerce`.`Pedido` (`idPedido` , `Cliente_idCliente` , `Entrega_idEntrega`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
