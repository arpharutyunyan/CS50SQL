-- Insert new players
INSERT INTO "players" ("username", "email", "age", "gender") VALUES
('player1', 'player1@example.com', 25, 'Male'),
('player2', 'player2@example.com', 30, 'Female'),
('player3', 'player3@example.com', 22, 'Male');

-- Insert new games
INSERT INTO "games" ("title", "genre", "release_date") VALUES
('Game 1', 'Action', '2024-01-01'),
('Game 2', 'Adventure', '2024-02-15'),
('Game 3', 'Puzzle', '2024-03-30');

-- Insert new teams
INSERT INTO "teams" ("team_name", "country", "owner_id") VALUES
('Team A', 'USA', 1),
('Team B', 'Canada', 2),
('Team C', 'UK', 3);

-- Assign players to teams
INSERT INTO "team_players" ("team_id", "player_id") VALUES
(1, 1),
(1, 2),
(2, 2),
(2, 3),
(3, 3);

-- Record teams' scores in games
INSERT INTO "played_team_games" ("team_id", "game_id", "score") VALUES
(1, 1, 100),
(1, 3, 80),
(3, 1, 70),
(2, 2, 45),
(2, 1, 62),
(3, 3, 90);

-- Find the usernames of players who are members of teams from a specific country:
SELECT "username" FROM "players"
WHERE "id" IN (
    SELECT "player_id" FROM "team_players"
    WHERE "team_id" IN (
        SELECT "id" FROM "teams"
        WHERE "country"='Canada'
    )
);

-- Retrieve the details of games played by teams along with the team names:
SELECT "teams"."team_name", "games"."title", "played_team_games"."score" FROM "played_team_games"
JOIN "teams" ON "teams"."id"="played_team_games"."team_id"
JOIN "games" ON "games"."id"="played_team_games"."game_id";

-- Find the team name of teams who played the game 'Game 2'
SELECT "team_name" FROM "teams"
WHERE "id" IN (
    SELECT "game_id" FROM "played_team_games"
    WHERE "game_id" IN (
        SELECT "id" FROM "games"
        WHERE "title"='Game 2'
    )
);

-- Retrieve the top 3 teams based on their total scores using team_scores_view VIEW
SELECT "teams"."team_name", "total_score" FROM "team_scores_view"
JOIN "teams" ON "teams"."id"="team_scores_view"."team_id"
ORDER BY "total_score" DESC
LIMIT 3;

-- Update the age of player with email 'player2...' to 31
UPDATE "players" SET "age"='31'
WHERE "email" LIKE 'player2%';

-- Delete player with username 'player3' from 'Team B' team
DELETE FROM "team_players"
WHERE "player_id"=(
    SELECT "id" FROM "players"
    WHERE "username"='player3'
)
AND "team_id"=(
    SELECT "id" FROM "teams"
    WHERE "team_name"='Team B'
);
