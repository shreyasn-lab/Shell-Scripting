#!/bin/bash

# ===============================
# Configuration
# ===============================

# Directories you want to backup (space-separated)
BACKUP_DIRS="/home/shreyas-n/Desktop/Files"

# Backup storage location
BACKUP_DEST="/home/shreyas-n/backups"

# Number of daily backups to keep
RETENTION_DAYS=7

# Optional remote server details
REMOTE_USER="user"
REMOTE_HOST="host.example.com"
REMOTE_DEST="/remote/backup/path"

# Enable or disable remote backup
ENABLE_REMOTE=false

# ===============================
# Script starts
# ===============================

# Create backup destination if it doesn't exist
mkdir -p "$BACKUP_DEST"

# Create timestamp
TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')

# Name of backup file
BACKUP_FILE="$BACKUP_DEST/backup_$TIMESTAMP.tar.gz"

# Compress directories into backup file
tar -czf "$BACKUP_FILE" $BACKUP_DIRS

echo "Backup created: $BACKUP_FILE"

# ===============================
# Remove old backups (retention policy)
# ===============================

echo "Removing backups older than $RETENTION_DAYS days..."

find "$BACKUP_DEST" -type f -name "backup_*.tar.gz" -mtime +$RETENTION_DAYS -exec rm {} \;

# ===============================
# Optional: Copy backup to remote server via SSH
# ===============================

if [ "$ENABLE_REMOTE" = true ]; then
    echo "Copying backup to remote server..."
    scp "$BACKUP_FILE" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DEST"
    echo "Remote backup completed."
fi

echo "Backup script completed!"

