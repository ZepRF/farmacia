CREATE DATABASE `farmacia` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
CREATE TABLE `procedimentos` (
  `id` int NOT NULL,
  `descricao` varchar(45),
  `tipo` int,
  `valor` decimal(9,2),
  PRIMARY KEY (`id`)
);

CREATE TABLE `servicos` (
  `id` int NOT NULL,
  `data` datetime ,
  `farmaceutico` varchar(50) ,
  `paciente` varchar(50) ,
  `valor_total` decimal(9,2),
  `observacoes` varchar(500) ,
  PRIMARY KEY (`id`)
);

CREATE TABLE `servicos_procedimentos` (
  `id` int NOT NULL,
  `id_servico` int,
  `id_procedimentos` int,
  PRIMARY KEY (`id`),
  KEY `fk_servicos_idx` (`id_servico`),
  KEY `fk_procedimentos_idx` (`id_procedimentos`),
  CONSTRAINT `fk_procedimentos` FOREIGN KEY (`id_procedimentos`) REFERENCES `procedimentos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_servicos` FOREIGN KEY (`id_servico`) REFERENCES `servicos` (`id`) ON DELETE CASCADE
);

INSERT INTO  procedimentos (id,descricao,tipo,valor) VALUES  (1,'Atenção farmacêutica domiciliar',0,100.0);
INSERT INTO  procedimentos (id,descricao,tipo,valor) VALUES  (2,'Aferição de pressão arterial',1,50.0);
INSERT INTO  procedimentos (id,descricao,tipo,valor) VALUES  (3,'Aferição de temperatura corporal',1,25.0);
INSERT INTO  procedimentos (id,descricao,tipo,valor) VALUES  (4,'Aferição de glicemia capilar',2,75.0);
INSERT INTO  procedimentos (id,descricao,tipo,valor) VALUES  (5,'Inalação',3,52.0);
INSERT INTO  procedimentos (id,descricao,tipo,valor) VALUES  (6,'Aplicação de injetáveis',3,50.0);