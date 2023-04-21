WITH votants_par_code_insee_par_annee AS (
    SELECT
        2017 AS annee,
        CONCAT(code_du_departement, code_de_la_commune) code_insee,
        SUM(TRY_CAST(inscrits AS INT)) nb_votants
    FROM
        elections_2017
    GROUP BY
        1, 2

    UNION ALL

    SELECT
        2022 AS annee,
        CONCAT(code_du_departement, code_de_la_commune) code_insee,
        SUM(TRY_CAST(inscrits AS INT)) nb_votants
    FROM
        elections_2022
    GROUP BY
        1, 2
),
votants_par_code_postal_par_annee AS (
    SELECT
        annee,
        code_postal,
        nb_votants
    FROM
        votants_par_code_insee_par_annee
    JOIN
        referentiel_communes
    USING(code_insee)
)
SELECT
    code_postal,
    regr_slope(annee, nb_votants) AS croissance_population
FROM
    votants_par_code_postal_par_annee
GROUP BY
    1
LIMIT 10;
