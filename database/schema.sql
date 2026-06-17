-- PETSHELP - Banco de Dados

CREATE DATABASE IF NOT EXISTS petshelp;
USE petshelp;

-- Tabela Doador
CREATE TABLE IF NOT EXISTS doador (
    id_doador INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    tipo_doador ENUM('Física', 'Jurídica', 'Parceira') NOT NULL,
    data_cadastro DATE NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela Doacao
CREATE TABLE IF NOT EXISTS doacao (
    id_doacao INT AUTO_INCREMENT PRIMARY KEY,
    id_doador INT NOT NULL,
    tipo_doacao ENUM('Financeira', 'Insumo', 'Serviço') NOT NULL,
    valor DECIMAL(10,2),
    descricao TEXT NOT NULL,
    quantidade INT,
    status ENUM('Pendente', 'Entregue', 'Cancelada') DEFAULT 'Pendente',
    data_doacao DATE NOT NULL,
    FOREIGN KEY (id_doador) REFERENCES doador(id_doador)
);