CREATE EXTERNAL TABLE test_parquet (
id_mutation string,
date_mutation string,
numero_disposition string,
nature_mutation string,
valeur_fonciere string,
adresse_numero string,
adresse_suffixe string,
adresse_nom_voie string,
adresse_code_voie string,
code_postal string,
code_commune string,
nom_commune string,
code_departement string,
ancien_code_commune string,
ancien_nom_commune string,
id_parcelle string,
ancien_id_parcelle string,
numero_volume string,
lot1_numero string,
lot1_surface_carrez string,
lot2_numero string,
lot2_surface_carrez string,
lot3_numero string,
lot3_surface_carrez string,
lot4_numero string,
lot4_surface_carrez string,
lot5_numero string,
lot5_surface_carrez string,
nombre_lots string,
code_type_local string,
type_local string,
surface_reelle_bati string,
nombre_pieces_principales string,
code_nature_culture string,
nature_culture string,
code_nature_culture_speciale string,
nature_culture_speciale string,
surface_terrain string,
longitude string,
latitude string
)
STORED AS PARQUET
LOCATION 'hdfs://namenode/user/hive/warehouse/test_db/test_parquet/'