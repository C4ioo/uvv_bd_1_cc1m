
CREATE TABLE cargos (
                id_cargo VARCHAR2(10) NOT NULL,
                cargo VARCHAR2(35) NOT NULL,
                salario_minimo NUMBER(8),
                salario_maximo NUMBER(8),
                CONSTRAINT ID_CARGO PRIMARY KEY (id_cargo)
);
COMMENT ON TABLE cargos IS 'Tabela de cargos.';
COMMENT ON COLUMN cargos.id_cargo IS 'Chave primária.';
COMMENT ON COLUMN cargos.cargo IS 'O nome do cargo no qual o empregado trabalhava.';
COMMENT ON COLUMN cargos.salario_minimo IS 'Salário minímo do cargo.';
COMMENT ON COLUMN cargos.salario_maximo IS 'Salário máximo para certo cargo.';


CREATE UNIQUE INDEX cargos_cargo_AK
 ON cargos
 ( cargo );

CREATE TABLE regioes (
                id_regiao NUMBER NOT NULL,
                nome VARCHAR2(25) NOT NULL,
                CONSTRAINT ID_REGIAO PRIMARY KEY (id_regiao)
);
COMMENT ON TABLE regioes IS 'Tabela regiões. Contém os números e nomes das regiões.';
COMMENT ON COLUMN regioes.id_regiao IS 'Chave primária da tabela regiões.';
COMMENT ON COLUMN regioes.nome IS 'Nome das regiões.';


CREATE UNIQUE INDEX regioes_nome_AK
 ON regioes
 ( nome );

CREATE TABLE paises (
                id_pais CHAR NOT NULL,
                nome VARCHAR2(50) NOT NULL,
                id_regiao NUMBER NOT NULL,
                CONSTRAINT ID_PAIS PRIMARY KEY (id_pais)
);
COMMENT ON TABLE paises IS 'Tabela com as informações dos países.';
COMMENT ON COLUMN paises.id_pais IS 'Chave primária da tabela países.';
COMMENT ON COLUMN paises.nome IS 'Nome dos países.';
COMMENT ON COLUMN paises.id_regiao IS 'Chave primária da tabela regiões.';


CREATE UNIQUE INDEX paises_nome_AK
 ON paises
 ( nome );

CREATE TABLE localizacoes (
                id_localizacao NUMBER NOT NULL,
                endereco VARCHAR2(50),
                cep VARCHAR2(12),
                cidade VARCHAR2(50),
                uf VARCHAR2(25),
                id_pais_FK CHAR NOT NULL,
                CONSTRAINT ID_LOCALIZACAO PRIMARY KEY (id_localizacao)
);
COMMENT ON TABLE localizacoes IS 'Tabela localizações. Contém os endereços de diversos escritórios e facilidades da empresa. Não armazena endereços de cliente.';
COMMENT ON COLUMN localizacoes.id_localizacao IS 'Chave primária da tabela.';
COMMENT ON COLUMN localizacoes.endereco IS 'da empresa.';
COMMENT ON COLUMN localizacoes.cep IS '.';
COMMENT ON COLUMN localizacoes.cidade IS 'da empresa.';
COMMENT ON COLUMN localizacoes.uf IS 'Estado onde está localizado a empresa.';
COMMENT ON COLUMN localizacoes.id_pais_FK IS 'Uma chave estrangeira da tabela países.';


CREATE TABLE departamentos (
                id_departamento NUMBER NOT NULL,
                nome VARCHAR2(50),
                id_localizacao NUMBER NOT NULL,
                id_gerente NUMBER NOT NULL,
                CONSTRAINT ID_DEPARTAMENTO PRIMARY KEY (id_departamento)
);
COMMENT ON TABLE departamentos IS 'Uma tabela com todas as informações dos departamentos da empresa.';
COMMENT ON COLUMN departamentos.id_departamento IS 'A chave primária da tabela.';
COMMENT ON COLUMN departamentos.nome IS 'Nomes no departamento da empresa.';
COMMENT ON COLUMN departamentos.id_localizacao IS 'ada por qual empregado, ou até gerente.';
COMMENT ON COLUMN departamentos.id_gerente IS 'Chave estrangeira da tabela localizações.';


CREATE UNIQUE INDEX departamentos_nome_AK
 ON departamentos
 ( nome );

CREATE TABLE empregados (
                id_empregado NUMBER NOT NULL,
                nome VARCHAR2(75) NOT NULL,
                email VARCHAR2(35) NOT NULL,
                telefone VARCHAR2(20),
                data_contratacao DATE NOT NULL,
                id_cargo VARCHAR2(10) NOT NULL,
                salario NUMBER(8),
                comissao NUMBER(4),
                id_departamento NUMBER NOT NULL,
                id_supervisor NUMBER NOT NULL,
                CONSTRAINT ID_EMPREGADO PRIMARY KEY (id_empregado)
);
COMMENT ON TABLE empregados IS 'A tabela que contém todas as informações dos empregados.';
COMMENT ON COLUMN empregados.id_empregado IS 'Chave primária.';
COMMENT ON COLUMN empregados.nome IS 'Nome dos empregados.';
COMMENT ON COLUMN empregados.email IS 'Email dos empregados.';
COMMENT ON COLUMN empregados.telefone IS 'Número de telefone dos empregados.';
COMMENT ON COLUMN empregados.data_contratacao IS 'Dia que o empresario entrou no cargo na empresa.';
COMMENT ON COLUMN empregados.id_cargo IS 'empregado.';
COMMENT ON COLUMN empregados.salario IS 'O salário atual do empregado.';
COMMENT ON COLUMN empregados.comissao IS 'Porcentagem de comissao do empregado.';
COMMENT ON COLUMN empregados.id_departamento IS 'partamento o empregado atua.';
COMMENT ON COLUMN empregados.id_supervisor IS 'Chave estrangeira da própria tabela(auto-relacionamento)';


CREATE UNIQUE INDEX empregados_email_AK
 ON empregados
 ( email );

CREATE TABLE historico_cargos (
                id_empregado NUMBER NOT NULL,
                data_inicial DATE NOT NULL,
                data_final DATE NOT NULL,
                id_cargo VARCHAR2(10) NOT NULL,
                id_departamento NUMBER NOT NULL,
                CONSTRAINT ID_EMPREGADO__PK_ PRIMARY KEY (id_empregado, data_inicial)
);
COMMENT ON TABLE historico_cargos IS 'Tabela que armazena o histórico de cargos de um empregado.';
COMMENT ON COLUMN historico_cargos.id_empregado IS 'Chave primária.';
COMMENT ON COLUMN historico_cargos.data_inicial IS 'a data que o empregado entrou no novo cargo.';
COMMENT ON COLUMN historico_cargos.data_final IS 'Mostra o último dia do empregado no cargo.';
COMMENT ON COLUMN historico_cargos.id_cargo IS 'egado trabalhava no passado.';
COMMENT ON COLUMN historico_cargos.id_departamento IS 'tamento no qual o empregado estava atuando.';


ALTER TABLE empregados ADD CONSTRAINT CARGOS_EMPREGADOS_FK
FOREIGN KEY (id_cargo)
REFERENCES cargos (id_cargo)
NOT DEFERRABLE;

ALTER TABLE historico_cargos ADD CONSTRAINT CARGOS_HISTORICO_CARGOS_FK
FOREIGN KEY (id_cargo)
REFERENCES cargos (id_cargo)
NOT DEFERRABLE;

ALTER TABLE paises ADD CONSTRAINT REGIOES_PAISES_FK
FOREIGN KEY (id_regiao)
REFERENCES regioes (id_regiao)
NOT DEFERRABLE;

ALTER TABLE localizacoes ADD CONSTRAINT PAISES_LOCALIZACOES_FK
FOREIGN KEY (id_pais_FK)
REFERENCES paises (id_pais)
NOT DEFERRABLE;

ALTER TABLE departamentos ADD CONSTRAINT LOCALIZACOES_DEPARTAMENTOS_FK
FOREIGN KEY (id_localizacao)
REFERENCES localizacoes (id_localizacao)
NOT DEFERRABLE;

ALTER TABLE empregados ADD CONSTRAINT DEPARTAMENTOS_EMPREGADOS_FK
FOREIGN KEY (id_departamento)
REFERENCES departamentos (id_departamento)
NOT DEFERRABLE;

ALTER TABLE historico_cargos ADD CONSTRAINT DEPARTAMENTOS_HISTORICO_CAR358
FOREIGN KEY (id_departamento)
REFERENCES departamentos (id_departamento)
NOT DEFERRABLE;

ALTER TABLE empregados ADD CONSTRAINT EMPREGADOS_EMPREGADOS_FK
FOREIGN KEY (id_supervisor)
REFERENCES empregados (id_empregado)
NOT DEFERRABLE;

ALTER TABLE departamentos ADD CONSTRAINT EMPREGADOS_DEPARTAMENTOS_FK
FOREIGN KEY (id_gerente)
REFERENCES empregados (id_empregado)
NOT DEFERRABLE;

ALTER TABLE historico_cargos ADD CONSTRAINT EMPREGADOS_HISTORICO_CARGOS_FK
FOREIGN KEY (id_empregado)
REFERENCES empregados (id_empregado)
NOT DEFERRABLE;
