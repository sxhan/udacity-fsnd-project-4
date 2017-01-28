-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.


\c tournament;

DROP TABLE IF EXISTS player CASCADE;
CREATE TABLE player (
    player_id serial primary key,
    name varchar(50)
);

DROP TABLE IF EXISTS match CASCADE;
CREATE TABLE match (
    match_id serial primary key,
    winner_id int references player (player_id),
    loser_id int references player (player_id)
);

DROP VIEW IF EXISTS player_wins CASCADE;
CREATE VIEW player_wins AS
SELECT player.player_id as player_id, COUNT(match.winner_id) as wins_cnt
FROM player
LEFT JOIN match ON player.player_id = match.winner_id
GROUP BY player.player_id
ORDER BY wins_cnt;

DROP VIEW IF EXISTS player_matches CASCADE;
CREATE VIEW player_matches AS
SELECT player.player_id as player_id, COUNT(match.winner_id) as matches_cnt
FROM player
LEFT JOIN match ON (player.player_id = match.loser_id OR player.player_id = match.winner_id)
GROUP BY player.player_id
ORDER BY matches_cnt;
