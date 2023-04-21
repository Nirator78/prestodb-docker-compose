CREATE EXTERNAL TABLE IF NOT EXISTS election2022(
code_du_departement               string,
libelle_du_departement            string,
code_de_la_circonscription       string,
libelle_de_la_circonscription     string,
code_de_la_commune               string,
libelle_de_la_commune             string,
code_du_bvote                   string,
inscrits                         string,
abstentions                       string,
percent_abs_ins                        string,
votants                          string,
percent_vot_ins                         string,
blancs                           string,
percent_blancs_ins                     string,
percent_blancs_vot                      string,
nuls                             string,
percent_nuls_ins                       string,
percent_nuls_vot                       string,
exprimes                          string,
percent_exp_ins                        string,
percent_exp_vot                        string,
N_panneau                         string,
sexe                             string,
nom                              string,
prenom                           string,
voix                              string,
percent_voix_ins                       string,
percent_voix_exp                       string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES("separatorChar" = ";")
STORED AS TEXTFILE
LOCATION 'hdfs://namenode/user/hive/warehouse/test_db/csv_election_2022/'
TBLPROPERTIES ('skip.header.line.count' = '1')