#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
container="${1:-mysql-estudos}"
mkdir -p backups
backup_file="backups/backup-escola-$(date +%Y%m%d-%H%M%S).sql"
tmp_file="${backup_file}.tmp"
trap 'rm -f -- "$tmp_file"' EXIT
docker exec "$container" sh -c 'MYSQL_PWD="$MYSQL_PASSWORD" exec mysqldump --no-tablespaces --single-transaction --set-gtid-purged=OFF -u"$MYSQL_USER" "$MYSQL_DATABASE"' > "$tmp_file"
test -s "$tmp_file"
mv -- "$tmp_file" "$backup_file"
printf 'Backup concluído: %s\n' "$backup_file"
ls -lh "$backup_file"
