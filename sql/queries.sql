-- @block
-- Consulta 1: Listar os psicólogos que estão disponíveis para consultas na próxima semana
SELECT psicologos.nome, horarios.data, horarios.hora_inicio, horarios.hora_fim
FROM psicologos
JOIN horarios ON psicologos.crp = horarios.psicologo_crp
WHERE horarios.data BETWEEN '2023-12-25' AND '2023-12-31';

-- @block
-- Consulta 2: Encontrar os projetos em andamento e seus respectivos estudantes
SELECT projetos.nome AS projeto, estudantes.nome AS estudante
FROM projetos
JOIN estudantes_em_projetos ON projetos.id = estudantes_em_projetos.projetos_id
JOIN estudantes ON estudantes_em_projetos.estudantes_id = estudantes.id
WHERE projetos.status_execucao = TRUE;

-- @block
-- Consulta 3: Contar o número de fichas de orientação familiar por psicólogo
SELECT psicologos.nome, COUNT(fichas_de_orientacao_familiar.id) AS num_fichas
FROM psicologos
JOIN fichas_de_orientacao_familiar ON psicologos.crp = fichas_de_orientacao_familiar.psicologo_crp
GROUP BY psicologos.crp;

-- @block
-- Consulta 4: Selecionar os estudantes que participaram de mais de um projeto
SELECT estudantes.nome, COUNT(estudantes_em_projetos.projetos_id) AS num_projetos
FROM estudantes
JOIN estudantes_em_projetos ON estudantes.id = estudantes_em_projetos.estudantes_id
GROUP BY estudantes.id
HAVING num_projetos > 1;

-- @block
-- Consulta 5: Listar os agendamentos de consultas com informações detalhadas
SELECT agendamentos.id, agendamentos.local, agendamentos.data_hora, psicologos.nome AS psicologo, estudantes.nome AS estudante
FROM agendamentos
JOIN psicologos ON agendamentos.psicologo_crp = psicologos.crp
JOIN estudantes ON agendamentos.estudantes_id = estudantes.id;
