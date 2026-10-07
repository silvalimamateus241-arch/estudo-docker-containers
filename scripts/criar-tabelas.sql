-- Script de criação de tabelas para o banco escola
USE escola;

-- Tabela de estudantes
CREATE TABLE IF NOT EXISTS estudantes (
	id INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	curso VARCHAR(50) NOT NULL,
	data_matricula DATE NOT NULL,
	ativo BOOLEAN DEFAULT TRUE
);

-- Tabela de disciplinas
CREATE TABLE IF NOT EXISTS disciplinas (
	id INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	codigo VARCHAR(20) UNIQUE NOT NULL,
	carga_horaria INT NOT NULL,
	professor VARCHAR(100)
);

-- Tabela de notas
CREATE TABLE IF NOT EXISTS notas (
	id INT AUTO_INCREMENT PRIMARY KEY,
	estudante_id INT,
	disciplina_id INT,
	nota DECIMAL(5,2),
	data_avaliacao DATE,
	FOREIGN KEY (estudante_id) REFERENCES estudantes(id),
	FOREIGN KEY (disciplina_id) REFERENCES disciplinas(id)
);

-- Inserindo dados de exemplo
INSERT INTO estudantes (nome, email, curso, data_matricula) VALUES
('Ana Silva', 'ana@exemplo.com', 'Informática', '2024-02-01'),
('João Santos', 'joao@exemplo.com', 'Informática', '2024-02-01'),
('Maria Oliveira', 'maria@exemplo.com', 'Administração', '2024-02-15');

INSERT INTO disciplinas (nome, codigo, carga_horaria, professor) VALUES
('Programação Web', 'PROG001', 80, 'Prof. Carlos'),
('Banco de Dados', 'BD001', 60, 'Prof. Ana'),
('Sistemas Operacionais', 'SO001', 70, 'Prof. Roberto');

INSERT INTO notas (estudante_id, disciplina_id, nota, data_avaliacao) VALUES
(1, 1, 8.5, '2024-03-15'),
(1, 2, 9.0, '2024-03-20'),
(2, 1, 7.5, '2024-03-15'),
(3, 3, 8.0, '2024-03-25');

-- Verificar dados inseridos
SELECT 'Dados inseridos com sucesso!' as status;
