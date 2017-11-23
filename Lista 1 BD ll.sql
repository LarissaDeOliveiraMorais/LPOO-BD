CREATE SCHEMA IF NOT EXISTS `banco` DEFAULT CHARACTER SET utf8 ;
USE `banco` ;

-- -----------------------------------------------------
-- Table `banco`.`banco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banco`.`banco` (
  `codigo` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;

insert into banco (codigo,nome) values (1,'banco do brasil');
insert into banco (codigo,nome) values (4,'CEF');
-- -----------------------------------------------------
-- Table `banco`.`agencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banco`.`agencia` (
  `numero_agencia` INT NOT NULL,
  `cod_banco` INT NOT NULL,
  `endereco` VARCHAR(45) NULL,
  `banco_codigo` INT NOT NULL,
  PRIMARY KEY (`numero_agencia`, `banco_codigo`),
  INDEX `fk_agencia_banco_idx` (`banco_codigo` ASC),
  CONSTRAINT `fk_agencia_banco`
    FOREIGN KEY (`banco_codigo`)
    REFERENCES `banco`.`banco` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

insert into agencia (numero_agencia,cod_banco,endereco,banco_codigo) values (0562,1,'RuaJoaquimTeixeira Alves',1);
insert into agencia (numero_agencia,cod_banco,endereco,banco_codigo) values (1960,4,'Av.Marcelino Pires',4);
-- -----------------------------------------------------
-- Table `banco`.`conta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banco`.`conta` (
  `numero_conta` INT NOT NULL,
  `saldo` DOUBLE NULL,
  `tipo_conta` VARCHAR(45) NULL,
  `num_agencia` INT NULL,
  `agencia_numero_agencia` INT NOT NULL,
  `agencia_banco_codigo` INT NOT NULL,
  PRIMARY KEY (`numero_conta`, `agencia_numero_agencia`, `agencia_banco_codigo`),
  INDEX `fk_conta_agencia1_idx` (`agencia_numero_agencia` ASC, `agencia_banco_codigo` ASC),
  CONSTRAINT `fk_conta_agencia1`
    FOREIGN KEY (`agencia_numero_agencia` , `agencia_banco_codigo`)
    REFERENCES `banco`.`agencia` (`numero_agencia` , `banco_codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

insert into conta (numero_conta,saldo,tipo_conta,num_agencia,agencia_numero_agencia,agencia_banco_codigo) values (863402,763.05,'2',0562,0562,1);
insert into conta (numero_conta,saldo,tipo_conta,num_agencia,agencia_numero_agencia,agencia_banco_codigo) values (235847,3879.12,'1',3153,1960,4);
-- -----------------------------------------------------
-- Table `banco`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banco`.`cliente` (
  `cpf` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `sexo` VARCHAR(45) NULL,
  `endereco` VARCHAR(45) NULL,
  PRIMARY KEY (`cpf`))
ENGINE = InnoDB;

insert into cliente (cpf,nome,sexo,endereco) values (11223344,'Jeniffer B Souza','F','Rua Cuiaba, 1050');
insert into cliente (cpf,nome,sexo,endereco) values (66778899,'Caetano K Lima','M','Rua Ivinhema, 879');
insert into cliente (cpf,nome,sexo,endereco) values (55447733,'Silvia Macedo','F','Rua Estados Unidos, 735');
-- -----------------------------------------------------
-- Table `banco`.`historico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banco`.`historico` (
  `cpf_cliente` INT NOT NULL,
  `num_conta` INT NULL,
  `data_inicio` DATE NULL,
  `conta_numero_conta` INT NOT NULL,
  `cliente_cpf` INT NOT NULL,
  PRIMARY KEY (`cpf_cliente`, `conta_numero_conta`, `cliente_cpf`),
  INDEX `fk_historico_conta1_idx` (`conta_numero_conta` ASC),
  INDEX `fk_historico_cliente1_idx` (`cliente_cpf` ASC),
  CONSTRAINT `fk_historico_conta1`
    FOREIGN KEY (`conta_numero_conta`)
    REFERENCES `banco`.`conta` (`numero_conta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_historico_cliente1`
    FOREIGN KEY (`cliente_cpf`)
    REFERENCES `banco`.`cliente` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
 
insert into historico (cpf_cliente,num_conta,data_inicio,conta_numero_conta,cliente_cpf) values (11223344,235847,17/12/1997,235847,11223344);
insert into historico (cpf_cliente,num_conta,data_inicio,conta_numero_conta,cliente_cpf) values (66778899,235847,17/12/1997,235847,66778899);
insert into historico (cpf_cliente,num_conta,data_inicio,conta_numero_conta,cliente_cpf) values (55447733,863402,29/11/2010,863402,55447733);
 

-- -----------------------------------------------------
-- Table `banco`.`telefone_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banco`.`telefone_cliente` (
  `cpf_cli` INT NOT NULL,
  `telefone` INT NULL,
  `cliente_cpf` INT NOT NULL,
  PRIMARY KEY (`cpf_cli`, `cliente_cpf`),
  INDEX `fk_telefone_cliente_cliente1_idx` (`cliente_cpf` ASC),
  CONSTRAINT `fk_telefone_cliente_cliente1`
    FOREIGN KEY (`cliente_cpf`)
    REFERENCES `banco`.`cliente` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

insert into telefone_cliente (cpf_cli,telefone,cliente_cpf) values (11223344,31227788,11223344);
insert into telefone_cliente (cpf_cli,telefone,cliente_cpf) values (66778899,34239900,66778899);
insert into telefone_cliente (cpf_cli,telefone,cliente_cpf) values (55447733,81218833,55447733);

select * from 
-- -------------------------------------
-- Inserção nas Tabelas
-- -------------------------------------

-- -------------------------------------
-- Alterações e Consultas nas Tabelas
-- -------------------------------------
alter table CLIENTE ADD COLUMN Email VARCHAR(40); -- adiconando coluna email na tabela cliente

SELECT Cpf, Endereco 
FROM CLIENTE -- Cpf e endereço de Paulo
WHERE Nome='Paulo A Lima';

SELECT Numero_agencia, Endereco 
FROM AGENCIA as a JOIN BANCO as b ON a.Cod_banco=b.Codigo -- numero da agencia e endereço referente ao Banco do Brasil 
WHERE a.Cod_banco=4;

SELECT Numero_conta, Num_agencia, Nome -- nome, agencia e conta de cada cliente
FROM CLIENTE as cl JOIN HISTORICO as h ON cl.Cpf=h.Cpf_cliente JOIN CONTA as co ON h.Num_conta = co.Numero_conta;

SELECT * FROM CLIENTE as cl JOIN TELEFONE_CLIENTE as tc ON cl.Cpf=tc.Cpf_cli 
JOIN HISTORICO as h ON cl.Cpf=h.Cpf_cliente 
JOIN CONTA as co ON h.Num_conta=co.Numero_conta -- Todos os atributos de clientes masculinos
JOIN AGENCIA as ag ON co.Num_agencia=ag.Numero_agencia
JOIN BANCO as b ON ag.Cod_banco=b.Codigo 
WHERE cl.Sexo='M';

SELECT * FROM AGENCIA as ag JOIN BANCO as b ON ag.Cod_banco=b.Codigo 
WHERE ag.Numero_agencia=0562;-- Todos os atributos de Agencia e Banco

DELETE FROM CONTA WHERE Numero_conta='86340-2'; -- Escluir conta 86340-2

UPDATE AGENCIA SET Numero_agencia=6342 WHERE Numero_agencia=0562;

UPDATE CLIENTE SET Email='caetanolima@gmail.com' WHERE Nome='Caetano K Lima';

UPDATE CONTA SET Salario = 0.10*Salario WHERE Numero_conta='23584-7';
