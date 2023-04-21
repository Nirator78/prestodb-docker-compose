from pyhive import hive

# Connexion à Hive
conn = hive.connect(host='hive-server')
# Création du cursor
cursor = conn.cursor()
# Exécution de la requête de création de la database
cursor.execute("CREATE DATABASE IF NOT EXISTS test_db")
# Utilisation de la database
cursor.execute("USE test_db")
# Création de la table via le fichier
query = open("./requetes_utiles/create_election_2022.sql", "r").read()
cursor.execute(query)
# Fermeture de la connexion
conn.close()