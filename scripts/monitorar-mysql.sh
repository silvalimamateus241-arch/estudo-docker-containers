#!/usr/bin/env bash
set -euo pipefail
container="${1:-mysql-estudos}"
echo '=== Status ==='
docker ps -a --filter "name=^/${container}$"
echo '=== Recursos ==='
docker stats "$container" --no-stream
echo '=== Últimos logs ==='
docker logs --tail 10 "$container"
echo '=== Conexão ==='
docker exec "$container" sh -c 'MYSQL_PWD="$MYSQL_PASSWORD" exec mysql -u"$MYSQL_USER" "$MYSQL_DATABASE" -e "SELECT 1 AS conexao_ok;"'
echo '=== Disco ==='
docker exec "$container" df -h
