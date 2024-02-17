-- Represent players
CREATE TABLE "players" (
    "id" INTEGER,
    "username" TEXT NOT NULL UNIQUE,
    "email" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "gender" TEXT NOT NULL,
    PRIMARY KEY("id")
);

-- Represent games
CREATE TABLE "games" (
    "id" INTEGER,
    "title" TEXT NOT NULL UNIQUE,
    "genre" TEXT NOT NULL,
    "release_date" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id")
);

-- Represent teams
CREATE TABLE "teams" (
    "id" INTEGER,
    "team_name" TEXT NOT NULL UNIQUE,
    "country" TEXT NOT NULL,
    "owner_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("owner_id") REFERENCES "players"("id")
);

-- Represent team members
CREATE TABLE "team_players" (
    "id" INTEGER,
    "team_id" INTEGER,
    "player_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("team_id") REFERENCES "teams"("id"),
    FOREIGN KEY("player_id") REFERENCES "players"("id")
);

-- Represent games played by teams
CREATE TABLE "played_team_games" (
    "id" INTEGER,
    "team_id" INTEGER,
    "game_id" INTEGER,
    "score" INTEGER DEFAULT 0,
    PRIMARY KEY("id"),
    FOREIGN KEY("team_id") REFERENCES "teams"("id"),
    FOREIGN KEY("game_id") REFERENCES "games"("id")
);

-- Create indexes to speed common searches
CREATE INDEX "team_name_index" ON "teams" ("team_name");
CREATE INDEX "game_title_index" ON "games" ("title");

-- Create a view to display the total score of each team in all games they've played
CREATE VIEW "team_scores_view" AS
SELECT "team_id", SUM("score") AS "total_score"
FROM "played_team_games"
GROUP BY "team_id";
