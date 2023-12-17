-- @block
DROP DATABASE IF EXISTS setor_psicologia_ifce;

-- @block
CREATE TABLE IF NOT EXISTS projetos(
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50),
    turma VARCHAR(15),
    data DATE,
    execucao CHAR(5),

    PRIMARY KEY(id)
);

--@block
DROP TABLE IF EXISTS enderecos;
