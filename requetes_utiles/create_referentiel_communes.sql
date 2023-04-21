CREATE EXTERNAL TABLE test_db.referentiel_communes(
code_insee string,
code_postal string,
commune string,
departement string,
region string,
statut string,
altitude_moyenne string,
superficie string,
population string,
geo_point_2d string,
geo_shape string,
id_geofla string,
code_commune string,
code_canton string,
code_arrondissement string,
code_departement string,
code_region string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' WITH SERDEPROPERTIES("serialization.encoding"='UTF-8', "separatorChar" = ";")
STORED AS TEXTFILE
LOCATION 'hdfs://namenode/user/hive/warehouse/test_db/referentiel_communes/'
TBLPROPERTIES ('skip.header.line.count' = '1')