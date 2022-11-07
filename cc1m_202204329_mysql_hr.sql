
CREATE TABLE cargos (
                id_cargo VARCHAR(10) NOT NULL,
                cargo VARCHAR(35) NOT NULL,
                salario_minimo DECIMAL(8),
                salario_maximo DECIMAL(8),
                PRIMARY KEY (id_cargo)
);

ALTER TABLE cargos COMMENT 'Tabela de cargos.';

ALTER TABLE cargos MODIFY COLUMN id_cargo VARCHAR(10) COMMENT 'Chave primária.';

ALTER TABLE cargos MODIFY COLUMN cargo VARCHAR(35) COMMENT 'O nome do cargo no qual o empregado trabalhava.';

ALTER TABLE cargos MODIFY COLUMN salario_minimo DECIMAL(8) COMMENT 'Salário minímo do cargo.';

ALTER TABLE cargos MODIFY COLUMN salario_maximo DECIMAL(8) COMMENT 'Salário máximo para certo cargo.';


CREATE UNIQUE INDEX cargos_cargo_ak
 ON cargos
 ( cargo );

CREATE TABLE regioes (
                id_regiao INT NOT NULL,
                nome VARCHAR(25) NOT NULL,
                PRIMARY KEY (id_regiao)
);

ALTER TABLE regioes COMMENT 'Tabela regiões. Contém os números e nomes das regiões.';

ALTER TABLE regioes MODIFY COLUMN id_regiao INTEGER COMMENT 'Chave primária da tabela regiões.';

ALTER TABLE regioes MODIFY COLUMN nome VARCHAR(25) COMMENT 'Nome das regiões.';


CREATE UNIQUE INDEX regioes_nome_ak
 ON regioes
 ( nome );

CREATE TABLE paises (
                id_pais CHAR NOT NULL,
                nome VARCHAR(50) NOT NULL,
                id_regiao INT NOT NULL,
                PRIMARY KEY (id_pais)
);

ALTER TABLE paises COMMENT 'Tabela com as informações dos países.';

ALTER TABLE paises MODIFY COLUMN id_pais CHAR COMMENT 'Chave primária da tabela países.';

ALTER TABLE paises MODIFY COLUMN nome VARCHAR(50) COMMENT 'Nome dos países.';

ALTER TABLE paises MODIFY COLUMN id_regiao INTEGER COMMENT 'Chave primária da tabela regiões.';


CREATE UNIQUE INDEX paises_nome_ak
 ON paises
 ( nome );

CREATE TABLE localizacoes (
                id_localizacao INT NOT NULL,
                endereco VARCHAR(50),
                cep VARCHAR(12),
                cidade VARCHAR(50),
                uf VARCHAR(25),
                id_pais_FK CHAR NOT NULL,
                PRIMARY KEY (id_localizacao)
);

ALTER TABLE localizacoes COMMENT 'Tabela localizações. Contém os endereços de diversos escritórios e facilidades da empresa. Não armazena endereços de cliente.';

ALTER TABLE localizacoes MODIFY COLUMN id_localizacao INTEGER COMMENT 'Chave primária da tabela.';

ALTER TABLE localizacoes MODIFY COLUMN endereco VARCHAR(50) COMMENT 'da empresa.';

ALTER TABLE localizacoes MODIFY COLUMN cep VARCHAR(12) COMMENT '.';

ALTER TABLE localizacoes MODIFY COLUMN cidade VARCHAR(50) COMMENT 'da empresa.';

ALTER TABLE localizacoes MODIFY COLUMN uf VARCHAR(25) COMMENT 'Estado onde está localizado a empresa.';

ALTER TABLE localizacoes MODIFY COLUMN id_pais_FK CHAR COMMENT 'Uma chave estrangeira da tabela países.';


CREATE TABLE departamentos (
                id_departamento INT NOT NULL,
                nome VARCHAR(50),
                id_localizacao INT NOT NULL,
                id_gerente INT NOT NULL,
                PRIMARY KEY (id_departamento)
);

ALTER TABLE departamentos COMMENT 'Uma tabela com todas as informações dos departamentos da empresa.';

ALTER TABLE departamentos MODIFY COLUMN id_departamento INTEGER COMMENT 'A chave primária da tabela.';

ALTER TABLE departamentos MODIFY COLUMN nome VARCHAR(50) COMMENT 'Nomes no departamento da empresa.';

ALTER TABLE departamentos MODIFY COLUMN id_localizacao INTEGER COMMENT 'ada por qual empregado, ou até gerente.';

ALTER TABLE departamentos MODIFY COLUMN id_gerente INTEGER COMMENT 'Chave estrangeira da tabela localizações.';


CREATE UNIQUE INDEX departamentos_nome_ak
 ON departamentos
 ( nome );

CREATE TABLE empregados (
                id_empregado INT NOT NULL,
                nome VARCHAR(75) NOT NULL,
                email VARCHAR(35) NOT NULL,
                telefone VARCHAR(20),
                data_contratacao DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                salario DECIMAL(8),
                comissao DECIMAL(4),
                id_departamento INT NOT NULL,
                id_supervisor INT NOT NULL,
                PRIMARY KEY (id_empregado)
);

ALTER TABLE empregados COMMENT 'A tabela que contém todas as informações dos empregados.';

ALTER TABLE empregados MODIFY COLUMN id_empregado INTEGER COMMENT 'Chave primária.';

ALTER TABLE empregados MODIFY COLUMN nome VARCHAR(75) COMMENT 'Nome dos empregados.';

ALTER TABLE empregados MODIFY COLUMN email VARCHAR(35) COMMENT 'Email dos empregados.';

ALTER TABLE empregados MODIFY COLUMN telefone VARCHAR(20) COMMENT 'Número de telefone dos empregados.';

ALTER TABLE empregados MODIFY COLUMN data_contratacao DATE COMMENT 'Dia que o empresario entrou no cargo na empresa.';

ALTER TABLE empregados MODIFY COLUMN id_cargo VARCHAR(10) COMMENT 'empregado.';

ALTER TABLE empregados MODIFY COLUMN salario DECIMAL(8) COMMENT 'O salário atual do empregado.';

ALTER TABLE empregados MODIFY COLUMN comissao DECIMAL(4) COMMENT 'Porcentagem de comissao do empregado.';

ALTER TABLE empregados MODIFY COLUMN id_departamento INTEGER COMMENT 'partamento o empregado atua.';

ALTER TABLE empregados MODIFY COLUMN id_supervisor INTEGER COMMENT 'Chave estrangeira da própria tabela(auto-relacionamento)';


CREATE UNIQUE INDEX empregados_email_ak
 ON empregados
 ( email );

CREATE TABLE historico_cargos (
                id_empregado INT NOT NULL,
                data_inicial DATE NOT NULL,
                data_final DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                id_departamento INT NOT NULL,
                PRIMARY KEY (id_empregado, data_inicial)
);

ALTER TABLE historico_cargos COMMENT 'Tabela que armazena o histórico de cargos de um empregado.';

ALTER TABLE historico_cargos MODIFY COLUMN id_empregado INTEGER COMMENT 'Chave primária.';

ALTER TABLE historico_cargos MODIFY COLUMN data_inicial DATE COMMENT 'a data que o empregado entrou no novo cargo.';

ALTER TABLE historico_cargos MODIFY COLUMN data_final DATE COMMENT 'Mostra o último dia do empregado no cargo.';

ALTER TABLE historico_cargos MODIFY COLUMN id_cargo VARCHAR(10) COMMENT 'egado trabalhava no passado.';

ALTER TABLE historico_cargos MODIFY COLUMN id_departamento INTEGER COMMENT 'tamento no qual o empregado estava atuando.';


ALTER TABLE empregados ADD CONSTRAINT cargos_empregados_fk
FOREIGN KEY (id_cargo)
REFERENCES cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE historico_cargos ADD CONSTRAINT cargos_historico_cargos_fk
FOREIGN KEY (id_cargo)
REFERENCES cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE paises ADD CONSTRAINT regioes_paises_fk
FOREIGN KEY (id_regiao)
REFERENCES regioes (id_regiao)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE localizacoes ADD CONSTRAINT paises_localizacoes_fk
FOREIGN KEY (id_pais_FK)
REFERENCES paises (id_pais)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE departamentos ADD CONSTRAINT localizacoes_departamentos_fk
FOREIGN KEY (id_localizacao)
REFERENCES localizacoes (id_localizacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE empregados ADD CONSTRAINT departamentos_empregados_fk
FOREIGN KEY (id_departamento)
REFERENCES departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE historico_cargos ADD CONSTRAINT departamentos_historico_cargos_fk
FOREIGN KEY (id_departamento)
REFERENCES departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE empregados ADD CONSTRAINT empregados_empregados_fk
FOREIGN KEY (id_supervisor)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE departamentos ADD CONSTRAINT empregados_departamentos_fk
FOREIGN KEY (id_gerente)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE historico_cargos ADD CONSTRAINT empregados_historico_cargos_fk
FOREIGN KEY (id_empregado)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
