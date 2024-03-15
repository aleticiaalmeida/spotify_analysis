SELECT * FROM pop_spotify;

-- Renomeando a tabela
ALTER TABLE popular_spotify_songs
RENAME TO pop_spotify;


-- Renomeando colunas com caracteres especiais
ALTER TABLE pop_spotify
CHANGE COLUMN `danceability_%` danceability VARCHAR(255),
CHANGE COLUMN `valence_%` valence VARCHAR(255),
CHANGE COLUMN `energy_%` energy VARCHAR(255),
CHANGE COLUMN `acousticness_%` acousticness VARCHAR(255),
CHANGE COLUMN `instrumentalness_%` instrumentalness VARCHAR(255),
CHANGE COLUMN `liveness_%` liveness VARCHAR(255),
CHANGE COLUMN `speechiness_%` speechiness VARCHAR(255);


-- Contando a quantidade de artistas: 365 artistas
SELECT
	COUNT(DISTINCT artist_name)
FROM pop_spotify;


-- Contando a quantidade de músicas - erro
SELECT
	COUNT(DISTINCT track_name)
FROM pop_spotify;


-- Resolvendo erros
SHOW COLUMNS FROM pop_spotify;

FLUSH TABLES pop_spotify;

ALTER TABLE pop_spotify
CHANGE COLUMN `﻿track_name` track_name TEXT;


-- Contando a quantidade de músicas na tabela: 627 músicas
SELECT
	COUNT(DISTINCT track_name)
FROM pop_spotify;



-- Contando a quantidade de lançamentos por ano
SELECT
	released_year,
    COUNT(released_year) AS 'count_released_year'
FROM pop_spotify
GROUP BY released_year
ORDER BY count_released_year DESC;


-- Contando a quantidade de lançamentos por mês
SELECT
	released_month,
    MONTHNAME(CONCAT('2022-', released_month, '-01')) AS 'month_name',
    COUNT(released_year) AS 'count_released_month'
FROM pop_spotify
GROUP BY released_month
ORDER BY count_released_month DESC;



-- Máximo e mínimo de streams
SELECT
	MAX(streams) AS max_streams,
    MIN(streams) AS min_streams
FROM pop_spotify;


-- Música com o maior e menor número de streams
(
    SELECT
        track_name,
        artist_name,
        streams
    FROM
        pop_spotify
    ORDER BY
        streams DESC
    LIMIT 1
)
UNION ALL
(
    SELECT
        track_name,
        artist_name,
        streams
    FROM
        pop_spotify
    ORDER BY
        streams ASC
    LIMIT 1
);





-- 10 músicas mais populares
SELECT
	track_name,
    artist_name,
    released_year,
    streams
FROM pop_spotify
ORDER BY streams DESC
LIMIT 10;



-- Artistas com mais músicas populares na plataforma
SELECT
	artist_name,
    COUNT(artist_name) AS count_artist_name
FROM pop_spotify
GROUP BY artist_name
ORDER BY count_artist_name DESC
LIMIT 5;



-- Música mais antiga: The Christmas Song (Merry Christmas To You) - Remastered 1999 - Nat King Cole - 1946 - 389771964 streams
SELECT
	track_name,
    artist_name,
    released_year,
    streams
FROM pop_spotify
ORDER BY released_year
LIMIT 1;




-- Música mais recente: Seven (feat. Latto) (Explicit Ver.),"Latto -  Jung Kook"" - 2023 - 141381703 streams
SELECT
	track_name,
    artist_name,
    released_year,
    streams
FROM pop_spotify
ORDER BY released_year DESC
LIMIT 1;




-- Total de streams por artista (todos os anos somados): Taylor Swift e The Weeknd lideram
SELECT DISTINCT
	artist_name,
    SUM(streams) AS total_streams
FROM pop_spotify
GROUP BY 
	artist_name
ORDER BY total_streams DESC;




-- Soma de artistas em playlists: Taylor Swift lidera nas playlists da Apple e Spotify, mas Bruno Mars lidera no Deezer
SELECT
	artist_name,
    SUM(in_spotify_playlists) AS artist_spotify,
    SUM(in_apple_playlists) AS artist_apple,
    SUM(in_deezer_playlists) AS artist_deezer
FROM pop_spotify
GROUP BY artist_name
ORDER BY artist_deezer DESC;



-- Músicas que estão presentes em todas as playlists analisadas na tabela: 600 faixas (94%)
SELECT
	track_name,
    artist_name,
    released_year
FROM pop_spotify
WHERE
	in_spotify_playlists IS NOT NULL
    AND in_spotify_playlists > 0
    AND in_apple_playlists IS NOT NULL
    AND in_apple_playlists > 0
    AND in_deezer_playlists IS NOT NULL
    AND in_deezer_playlists > 0;





-- Avaliando alguns pontos da estrutura da música:

-- Contando quantidade de músicas em tom maior ou menor
SELECT
	mode,
    COUNT(mode) AS count_mode
FROM pop_spotify
GROUP BY mode;


-- Contando streams dos modos maior e menor
SELECT
	mode,
    COUNT(mode) AS count_mode,
    SUM(streams) total_streams
FROM pop_spotify
GROUP BY 
	mode;
    



-- Estrutura das 10 faixas mais tocadas
SELECT
	track_name,
	artist_name,
    SUM(streams) AS total_streams,
    mode,
    bpm,
	danceability,
    valence,
    energy,
    acousticness,
    instrumentalness,
    liveness,
    speechiness
FROM pop_spotify
GROUP BY 
	track_name,
	artist_name,
    mode,
    bpm,
	danceability,
    valence,
    energy,
    acousticness,
    instrumentalness,
    liveness,
    speechiness
ORDER BY total_streams DESC
LIMIT 10;


CREATE VIEW estrutura AS
SELECT
	track_name,
	artist_name,
    SUM(streams) AS total_streams,
    mode,
    bpm,
	danceability,
    valence,
    energy,
    acousticness,
    instrumentalness,
    liveness,
    speechiness
FROM pop_spotify
GROUP BY 
	track_name,
	artist_name,
    mode,
    bpm,
	danceability,
    valence,
    energy,
    acousticness,
    instrumentalness,
    liveness,
    speechiness
ORDER BY total_streams DESC
LIMIT 10;


SELECT * FROM estrutura_top10;




-- Comparativo geral vs. top 10
-- Dançabilidade
SELECT
	maxdance_geral,
    maxdance_top10,
    mindance_geral,
    mindance_top10,
    avgdance_geral,
    avgdance_top10	
FROM
	(SELECT MAX(danceability) AS maxdance_geral FROM pop_spotify) AS max_geral,
	(SELECT MAX(danceability) AS maxdance_top10 FROM estrutura_top10) AS max_top10,
    (SELECT MIN(danceability) AS mindance_geral FROM pop_spotify) AS min_geral,
    (SELECT MIN(danceability) AS mindance_top10 FROM estrutura_top10) AS min_top10,
    (SELECT AVG(danceability) AS avgdance_geral FROM pop_spotify) AS avg_geral,
    (SELECT AVG(danceability) AS avgdance_top10 FROM estrutura_top10) AS avg_top10;
     


-- bpm 
SELECT
    maxbpm_geral,
    maxbpm_top10,
    minbpm_geral,
    minbpm_top10
FROM
    (SELECT MAX(bpm) AS maxbpm_geral FROM pop_spotify) AS max_geral,
    (SELECT MAX(bpm) AS maxbpm_top10 FROM estrutura_top10) AS max_top10,
	(SELECT MIN(bpm) AS minbpm_geral FROM pop_spotify) AS min_geral,
	(SELECT MIN(bpm) AS minbpm_top10 FROM estrutura_top10) AS min_top10;


SELECT
	MAX(bpm) AS max_bpm,
    MIN(bpm) AS min_bpm
FROM
	estrutura_top10;    
 
 
-- bpm que mais aparece nas faixas tabela geral
SELECT
    ,
    COUNT(bpm) AS frequencia_bpm
FROM
    pop_spotify
GROUP BY
    bpm
ORDER BY
    frequencia_bpm DESC
LIMIT 1;



-- Valência média
SELECT
    valence_geral,
    valence_top10
FROM
    (SELECT AVG(valence) AS valence_geral FROM pop_spotify) AS geral,
    (SELECT AVG(valence) AS valence_top10 FROM estrutura_top10) AS top10;
    
-- Valência máx e mín
SELECT
    maxvalence_geral,
    maxvalence_top10,
    minvalence_geral,
    minvalence_top10
FROM
    (SELECT MAX(valence) AS maxvalence_geral FROM pop_spotify) AS maxgeral,
    (SELECT MAX(valence) AS maxvalence_top10 FROM estrutura_top10) AS maxtop10,
    (SELECT MIN(valence) AS minvalence_geral FROM pop_spotify) AS mingeral,
    (SELECT MIN(valence) AS minvalence_top10 FROM estrutura_top10) AS mintop10;









