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


-- -- Ex 3 : Trouver les clients étrangers

-- SELECT 
--     COUNT(*)
-- FROM 
--     client_0
-- WHERE 
--     SELLER_COUNTRY <> 'FRANCE_ METROPOLITAN'
-- LIMIT
--     50
-- ;


-- -- Ex 4 : Tables de vendeurs par origine

-- -- a) Vendeurs étrangers

-- DROP TABLE IF EXISTS vendeur1;
-- CREATE TABLE 
--     vendeur1
-- LIKE 
--     client_0;
-- INSERT INTO 
--     vendeur1
-- SELECT 
--     * 
-- FROM 
--     client_0
-- WHERE 
--     SELLER_COUNTRY <> 'FRANCE_ METROPOLITAN' 
-- AND 
--     SELLER_COUNTRY <> 'GUYANA' 
-- AND 
--     SELLER_COUNTRY <> 'MARTINIQUE';

-- SELECT * FROM vendeur1 LIMIT 100;

-- -- b) Vendeurs français

-- DROP TABLE IF EXISTS vendeur2;
-- CREATE TABLE 
--     vendeur2
-- LIKE 
--     client_0;
-- INSERT INTO 
--     vendeur2
-- SELECT 
--     * 
-- FROM 
--     client_0
-- WHERE 
--     SELLER_COUNTRY = 'FRANCE_ METROPOLITAN'
-- OR
--     SELLER_COUNTRY = 'GUYANA'
-- OR 
--     SELLER_COUNTRY = 'MARTINIQUE'
-- ;

-- SELECT * FROM vendeur2 LIMIT 100;

-- -- c) Vendeurs français metropolitains

-- DROP TABLE IF EXISTS vendeur2;
-- CREATE TABLE 
--     vendeur3
-- LIKE 
--     client_0;
-- INSERT INTO 
--     vendeur3
-- SELECT 
--     * 
-- FROM 
--     client_0
-- WHERE 
--     SELLER_COUNTRY = 'FRANCE_ METROPOLITAN';

-- SELECT * FROM vendeur3 LIMIT 100;


-- -- Ex5 : Probabilité d'avoir un bon score un lundi

