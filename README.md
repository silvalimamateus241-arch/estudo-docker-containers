# Estudo Docker - Containers

## Sobre
**Autor:** Mateus Da Silva Lima  
**Curso:** Banco De Dados  
**Disciplina:** A confirmar  
**Data:** 07/10/2026

Estudo de imagens, containers, Dockerfile, MySQL e Docker Compose.

## Estrutura
- `containers/`: aplicação Nginx, Dockerfile e documentação de comandos/banco.
- `compose/`: aplicação Flask, template, Dockerfile, dependências e Compose.
- `scripts/`: SQL, backup e monitoramento.
- `evidencias/`: roteiro das capturas necessárias.

## Execução no Ubuntu/WSL
Instale Docker Engine e o plugin Compose conforme https://docs.docker.com/engine/install/ubuntu/.
Na raiz deste projeto:
```bash
docker run hello-world
docker run -it ubuntu:latest /bin/bash
# Dentro do container: ls -la; cat /etc/os-release; exit
docker build -t minha-webapp:1.0 containers
docker run -d -p 127.0.0.1:8080:80 --name meu-site minha-webapp:1.0
```
Abra http://localhost:8080 e salve a captura solicitada.
Siga `containers/bancos-de-dados.md` para a tarefa do MySQL isolado.

Para executar a aplicação completa:
```bash
docker compose -f compose/docker-compose.yml up --build -d
docker compose -f compose/docker-compose.yml ps
```
Abra http://localhost:8000, cadastre um estudante fictício e confirme sua presença na lista.
Para backup do banco do Compose: `bash scripts/backup-banco.sh db-escola`.
Para monitorar: `bash scripts/monitorar-mysql.sh db-escola`.
As senhas dos exemplos são didáticas, conforme o enunciado.

## Status real
- [x] Arquivos das tarefas 1 a 4 preparados.
- [ ] Docker instalado e hello-world executado.
- [ ] Nginx construído, executado e fotografado.
- [ ] MySQL, consultas, backup e monitoramento executados.
- [ ] Compose, cadastro e persistência testados.
- [ ] Capturas de tela adicionadas.
- [ ] Histórico de pelo menos 6 commits e publicação no GitHub.

O enunciado menciona “Tarefa 5” no checklist inicial, mas detalha apenas quatro tarefas práticas. A aplicação completa é a tarefa 4.

## Reflexão final
1. **Vantagem dos containers:** isolam dependências e permitem recriar o ambiente sem instalar cada servidor diretamente no sistema principal.
2. **Dockerfile:** é a receita de construção da imagem, com base, arquivos, dependências e comando de execução. Documenta como reproduzir o ambiente; fixar versões e digests aumenta a precisão dessa reprodução.
3. **Docker Compose:** é útil quando existem vários serviços relacionados, como aplicação e banco. Evita repetir longos comandos docker run e centraliza redes, volumes e dependências.
4. **Volumes:** preservam dados além da vida do container. Sem volume, remover o container elimina o que foi gravado apenas em sua camada gravável. Parar um container não apaga essa camada.
5. **Trabalho em equipe:** todos podem usar a mesma configuração de ambiente, reduzindo diferenças de versões e facilitando testes e integração.

## Entrega
Publicar no repositório público `estudo-docker-containers`, após completar os testes e evidências. A URL ainda não foi criada.
