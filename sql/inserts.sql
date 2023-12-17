--@block
-- Tabelas sem chaves estrangeiras
INSERT INTO psicologos (crp, nome, email, funcao, unidade_de_educacao) VALUES
('11111111', 'Maria Oliveira', 'maria.oliveira@email.com', 'Psicóloga', 'Setor A'),
('22222222', 'João Silva', 'joao.silva@email.com', 'Psicólogo', 'Setor B'),
('33333333', 'Amanda Santos', 'amanda.santos@email.com', 'Psicóloga', 'Setor C');

INSERT INTO projetos (nome, turma, data, status_execucao) VALUES
('Projeto X', 'Turma 1A', '2023-01-15', true),
('Projeto Y', 'Turma 2B', '2023-02-20', false),
('Projeto Z', 'Turma 3C', '2023-03-25', true);

INSERT INTO consultas (resumo, data_hora) VALUES
('Consulta 1 - Resumo', '2023-03-01 10:00:00'),
('Consulta 2 - Resumo', '2023-03-02 15:30:00'),
('Consulta 3 - Resumo', '2023-03-03 12:45:00');

INSERT INTO denuncias (vitima, agressor, data_hora, descricao) VALUES
('Vítima 1', 'Agressor 1', '2023-04-10 14:00:00', 'Descrição da denúncia 1'),
('Vítima 2', 'Agressor 2', '2023-04-15 16:30:00', 'Descrição da denúncia 2'),
('Vítima 3', 'Agressor 3', '2023-05-01 09:30:00', 'Descrição da denúncia 3');

INSERT INTO enderecos (logradouro, pais, municipio, estado, bairro, cep, numero, distrito, zona, complemento, telefone, referencia) VALUES
('Rua Principal', 'Brasil', 'Cidade A', 'CE', 'Bairro Central', '12345678', '100', 'Distrito 1', 'urbana', 'Complemento A', '12345678901', 'Próximo à Praça'),
('Avenida Secundária', 'Brasil', 'Cidade B', 'SP', 'Bairro Sul', '87654321', '200', 'Distrito 2', 'rural', 'Complemento B', '98765432109', 'Ao lado do Mercado'),
('Travessa do Centro', 'Brasil', 'Cidade C', 'RJ', 'Bairro Norte', '56789012', '300', 'Distrito 3', 'urbana', 'Complemento C', '34567890123', 'Próximo à Escola');

INSERT INTO violencia (tipo, motivo_da_autoviolencia, metodo_da_autoagressao, encaminhamento) VALUES
('Tipo A', 'Motivo 1', 'Método 1', 'Encaminhamento 1'),
('Tipo B', 'Motivo 2', 'Método 2', 'Encaminhamento 2'),
('Tipo C', 'Motivo 3', 'Método 3', 'Encaminhamento 3');

INSERT INTO dados_complementares (nome_social, ocupacao, estado_civil, orientacao_sexual, identidade_de_genero, possui_deficiencia, tipo_deficiencia) VALUES
('Nome Social 1', 'Ocupação 1', 'casado', 'heterossexual', 'homem', 'sim', 'Deficiência 1'),
('Nome Social 2', 'Ocupação 2', 'solteiro', 'homossexual', 'mulher', 'não', NULL),
('Nome Social 3', 'Ocupação 3', 'casado', 'bissexual', 'travesti', 'não', NULL);

INSERT INTO pessoas_presentes (nome) VALUES
('Pessoa 1'),
('Pessoa 2'),
('Pessoa 3');

INSERT INTO outros_responsaveis (nome) VALUES
('Responsável 1'),
('Responsável 2'),
('Responsável 3');


-- @block
-- Tabelas com chaves estrangeiras
INSERT INTO horarios (data, hora_inicio, hora_fim, local, psicologo_crp) VALUES
('2023-12-27', '09:00:00', '11:00:00', 'areias', '11111111'),
('2023-06-02', '14:30:00', '16:30:00', 'cajazeiras', '22222222'),
('2023-06-03', '10:00:00', '12:00:00', 'areias', '33333333');

INSERT INTO dados_da_ocorrencia (hora, local, ocorreu_outas_vezes, enderecos_id, violencia_id) VALUES
('12:30:00', 'Local Ocorrência 1', 'sim', 1, 1),
('18:45:00', 'Local Ocorrência 2', 'não', 2, 2),
('14:00:00', 'Local Ocorrência 3', 'sim', 3, 3);

INSERT INTO estudantes (nome, curso, semestre, data_de_nascimento, raca_ou_cor, escolaridade, cartao_do_sus, nome_da_mae, nome_do_responsavel, grau_de_parentesco_do_responsavel, dados_complementares_id, enderecos_id) VALUES
('Estudante 1', 'Curso 1', 3, '1998-02-15', 'preta', 'educação superior completo', '12345678901', 'Mãe 1', 'Responsável 1', 'Pai', 1, 1),
('Estudante 2', 'Curso 2', 2, '1999-05-20', 'parda', 'educação superior incompleta', '98765432109', 'Mãe 2', 'Responsável 2', 'Mãe', 2, 2),
('Estudante 3', 'Curso 3', 4, '1997-09-10', 'branca', 'educação superior completo', '56789012345', 'Mãe 3', 'Responsável 3', 'Pai', 3, 3);

INSERT INTO fichas_de_notificacao (data_da_ocorrencia_de_violencia, data_da_notificacao, data_encaminhamento, municipio_da_notificação, estado, campus, psicologo_crp, dados_da_ocorrencia_id, estudantes_id) VALUES
('2023-07-01', '2023-07-05', '2023-07-10', 'Cidade A', 'CE', 'Campus X', '11111111', 1, 1),
('2023-07-02', '2023-07-06', '2023-07-12', 'Cidade B', 'SP', 'Campus Y', '22222222', 2, 2),
('2023-07-03', '2023-07-07', '2023-07-14', 'Cidade C', 'RJ', 'Campus Z', '33333333', 3, 3);

INSERT INTO agendamentos (local, data_hora, estudantes_id, psicologo_crp, consultas_id) VALUES
('areias', '2023-08-01 14:00:00', 1, '11111111', 1),
('cajazeiras', '2023-08-02 09:30:00', 2, '22222222', 2),
('areias', '2023-08-03 16:30:00', 3, '33333333', 3);

INSERT INTO encaminhamentos (pra_quem, motivo, psicologo_crp, estudantes_id) VALUES
('Encaminhamento 1', 'Motivo 1', '11111111', 1),
('Encaminhamento 2', 'Motivo 2', '22222222', 2),
('Encaminhamento 3', 'Motivo 3', '33333333', 3);

INSERT INTO fichas_de_orientacao_familiar (orientacao_realizada, data, estudantes_id, psicologo_crp) VALUES
('Orientação realizada para a família do estudante 1.', '2023-09-01', 1, '11111111'),
('Orientação realizada para a família do estudante 2.', '2023-09-02', 2, '22222222'),
('Orientação realizada para a família do estudante 3.', '2023-09-03', 3, '33333333');


--@block
-- Tabelas pivô
INSERT INTO pessoas_ficha_orientacao_familiar (fichas_de_orientacao_familiar_id, pessoas_presentes_id) VALUES
(1, 1),
(1, 2),
(2, 2),
(3, 1),
(3, 3);

INSERT INTO psicologos_em_projetos (projetos_id, psicologo_crp) VALUES
(1, '11111111'),
(2, '22222222'),
(3, '33333333');

INSERT INTO responsaveis_em_projetos (projetos_id, outros_responsaveis_id) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO estudantes_em_projetos (projetos_id, estudantes_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(2, 3);

INSERT INTO denuncias_por_estudantes (estudantes_id, denuncias_id) VALUES
(1, 1),
(2, 2),
(3, 3);
