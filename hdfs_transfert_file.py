from hdfs import InsecureClient
import os

# Fichier ou l'on va récupérer les données
csv_data_directory = "./data/election2022"
# Node hdfs
client = InsecureClient('http://namenode:50070/')
# Création de l'arbo temporaire
client.makedirs('/user/hive/warehouse/temp/', permission=None)
# Création arbo de fichier
client.makedirs('/user/hive/warehouse/test_db/csv_election_2022/', permission=None)

# Boucle sur les fichiers
for filename in os.listdir(csv_data_directory):
    # Si fichier de type .csv
    if filename.endswith(".csv"):
        print(filename)
        filename = os.path.join(csv_data_directory, filename)
        # Upload dans le hdfs
        client.upload('/user/hive/warehouse/test_db/csv_election_2022/', filename, temp_dir='/user/hive/warehouse/temp/', overwrite=True)
        # client.delete("/user/hive/warehouse/test_db/csv_election_2022/resultats-par-niveau-burvot-t2-france-entiere.xlsx")
