-- Init

USE dataia; 
SET sql_mode=(SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', '')); -- bricolage


-- -- Ex 1 : Combien de doublons ?

-- SELECT 
--     ID, count(ID)
-- FROM 
--     client_0 
-- GROUP BY 
--     ID 
-- HAVING 
--     count(*)>1;


-- -- Ex 2 : Supprimer les doublons

-- DROP TABLE IF EXISTS client_0_cp;
-- CREATE TABLE 
--     client_0_cp
-- LIKE
--     client_0;
-- INSERT INTO 
--     client_0_cp
-- SELECT 
--     * 
-- FROM 
--     client_0
-- GROUP BY
--     ID; -- grâce au bricolage
-- DROP TABLE 
--     client_0;
-- ALTER TABLE
--     client_0_cp
-- RENAME TO
--     client_0;
-- SELECT * FROM client_0 LIMIT 100;


-- -- Ex 3 : Trouver les vendeurs étrangers

-- SELECT 
--     COUNT(*)
-- FROM 
--     client_0
-- WHERE 
--     SELLER_COUNTRY <> 'FRANCE_ METROPOLITAN'
-- AND 
--     SELLER_COUNTRY <> 'GUYANA'
-- AND
--     SELLER_COUNTRY <> 'MARTINIQUE'
-- LIMIT
--     50
-- ;

-- SELECT * FROM client_0 GROUP BY SELLER_COUNTRY;

-- Ex 4 : Tables de vendeurs par origine

-- a) Vendeurs étrangers

DROP TABLE IF EXISTS vendeur1;
CREATE TABLE 
    vendeur1
LIKE 
    client_0;
INSERT INTO 
    vendeur1
SELECT 
    * 
FROM 
    client_0
WHERE 
    SELLER_COUNTRY <> 'FRANCE_ METROPOLITAN' 
AND 
    SELLER_COUNTRY <> 'GUYANA' 
AND 
    SELLER_COUNTRY <> 'MARTINIQUE';

-- b) Vendeurs français

DROP TABLE IF EXISTS vendeur2;
CREATE TABLE 
    vendeur2
LIKE 
    client_0;
INSERT INTO 
    vendeur2
SELECT 
    * 
FROM 
    client_0
WHERE 
    SELLER_COUNTRY = 'FRANCE_ METROPOLITAN'
OR
    SELLER_COUNTRY = 'GUYANA'
OR 
    SELLER_COUNTRY = 'MARTINIQUE'
;

-- c) Vendeurs français metropolitains

DROP TABLE IF EXISTS vendeur3;
CREATE TABLE 
    vendeur3
LIKE 
    client_0;
INSERT INTO 
    vendeur3
SELECT 
    * 
FROM 
    client_0
WHERE 
    SELLER_COUNTRY = 'FRANCE_ METROPOLITAN';



-- -- Ex5 : Probabilité d'avoir un bon score un lundi

-- Je démissionne de l'entreprise parce que mon patron me veut évidemment du mal.

-- -- Ex 6 : Total des achats par famille de produits

-- SELECT PRODUCT_FAMILY,
-- SUM(CASE
--         WHEN PURCHASE_COUNT = '50<100' THEN 75
--         WHEN PURCHASE_COUNT = '5<20' THEN 12.5
--         WHEN PURCHASE_COUNT = '20<50' THEN 35
--         WHEN PURCHASE_COUNT = '100<500' THEN 300
--         WHEN PURCHASE_COUNT = '>500' THEN 500
--         WHEN PURCHASE_COUNT = '<5' THEN 5
--     END) AS TOTAL_ACHATS_PAR_FAMILLE
-- FROM client_0
-- GROUP BY PRODUCT_FAMILY;

-- -- Ex 7 : Competition entre nationaux et étrangers
-- -- L'exercice qui m'a fait décider de mettre le repo github en privé parce que c'est vraiment sale

-- SELECT
--     (SELECT SUM(CASE
--         WHEN PURCHASE_COUNT = '50<100' THEN 75
--         WHEN PURCHASE_COUNT = '5<20' THEN 12.5
--         WHEN PURCHASE_COUNT = '20<50' THEN 35
--         WHEN PURCHASE_COUNT = '100<500' THEN 300
--         WHEN PURCHASE_COUNT = '>500' THEN 500
--         WHEN PURCHASE_COUNT = '<5' THEN 5
--     END) AS TOTAL_ACHATS_ETRANGERS
--         FROM client_0 
--         WHERE 
--             SELLER_COUNTRY <> 'FRANCE_ METROPOLITAN' 
--         AND 
--             SELLER_COUNTRY <> 'GUYANA' 
--         AND 
--             SELLER_COUNTRY <> 'MARTINIQUE') étrangers,

--     (SELECT SUM(CASE
        -- WHEN PURCHASE_COUNT = '50<100' THEN 75
        -- WHEN PURCHASE_COUNT = '5<20' THEN 12.5
        -- WHEN PURCHASE_COUNT = '20<50' THEN 35
        -- WHEN PURCHASE_COUNT = '100<500' THEN 300
        -- WHEN PURCHASE_COUNT = '>500' THEN 500
        -- WHEN PURCHASE_COUNT = '<5' THEN 5
--     END) AS TOTAL_ACHATS_ETRANGERS
--         FROM client_0 
--         WHERE 
--             SELLER_COUNTRY = 'FRANCE_ METROPOLITAN') français
-- ;


-- -- Ex 8 : Montant des types de produits par famille

-- DROP TABLE IF EXISTS produit_1;
-- CREATE TABLE produit_1 AS
--     SELECT
--         PRODUCT_TYPE,
--         PRODUCT_FAMILY,
--         SUM((CASE
--                         WHEN PURCHASE_COUNT = '50<100' THEN 75
--                         WHEN PURCHASE_COUNT = '5<20' THEN 12.5
--                         WHEN PURCHASE_COUNT = '20<50' THEN 35
--                         WHEN PURCHASE_COUNT = '100<500' THEN 300
--                         WHEN PURCHASE_COUNT = '>500' THEN 500
--                         WHEN PURCHASE_COUNT = '<5' THEN 5
--             END) * (CASE
--                         WHEN ITEM_PRICE = '<10' THEN 10
--                         WHEN ITEM_PRICE = '50<100' THEN 75
--                         WHEN ITEM_PRICE = '1000<5000' THEN 3000
--                         WHEN ITEM_PRICE = '100<500' THEN 300
--                         WHEN ITEM_PRICE = '10<20' THEN 15
--                         WHEN ITEM_PRICE = '20<50' THEN 35
--                         WHEN ITEM_PRICE = '500<1000' THEN 750
--                         WHEN ITEM_PRICE = '>5000' THEN 5000
--                     END)) AS TOTAL
--     FROM 
--         vendeur1
--     GROUP BY 
--         PRODUCT_TYPE,
--         PRODUCT_FAMILY
-- ;

-- -- Ex 9 : Même chose mais pour la table 2

-- DROP TABLE IF EXISTS produit_2;
-- CREATE TABLE produit_2 AS
--     SELECT
--         PRODUCT_TYPE,
--         PRODUCT_FAMILY,
--         SUM((CASE
--                         WHEN PURCHASE_COUNT = '50<100' THEN 75
--                         WHEN PURCHASE_COUNT = '5<20' THEN 12.5
--                         WHEN PURCHASE_COUNT = '20<50' THEN 35
--                         WHEN PURCHASE_COUNT = '100<500' THEN 300
--                         WHEN PURCHASE_COUNT = '>500' THEN 500
--                         WHEN PURCHASE_COUNT = '<5' THEN 5
--             END) * (CASE
--                         WHEN ITEM_PRICE = '<10' THEN 10
--                         WHEN ITEM_PRICE = '50<100' THEN 75
--                         WHEN ITEM_PRICE = '1000<5000' THEN 3000
--                         WHEN ITEM_PRICE = '100<500' THEN 300
--                         WHEN ITEM_PRICE = '10<20' THEN 15
--                         WHEN ITEM_PRICE = '20<50' THEN 35
--                         WHEN ITEM_PRICE = '500<1000' THEN 750
--                         WHEN ITEM_PRICE = '>5000' THEN 5000
--                     END)) AS TOTAL
--     FROM 
--         vendeur2
--     GROUP BY 
--         PRODUCT_TYPE,
--         PRODUCT_FAMILY
-- ;


-- -- Ex 10 : Les deux ensemble


DROP TABLE IF EXISTS produit_3;
CREATE TABLE produit_3 AS
    SELECT
        PRODUCT_TYPE,
        PRODUCT_FAMILY,
        SUM((CASE
                        WHEN PURCHASE_COUNT = '50<100' THEN 75
                        WHEN PURCHASE_COUNT = '5<20' THEN 12.5
                        WHEN PURCHASE_COUNT = '20<50' THEN 35
                        WHEN PURCHASE_COUNT = '100<500' THEN 300
                        WHEN PURCHASE_COUNT = '>500' THEN 500
                        WHEN PURCHASE_COUNT = '<5' THEN 5
            END) * (CASE
                        WHEN ITEM_PRICE = '<10' THEN 10
                        WHEN ITEM_PRICE = '50<100' THEN 75
                        WHEN ITEM_PRICE = '1000<5000' THEN 3000
                        WHEN ITEM_PRICE = '100<500' THEN 300
                        WHEN ITEM_PRICE = '10<20' THEN 15
                        WHEN ITEM_PRICE = '20<50' THEN 35
                        WHEN ITEM_PRICE = '500<1000' THEN 750
                        WHEN ITEM_PRICE = '>5000' THEN 5000
                    END)) AS TOTAL
    FROM 
        (SELECT 
            *
        FROM 
            vendeur1
        UNION ALL
        SELECT
            *
        FROM
            vendeur2) AS AUSECOURS
    GROUP BY PRODUCT_TYPE, PRODUCT_FAMILY;

    SELECT * FROM produit_3 LIMIT 500;
               
            
            
            )
