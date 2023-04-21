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
),
croissance_population AS (
    SELECT
        code_postal,
        regr_slope(annee, nb_votants) AS croissance_population
    FROM
        votants_par_code_postal_par_annee
    GROUP BY
        1
),
prix_moyens_par_cp_et_annee AS (
    SELECT 
        code_postal,
        TRY_CAST(SUBSTRING(date_mutation, 1, 4) AS INT) AS anne_vente,
        AVG(
            TRY_CAST(valeur_fonciere AS REAL)
            /
            CASE WHEN 
                COALESCE(TRY_CAST(lot1_surface_carrez AS REAL), 0)
                + COALESCE(TRY_CAST(lot2_surface_carrez AS REAL), 0)
                + COALESCE(TRY_CAST(lot3_surface_carrez AS REAL), 0)
                + COALESCE(TRY_CAST(lot4_surface_carrez AS REAL), 0)
                + COALESCE(TRY_CAST(lot5_surface_carrez AS REAL), 0)
                <> 0 THEN
                COALESCE(TRY_CAST(lot1_surface_carrez AS REAL), 0)
                + COALESCE(TRY_CAST(lot2_surface_carrez AS REAL), 0)
                + COALESCE(TRY_CAST(lot3_surface_carrez AS REAL), 0)
                + COALESCE(TRY_CAST(lot4_surface_carrez AS REAL), 0)
                + COALESCE(TRY_CAST(lot5_surface_carrez AS REAL), 0)
                ELSE
                COALESCE(TRY_CAST(surface_reelle_bati AS REAL), 0)
            END
        )
        AS prix_moyen_au_m2
    FROM
        geo_dvf_data
    WHERE
        type_local IN ('Appartement', 'Maison')
    GROUP BY
        1, 2
),
croissance_prix AS (
    SELECT
        code_postal,
        regr_slope(anne_vente, prix_moyen_au_m2) AS croissance_prix
    FROM
        prix_moyens_par_cp_et_annee
    GROUP BY
        1
)
SELECT
    code_postal,
    croissance_prix - croissance_population AS difference_de_croissance
FROM
    croissance_prix
JOIN
    croissance_population USING(code_postal)
ORDER BY
    ABS(croissance_prix - croissance_population)
LIMIT 10;
