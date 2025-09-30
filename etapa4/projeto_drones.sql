-- =========================
-- Criação das tabelas
-- =========================

DROP TABLE IF EXISTS relatorios;
DROP TABLE IF EXISTS dados;
DROP TABLE IF EXISTS missoes;
DROP TABLE IF EXISTS drones;
DROP TABLE IF EXISTS areas;
DROP TABLE IF EXISTS usuarios;

-- Usuários
CREATE TABLE usuarios (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    login TEXT UNIQUE NOT NULL,
    senha TEXT NOT NULL,
    perfil TEXT NOT NULL CHECK (perfil IN ('ADMIN', 'OPERADOR'))
);

-- Áreas agrícolas
CREATE TABLE areas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tamanho REAL NOT NULL,
    localizacao TEXT NOT NULL,
    tipo_cultivo TEXT NOT NULL
);

-- Drones
CREATE TABLE drones (
    id TEXT PRIMARY KEY,
    status TEXT NOT NULL CHECK (status IN ('DISPONIVEL', 'EM_MISSAO', 'MANUTENCAO')),
    bateria INTEGER NOT NULL CHECK (bateria BETWEEN 0 AND 100)
);

-- Missões
CREATE TABLE missoes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    data_hora TEXT NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('AGENDADA', 'EM_EXECUCAO', 'CONCLUIDA', 'CANCELADA')),
    sensores_usados TEXT,
    area_id INTEGER NOT NULL,
    drone_id TEXT NOT NULL,
    criada_por INTEGER NOT NULL,
    executada_por INTEGER,
    FOREIGN KEY (area_id) REFERENCES areas(id),
    FOREIGN KEY (drone_id) REFERENCES drones(id),
    FOREIGN KEY (criada_por) REFERENCES usuarios(id),
    FOREIGN KEY (executada_por) REFERENCES usuarios(id)
);

-- Dados coletados
CREATE TABLE dados (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    imagens TEXT,
    temperatura REAL,
    umidade REAL,
    pragas INTEGER CHECK (pragas IN (0,1)),
    missao_id INTEGER NOT NULL,
    FOREIGN KEY (missao_id) REFERENCES missoes(id)
);

-- Relatórios
CREATE TABLE relatorios (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    data_geracao TEXT NOT NULL,
    missao_id INTEGER NOT NULL,
    area_id INTEGER NOT NULL,
    FOREIGN KEY (missao_id) REFERENCES missoes(id),
    FOREIGN KEY (area_id) REFERENCES areas(id)
);

-- =========================
-- Restrição extra: não permitir missões sobrepostas no mesmo drone
-- =========================
CREATE UNIQUE INDEX IF NOT EXISTS ux_missoes_drone_data
ON missoes(drone_id, data_hora);

-- =========================
-- Inserts de exemplo
-- =========================

-- Usuários
INSERT INTO usuarios (nome, login, senha, perfil)
VALUES ('Gabriel Admin', 'gabriel_admin', '1234', 'ADMIN'),
       ('Kauan Operador', 'lucas_op', 'abcd', 'OPERADOR');

-- Áreas agrícolas
INSERT INTO areas (tamanho, localizacao, tipo_cultivo)
VALUES (120.5, 'Fazenda Das Vaquinhas', 'Soja'),
       (75.0, 'Sítio Sertão Bão', 'Milho');

-- Drones
INSERT INTO drones (id, status, bateria)
VALUES ('DRN001', 'DISPONIVEL', 95),
       ('DRN002', 'MANUTENCAO', 40);

-- Missão de exemplo
INSERT INTO missoes (data_hora, status, sensores_usados, area_id, drone_id, criada_por, executada_por)
VALUES ('2025-09-30 10:00:00', 'AGENDADA', 'TEMP,UMID,CAMERA', 1, 'DRN001', 1, 2);

-- Dados coletados
INSERT INTO dados (imagens, temperatura, umidade, pragas, missao_id)
VALUES ('img001.png', 28.5, 70.0, 0, 1),
       ('img002.png', 29.1, 65.2, 1, 1);

-- Relatório de exemplo
INSERT INTO relatorios (data_geracao, missao_id, area_id)
VALUES ('2025-09-30 12:00:00', 1, 1);
