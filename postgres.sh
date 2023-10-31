#!/bin/bash

# Psql database credentials
DB_NAME="db_name"
USERNAME="username"
DB_HOST="localhost"
DB_PORT="5432"

# Backup directory
BACKUP_DIR="/path/of/dump/"

# Current date and time
CURRENT_DATE=$(date +%Y-%m-%d_%H-%M-%S)

# Pg dump command
PGPASSWORD="yourpassword" pg_dump -h "$DB_HOST" -p "$DB_PORT" -U "$USERNAME" -d "$DB_NAME" > "$BACKUP_DIR/$DB_NAME_$CURRENT_DATE.sql"

# Compress the backup directory using gzip
gzip "$BACKUP_DIR/$DB_NAME_$CURRENT_DATE.sql"

# Delete backups older than 7 days
find $BACKUP_DIR -name "$DB_NAME*.sql" -type f -mtime +7 -exec rm {} \;
