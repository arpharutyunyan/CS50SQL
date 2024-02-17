
-- *** The Lost Letter ***

-- get address and type with given address
-- starting with subqueries, first I find from and to addresses ids with given addresses, and then take package with that from and to addresses ids.
-- with package id find the scans where action is 'drop'. This give the address which recived the letter.
-- with gotten address id find the address and type

SELECT "address", "type" FROM "addresses" WHERE "id"=(
    SELECT "address_id" FROM "scans" WHERE ("action"='Drop' AND "package_id"=(
        SELECT "id" FROM "packages" WHERE ("from_address_id"=(
            SELECT "id" FROM "addresses" WHERE "address"='900 Somerville Avenue'
        ) AND "to_address_id"=(
            SELECT "id" FROM "addresses" WHERE "address"='2 Finnigan Street'
        ))
    ))
);


-- *** The Devious Delivery ***

-- first find the package id which don't have the 'from' address
-- with package id get the address id from scans table which action is droped
-- with address id get the address type which recieved the letter

SELECT "type" FROM "addresses" WHERE "id"=(
    SELECT "address_id" FROM "scans" WHERE "package_id"=(
        SELECT "id" FROM "packages" WHERE "from_address_id" IS NULL
    ) AND "action"='Drop'
);

-- get the content of the letter which don't have 'from' address

SELECT "contents" FROM "packages" WHERE "from_address_id" IS NULL;


-- *** The Forgotten Gift ***

-- get address id from where send the gift
-- with 'from' address id get contents from packages table

SELECT "contents" FROM "packages" WHERE "from_address_id"=(
    SELECT "id" FROM "addresses" WHERE "address"='109 Tileston Street'
);

-- get address id from where the gift send
-- with 'from' address id get package id
-- with package id get driver id from the scans table which action is 'pick' and not taken from the main sender address
-- get driver name with given driver id

SELECT "name" FROM "drivers" WHERE "id"=(
    SELECT "driver_id" FROM "scans" WHERE "package_id"=(
        SELECT "id" FROM "packages" WHERE "from_address_id"=(
            SELECT "id" FROM "addresses" WHERE "address"='109 Tileston Street'
        )
    ) AND "action"='Pick' AND "address_id"!=(
        SELECT "id" FROM "addresses" WHERE "address"='109 Tileston Street'
    )
);
