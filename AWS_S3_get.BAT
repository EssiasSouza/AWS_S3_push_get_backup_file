@echo off
setlocal enabledelayedexpansion

set AWS_BUCKET=bucket-name
set DEST_DIR=C:\destino
set BACKUP_DIR=C:\backup
set LOG_FILE=C:\log.txt
set NAMES_FILE=C:\nomes_arquivos.txt

aws s3 ls s3://%AWS_BUCKET% > arquivos.txt

for /f "tokens=*" %%i in (arquivos.txt) do (
    set FILE_NAME=%%i
    set FILE_NAME=!FILE_NAME:~31!
    if not "!FILE_NAME!"=="" (
        aws s3 cp s3://%AWS_BUCKET%/!FILE_NAME! %DEST_DIR%\!FILE_NAME!
        copy %DEST_DIR%\!FILE_NAME! %BACKUP_DIR%
        echo !FILE_NAME! >> %NAMES_FILE%
        aws s3 rm s3://%AWS_BUCKET%/!FILE_NAME!
        if errorlevel 1 (
            echo Falha ao deletar o arquivo !FILE_NAME!
        )
    )
)

echo %date% %time% >> %LOG_FILE%
echo Arquivos encontrados e copiados: >> %LOG_FILE%
type %NAMES_FILE% >> %LOG_FILE%
