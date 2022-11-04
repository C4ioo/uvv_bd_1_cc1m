
CREATE TABLE cargos (
                id_cargo VARCHAR(10) NOT NULL,
                cargo VARCHAR(35) NOT NULL,
                salario_minimo NUMERIC(8),
                salario_maximo NUMERIC(8),
                CONSTRAINT id_cargo PRIMARY KEY (id_cargo)
);
COMMENT ON TABLE cargos IS 'Tabela de cargos.';
COMMENT ON COLUMN cargos.id_cargo IS 'Chave prim�ria.';
COMMENT ON COLUMN cargos.cargo IS 'O nome do cargo no qual o empregado trabalhava.';
COMMENT ON COLUMN cargos.salario_minimo IS 'Sal�rio min�mo do cargo.';
COMMENT ON COLUMN cargos.salario_maximo IS 'Sal�rio m�ximo para certo cargo.';


CREATE UNIQUE INDEX cargos_cargo_ak
 ON cargos
 ( cargo );

CREATE TABLE regioes (
                id_regiao INTEGER NOT NULL,
                nome VARCHAR(25) NOT NULL,
                CONSTRAINT id_regiao PRIMARY KEY (id_regiao)
);
COMMENT ON TABLE regioes IS 'Tabela regi�es. Cont�m os n�meros e nomes das regi�es.';
COMMENT ON COLUMN regioes.id_regiao IS 'Chave prim�ria da tabela regi�es.';
COMMENT ON COLUMN regioes.nome IS 'Nome das regi�es.';


CREATE UNIQUE INDEX regioes_nome_ak
 ON regioes
 ( nome );

CREATE TABLE paises (
                id_pais CHAR NOT NULL,
                nome VARCHAR(50) NOT NULL,
                id_regiao INTEGER NOT NULL,
                CONSTRAINT id_pais PRIMARY KEY (id_pais)
);
COMMENT ON TABLE paises IS 'Tabela com as informa��es dos pa�ses.';
COMMENT ON COLUMN paises.id_pais IS 'Chave prim�ria da tabela pa�ses.';
COMMENT ON COLUMN paises.nome IS 'Nome dos pa�ses.';
COMMENT ON COLUMN paises.id_regiao IS 'Chave prim�ria da tabela regi�es.';


CREATE UNIQUE INDEX paises_nome_ak
 ON paises
 ( nome );

CREATE TABLE localizacoes (
                id_localizacao INTEGER NOT NULL,
                endereco VARCHAR(50),
                cep VARCHAR(12),
                cidade VARCHAR(50),
                uf VARCHAR(25),
                id_pais_FK CHAR NOT NULL,
                CONSTRAINT id_localizacao PRIMARY KEY (id_localizacao)
);
COMMENT ON TABLE localizacoes IS 'Tabela localiza��es. Cont�m os endere�os de diversos escrit�rios e facilidades da empresa. N�o armazena endere�os de cliente.';
COMMENT ON COLUMN localizacoes.id_localizacao IS 'Chave prim�ria da tabela.';
COMMENT ON COLUMN localizacoes.endereco IS 'da empresa.';
COMMENT ON COLUMN localizacoes.cep IS '.';
COMMENT ON COLUMN localizacoes.cidade IS 'da empresa.';
COMMENT ON COLUMN localizacoes.uf IS 'Estado onde est� localizado a empresa.';
COMMENT ON COLUMN localizacoes.id_pais_FK IS 'Uma chave estrangeira da tabela pa�ses.';


CREATE TABLE departamentos (
                id_departamento INTEGER NOT NULL,
                nome VARCHAR(50),
                id_localizacao INTEGER NOT NULL,
                id_gerente INTEGER NOT NULL,
                CONSTRAINT id_departamento PRIMARY KEY (id_departamento)
);
COMMENT ON TABLE departamentos IS 'Uma tabela com todas as informa��es dos departamentos da empresa.';
COMMENT ON COLUMN departamentos.id_departamento IS 'A chave prim�ria da tabela.';
COMMENT ON COLUMN departamentos.nome IS 'Nomes no departamento da empresa.';
COMMENT ON COLUMN departamentos.id_localizacao IS 'ada por qual empregado, ou at� gerente.';
COMMENT ON COLUMN departamentos.id_gerente IS 'Chave estrangeira da tabela localiza��es.';


CREATE UNIQUE INDEX departamentos_nome_ak
 ON departamentos
 ( nome );

CREATE TABLE empregados (
                id_empregado INTEGER NOT NULL,
                nome VARCHAR(75) NOT NULL,
                email VARCHAR(35) NOT NULL,
                telefone VARCHAR(20),
                data_contratacao DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                salario NUMERIC(8),
                comissao NUMERIC(4),
                id_departamento INTEGER NOT NULL,
                id_supervisor INTEGER NOT NULL,
                CONSTRAINT id_empregado PRIMARY KEY (id_empregado)
);
COMMENT ON TABLE empregados IS 'A tabela que cont�m todas as informa��es dos empregados.';
COMMENT ON COLUMN empregados.id_empregado IS 'Chave prim�ria.';
COMMENT ON COLUMN empregados.nome IS 'Nome dos empregados.';
COMMENT ON COLUMN empregados.email IS 'Email dos empregados.';
COMMENT ON COLUMN empregados.telefone IS 'N�mero de telefone dos empregados.';
COMMENT ON COLUMN empregados.data_contratacao IS 'Dia que o empresario entrou no cargo na empresa.';
COMMENT ON COLUMN empregados.id_cargo IS 'empregado.';
COMMENT ON COLUMN empregados.salario IS 'O sal�rio atual do empregado.';
COMMENT ON COLUMN empregados.comissao IS 'Porcentagem de comissao do empregado.';
COMMENT ON COLUMN empregados.id_departamento IS 'partamento o empregado atua.';
COMMENT ON COLUMN empregados.id_supervisor IS 'Chave estrangeira da pr�pria tabela(auto-relacionamento)';


CREATE UNIQUE INDEX empregados_email_ak
 ON empregados
 ( email );

CREATE TABLE historico_cargos (
                id_empregado INTEGER NOT NULL,
                data_inicial DATE NOT NULL,
                data_final DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                id_departamento INTEGER NOT NULL,
                CONSTRAINT id_empregado__pk_ PRIMARY KEY (id_empregado, data_inicial)
);
COMMENT ON TABLE historico_cargos IS 'Tabela que armazena o hist�rico de cargos de um empregado.';
COMMENT ON COLUMN historico_cargos.id_empregado IS 'Chave prim�ria.';
COMMENT ON COLUMN historico_cargos.data_inicial IS 'a data que o empregado entrou no novo cargo.';
COMMENT ON COLUMN historico_cargos.data_final IS 'Mostra o �ltimo dia do empregado no cargo.';
COMMENT ON COLUMN historico_cargos.id_cargo IS 'egado trabalhava no passado.';
COMMENT ON COLUMN historico_cargos.id_departamento IS 'tamento no qual o empregado estava atuando.';


ALTER TABLE empregados ADD CONSTRAINT cargos_empregados_fk
FOREIGN KEY (id_cargo)
REFERENCES cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE historico_cargos ADD CONSTRAINT cargos_historico_cargos_fk
FOREIGN KEY (id_cargo)
REFERENCES cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE paises ADD CONSTRAINT regioes_paises_fk
FOREIGN KEY (id_regiao)
REFERENCES regioes (id_regiao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE localizacoes ADD CONSTRAINT paises_localizacoes_fk
FOREIGN KEY (id_pais_FK)
REFERENCES paises (id_pais)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE departamentos ADD CONSTRAINT localizacoes_departamentos_fk
FOREIGN KEY (id_localizacao)
REFERENCES localizacoes (id_localizacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE empregados ADD CONSTRAINT departamentos_empregados_fk
FOREIGN KEY (id_departamento)
REFERENCES departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE historico_cargos ADD CONSTRAINT departamentos_historico_cargos_fk
FOREIGN KEY (id_departamento)
REFERENCES departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE empregados ADD CONSTRAINT empregados_empregados_fk
FOREIGN KEY (id_supervisor)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE departamentos ADD CONSTRAINT empregados_departamentos_fk
FOREIGN KEY (id_gerente)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE historico_cargos ADD CONSTRAINT empregados_historico_cargos_fk
FOREIGN KEY (id_empregado)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
