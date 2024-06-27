import boto3
import sys

def download_file_from_s3(bucket_name, file_key, destination_path):
    s3 = boto3.client('s3')
    try:
        s3.download_file(bucket_name, file_key, destination_path)
        print(f'Arquivo baixado com sucesso: {destination_path}')
    except Exception as e:
        print(f'Erro ao baixar o arquivo: {e}')
        sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print('Uso: python download_s3_file.py bucket_name file_key destination_path')
        sys.exit(1)

    bucket_name = sys.argv[1]
    file_key = sys.argv[2]
    destination_path = sys.argv[3]

    download_file_from_s3(bucket_name, file_key, destination_path)

