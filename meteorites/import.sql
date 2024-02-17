CREATE TABLE "meteorites_temp" (
    "name" TEXT,
    "id" INTEGER,
    "nametype" TEXT,
    "class" TEXT,
    "mass" REAL,
    "discovery" TEXT,
    "year" REAL,
    "lat" REAL,
    "long" REAL,
    PRIMARY kEY("id")
);

CREATE TABLE "meteorites" (
     "name" TEXT,
    "id" INTEGER,
    "class" TEXT,
    "mass" REAL,
    "discovery" TEXT,
    "year" REAL,
    "lat" REAL,
    "long" REAL,
    PRIMARY kEY("id")
);

.import --csv --skip 1 meteorites.csv meteorites_temp

UPDATE "meteorites_temp" SET "mass" = NULL
WHERE "mass"=0;

UPDATE "meteorites_temp" SET "year" = NULL
WHERE "year"='';

UPDATE "meteorites_temp" SET "lat" = NULL
WHERE "lat"=0;

UPDATE "meteorites_temp" SET "long" = NULL
WHERE "long"=0;

UPDATE "meteorites_temp" SET "mass"=Round("mass", 2), "lat"=Round("lat", 2), "long"=Round("long", 2);

DELETE FROM "meteorites_temp" WHERE "nametype"='Relict';

INSERT INTO "meteorites" ("name", "class", "mass", "discovery", "year", "lat", "long")
SELECT "name", "class", "mass", "discovery", "year", "lat", "long" FROM "meteorites_temp"
ORDER BY "year", "name";
