WITH prix_moyens_par_cp_et_annee AS (
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
        test_db.geo_dvf_data
    WHERE
        type_local IN ('Appartement', 'Maison')
    GROUP BY
        1, 2
)
SELECT
    code_postal,
    regr_slope(anne_vente, prix_moyen_au_m2) AS croissance_prix
FROM
    prix_moyens_par_cp_et_annee
GROUP BY
    1
LIMIT 10;