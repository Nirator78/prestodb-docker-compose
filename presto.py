from pyhive import presto

# establish connection to Presto
conn = presto.connect(
    host='prestodb-coordinator',
    port=8080,
    catalog='hive',
)

# create cursor object
cursor = conn.cursor()

# execute query
query = open("./query_stat/requete_1.sql", "r").read()
cursor.execute(query)

# fetch results
results = cursor.fetchall()

# print results
print(results)