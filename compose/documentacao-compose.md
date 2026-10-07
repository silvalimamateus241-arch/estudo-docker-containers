# Tarefa 4 - Docker Compose

Compose define e gerencia os serviços da aplicação em um arquivo YAML.

## Serviços criados
- `app`: Python/Flask na porta 8000, construída com Dockerfile. Conecta a `db` pela rede interna.
- `db`: MySQL 8.0. O volume `db_data` preserva os dados; o SQL é executado na primeira inicialização de um volume vazio.
- O healthcheck consulta a tabela estudantes antes de liberar a inicialização da aplicação.

## Como executar
Na raiz: `docker compose -f compose/docker-compose.yml up --build -d`.
Abra http://localhost:8000, confira os estudantes e cadastre um novo estudante fictício.
Confira os logs com `docker compose -f compose/docker-compose.yml logs`.
`stop` e `start` param e iniciam os serviços existentes; `down` remove containers e redes, preservando o volume nomeado. `down -v` também apaga o volume e seus dados.

## Vantagens
Configuração centralizada, rede interna, persistência e reprodução do ambiente com um comando.

## Ajustes no exemplo
A porta do Dockerfile e da documentação foi alinhada a 8000; a aplicação aguarda a saúde do banco. O backup corrige o argumento da senha e não anuncia sucesso em caso de falha. O campo obsoleto `version` foi omitido do Compose.

## Evidência
Pendente: executar com Docker e salvar `screenshot-compose-app.png` nesta pasta. Nenhuma captura foi simulada.

Referência: https://docs.docker.com/compose/how-tos/startup-order/
