# spotify_analysis
/*
Primeiro passo: alterar o nome da tabela para um nome menor (pop_spotify).
Segundo passo: alterar o nome da coluna 'track_name' que possuía um espaço no início do nome, gerando erro ao executar a consulta.
Terceiro passo: renomear todas as colunas com caracteres especiais para eliminar problemas na hora de executar as consultas.

Em seguida, prossegui com a análise exploratória dos dados para conhecer mais os dados que tinha nas mãos.

- A tabela possui dados de músicas de 365 artistas, somando 627 faixas.
- Os 3 anos com mais lançamentos foram 2022 (303), 2022 (125) e 2021 (67).
- Os meses com mais lançamentos são maio, janeiro e março. Na consulta trouxe também os nomes dos meses, que na tabela original aparecem somente com os números.
- A faixa menos tocada foi Que Vuelvas,"Carin Leon, com 2762 streams, enquanto a mais tocada foi Circles, do Post Malone, com 2.132.335.812 streams.
- Dentre as 10 músicas mais populares destaco que: The Weeknd aparece duas vezes; a música mais antiga é de 1983 (Every Breath You Take Remastered 2003 - The Police)
- Os 5 artistas com mais músicas populares foram Taylor Swift, SZA, The Weeknd, Harry Styles e Bad Bunny. Interessante notar que o artista com mais streams não consta dessa lista.
- A música mais antiga da tabela data de 1946, The Christmas Song (Merry Christmas To You) - Remastered 1999 - Nat King Cole -  com 389.771.964 streams.
- Já a música mais recente é Seven (feat. Latto) (Explicit Ver.),"Latto -  Jung Kook"" - 2023 com 141.381.703 streams.
- Taylor Swift lidera as playlists da Apple e do Spotify, enquanto Bruno Mars lidera a playlist do Deezer.
- 94% das músicas estão presentes em todas as playlists analisadas (Apple, Deezer e Spotify).
- Sobre a estrutura das músicas:

- Criei uma View (estrutura) para simplificar os códigos a partir daqui.

1. Músicas em escala maior tiveram mais streams do que músicas em escala menor - a música mais tocada também é em escala maior.

* Músicas em escala maior despertam sentimentos de alegria, pelo menos no mundo ocidental. Entretando a segunda música mais tocada está em escala menor. Das 10 músicas mais tocadas, 6 estão em escala maior. 

2. Dançabilidade: indica o quão dançante é uma faixa. Dentre as 10 faixas mais tocadas, 6 possuem dançabilidade > 70.

3. Valência: quanto maior a valência, mais a música soa alegre, eufórica. A segunda música mais tocada possui valência 92. Contudo, a média da valência entre as 10 músicas mais tocadas é de 53.3.

4. Instrumentalidade: refere-se a faixas mais vocais ou mais instrumentais. Todas as 10 músicas mais tocadas tem instrumentalidade 0, indicando que são músicas vocais e não instrumentais.

5. É possível perceber uma homogeneidade maior no grupo das 10 faixas mais tocadas (view estrutura). 
5.1. No quesito dançabilidade, a variação na tabela geral é de 96 a 24, já na view estrutura, varia entre 82 e 45.
5.2. Na tabela geral, o bpm varia entre 206 e 55, enquanto nas top 10, a variação é entre 145 e 100.
5.3 A média da valência entre os dois grupos é de 49.8 no grupo geral e 53.3 no top 10.
*/
