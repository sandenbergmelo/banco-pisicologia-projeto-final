-- Criação do banco de dados e seleção
-- @block
DO
$$
BEGIN
    IF NOT EXISTS (
        SELECT FROM pg_database WHERE datname = 'setor_psicologia_ifce'
    ) THEN
        PERFORM dblink_exec('dbname=' || current_database(), 'CREATE DATABASE setor_psicologia_ifce');
    END IF;
END
$$;

-- @block
-- Criação de tabelas sem chaves estrangeiras
CREATE TABLE IF NOT EXISTS psicologos(
    crp CHAR(8) NOT NULL,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE,
    funcao VARCHAR(20),
    unidade_de_educacao VARCHAR(20),
    PRIMARY KEY(crp)
);

CREATE TABLE IF NOT EXISTS projetos(
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    turma VARCHAR(15),
    data DATE NOT NULL,
    status_execucao BOOLEAN
);

CREATE TABLE IF NOT EXISTS consultas(
    id SERIAL PRIMARY KEY,
    resumo TEXT,
    data_hora TIMESTAMP
);

CREATE TABLE IF NOT EXISTS denuncias(
    id SERIAL PRIMARY KEY,
    vitima VARCHAR(50) NOT NULL,
    agressor VARCHAR(50) NOT NULL,
    data_hora TIMESTAMP,
    descricao TEXT
);

CREATE TABLE IF NOT EXISTS violencia(
    id SERIAL PRIMARY KEY,
    tipo VARCHAR(20) NOT NULL,
    motivo_da_autoviolencia VARCHAR(20) NOT NULL,
    metodo_da_autoagressao VARCHAR(20),
    encaminhamento VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS dados_complementares(
    id SERIAL PRIMARY KEY,
    nome_social VARCHAR(50) NOT NULL,
    ocupacao VARCHAR(20),
    estado_civil VARCHAR(20) CHECK (estado_civil IN ('solteiro', 'casado', 'união estável', 'viúvo', 'separado', 'não se aplica', 'ignorado')),
    orientacao_sexual VARCHAR(20) CHECK (orientacao_sexual IN ('heterossexual', 'homossexual', 'bissexual', 'não se aplica', 'ignorado')),
    identidade_de_genero VARCHAR(20) CHECK (identidade_de_genero IN ('homem', 'mulher', 'travesti', 'mulher transexual', 'homem transexual', 'não se aplica', 'ignorado')),
    possui_deficiencia VARCHAR(20) CHECK (possui_deficiencia IN ('sim', 'não', 'ignorado')),
    tipo_deficiencia VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS pessoas_presentes(
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS outros_responsaveis(
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

-- @block
-- Tabelas com chaves estrangeiras
CREATE TABLE IF NOT EXISTS horarios(
    id SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fim TIME NOT NULL,
    local VARCHAR(20) CHECK (local IN ('areias', 'cajazeiras')),
    psicologo_crp CHAR(8) NOT NULL,
    CONSTRAINT FK_horarios_psicologos FOREIGN KEY(psicologo_crp) REFERENCES psicologos(crp)
);

CREATE TABLE IF NOT EXISTS estudantes(
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    curso VARCHAR(10) NOT NULL,
    semestre INT,
    data_de_nascimento DATE NOT NULL,
    raca_ou_cor VARCHAR(20) CHECK (raca_ou_cor IN ('preta', 'branca', 'parda', 'indígena', 'ignorado')),
    escolaridade VARCHAR(50) CHECK (escolaridade IN ('ensino fundamental completo',
                      'ensino médio incompleto',
                      'ensino médio completa',
                      'educação superior incompleta',
                      'educação superior completo',
                      'ignorado', 'não se aplica')),
    cartao_do_sus CHAR(11) UNIQUE,
    nome_da_mae VARCHAR(50),
    nome_do_responsavel VARCHAR(50),
    grau_de_parentesco_do_responsavel VARCHAR(20),
    dados_complementares_id INT NOT NULL,
    CONSTRAINT FK_dados_estudantes FOREIGN KEY(dados_complementares_id) REFERENCES dados_complementares(id)
);

CREATE TABLE IF NOT EXISTS enderecos(
    id SERIAL PRIMARY KEY,
    logradouro VARCHAR(80) NOT NULL,
    pais VARCHAR(30),
    municipio VARCHAR(80) NOT NULL,
    estado CHAR(2) NOT NULL,
    bairro VARCHAR(50),
    cep CHAR(8),
    numero CHAR(4) NOT NULL,
    distrito CHAR(40),
    zona VARCHAR(20) CHECK (zona IN ('rural', 'urbana')),
    complemento VARCHAR(50),
    telefone VARCHAR(11) NOT NULL,
    referencia VARCHAR(40),
    estudantes_id INT NOT NULL,
    CONSTRAINT FK_estudantes_enderecos FOREIGN KEY(estudantes_id) REFERENCES estudantes(id)
);

CREATE TABLE IF NOT EXISTS dados_da_ocorrencia(
    id SERIAL PRIMARY KEY,
    hora TIME NOT NULL,
    local VARCHAR(40) NOT NULL,
    ocorreu_outas_vezes VARCHAR(20) CHECK (ocorreu_outas_vezes IN ('sim', 'não', 'ignorado')),
    enderecos_id INT NOT NULL,
    violencia_id INT NOT NULL,
    CONSTRAINT FK_dados_enderecos FOREIGN KEY(enderecos_id) REFERENCES enderecos(id),
    CONSTRAINT FK_dados_violencia FOREIGN KEY(violencia_id) REFERENCES violencia(id)
);

CREATE TABLE IF NOT EXISTS fichas_de_notificacao(
    id SERIAL PRIMARY KEY,
    data_da_ocorrencia_de_violencia DATE NOT NULL,
    data_da_notificacao DATE NOT NULL,
    data_encaminhamento DATE,
    municipio_da_notificação VARCHAR(50),
    estado CHAR(2),
    campus VARCHAR(20) NOT NULL,
    psicologo_crp CHAR(8) NOT NULL,
    dados_da_ocorrencia_id INT NOT NULL,
    estudantes_id INT NOT NULL,
    CONSTRAINT FK_ficha_psicologos FOREIGN KEY(psicologo_crp) REFERENCES psicologos(crp),
    CONSTRAINT FK_ficha_dados_ocorrencia FOREIGN KEY(dados_da_ocorrencia_id) REFERENCES dados_da_ocorrencia(id),
    CONSTRAINT FK_ficha_estudantes FOREIGN KEY(estudantes_id) REFERENCES estudantes(id)
);

CREATE TABLE IF NOT EXISTS agendamentos(
    id SERIAL PRIMARY KEY,
    local VARCHAR(20) CHECK (local IN ('areias', 'cajazeiras')) NOT NULL,
    data_hora TIMESTAMP NOT NULL,
    estudantes_id INT NOT NULL,
    psicologo_crp CHAR(8) NOT NULL,
    consultas_id INT,
    CONSTRAINT FK_agendamentos_estudantes FOREIGN KEY(estudantes_id) REFERENCES estudantes(id),
    CONSTRAINT FK_agendamentos_psicologos FOREIGN KEY(psicologo_crp) REFERENCES psicologos(crp),
    CONSTRAINT FK_agendamentos_consultas FOREIGN KEY(consultas_id) REFERENCES consultas(id)
);

CREATE TABLE IF NOT EXISTS encaminhamentos(
    id SERIAL PRIMARY KEY,
    pra_quem VARCHAR(30) NOT NULL,
    motivo VARCHAR(20) NOT NULL,
    psicologo_crp CHAR(8) NOT NULL,
    estudantes_id INT NOT NULL,
    CONSTRAINT FK_encaminhamento_psicologos FOREIGN KEY(psicologo_crp) REFERENCES psicologos(crp),
    CONSTRAINT FK_encaminhamento_estudantes FOREIGN KEY(estudantes_id) REFERENCES estudantes(id)
);

CREATE TABLE IF NOT EXISTS fichas_de_orientacao_familiar(
    id SERIAL PRIMARY KEY,
    orientacao_realizada TEXT,
    data DATE NOT NULL,
    estudantes_id INT NOT NULL,
    psicologo_crp CHAR(8) NOT NULL,
    CONSTRAINT FK_fichas_familiares_estudantes FOREIGN KEY(estudantes_id) REFERENCES estudantes(id),
    CONSTRAINT FK_fichas_familiares_psicologos FOREIGN KEY(psicologo_crp) REFERENCES psicologos(crp)
);

-- @block
-- Tabelas pivô
CREATE TABLE IF NOT EXISTS pessoas_ficha_orientacao_familiar(
    fichas_de_orientacao_familiar_id INT NOT NULL,
    pessoas_presentes_id INT NOT NULL,
    PRIMARY KEY(fichas_de_orientacao_familiar_id, pessoas_presentes_id),
    CONSTRAINT FK_fichas_familiar_pessoas FOREIGN KEY(fichas_de_orientacao_familiar_id) REFERENCES fichas_de_orientacao_familiar(id),
    CONSTRAINT FK_pessoas_fichas_familiar FOREIGN KEY(pessoas_presentes_id) REFERENCES pessoas_presentes(id)
);

CREATE TABLE IF NOT EXISTS psicologos_em_projetos(
    projetos_id INT NOT NULL,
    psicologo_crp CHAR(8) NOT NULL,
    PRIMARY KEY(projetos_id, psicologo_crp),
    CONSTRAINT FK_projetos_psicologos FOREIGN KEY(projetos_id) REFERENCES projetos(id),
    CONSTRAINT FK_psicologos_projetos FOREIGN KEY(psicologo_crp) REFERENCES psicologos(crp)
);

CREATE TABLE IF NOT EXISTS outros_responsaveis_em_projetos(
    projetos_id INT NOT NULL,
    outros_responsaveis_id INT NOT NULL,
    PRIMARY KEY(projetos_id, outros_responsaveis_id),
    CONSTRAINT FK_projetos_outros_responsaveis FOREIGN KEY(projetos_id) REFERENCES projetos(id),
    CONSTRAINT FK_outros_responsaveis_projetos FOREIGN KEY(outros_responsaveis_id) REFERENCES outros_responsaveis(id)
);

CREATE TABLE IF NOT EXISTS estudantes_em_projetos(
    projetos_id INT NOT NULL,
    estudantes_id INT NOT NULL,
    PRIMARY KEY(projetos_id, estudantes_id),
    CONSTRAINT FK_projetos_estudantes FOREIGN KEY(projetos_id) REFERENCES projetos(id),
    CONSTRAINT FK_estudantes_projetos FOREIGN KEY(estudantes_id) REFERENCES estudantes(id)
);

CREATE TABLE IF NOT EXISTS denuncias_por_estudantes(
    estudantes_id INT NOT NULL,
    denuncias_id INT NOT NULL,
    PRIMARY KEY(estudantes_id, denuncias_id),
    CONSTRAINT FK_estudantes_denuncias FOREIGN KEY(estudantes_id) REFERENCES estudantes(id),
    CONSTRAINT FK_denuncias_estudantes FOREIGN KEY(denuncias_id) REFERENCES denuncias(id)
);
