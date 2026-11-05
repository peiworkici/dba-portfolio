#!/bin/bash
BACKUP_DIR="$HOME/dba-portfolio/project-02/backup"
DATE=$(date +"%Y%m%d_%H%M%S")
mkdir -p "$BACKUP_DIR"
sudo -u postgres pg_dump -Fc ecommerce \
-f "$BACKUP_DIR/ecommerce_$DATE.backup"

if [ $? -eq 0 ];then
	echo "Backup completed successfully: $DATE"
else
	echo "Backup failed"
	exit 1
fi
