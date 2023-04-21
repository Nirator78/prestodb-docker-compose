import os
from hdfs import InsecureClient

# Définition du dossier contenant les fichiers CSV
csv_data_directory = "./csv_data_directory"

# Connexion au HDFS local
client_hdfs = InsecureClient('http://localhost:50070')

# Chemin du dossier dans le HDFS
hdfs_directory = "/user/hive/warehouse/geo-dvf/"

# Vérification et création du dossier dans le HDFS
if not client_hdfs.status(hdfs_directory, strict=False):
    print(f"Creating directory {hdfs_directory}")
    client_hdfs.makedirs(hdfs_directory)
    
# Parcours des fichiers dans le dossier csv_data_directory
for filename in os.listdir(csv_data_directory):
    # On ne traite que les fichiers CSV
    if filename.endswith(".csv"):
        print("Uploading file", filename)
        # Chemin complet du fichier CSV à uploader
        local_path = os.path.join(csv_data_directory, filename)
        # Nom du fichier dans le HDFS avec ajout de l'année dans le nom
        hdfs_filename = filename[:-4] + ".csv"
        # Chemin complet du fichier dans le HDFS
        hdfs_path = os.path.join(hdfs_directory, hdfs_filename)
        # Upload du fichier dans le HDFS
        client_hdfs.upload(hdfs_path, local_path)
        print("File uploaded to", hdfs_path)