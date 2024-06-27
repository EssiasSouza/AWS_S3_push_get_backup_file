## Script Bash para Acessar e Manipular Arquivos em um Bucket S3 da AWS

Este script em bash permite acessar um bucket S3 da AWS, listar os arquivos disponíveis, fazer o download desses arquivos para uma pasta de destino e também criar um backup dos arquivos baixados em outra pasta. Após o download e backup, o script tenta deletar os arquivos no bucket S3. Em caso de falha na deleção, uma mensagem é registrada no log, mas o script continua executando até o final.

### Funcionalidades do Script

1. **Configuração de Variáveis:**
   - `AWS_BUCKET`: Nome do bucket S3 da AWS de onde os arquivos serão baixados.
   - `DEST_DIR`: Diretório local onde os arquivos serão salvos inicialmente.
   - `BACKUP_DIR`: Diretório local onde os arquivos também serão copiados como backup.
   - `LOG_FILE`: Caminho para o arquivo de log onde serão registradas informações sobre a execução do script.
   - `NAMES_FILE`: Caminho para o arquivo de texto onde serão registrados apenas os nomes dos arquivos baixados.

2. **Listagem de Arquivos:**
   - O script utiliza o comando `aws s3 ls s3://$AWS_BUCKET` para listar os arquivos no bucket S3 e redireciona a saída para o arquivo `arquivos.txt`.

3. **Iteração sobre os Arquivos Listados:**
   - Utilizando um loop `while` combinado com `read`, o script lê cada linha do arquivo `arquivos.txt` que contém a lista de arquivos no bucket S3.
   - Para cada linha, o script extrai o nome do arquivo usando `awk`.

4. **Download e Backup de Arquivos:**
   - O script faz o download do arquivo do bucket S3 para o diretório de destino (`DEST_DIR`) usando `aws s3 cp`.
   - Em seguida, cria um backup do arquivo baixado copiando-o para o diretório de backup (`BACKUP_DIR`) usando o comando `cp`.
   - Registra o nome do arquivo baixado no arquivo `NAMES_FILE`.

5. **Deleção de Arquivos no S3:**
   - Após o download e backup, o script tenta deletar o arquivo do bucket S3 utilizando `aws s3 rm`.
   - Caso a deleção falhe (verificado com `$? -ne 0`), uma mensagem de falha é registrada no log.

6. **Registro no Log:**
   - Ao final da execução do loop, o script registra no arquivo de log (`LOG_FILE`) a data e hora da execução, assim como os nomes dos arquivos que foram encontrados e copiados.

### Como Usar

1. **Pré-requisitos:**
   - Certifique-se de ter o AWS CLI configurado e autorizado para acessar o bucket S3 especificado.

2. **Configuração das Variáveis:**
   - Edite as variáveis `AWS_BUCKET`, `DEST_DIR`, `BACKUP_DIR`, `LOG_FILE` e `NAMES_FILE` conforme necessário para refletir o seu ambiente.

3. **Execução:**
   - Execute o script bash `script.sh` no terminal:
     ```
     ./script.sh
     ```

4. **Verificação:**
   - Verifique os arquivos baixados no diretório de destino e no diretório de backup especificados.
   - Confira o arquivo de log (`log.txt`) para detalhes sobre a execução do script.

Este script é útil para automação de tarefas envolvendo a manipulação de arquivos em um bucket S3 da AWS, facilitando o download, backup e gerenciamento dos arquivos localmente.
