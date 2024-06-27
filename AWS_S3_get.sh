#!/bin/bash

AWS_BUCKET="bucket-name"
DEST_DIR="/path/to/destino"
BACKUP_DIR="/path/to/backup"
LOG_FILE="/path/to/log.txt"

aws s3 ls s3://$AWS_BUCKET > arquivos_encontrados.txt

NAMES_FILE="/path/to/arquivos_encontrados.txt"

while IFS= read -r line; do
    FILE_NAME=$(echo "$line" | awk '{print $4}')
    if [ -n "$FILE_NAME" ]; then
        aws s3 cp s3://$AWS_BUCKET/$FILE_NAME $DEST_DIR/$FILE_NAME
        cp $DEST_DIR/$FILE_NAME $BACKUP_DIR
        echo $FILE_NAME >> $NAMES_FILE
        aws s3 rm s3://$AWS_BUCKET/$FILE_NAME
        if [ $? -ne 0 ]; then
            echo "Falha ao deletar o arquivo $FILE_NAME"
        fi
    fi
done < arquivos_encontrados.txt

{
    echo "$(date) Arquivos encontrados e copiados:"
    cat $NAMES_FILE
} >> $LOG_FILE


