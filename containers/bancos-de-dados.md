# Bancos de Dados em Docker

MySQL 8.0, banco `escola`, usuário didático `aluno` e senha didática `aluno123`.
As credenciais são exclusivamente exemplos do exercício.

## Scripts
- `criar-tabelas.sql`: estudantes, disciplinas, notas e dados fictícios iniciais.
- `backup-banco.sh [container]`: gera dump e só informa sucesso se o comando terminar corretamente.
- `monitorar-mysql.sh [container]`: status, recursos, logs, conexão e disco.

No Bash do Ubuntu, a partir da raiz do projeto:
```bash
docker run -d --name mysql-estudos -e MYSQL_ROOT_PASSWORD=senha123 -e MYSQL_DATABASE=escola -e MYSQL_USER=aluno -e MYSQL_PASSWORD=aluno123 -p 127.0.0.1:3306:3306 mysql:8.0
docker logs mysql-estudos
# Execute após o banco estar pronto; a carga de exemplo deve ser aplicada uma vez.
docker exec -i mysql-estudos mysql -u aluno -paluno123 escola < scripts/criar-tabelas.sql
docker exec mysql-estudos mysql -u aluno -paluno123 escola -e 'SHOW TABLES; SELECT * FROM estudantes; SELECT e.nome, d.nome AS disciplina, n.nota FROM estudantes e JOIN notas n ON e.id=n.estudante_id JOIN disciplinas d ON n.disciplina_id=d.id;'
bash scripts/backup-banco.sh
bash scripts/monitorar-mysql.sh
```

O container isolado acima reproduz a tarefa 3 sem volume. Removê-lo apaga os dados de sua camada gravável; faça backup antes. O Compose usa um volume nomeado para persistência.

Execução e evidências pendentes.
