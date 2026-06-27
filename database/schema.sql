-- =============================================
-- PETSHELP - Banco de Dados
-- =============================================
-- Versão: 2.0
-- Data: 16/06/2026
-- =============================================

-- Criar o banco de dados
CREATE DATABASE IF NOT EXISTS petshelp;
USE petshelp;

-- =============================================
-- TABELA: ABRIGO
-- =============================================
CREATE TABLE IF NOT EXISTS abrigo (
    id_abrigo INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    cep VARCHAR(10),
    telefone VARCHAR(20),
    email VARCHAR(100),
    capacidade INT,
    quantidade_atual INT DEFAULT 0,
    ativo BOOLEAN DEFAULT TRUE,
    observacoes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- =============================================
-- TABELA: DOADOR
-- =============================================
CREATE TABLE IF NOT EXISTS doador (
    id_doador INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    tipo_doador ENUM('Física', 'Jurídica', 'Parceira') NOT NULL,
    data_cadastro DATE NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,
    receber_informativos BOOLEAN DEFAULT TRUE,
    observacao TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- =============================================
-- TABELA: DOACAO
-- =============================================
CREATE TABLE IF NOT EXISTS doacao (
    id_doacao INT AUTO_INCREMENT PRIMARY KEY,
    id_doador INT NOT NULL,
    id_abrigo INT NOT NULL,
    tipo_doacao ENUM('Financeira', 'Insumo', 'Serviço') NOT NULL,
    valor DECIMAL(10,2),
    descricao TEXT NOT NULL,
    quantidade INT,
    unidade_medida VARCHAR(20),
    destino ENUM('Abrigo', 'Evento', 'Adoção', 'Clínica') NOT NULL,
    data_doacao DATE NOT NULL,
    status ENUM('Pendente', 'Entregue', 'Cancelada', 'Em trânsito') DEFAULT 'Pendente',
    data_previsao_entrega DATE,
    data_entrega_realizada DATE,
    observacoes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_doador) REFERENCES doador(id_doador) ON DELETE CASCADE,
    FOREIGN KEY (id_abrigo) REFERENCES abrigo(id_abrigo) ON DELETE CASCADE
);

-- =============================================
-- TABELA: ANIMAL
-- =============================================
CREATE TABLE IF NOT EXISTS animal (
    id_animal INT AUTO_INCREMENT PRIMARY KEY,
    id_abrigo INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    especie ENUM('Cachorro', 'Gato', 'Pássaro', 'Outro') NOT NULL,
    raca VARCHAR(100),
    idade INT,
    sexo ENUM('Macho', 'Fêmea') NOT NULL,
    cor VARCHAR(50),
    porte ENUM('Pequeno', 'Médio', 'Grande'),
    data_entrada DATE NOT NULL,
    status ENUM('Disponível', 'Adotado', 'Em tratamento', 'Falecido') DEFAULT 'Disponível',
    observacoes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_abrigo) REFERENCES abrigo(id_abrigo) ON DELETE CASCADE
);

-- =============================================
-- TABELA ASSOCIATIVA: DOACAO_ANIMAL (N:N)
-- =============================================
CREATE TABLE IF NOT EXISTS doacao_animal (
    id_doacao INT NOT NULL,
    id_animal INT NOT NULL,
    quantidade INT DEFAULT 1,
    observacao TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_doacao, id_animal),
    FOREIGN KEY (id_doacao) REFERENCES doacao(id_doacao) ON DELETE CASCADE,
    FOREIGN KEY (id_animal) REFERENCES animal(id_animal) ON DELETE CASCADE
);

-- =============================================
-- TABELA: USUARIO
-- =============================================
CREATE TABLE IF NOT EXISTS usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha_hash VARCHAR(255) NOT NULL,
    perfil ENUM('Coordenador', 'Voluntário', 'Administrador') NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,
    ultimo_acesso TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- =============================================
-- DADOS DE EXEMPLO
-- =============================================

-- Inserir Abrigos
INSERT INTO abrigo (nome, endereco, cidade, estado, cep, telefone, email, capacidade, quantidade_atual) VALUES
('Abrigo Central', 'Rua das Flores, 123', 'São Paulo', 'SP', '01234-567', '(11) 99999-1111', 'abrigo.central@petshelp.org', 50, 35),
('Abrigo Zona Sul', 'Av. dos Animais, 456', 'São Paulo', 'SP', '04567-890', '(11) 99999-2222', 'abrigo.sul@petshelp.org', 30, 20);

-- Inserir Doadores
INSERT INTO doador (nome, cpf, email, telefone, tipo_doador, data_cadastro, ativo) VALUES
('Maria Silva', '123.456.789-00', 'maria@email.com', '(11) 99999-1111', 'Física', CURDATE(), TRUE),
('João Santos', '987.654.321-00', 'joao@email.com', '(11) 99999-2222', 'Física', CURDATE(), TRUE),
('Empresa Pet Love', '11.222.333/0001-44', 'contato@petlove.com', '(11) 99999-3333', 'Parceira', CURDATE(), TRUE);

-- Inserir Animais
INSERT INTO animal (id_abrigo, nome, especie, raca, idade, sexo, cor, porte, data_entrada, status) VALUES
(1, 'Rex', 'Cachorro', 'Labrador', 24, 'Macho', 'Caramelo', 'Grande', CURDATE(), 'Disponível'),
(1, 'Mia', 'Gato', 'Siamês', 12, 'Fêmea', 'Branco', 'Pequeno', CURDATE(), 'Disponível'),
(1, 'Bolt', 'Cachorro', 'Vira-lata', 6, 'Macho', 'Preto', 'Médio', CURDATE(), 'Em tratamento'),
(2, 'Luna', 'Gato', 'Persa', 18, 'Fêmea', 'Cinza', 'Pequeno', CURDATE(), 'Disponível');

-- Inserir Doações
INSERT INTO doacao (id_doador, id_abrigo, tipo_doacao, valor, descricao, quantidade, unidade_medida, destino, data_doacao, status) VALUES
(1, 1, 'Insumo', NULL, 'Ração Premium para cães adultos', 10, 'kg', 'Abrigo', CURDATE(), 'Entregue'),
(1, 1, 'Insumo', NULL, 'Medicamentos antipulgas', 5, 'unidades', 'Clínica', CURDATE(), 'Pendente'),
(2, 2, 'Financeira', 150.00, 'Doação mensal para manutenção', NULL, NULL, 'Abrigo', CURDATE(), 'Entregue'),
(3, 1, 'Insumo', NULL, 'Areia sanitária e brinquedos', 20, 'kg', 'Abrigo', CURDATE(), 'Em trânsito');

-- Inserir relação Doação-Animal
INSERT INTO doacao_animal (id_doacao, id_animal, quantidade) VALUES
(1, 1, 2), -- Ração para o Rex (2 pacotes)
(1, 2, 1), -- Ração para a Mia (1 pacote)
(2, 3, 1); -- Medicamento para o Bolt

-- Inserir Usuários
INSERT INTO usuario (nome, email, senha_hash, perfil, ativo) VALUES
('Brenda Lannig Costa', 'brendalannig@gmail.com', '$2b$10$hash-aqui', 'Administrador', TRUE);

-- =============================================
-- CONSULTAS DE EXEMPLO
-- =============================================

-- Listar todos os doadores ativos
SELECT * FROM doador WHERE ativo = TRUE;

-- Listar doações com nome do doador e abrigo
SELECT 
    d.id_doacao,
    do.nome AS doador,
    a.nome AS abrigo,
    d.tipo_doacao,
    d.valor,
    d.descricao,
    d.quantidade,
    d.status,
    d.data_doacao
FROM doacao d
JOIN doador do ON d.id_doador = do.id_doador
JOIN abrigo a ON d.id_abrigo = a.id_abrigo
ORDER BY d.data_doacao DESC;

-- Listar animais por abrigo
SELECT 
    a.nome AS abrigo,
    an.nome AS animal,
    an.especie,
    an.raca,
    an.status
FROM animal an
JOIN abrigo a ON an.id_abrigo = a.id_abrigo
ORDER BY a.nome, an.nome;

-- Relatório de doações por abrigo
SELECT 
    a.nome AS abrigo,
    COUNT(d.id_doacao) AS total_doacoes,
    SUM(CASE WHEN d.tipo_doacao = 'Financeira' THEN d.valor ELSE 0 END) AS total_financeiro
FROM doacao d
JOIN abrigo a ON d.id_abrigo = a.id_abrigo
GROUP BY a.id_abrigo;

-- Animais que receberam doações
SELECT 
    an.nome AS animal,
    COUNT(da.id_doacao) AS total_doacoes_recebidas
FROM animal an
LEFT JOIN doacao_animal da ON an.id_animal = da.id_animal
GROUP BY an.id_animal;