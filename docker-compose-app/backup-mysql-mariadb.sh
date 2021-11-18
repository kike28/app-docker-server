#!/bin/bash -x 
  
# Declarando Variables
NOMBRE_CONTAINER="db_wp_prueba"
DB_NAME="exampledb"
DB_USER="exampleuser"
DB_PASS="examplepass"
BACKUP_DATE=`date +%d-%m-%Y-%H:%M:%S`
BACKUP_PATH="/opt/Backups/mysql"
BACKUP_RETENTION_DAYS="3"

# Crear Carpeta de Backup si no se encuentra
if [ ! -d $BACKUP_PATH ]; then
        mkdir -p $BACKUP_PATH
fi


# Comando de Backups de Base de datos Mysql, MariaDB.

docker exec -i $NOMBRE_CONTAINER /usr/bin/mysqldump -u$DB_USER -p$DB_PASS $DB_NAME | gzip -c - > $BACKUP_PATH/$DB_NAME-$BACKUP_DATE.sql.gz


## Backup retention clear
if [ $BACKUP_RETENTION_DAYS ]; then
        find $BACKUP_PATH -type f -mtime +$BACKUP_RETENTION_DAYS -exec rm {} \;
fi