#!/bin/bash

# Backup directory path
BACKUP_DIR="/path/of/dump/"

#Username and Password
USERNAME="admin"
PASSWORD="Password"

# MongoDB host and port
MONGO_HOST="localhost"
MONGO_PORT="27017"

# Database name to be backed up
DB_NAME="db_name"

# Timestamp for the backup file
TIMESTAMP=$(date +%Y%m%d%H%M%S)

# Create a new backup directory for the current timestamp
BACKUP_PATH="$BACKUP_DIR/backup_$TIMESTAMP"
mkdir -p "$BACKUP_PATH"

# Take MongoDB backup using mongodump command
mongodump --host "$MONGO_HOST" --port "$MONGO_PORT" --db "$DB_NAME" --out "$BACKUP_PATH" --username "$USERNAME" --password "$PASSWORD"

# Compress the backup directory using tar
tar -czvf "$BACKUP_PATH.tar.gz" "$BACKUP_PATH"
# Delete the uncompressed backup directory
rm -rf "$BACKUP_PATH"

# Delete backups older than 10 days
find "$BACKUP_DIR" -type f -name "*.tar.gz" -mtime +10 -exec rm -f {} \;
