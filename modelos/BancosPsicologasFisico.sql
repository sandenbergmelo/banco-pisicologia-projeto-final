/* BancosPsicologasLogico: */

CREATE TABLE fichas_de_orientacao_familiar (
    id INT AUTO_INCREMENT PRIMARY KEY,
    orientacao_realizada TEXT,
    data DATE,
    estudantes_id INT,
    psicologos_id VARCHAR
);

CREATE TABLE encaminhamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    para_quem VARCHAR,
    motivo VARCHAR,
    psicologos_id VARCHAR,
    estudantes_id INT
);

CREATE TABLE projetos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR,
    turma VARCHAR,
    data DATE,
    execucao CHAR
);

CREATE TABLE psicologos (
    email VARCHAR PRIMARY KEY,
    nome VARCHAR,
    funcao VARCHAR,
    unidade_de_educacao VARCHAR,
    horarios_id INT
);

CREATE TABLE horarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data_hora DATETIME,
    local VARCHAR,
    turno CHAR
);

CREATE TABLE agendamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    local VARCHAR,
    data_hora DATETIME,
    estudantes_id INT,
    psicologos_id VARCHAR,
    consultas_id INT
);

CREATE TABLE consultas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    resumo TEXT,
    data_e_hora DATETIME
);

CREATE TABLE estudantes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR,
    curso VARCHAR,
    semestre INT,
    data_de_nascimento DATE,
    raca_ou_cor ENUM,
    escolaridade ENUM,
    cartao_do_sus VARCHAR UNIQUE,
    nome_da_mae VARCHAR,
    nome_do_responsavel VARCHAR,
    grau_de_parentesco_do_responsavel VARCHAR,
    dados_complementares_id INT,
    enderecos_id INT,
    fichas_de_notificacao_id INT
);

CREATE TABLE dados_complementares (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_social VARCHAR,
    ocupacao VARCHAR,
    estado_civil ENUM,
    orientacao_sexual ENUM,
    identidade_de_genero ENUM,
    possui_deficiencia ENUM,
    qual_deficiencia ENUM
);

CREATE TABLE enderecos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    referencia VARCHAR,
    pais VARCHAR,
    cep VARCHAR,
    estado VARCHAR,
    zona ENUM,
    municipio VARCHAR,
    telefone VARCHAR,
    distrito VARCHAR,
    bairro VARCHAR,
    numero INT,
    complemento VARCHAR,
    lagradouro VARCHAR
);

CREATE TABLE denuncias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    vitima VARCHAR,
    agressor VARCHAR,
    data_hora DATETIME,
    descricao TEXT
);

CREATE TABLE fichas_de_notificacao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data_da_ocorrencia_da_violencia DATE,
    data_da_notificacao DATE,
    data_encaminhamento DATE,
    municipio_de_notificacao VARCHAR,
    estado VARCHAR,
    campus VARCHAR,
    tipo_de_notificacao ENUM,
    agravo_ou_doenca ENUM,
    unidade_notificadora ENUM,
    psicologos_id INT,
    estudantes_id INT,
    dados_da_ocorrencia_id INT
);

CREATE TABLE dados_da_ocorrencia (
    id INT AUTO_INCREMENT PRIMARY KEY,
    hora DATE,
    local ENUM,
    ocorreu_outras_vezes ENUM,
    enderecos_id INT,
    violencia_id INT
);

CREATE TABLE denuncias_estudantes (
    estudantes_id VARCHAR,
    denuncias_id INT,
    PRIMARY KEY (estudantes_id, denuncias_id)
);

CREATE TABLE projetos_estudantes (
    projetos_id INT,
    estudantes_id INT,
    PRIMARY KEY (projetos_id, estudantes_id)
);

CREATE TABLE projetos_psicologos (
    projetos_id INT,
    psicologos_id VARCHAR,
    PRIMARY KEY (psicologos_id, projetos_id)
);

CREATE TABLE autros_responsaveis_projetos (
    projetos_id INT,
    outros_responsaveis_id INT,
    PRIMARY KEY (outros_responsaveis_id, projetos_id)
);

CREATE TABLE outros_responsaveis (
    id INT PRIMARY KEY,
    nome VARCHAR
);

CREATE TABLE pessoas_presente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR
);

CREATE TABLE participam (
    fichas_de_orientacao_familiar_id INT AUTO_INCREMENT,
    pessoas_presente_id INT,
    PRIMARY KEY (pessoas_presente_id, fichas_de_orientacao_familiar_id)
);

CREATE TABLE violencia (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_de_violencia ENUM,
    motivo_da_autoviolencia ENUM,
    metodo_de_autoagressao ENUM,
    encaminhamento ENUM
);

ALTER TABLE fichas_de_orientacao_familiar ADD CONSTRAINT FK_fichas_de_orientacao_familiar_2
    FOREIGN KEY (estudantes_id???, psicologos_id???)
    REFERENCES ??? (???);

ALTER TABLE encaminhamentos ADD CONSTRAINT FK_encaminhamentos_2
    FOREIGN KEY (psicologos_id???, estudantes_id???)
    REFERENCES ??? (???);

ALTER TABLE encaminhamentos ADD CONSTRAINT FK_encaminhamentos_3
    FOREIGN KEY (motivo)
    REFERENCES psicologos (email);

ALTER TABLE psicologos ADD CONSTRAINT FK_psicologos_2
    FOREIGN KEY (horarios_id???)
    REFERENCES ??? (???);

ALTER TABLE agendamentos ADD CONSTRAINT FK_agendamentos_2
    FOREIGN KEY (estudantes_id???, psicologos_id???, consultas_id???)
    REFERENCES ??? (???);

ALTER TABLE estudantes ADD CONSTRAINT FK_estudantes_1
    FOREIGN KEY (dados_complementares_id???, enderecos_id???, fichas_de_notificacao_id???)
    REFERENCES ??? (???);

ALTER TABLE denuncias ADD CONSTRAINT FK_denuncias_1
    FOREIGN KEY (estudantes_id???)
    REFERENCES ??? (???);

ALTER TABLE fichas_de_notificacao ADD CONSTRAINT FK_fichas_de_notificacao_2
    FOREIGN KEY (psicologos_id???, estudantes_id???, dados_da_ocorrencia_id???)
    REFERENCES ??? (???);

ALTER TABLE dados_da_ocorrencia ADD CONSTRAINT FK_dados_da_ocorrencia_2
    FOREIGN KEY (enderecos_id???, violencia_id???)
    REFERENCES ??? (???);

ALTER TABLE denuncias_estudantes ADD CONSTRAINT FK_denuncias_estudantes_1
    FOREIGN KEY (estudantes_id???, denuncias_id???)
    REFERENCES ??? (???);

ALTER TABLE projetos_estudantes ADD CONSTRAINT FK_projetos_estudantes_2
    FOREIGN KEY (estudantes_id???, projetos_id???)
    REFERENCES ??? (???);

ALTER TABLE projetos_psicologos ADD CONSTRAINT FK_projetos_psicologos_2
    FOREIGN KEY (projetos_id???, psicologos_id???)
    REFERENCES ??? (???);

ALTER TABLE autros_responsaveis_projetos ADD CONSTRAINT FK_autros_responsaveis_projetos_2
    FOREIGN KEY (outros_responsaveis_id)
    REFERENCES outros_responsaveis (id);

ALTER TABLE autros_responsaveis_projetos ADD CONSTRAINT FK_autros_responsaveis_projetos_3
    FOREIGN KEY (projetos_id???)
    REFERENCES ??? (???);

ALTER TABLE participam ADD CONSTRAINT FK_participam_1
    FOREIGN KEY (fichas_de_orientacao_familiar_id)
    REFERENCES fichas_de_orientacao_familiar (id);

ALTER TABLE participam ADD CONSTRAINT FK_participam_2
    FOREIGN KEY (pessoas_presente_id???)
    REFERENCES ??? (???);
